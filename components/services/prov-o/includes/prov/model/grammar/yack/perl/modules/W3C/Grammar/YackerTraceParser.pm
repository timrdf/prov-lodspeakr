#Copyright Massachusetts Institute of technology, 2007.
#Written by Eric Prud'hommeaux for the World Wide Web Consortium

# $Id: YackerTraceParser.pm,v 1.3 2007-12-01 10:05:04 eric Exp $

use strict;

package W3C::Grammar::YackerTraceEvent;

sub new {
    my ($proto, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Parser => $parser};
    bless ($self, $class);
    return $self;
}


package W3C::Grammar::YackerTraceParseError;
@W3C::Grammar::YackerTraceParseError::ISA = qw(W3C::Grammar::YackerTraceEvent);
sub new {
    my ($proto, $error, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($parser);
    $self->{Error} = $error;
    bless ($self, $class);
    return $self;
}
sub getError {
    my ($self) = @_;
    return $self->{Error};
}


package W3C::Grammar::YackerTraceConsume;
@W3C::Grammar::YackerTraceConsume::ISA = qw(W3C::Grammar::YackerTraceEvent);
sub new {
    my ($proto, $token, $value, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($parser);
    $self->{Token} = $token;
    $self->{Value} = $value;
    bless ($self, $class);
    return $self;
}
sub getToken {
    my ($self) = @_;
    return $self->{Token};
}
sub getValue {
    my ($self) = @_;
    return $self->{Value};
}
sub toString {
    my ($self, %flags) = @_;
    return 'shift ('.$self->getToken().', '.$self->getValue().')';
}


package W3C::Grammar::YackerTraceMatch;
@W3C::Grammar::YackerTraceMatch::ISA = qw(W3C::Grammar::YackerTraceEvent);
sub new {
    my ($proto, $match, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($parser);
    $self->{Match} = $match;
    bless ($self, $class);
    return $self;
}
sub getMatch {
    my ($self) = @_;
    return $self->{Match};
}
sub toString {
    my ($self, %flags) = @_;
    return $self->getMatch();
}


package W3C::Grammar::YackerTraceRule;
@W3C::Grammar::YackerTraceRule::ISA = qw(W3C::Grammar::YackerTraceEvent);
sub new {
    my ($proto, $rule, $matched, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($parser);
    $self->{Rule} = $rule;
    $self->{Matched} = $matched;
    bless ($self, $class);
    return $self;
}
sub getRule {
    my ($self) = @_;
    return $self->{Rule};
}
sub getMatched {
    my ($self) = @_;
    return $self->{Matched};
}
sub toString {
    my ($self, %flags) = @_;
    my $matched = $self->getMatched();
    my @ret = (' '.$self->getRule().'('.(scalar @$matched).')');
    for (my $iMatch = 0; $iMatch < @$matched; $iMatch++) {
	my $match = $matched->[$iMatch];
	push (@ret, '    '.$self->getRule."($iMatch): ".$match->toString(%flags));
    }
    return wantarray ? @ret : join("\n", @ret);
}


package W3C::Grammar::YackerTraceStateChange;
@W3C::Grammar::YackerTraceStateChange::ISA = qw(W3C::Grammar::YackerTraceEvent);
sub new {
    my ($proto, $production, $rules, $parser) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($parser);
    $self->{Production} = $production;
    $self->{Rules} = $rules;
    bless ($self, $class);
    return $self;
}
sub getProduction {
    my ($self) = @_;
    return $self->{Production};
}
sub getRules {
    my ($self) = @_;
    return $self->{Rules};
}
sub toString {
    my ($self, %flags) = @_;
    my @ret = '  '.$self->getProduction().':';
    foreach my $rule (@{$self->{Rules}}) {
	my $matched = $rule->getMatched();
	$ret[0] .= ' '.$rule->getRule().'('.(scalar @$matched).')';
	for (my $iMatch = 0; $iMatch < @$matched; $iMatch++) {
	    my $match = $matched->[$iMatch];
	    push (@ret, '    '.$rule->getRule."($iMatch): ".$match->toString(%flags));
	}
    }
    return wantarray ? @ret : join("\n", @ret);
}


package W3C::Grammar::YackerTraceParser;

sub new {
    my ($proto, %parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Consumes => [], Productions => [], Events => [], %parms};
    bless ($self, $class);
    return $self;
}
sub getConsumes {
    my ($self) = @_;
    return $self->{Consumes};
}
sub getProductions {
    my ($self) = @_;
    return $self->{Productions};
}
sub parse {
    my ($self, $text) = @_;
    my @inputLines = split("\n", $text);
    for (my $lineNo = 0; $lineNo < @inputLines; $lineNo++) {
	my $line = $inputLines[$lineNo];
	if ($line =~ m/^shift \((.*?), (.*?)\)$/) {
	    my ($token, $value) = ($1, $2);
	    my $consume = new W3C::Grammar::YackerTraceConsume($token, $value, $self);
	    push (@{$self->{Consumes}}, $consume);
	    push (@{$self->{Events}}, $consume);
	} elsif ($line =~ m/^  ([^:]+): ?(.*)$/) {
	    my ($production, @ruleStrs) = ($1, split (' ', $2));
	    my $rules = [];
	  RULE:
	    foreach my $rule (@ruleStrs) {
		$rule =~ s/\((\d+)\)$//;
		my $matched = [];
		my $matchCount = $1;
		for (my $col = 0; $col < $matchCount; $col++) {
		    if ($inputLines[++$lineNo] =~ m/^    \Q$rule($col)\E: (.*)$/) {
			push (@$matched, new W3C::Grammar::YackerTraceMatch($1, $self));
		    } else {
			my $errorStr = "\"$inputLines[$lineNo]\" did not match \"^    \\Q$rule\\E: (.*)\$\"";
			if ($self->{-noErrors}) {
			    push (@$matched, new W3C::Grammar::YackerTraceParseError($errorStr, $self));
			    --$lineNo;
			    last RULE;
			} else {
			    &throw(new W3C::Util::Exception(-message => $errorStr));
			}
		    }
		}
		push (@$rules, new W3C::Grammar::YackerTraceRule($rule, $matched, $self));
	    }
	    my $stateChange = new W3C::Grammar::YackerTraceStateChange($production, $rules, $self);
	    push (@{$self->{Productions}}, $stateChange);
	    push (@{$self->{Events}}, $stateChange);
	} else {
	    chomp $line;
	    my $errorStr = "line $lineNo not expected: \"$line\"";
	    if ($self->{-noErrors}) {
		push (@{$self->{Events}}, new W3C::Grammar::YackerTraceParseError($errorStr, $self));
	    } else {
		&throw(new W3C::Util::Exception(-message => $errorStr));
	    }
	}
    }
    return $self->{Events};
}
sub toString {
    my ($self, %flags) = @_;
    my @ret = map {$_->toString(%flags)} @{$self->{Events}};
    return wantarray ? @ret : join("\n", @ret);
}

1;

# $Log: YackerTraceParser.pm,v $
# Revision 1.3  2007-12-01 10:05:04  eric
# don't require a trailing space on empty productions
#
# Revision 1.2  2007/01/10 03:21:46  eric
# + toString functions
# ~ make work
#
# 
