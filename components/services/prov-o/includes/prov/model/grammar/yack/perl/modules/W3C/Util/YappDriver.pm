#Copyright Massachusetts Institute of technology, 2003.
#Written by Eric Prud'hommeaux for the World Wide Web Consortium

# $Id: YappDriver.pm,v 1.15 2005-11-05 11:11:17 eric Exp $

use strict;

package W3C::Util::YappDriver::GrammarException;
use W3C::Util::Exception;
@W3C::Util::YappDriver::GrammarException::ISA = qw(W3C::Util::Exception);

package W3C::Util::YappDriver::YappContextException;
@W3C::Util::YappDriver::YappContextException::ISA = qw(W3C::Util::CachedContextException);
sub new {
    my ($proto, $parser, @parms) = @_;
    my $class = ref($proto) || $proto;

    my ($token, $value, $data) = ($parser->YYCurtok(), $parser->YYCurval(), $parser->YYData);
    my $expect = @{$parser->{STACK}} ? $parser->YYExpect() : 'INVALID INITIALIZER';
    my $tokenStr = defined $token && $token ne $value ? "$token " : '';
    my $trimmed = $parser->YYData->{INPUT};
    $trimmed =~ s/[\r\n]*\Z//m;

    my $before = substr($trimmed, 0, $parser->YYData->{my_LASTPOS}+1);
    $before =~ m/([^\r\n]*)\Z/m;
    my $column = length ($1) - 1;
    my $after = substr($trimmed, $parser->YYData->{my_LASTPOS}+1);

    $after =~ m/([^\r\n]*)[\r\n]?(.*)/s;
    my ($line, $last) = ($1, $2);

    my $self = $class->SUPER::new(-contextID => $parser, 
				  -str => $parser->YYData->{INPUT}, 
				  -pos => $parser->YYData->{my_LASTPOS}+1, 
				  -token => $tokenStr, 
				  -parser => $parser, 
#				  -before => "$before$line", 
#				  -marker => ('=' x $column).'^'
#				  -last_ => $last, 
				  -parserStack => [@{$parser->{STACK}}], 
				  -location => $parser->YYData->{LOCATION}, 
				  @parms);
    $self->fillInStackTrace;
    return $self;
}

sub getFullContext {$_[0]->{-before}, $_[0]->{-marker}, $_[0]->{-last_}}

package W3C::Util::YappDriver::MesgYappContextException;
@W3C::Util::YappDriver::MesgYappContextException::ISA = qw(W3C::Util::CachedContextException);
sub new {
    my ($proto, $parser, @parms) = @_;
    my $class = ref($proto) || $proto;

    my ($token, $value, $data) = ($parser->YYCurtok(), $parser->YYCurval(), $parser->YYData);
    if (UNIVERSAL::can($value, "toString")) {
	$value = $value->toString();
    }
    my $expect = @{$parser->{STACK}} ? join (' | ', sort {(!(lc $a cmp lc $b)) ? $b cmp $a : lc $a cmp lc $b} $parser->YYExpect()) : 'INVALID INITIALIZER';
    my $tokenStr = defined $token && $token ne $value ? "$token " : '';
    my $trimmed = $parser->YYData->{INPUT};
    $trimmed =~ s/[\r\n]*\Z//m;

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
    my $valueStr = defined $value ? "'$value'" : 'EOF';
    my $dataStr = ref $data eq 'HASH' ? join ("\n", map {"$_: $data->{$_}"} keys %$data) : $data;
    $dataStr = substr($trimmed, $parser->YYData->{my_LASTPOS}, 20);
    my @stackStrs;
    foreach my $entry (@{$parser->{STACK}}) {
	my ($state, $semval) = @$entry;
	my $semvalStr = $semval ? 
	    UNIVERSAL::can($semval, 'toString') ? $semval->toString() : 
	    ref $semval eq 'ARRAY' ? '['.join('|', @$semval).']' : 
	    $semval : 
	    '';
	push (@stackStrs, "$state   $semvalStr");
    }
    my $stackStr = join("\n", '', 'LALR STACK:', @stackStrs, '___________');

    return $class->SUPER::new(-str => $parser->YYData->{INPUT}, 
			      -pos => $parser->YYData->{my_LASTPOS}, 
			      -contextID => $parser, 
			      -errorMessage => "expected '$expect', got $tokenStr$valueStr at \"$dataStr\"$stackStr", 
			      @parms);
}

#Included Parse/Yapp/Driver.pm file----------------------------------------
{
#
# Module Parse::Yapp::Driver
#
# This module is part of the Parse::Yapp package available on your
# nearest CPAN
#
# Any use of this module in a standalone parser make the included
# text under the same copyright as the Parse::Yapp module itself.
#
# This notice should remain unchanged.
#
# (c) Copyright 1998-2001 Francois Desarmenien, all rights reserved.
# (see the pod text in Parse::Yapp module for use and distribution rights)
#

package Parse::Yapp::Driver;

require 5.004;

use strict;

use vars qw ( $VERSION $COMPATIBLE $FILENAME );

$VERSION = '1.05';
$COMPATIBLE = '0.07';
$FILENAME=__FILE__;

use Carp;

#Known parameters, all starting with YY (leading YY will be discarded)
my(%params)=(YYLEX => 'CODE', 'YYERROR' => 'CODE', YYVERSION => '',
			 YYRULES => 'ARRAY', YYSTATES => 'ARRAY', YYDEBUG => '');
#Mandatory parameters
my(@params)=('LEX','RULES','STATES');

sub new {
    my($class)=shift;
	my($errst,$nberr,$token,$value,$check,$dotpos);
    my($self)={ ERROR => \&_Error,
				ERRST => \$errst,
                NBERR => \$nberr,
				TOKEN => \$token,
				VALUE => \$value,
				DOTPOS => \$dotpos,
				STACK => [],
				DEBUG => 0,
				CHECK => \$check };

	_CheckParams( [], \%params, \@_, $self );

		exists($$self{VERSION})
	and	$$self{VERSION} < $COMPATIBLE
	and	croak "Yapp driver version $VERSION ".
			  "incompatible with version $$self{VERSION}:\n".
			  "Please recompile parser module.";

        ref($class)
    and $class=ref($class);

    bless($self,$class);
}

sub YYParse {
    my($self)=shift;
    my($retval);

	_CheckParams( \@params, \%params, \@_, $self );

	if($$self{DEBUG}) {
		_DBLoad();
		$retval = eval '$self->_DBParse()';#Do not create stab entry on compile
        $@ and die $@;
	}
	else {
		$retval = $self->_Parse();
	}
    $retval
}

sub YYData {
	my($self)=shift;

		exists($$self{USER})
	or	$$self{USER}={};

	$$self{USER};
	
}

sub YYErrok {
	my($self)=shift;

	${$$self{ERRST}}=0;
    undef;
}

sub YYNberr {
	my($self)=shift;

	${$$self{NBERR}};
}

sub YYRecovering {
	my($self)=shift;

	${$$self{ERRST}} != 0;
}

sub YYAbort {
	my($self)=shift;

	${$$self{CHECK}}='ABORT';
    undef;
}

sub YYAccept {
	my($self)=shift;

	${$$self{CHECK}}='ACCEPT';
    undef;
}

sub YYError {
	my($self)=shift;

	${$$self{CHECK}}='ERROR';
    undef;
}

sub YYSemval {
	my($self)=shift;
	my($index)= $_[0] - ${$$self{DOTPOS}} - 1;

		$index < 0
	and	-$index <= @{$$self{STACK}}
	and	return $$self{STACK}[$index][1];

	undef;	#Invalid index
}

sub YYCurtok {
	my($self)=shift;

        @_
    and ${$$self{TOKEN}}=$_[0];
    ${$$self{TOKEN}};
}

sub YYCurval {
	my($self)=shift;

        @_
    and ${$$self{VALUE}}=$_[0];
    ${$$self{VALUE}};
}

sub YYExpect {
    my($self)=shift;

    keys %{$self->{STATES}[$self->{STACK}[-1][0]]{ACTIONS}}
}

sub YYLexer {
    my($self)=shift;

	$$self{LEX};
}


#################
# Private stuff #
#################


sub _CheckParams {
	my($mandatory,$checklist,$inarray,$outhash)=@_;
	my($prm,$value);
	my($prmlst)={};

	while(($prm,$value)=splice(@$inarray,0,2)) {
        $prm=uc($prm);
			exists($$checklist{$prm})
		or	croak("Unknow parameter '$prm'");
			ref($value) eq $$checklist{$prm}
		or	croak("Invalid value for parameter '$prm'");
        $prm=unpack('@2A*',$prm);
		$$outhash{$prm}=$value;
	}
	for (@$mandatory) {
			exists($$outhash{$_})
		or	croak("Missing mandatory parameter '".lc($_)."'");
	}
}

sub _Error {
	print "Parse error.\n";
}

sub _DBLoad {
	{
		no strict 'refs';

			exists(${__PACKAGE__.'::'}{_DBParse})#Already loaded ?
		and	return;
	}
	my($fname)=__FILE__;
	my(@drv);
	open(DRV,"<$fname") or die "Report this as a BUG: Cannot open $fname";
	while(<DRV>) {
                	/^\s*sub\s+_Parse\s*{\s*$/ .. /^\s*}\s*#\s*_Parse\s*$/
        	and     do {
                	s/^#DBG>//;
                	push(@drv,$_);
        	}
	}
	close(DRV);

	$drv[0]=~s/_P/_DBP/;
	eval join('',@drv);
}

#Note that for loading debugging version of the driver,
#this file will be parsed from 'sub _Parse' up to '}#_Parse' inclusive.
#So, DO NOT remove comment at end of sub !!!
sub _Parse {
    my($self)=shift;

	my($rules,$states,$lex,$error)
     = @$self{ 'RULES', 'STATES', 'LEX', 'ERROR' };
	my($errstatus,$nberror,$token,$value,$stack,$check,$dotpos)
     = @$self{ 'ERRST', 'NBERR', 'TOKEN', 'VALUE', 'STACK', 'CHECK', 'DOTPOS' };

#DBG>	my($debug)=$$self{DEBUG};
#DBG>	my($dbgerror)=0;

#DBG>	my($ShowCurToken) = sub {
#DBG>		my($tok)='>';
#DBG>		for (split('',$$token)) {
#DBG>			$tok.=		(ord($_) < 32 or ord($_) > 126)
#DBG>					?	sprintf('<%02X>',ord($_))
#DBG>					:	$_;
#DBG>		}
#DBG>		$tok.='<';
#DBG>	};

	$$errstatus=0;
	$$nberror=0;
	($$token,$$value)=(undef,undef);
	@$stack=( [ 0, undef ] );
	$$check='';

    while(1) {
        my($actions,$act,$stateno);

        $stateno=$$stack[-1][0];
        $actions=$$states[$stateno];

#DBG>	print STDERR ('-' x 40),"\n";
#DBG>		$debug & 0x2
#DBG>	and	print STDERR "In state $stateno:\n";
#DBG>		$debug & 0x08
#DBG>	and	print STDERR "Stack:[".
#DBG>					 join(',',map { $$_[0] } @$stack).
#DBG>					 "]\n";


        if  (exists($$actions{ACTIONS})) {

				defined($$token)
            or	do {
				($$token,$$value)=&$lex($self);
#DBG>				$debug & 0x01
#DBG>			and	print STDERR "Need token. Got ".&$ShowCurToken."\n";
			};

            $act=   exists($$actions{ACTIONS}{$$token})
                    ?   $$actions{ACTIONS}{$$token}
                    :   exists($$actions{DEFAULT})
                        ?   $$actions{DEFAULT}
                        :   undef;
        }
        else {
            $act=$$actions{DEFAULT};
#DBG>			$debug & 0x01
#DBG>		and	print STDERR "Don't need token.\n";
        }

            defined($act)
        and do {

                $act > 0
            and do {        #shift

#DBG>				$debug & 0x04
#DBG>			and	print STDERR "Shift and go to state $act.\n";

					$$errstatus
				and	do {
					--$$errstatus;

#DBG>					$debug & 0x10
#DBG>				and	$dbgerror
#DBG>				and	$$errstatus == 0
#DBG>				and	do {
#DBG>					print STDERR "**End of Error recovery.\n";
#DBG>					$dbgerror=0;
#DBG>				};
				};


                push(@$stack,[ $act, $$value ]);

					$$token ne ''	#Don't eat the eof
				and	$$token=$$value=undef;
                next;
            };

            #reduce
            my($lhs,$len,$code,@sempar,$semval);
            ($lhs,$len,$code)=@{$$rules[-$act]};

#DBG>			$debug & 0x04
#DBG>		and	$act
#DBG>		and	print STDERR "Reduce using rule ".-$act." ($lhs,$len): ";

                $act
            or  $self->YYAccept();

            $$dotpos=$len;

                unpack('A1',$lhs) eq '@'    #In line rule
            and do {
                    $lhs =~ /^\@[0-9]+\-([0-9]+)$/
                or  die "In line rule name '$lhs' ill formed: ".
                        "report it as a BUG.\n";
                $$dotpos = $1;
            };

            @sempar =       $$dotpos
                        ?   map { $$_[1] } @$stack[ -$$dotpos .. -1 ]
                        :   ();

            $semval = $code ? &$code( $self, @sempar )
                            : @sempar ? $sempar[0] : undef;

            splice(@$stack,-$len,$len);

                $$check eq 'ACCEPT'
            and do {

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Accept.\n";

				return($semval);
			};

                $$check eq 'ABORT'
            and	do {

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Abort.\n";

				return(undef);

			};

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Back to state $$stack[-1][0], then ";

                $$check eq 'ERROR'
            or  do {
#DBG>				$debug & 0x04
#DBG>			and	print STDERR 
#DBG>				    "go to state $$states[$$stack[-1][0]]{GOTOS}{$lhs}.\n";

#DBG>				$debug & 0x10
#DBG>			and	$dbgerror
#DBG>			and	$$errstatus == 0
#DBG>			and	do {
#DBG>				print STDERR "**End of Error recovery.\n";
#DBG>				$dbgerror=0;
#DBG>			};

			    push(@$stack,
                     [ $$states[$$stack[-1][0]]{GOTOS}{$lhs}, $semval ]);
                $$check='';
                next;
            };

#DBG>			$debug & 0x04
#DBG>		and	print STDERR "Forced Error recovery.\n";

            $$check='';

        };

        #Error
            $$errstatus
        or   do {

            $$errstatus = 1;
            &$error($self);
                $$errstatus # if 0, then YYErrok has been called
            or  next;       # so continue parsing

#DBG>			$debug & 0x10
#DBG>		and	do {
#DBG>			print STDERR "**Entering Error recovery.\n";
#DBG>			++$dbgerror;
#DBG>		};

            ++$$nberror;

        };

			$$errstatus == 3	#The next token is not valid: discard it
		and	do {
				$$token eq ''	# End of input: no hope
			and	do {
#DBG>				$debug & 0x10
#DBG>			and	print STDERR "**At eof: aborting.\n";
				return(undef);
			};

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Dicard invalid token ".&$ShowCurToken.".\n";

			$$token=$$value=undef;
		};

        $$errstatus=3;

		while(	  @$stack
			  and (		not exists($$states[$$stack[-1][0]]{ACTIONS})
			        or  not exists($$states[$$stack[-1][0]]{ACTIONS}{error})
					or	$$states[$$stack[-1][0]]{ACTIONS}{error} <= 0)) {

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Pop state $$stack[-1][0].\n";

			pop(@$stack);
		}

			@$stack
		or	do {

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**No state left on stack: aborting.\n";

			return(undef);
		};

		#shift the error token

#DBG>			$debug & 0x10
#DBG>		and	print STDERR "**Shift \$error token and go to state ".
#DBG>						 $$states[$$stack[-1][0]]{ACTIONS}{error}.
#DBG>						 ".\n";

		push(@$stack, [ $$states[$$stack[-1][0]]{ACTIONS}{error}, undef ]);

    }

    #never reached
	croak("Error in driver logic. Please, report it as a BUG");

}#_Parse
#DO NOT remove comment

1;

}
#End of include--------------------------------------------------

package W3C::Util::YappDriver;
use W3C::Util::Exception;
use vars qw(@ISA);
@ISA= qw (Parse::Yapp::Driver);

sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->{yd_CHOICES} = [];
    return $self;
}

sub parse {
    my ($self, $yydebug, $errorSub) = @_;
    my $ret = undef;
    eval {
	$errorSub ||= sub {$self->_Error()};
	$ret = $self->YYParse( yylex => sub {$self->_Lexer()}, yyerror => $errorSub, yydebug => $yydebug );
    }; if ($@) {if (my $ex = &catch('W3C::Util::CachedContextException')) {
	if ($ex->{-contextID} == $self) {
	    # Something thrown by this parse, pass it on.
	    &throw($ex);;
	} else {
	    # Something thrown by a child parser, show context for it.
	    my $newEx = new W3C::Util::YappDriver::YappContextException($self, -chainedException => $ex);
	    $newEx->assumeStackTrace($ex);
	    &throw($newEx);
	}
    } elsif ($ex = &catch('W3C::Util::Exception')) {
	my $newEx = new W3C::Util::YappDriver::YappContextException($self, -chainedException => $ex);
	$newEx->assumeStackTrace($ex);
	&throw($newEx);
    } else {
	my $newEx = new W3C::Util::YappDriver::MesgYappContextException($self, -errorMessage => $@);
	&throw($newEx);
    }}
    return $ret;
}

package W3C::Util::rlDriver;
use vars qw(@ISA);
@ISA= qw (W3C::Util::YappDriver);

use Term::ReadLine;
use W3C::Util::Exception;

sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->YYData->{my_CHUNKS} = []; # "(\n", ")\n"]; # '( ask \' ( ( '];
    $self->{rl_LINES} = [];
    $self->prepareReadline;
    return $self;
}

sub prepareReadline {
    my ($self) = @_;
    $self->{rl_TERM} = new Term::ReadLine 'Calc';
    my $attribs = $self->{rl_TERM}->Attribs;
    my $counter = undef;
    $attribs->{attempted_completion_function} = sub {$self->_hairyCompletionFunction($self->{rl_TERM}, \$counter, @_)};
    $self->{rl_TERM}->ornaments('md,me,,');	# bold face prompt
    $self->{rl_PROMPT} = "command: ";
    my $OUT = $self->{rl_TERM}->OUT || *STDOUT;
}

sub readline {
    my ($self, $defaultInput) = @_;
    my $line = $self->{rl_TERM}->readline($self->{rl_PROMPT}, $defaultInput);
    push (@{$self->{rl_LINES}}, $line);
    return $line;
}

sub _hairyCompletionFunction {
    my ($self, $term, $pCounter, $text, $line, $start, $end) = @_;
    my $soFar = join ("\n", @{$self->{rl_LINES}}).substr($line, 0, $start).$text;
    #print $main::DBG "$self->_hairyCompletionFunction($term, $pCounter, $text, $line, $start, $end [$soFar])\n";
    my $attribs = $term->Attribs;
    my $class = ref $self;

    $self->{yd_CHOICES} = [];
    if ($soFar =~ m/^\w*$/) {
        $self->_BuildOpts;
    } else {
	$self->{rl_COMPLETE_MODE} = 1;
	$self->{rl_SO_FAR} = $soFar;
	my $copy = new Parse::Yapp::Driver(yyversion => $self->{VERSION}, yystates => $self->{STATES}, yyrules => $self->{RULES});
	$copy->{USER} = {%{$self->{USER}}};
	$self->initState($copy);
	my $save = {};
	foreach my $key (%$copy) {
	    $save->{$key} = $self->{$key};
	    $self->{$key} = $copy->{$key};
	}
	#print "\n$self calling $self->YYparser($soFar)\n";
	my $lexer = $self->{LEX}; # $soFar =~ m/^\w*$/ ? \&_Empty : $self->{LEX};
	$self->parse(0x00, \&_BuildOpts);
	foreach my $key (%$copy) {
	    $self->{$key} = $save->{$key};
	}
	$self->{rl_COMPLETE_MODE} = 0;
    }
    #$self->{STACK} = [];
    #print join (' | ', @{$self->{yd_CHOICES}}), "\n";
    if (@{$self->{yd_CHOICES}}) {
	$attribs->{completion_word} = $self->{yd_CHOICES};
	undef $attribs->{completion_display_matches_hook};
	my ($l, $r) = $text =~ m/^(.*?)([^\s]*)$/;
	my $completeFunction = $attribs->{'list_completion_function'};
	my $wordStr = join (' ', @{$attribs->{completion_word}});

	print $main::DBG "_BuildOpts(\$text:$text, \$l:$l, \$r:$r) match $text in ($wordStr)\n";
	return $term->completion_matches("$r $l", sub {
	    my ($t, $i) = @_;
	    my ($r, $l) = $t =~ m/^([^ ]*) (.*)$/;
	    my $ret = &$completeFunction($r, $i);
	    print $main::DBG "complete($r, $i) => $ret\n";
	    return $ret ? "$l$ret" : undef;
	});
    } else {
	print "\nstop hitting tab\n";
	return undef;
    }
}

sub _BuildOpts {
    my ($self) = @_;

    #print $main::DBG "$self->_BuildOpts()\n";

    # Start at latest stack entry.
    my $stateNo = @{$self->{STACK}} > 0 ? $self->{STACK}[-1][0] : 0;

    # Some debugging stuff...
    #print "\nstateNo: $stateNo\n";
    foreach my $entry (@{$self->{STACK}}) {
	#print join (' | ', @$entry),"\n";
    }

    # Follow default actions untill we find one expecting tokens.
    while (defined $stateNo) {
	if (exists $self->{STATES}[$stateNo]{ACTIONS}) {
	    #print "actions: stateNo: $stateNo  action: ", join (' | ', keys %{$self->{STATES}[$stateNo]{ACTIONS}}), "\n";
	    push (@{$self->{yd_CHOICES}}, keys %{$self->{STATES}[$stateNo]{ACTIONS}});
	}
	$stateNo = $self->defaultStateNo($stateNo);
    }

    # Follow stack up to find all default actions that led us here.
    # look up stack
    # if has a negative default
    #   my $production = RULES[-DEFAULT]
    #   my $reduce = GOTOS{$production}
    #   if $reduce = $stateNo
    #      add words from ACTIONS
    for (my $sp = @{$self->{STACK}} - 2; $sp >= 0; $sp--) {
	$stateNo = $self->{STACK}[$sp][0];
	if ($self->{STATES}[$stateNo]{DEFAULT} &&
	    $self->{STACK}[$sp+1][0] == $self->defaultStateNo($stateNo)) {
	    #print "parent actions: stateNo: $stateNo  action: ", join (' | ', keys %{$self->{STATES}[$stateNo]{ACTIONS}}), "\n";
	    push (@{$self->{yd_CHOICES}}, keys %{$self->{STATES}[$stateNo]{ACTIONS}});	    
	} else {
	    last;
	}
    }

    if (!@{$self->{yd_CHOICES}}) {
	push (@{$self->{yd_CHOICES}}, $self->YYExpect());
    }
}

sub defaultStateNo {
    my ($self, $stateNo) = @_;
    my $next = $self->{STATES}[$stateNo]{DEFAULT};
    if ($next < 0) {
	my ($production, $depth, $code) = @{$self->{RULES}[-$next]};
	$next = $self->{STATES}[$stateNo]{GOTOS}{$production};
    }
    return $next;
}

sub initState {}

sub _Empty {print "Empty!\n"; return ('', undef)}

1;

__END__

=head1 NAME

W3C::Util::rlDriver - Parse::Yapp::Driver derivative to allow readline interaction.

=head1 SYNOPSIS

  %{
    use W3C::Util::rlDriver;
    @ISA= qw ( W3C::Util::rlDriver );

    use W3C::Rdf::AlgaeStructure;
  %}

  $parser->YYData->{INPUT} = $self->readline('test')

=head1 DESCRIPTION

This is a parser program generated by Parse::Yapp to use Term::ReadLine to feed input to the lexer. This leverages off the grammer definition passed to yapp to provide lists of syntacticly legal alternatives to the readline completion function.

This module is currently part of the W3C::Util CPAN module.

=head1 AUTHOR

Eric Prud\'hommeaux <eric@w3.org>

=head1 SEE ALSO

Parse::Yapp(3) Term::ReadLine(3) perl(1).

=cut
