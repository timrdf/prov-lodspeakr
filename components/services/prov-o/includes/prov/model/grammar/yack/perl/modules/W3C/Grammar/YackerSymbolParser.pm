#!/usr/bin/perl
####################################################################
#
#    This file was generated using Parse::Yapp version 1.05.
#
#        Don't edit this file, use source file instead.
#
#             ANY CHANGE MADE HERE WILL BE LOST !
#
####################################################################
package W3C::Grammar::_YackerSymbolParser;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
# use Parse::Yapp::Driver; @@ replaced by W3C::Util::YappDriver

#line 1 "YackerSymbolParser.yp"

use W3C::Util::YappDriver;
use W3C::Grammar::YaccCompileTree;
use W3C::Util::Exception;

# START TokenBlock
my $IT__Opt = "_Opt";
my $IT__Plus = "_Plus";
my $IT__Star = "_Star";
my $IT__Q = "_Q";
my $IT__E = "_E";
my $IT__O = "_O";
my $IT__C = "_C";
my $IT__Or = "_Or";
my $IT__S = "_S";
my $escapedSymbol = "(?:[GI]T_(?:[A-Za-z])+)|(?:(?:(?:(?:[\x{0000}-\\^`-\x{10FFFE}])|(?:__)))+)";
my $PASSED_TOKENS = "(?:[\\t\\n\\r ])+";
my $Tokens = [[0, qr/$PASSED_TOKENS/, undef],
              [0, qr/$IT__Opt/i, 'IT__Opt'],
              [0, qr/$IT__Plus/i, 'IT__Plus'],
              [0, qr/$IT__Star/i, 'IT__Star'],
              [0, qr/$IT__Q/i, 'IT__Q'],
              [0, qr/$IT__E/i, 'IT__E'],
              [0, qr/$IT__O/i, 'IT__O'],
              [0, qr/$IT__C/i, 'IT__C'],
              [0, qr/$IT__Or/i, 'IT__Or'],
              [0, qr/$IT__S/i, 'IT__S'],
              [0, qr/$escapedSymbol/, 'escapedSymbol']];
# END TokenBlock


sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			'IT__O' => 1,
			'escapedSymbol' => 7,
			'IT__Q' => 4
		},
		GOTOS => {
			'quotedSymbol' => 6,
			'symbol' => 2,
			'starSymbol' => 3,
			'root' => 8,
			'list' => 10,
			'plusSymbol' => 9,
			'optSymbol' => 5
		}
	},
	{#State 1
		ACTIONS => {
			'IT__Q' => 4
		},
		GOTOS => {
			'quotedSymbol' => 11,
			'symbolSequence' => 12,
			'symbolOrGroup' => 13
		}
	},
	{#State 2
		DEFAULT => -1
	},
	{#State 3
		DEFAULT => -5
	},
	{#State 4
		ACTIONS => {
			'IT__O' => 1,
			'escapedSymbol' => 7,
			'IT__Q' => 4
		},
		GOTOS => {
			'quotedSymbol' => 6,
			'symbol' => 14,
			'starSymbol' => 3,
			'plusSymbol' => 9,
			'list' => 10,
			'optSymbol' => 5
		}
	},
	{#State 5
		DEFAULT => -3
	},
	{#State 6
		ACTIONS => {
			'IT__Star' => 16,
			'IT__Opt' => 17,
			'IT__Plus' => 15
		}
	},
	{#State 7
		DEFAULT => -2
	},
	{#State 8
		ACTIONS => {
			'' => 18
		}
	},
	{#State 9
		DEFAULT => -4
	},
	{#State 10
		DEFAULT => -6
	},
	{#State 11
		DEFAULT => -14
	},
	{#State 12
		ACTIONS => {
			'IT__S' => 19
		},
		DEFAULT => -12
	},
	{#State 13
		ACTIONS => {
			'IT__C' => 21,
			'IT__Or' => 20
		}
	},
	{#State 14
		ACTIONS => {
			'IT__E' => 22
		}
	},
	{#State 15
		DEFAULT => -8
	},
	{#State 16
		DEFAULT => -9
	},
	{#State 17
		DEFAULT => -7
	},
	{#State 18
		DEFAULT => 0
	},
	{#State 19
		ACTIONS => {
			'IT__Q' => 4
		},
		GOTOS => {
			'quotedSymbol' => 23
		}
	},
	{#State 20
		ACTIONS => {
			'IT__Q' => 4
		},
		GOTOS => {
			'quotedSymbol' => 11,
			'symbolSequence' => 24
		}
	},
	{#State 21
		DEFAULT => -11
	},
	{#State 22
		DEFAULT => -10
	},
	{#State 23
		DEFAULT => -15
	},
	{#State 24
		ACTIONS => {
			'IT__S' => 19
		},
		DEFAULT => -13
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'root', 1,
sub
#line 34 "YackerSymbolParser.yp"
{
    my ($self, $symbol) = @_;
    new W3C::Grammar::YaccCompileTree::Rule($symbol, undef, undef, $self);
}
	],
	[#Rule 2
		 'symbol', 1, undef
	],
	[#Rule 3
		 'symbol', 1, undef
	],
	[#Rule 4
		 'symbol', 1, undef
	],
	[#Rule 5
		 'symbol', 1, undef
	],
	[#Rule 6
		 'symbol', 1, undef
	],
	[#Rule 7
		 'optSymbol', 2,
sub
#line 48 "YackerSymbolParser.yp"
{
    my ($self, $quotedSymbol, $IT__Opt) = @_;
    new W3C::Grammar::YaccCompileTree::Opt($quotedSymbol, undef, $self);
}
	],
	[#Rule 8
		 'plusSymbol', 2,
sub
#line 54 "YackerSymbolParser.yp"
{
    my ($self, $quotedSymbol, $IT__Plus) = @_;
    new W3C::Grammar::YaccCompileTree::Plus($quotedSymbol, undef, $self);
}
	],
	[#Rule 9
		 'starSymbol', 2,
sub
#line 60 "YackerSymbolParser.yp"
{
    my ($self, $quotedSymbol, $IT__Star) = @_;
    new W3C::Grammar::YaccCompileTree::Star($quotedSymbol, undef, $self);
}
	],
	[#Rule 10
		 'quotedSymbol', 3,
sub
#line 66 "YackerSymbolParser.yp"
{
    my ($self, $IT__Q, $symbol, $IT__E) = @_;
    $symbol;
}
	],
	[#Rule 11
		 'list', 3,
sub
#line 72 "YackerSymbolParser.yp"
{
    my ($self, $IT__O, $symbolOrGroup, $IT__C) = @_;
    $symbolOrGroup;
}
	],
	[#Rule 12
		 'symbolOrGroup', 1, undef
	],
	[#Rule 13
		 'symbolOrGroup', 3,
sub
#line 79 "YackerSymbolParser.yp"
{
    my ($self, $symbolOrGroup, $IT__Or, $symbolSequence) = @_;
    $symbolOrGroup ? 
	W3C::Grammar::YaccCompileTree::Disjunction::addRightBranch($symbolOrGroup, $symbolSequence, $self) : 
	$symbolSequence;
}
	],
	[#Rule 14
		 'symbolSequence', 1, undef
	],
	[#Rule 15
		 'symbolSequence', 3,
sub
#line 88 "YackerSymbolParser.yp"
{
    my ($self, $symbolSequence, $IT__S, $quotedSymbol) = @_;
    new W3C::Grammar::YaccCompileTree::Sequence($symbolSequence, $quotedSymbol, $self);
}
	]
],
                                  @_);
    bless($self,$class);
}

#line 97 "YackerSymbolParser.yp"


my $LanguageName = 'yackerSymbol';
# -*- Mode: cperl; coding: utf-8; cperl-indent-level: 4 -*-
# START LexerBlock
#
# YappTemplate: used by yacker to create yapp input files.
#
# Use: yacker -l perl -s -n <name> <name>.txt
#
# to generate a yapp input module called Sparql.yp.

#line 11 "YappTemplate"

# $Id: YackerSymbolParser.pm,v 1.1 2007-01-08 09:52:15 eric Exp $

package W3C::Grammar::YackerSymbolParser;
require Exporter;
@W3C::Grammar::YackerSymbolParser::ISA = qw(W3C::Grammar::_YackerSymbolParser Exporter);
use vars qw(@EXPORT);
@EXPORT = qw(&test);

use W3C::Util::Exception;
use W3C::Grammar::YaccCompileTree qw($Name2Symbol);

sub _Error {
    my ($self) = @_;
        exists $self->YYData->{ERRMSG}
    and do {
        print $self->YYData->{ERRMSG};
        delete $self->YYData->{ERRMSG};
        return;
    };
    my $pos = pos $self->YYData->{INPUT};
    my $lastPos = $self->YYData->{my_LASTPOS};
    my $excerpt = substr($self->YYData->{INPUT}, $lastPos, $pos - $lastPos);
    my $expect = @{$self->{STACK}} ? join (' | ', sort {(!(lc $a cmp lc $b)) ? $b cmp $a : lc $a cmp lc $b} map {&_terminalString($_)} $self->YYExpect()) : 'INVALID INITIALIZER';
    if (ref $expect) {
	# Flag unexpected (by the author at this point) refs with '?ref'.
	if (ref $expect eq 'HASH') {
	    if (exists $expect->{NEXT}) {
		$expect = $ {$expect->{NEXT}};
	    } else {
		$expect = "?ref {%$expect}";
	    }
	} elsif (ref $expect eq 'ARRAY') {
	    $expect = "?ref [@$expect]";
	} elsif (ref $expect eq 'SCALAR') {
	    $expect = "?ref $$expect";
	} elsif (ref $expect eq 'GLOB') {
	    $expect = "?ref \**$expect";
	} else {
	    $expect = "?ref ??? $expect";
	}
    }
    my $token = &_terminalString($self->YYData->{my_LASTTOKEN});
    my $value = $self->YYData->{my_LASTVALUE};
    die "expected \"$expect\", got ($token, $value) from \"$excerpt\" at offset $lastPos.\n";
}

sub _terminalString { # static
    my ($token) = @_;
    if ($token =~ m{^I_T_(.+)$}) {
	$token = "'$1'";
    } elsif ($token =~ m{^T_(.+)$}) {
	if (my $base = $ARGV[0]) {
	    $token = "&lt;<a href=\"${base}$token\">$1</a>&gt;";
	} else {
	    $token = "<$1>";
	}
    }
    return $token;
}

my $AtStart;

sub _Lexer {
    my($self)=shift;

    my ($token, $value) = ('', undef);

  top:
    if (defined $self->YYData->{INPUT} && 
	pos $self->YYData->{INPUT} < length ($self->YYData->{INPUT})) {
	# still some chars left.
    } else {
	return ('', undef);
    }

    $self->YYData->{my_LASTPOS} = pos $self->YYData->{INPUT};
    my $startPos = pos $self->YYData->{INPUT};
    my ($mText, $mLen, $mI, $mLookAhead) = ('', 0, undef, undef);
    for (my $i = 0; $i < @$Tokens; $i++) {
	my $rule = $Tokens->[$i];
	my ($start, $regexp, $action) = @$rule;
	if ($start && !$AtStart) {
	    next;
	}
	eval {
	    if ($self->YYData->{INPUT} =~ m/\G($regexp)/gc) {
		my $lookAhead = length $2;
		my $len = (pos $self->YYData->{INPUT}) - $startPos + $lookAhead;
		if ($len > $mLen) {
		    $mText = substr($self->YYData->{INPUT}, $startPos, $len - $lookAhead);
		    $mLen = $len;
		    $mI = $i;
		    $mLookAhead = $lookAhead
		}
		pos $self->YYData->{INPUT} = $startPos;
	    }
	}; if ($@) {
	    die "error processing $action: $@";
	}
    }
    if ($mLen) {
	my ($start, $regexp, $action) = @{$Tokens->[$mI]};
	pos $self->YYData->{INPUT} += $mLen - $mLookAhead;
	$AtStart = $mText =~ m/\z/gc;
	($token, $value) = ($action, $mText);
    } else {
	my $excerpt = substr($self->YYData->{INPUT}, pos $self->YYData->{INPUT}, 40);
	die "lexer couldn't parse at \"$excerpt\"\n";
    }
    if (!defined $token) {
	# We just parsed whitespace or comment.
	goto top;
    }
#    my $pos = pos $self->YYData->{INPUT};
#    print "\n$pos,$token,$value\n";
    $self->YYData->{my_LASTTOKEN} = $token;
    $self->YYData->{my_LASTVALUE} = $value;
    &utf8::encode($value);
    my $ret = undef;
    if ($token eq 'escapedSymbol') {
	if ($value =~ m/^IT_(.*)$/) {
	    $ret = new W3C::Grammar::YaccCompileTree::LLITERAL($1, undef, $self);
	} elsif ($value =~ m/^GT_(.*)$/) {
	    if (my $mapped = $Name2Symbol->{$1}) {
		$ret = new W3C::Grammar::YaccCompileTree::LLITERAL($mapped, undef, $self);
	    } else {
		&throw(new W3C::Util::Exception(-message => "no map for \"$1\""));
	    }
	} else {
	    $value =~ s/__/_/g;
	    $ret = new W3C::Grammar::YaccCompileTree::IDENT($value, undef, $self);
	}
    } elsif ($token eq 'IT__Or') {
	$ret = '|';
    }
    return ($token, $ret);
}

sub parse {
    my($self, $symbol) = @_;
    $self->YYData->{INPUT} = $symbol;
    return $self->YYParse( yylex => \&_Lexer, yyerror => \&_Error, yydebug => $ENV{YYDEBUG} );
}

sub test {
    my ($symbol, $langName) = @ARGV[0..1];
    my $parser = new W3C::Grammar::YackerSymbolParser();
    eval {
	&utf8::decode($symbol);
	my $root = $parser->parse($symbol);
	my $text = $root->toString();
	&utf8::encode($text);
	print "$text\n";
    }; if ($@) {if (my $ex = &catch('W3C::Util::Exception')) {
	die $ex->toString;
    } else {die $@;}}
}
# END LexerBlock

1;

__END__

=head1 NAME

W3C::Grammar::YackerSymbolParser - parse intermediate production names generated by Yacker.

=head1 SYNOPSIS

    my ($symbol, $langName) = @ARGV[0..1];
    my $parser = new W3C::Grammar::YackerSymbolParser();
    &utf8::decode($symbol);
    my $root = $parser->parse($symbol);
    my $text = $root->toString(Markup => 'html', LanguageName => $langName);
    &utf8::encode($text);
    print "$text\n";

=head1 DESCRIPTION

Yacker needs to encode rule patterns in [a-zA-Z_]+ so it reserves symbols starting with '_'. This parser reverses the process.

This module is part of the W3C::Grammar CPAN module.

=head1 API

This function supplies a single parsing function. The methods of the returned object are described in W3C::Grammar::YaccCompileTree(1).

=head2 parse($inputString)

Returns a W3C::Grammar::YaccCompileTree::Rule represented by $inputString. $inputString is expected to be [a-zA-Z0-0_]+, though no specific restrictions prevent any of the rest of unicode.

=head1 TEST

    perl -MW3C::Grammar::YackerSymbolParser -e test \
    _Q_O_QOptionalGraphPattern_E_S_QGT_DOT_E_Opt_S_QGroupElement_E_C_E_Opt

which should return

    BrackettedExpression | BuiltInCall | FunctionCall


=head2 longer test

    _Q_O_QGT_EQUAL_E_S_QNumericExpression_E_Or__QGT_NEQUAL_E_S_QNumericExpression_E_Or__QGT_LT_E_S_QNumericExpression_E_Or__QGT_GT_E_S_QNumericExpression_E_Or__QGT_LE_E_S_QNumericExpression_E_Or__QGT_GE_E_S_QNumericExpression_E_C_E_Opt

    ("=" NumericExpression | "!=" NumericExpression | "<" NumericExpression | ">" NumericExpression | "<=" NumericExpression | ">=" NumericExpression)?

With extra args $root->toString(Markup => 'html', LanguageName => 'SPARQL-')
you get:

    ("=" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span> | "!=" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span> | "<" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span> | ">" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span> | "<=" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span> | ">=" <span class="prod"><a class="grammarRef" href="#prod-SPARQL-NumericExpression">NumericExpression</a></span>)?


=head1 BUGS

    _O_QGraphPatternNotTriples_E_S_QGT_DOT_E_Opt_S_QGraphPattern_E_C


=head1 AUTHOR

Eric Prud'hommeaux <eric@w3.org>

=head1 SEE ALSO

W3C::Grammar::YaccCompileTree(1)

=cut

1;
