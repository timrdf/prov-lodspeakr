#Copyright Massachusetts Institute of technology, 1998.
#Written by Eric Prud'hommeaux for the World Wide Web Consortium

use strict;

require Exporter;
require AutoLoader;

package W3C::Util::Exception;

use vars qw($VERSION @ISA @EXPORT @EXPORT_OK);
@ISA = qw(Exporter AutoLoader);
@EXPORT = qw(&throw &catch);
@EXPORT_OK = qw(&watch &DieHandler);
$VERSION = 1.0;

$W3C::Util::Exception::revision = '$Id: Exception.pm,v 1.79 2007-05-25 21:16:15 eric Exp $ ';

@W3C::Util::ExceptionConstructionException::ISA = qw(W3C::Util::Exception);
@W3C::Util::IOException::ISA = qw(W3C::Util::Exception);
@W3C::Util::OutOfBoundsException::ISA = qw(W3C::Util::Exception);
@W3C::Util::FunctionException::ISA = qw(W3C::Util::Exception);
@W3C::Util::DeprecatedException::ISA = qw(W3C::Util::FunctionException);
@W3C::Util::NotImplementedException::ISA = qw(W3C::Util::FunctionException);
@W3C::Util::ParameterException::ISA = qw(W3C::Util::Exception);
@W3C::Util::SafeEvaluationException::ISA = qw(W3C::Util::Exception);
@W3C::Util::UnsafeEvaluationException::ISA = qw(W3C::Util::Exception);


#####
# per-class data
# hash table of current exceptions - needed in multi-threaded environment.
%W3C::Util::Exception::currentException = ();
$W3C::Util::Exception::IgnoreNext = 0;

#####
# constants
my ($PACKAGENAME, $FILENAME, $LINE, $SUBROUTINE, $HASARGS, $WANTARRAY, $EVALTEXT, $IS_REQUIRE) = (0..7);

#####
# throw

sub throw {
    my ($exception) = @_;
    if (!$exception || !UNIVERSAL::isa($exception, 'W3C::Util::Exception')) {
	if ($exception = &catch('W3C::Util::Exception')) {
	} else {
	    $exception = new W3C::Util::UnspecifiedException();
	}
    }
    $@ = '<'.$exception.'> '.$exception->getMessage." at $exception->{STACK_FRAMES}[0][1] line $exception->{STACK_FRAMES}[0][2].\n";
    $W3C::Util::Exception::currentExceptions{$exception} = [$exception, $@];
    $W3C::Util::Exception::currentException = $exception;
    if ($W3C::Util::Exception::IgnoreNext) {
	$W3C::Util::Exception::IgnoreNext--;
	return $exception;
    }
    die $@;
}

#####
# catch

sub catch {
    my ($type) = @_;
    return undef if (!$@ || $@ !~ m/^\<([^\>]+)\>/);
    my $lookFor = $1;
    my $pair = $W3C::Util::Exception::currentExceptions{$lookFor};
    return undef if (!defined $pair);
    my ($current, $msg) = @$pair;
    if (UNIVERSAL::isa($current, $type)) {
	delete $W3C::Util::Exception::currentExceptions{$lookFor};
	if ($@ ne $msg) {
	    print STDERR "\$@ changed to $@";
	}
	undef $@;
	return $current;
    } else {
	return undef;
    }
}

sub watch {
    my (@codes) = @_;
    my @ret;
    foreach my $code (@codes) {
	eval {
	    @ret = &$code;
	}; if ($@) {
	    # watch is not intended to be used with other die handlers.
	    local($SIG{"__DIE__"}) = '__DEFAULT__';
	    if (my $ex = &catch('W3C::Util::Exception')) {
		die $ex->toString;
	    } else {
		die $@;
	    }
	}
    }
    return @ret;
}

sub DieHandler {
    my ($msg) = @_;

    # Keep nested calls to die (like in &throw) from calling this handler.
    local($SIG{"__DIE__"}) = '__DEFAULT__';

    if (my $ex = &catch('W3C::Util::Exception')) {
	# Already in an exception state.
	&throw($ex);
    } else {
	# Handling a perl exception.
	&throw(new W3C::Util::DieException(-dieHandlerArg => $msg));
    };
}

sub new {
    my ($proto, $parms) = @_;
    my $class = ref($proto) || $proto;
    my $self;
    if (ref $parms eq 'HASH') {
	$self = $parms;
    } elsif (ref $parms eq 'ARRAY') {
	$self = {@$parms};
    } elsif (ref $parms eq 'SCALAR') {
	$self = {-message => $$parms};
    } elsif ($parms) {
	$self = {$parms, @_};
    } else {
	$self = {};
    }
    bless ($self, $class);
    $self->fillInStackTrace;
    return $self;
}

sub fillInStackTrace {
    my ($self, $stackIncrement) = @_;
    if (!defined $stackIncrement) {
	$stackIncrement = 0;
    }
    $self->{STACK_FRAMES} = [];
    for (my $i = 1 + $stackIncrement; $i < 100; $i++) {
	my (@frame) = caller($i);
	if (defined $frame[$SUBROUTINE]) {
	    push (@{$self->{STACK_FRAMES}}, \@frame);
	} else {
	    last;
	}
    }
}

sub assumeStackTrace {
    my ($self, $ex) = @_;
    $self->{STACK_FRAMES} = $ex->{STACK_FRAMES};
}

sub getMessage {
    my ($self) = @_;
    if ($_[0]->{-exceptionConstructionException}) {
	return $self->{-exceptionConstructionException}->getMessage;
    }
    my $chainedMessage = $self->{-chainedException} ? 
	join ("\n", $self->{-chainedException}->getMessage)."\n" : '';
    my $message = $self->getSpecificMessage ? 
	join ("\n", $self->getSpecificMessage) : 
	$self->{-message};
    return "$message$chainedMessage";
}
sub toString {
    my ($self) = @_;
    if ($self->{-exceptionConstructionException}) {
	return $self->{-exceptionConstructionException}->toString();
    }
    my $ret;
    foreach my $message ($self->getMessage) {
	&printMessage($message, \ $ret);
    }
    $self->printStackTrace(\ $ret);
    return $ret;
}
# overload this baby for exception-specific messages
sub getSpecificMessage {return undef;}
sub printStackTrace {
    my ($self, $outputHandle) = @_;
    if ($self->{-chainedException}) {
	return $self->{-chainedException}->printStackTrace($outputHandle);
    }
    for (my $i = 0; $i < @{$self->{STACK_FRAMES}}; $i++) {
	my $frame = $self->{STACK_FRAMES}[$i];
	my @messageLine;
	if ($i > 0) {
	    if ($frame->[$SUBROUTINE] eq '(eval)' && $frame->[$EVALTEXT]) {
		push (@messageLine, 'eval ('.$frame->[$EVALTEXT].')');
	    } else {
		push (@messageLine, $frame->[$SUBROUTINE]);
	    }
	    push (@messageLine, '(...)') if ($frame->[$HASARGS]);
	} else {
	    push (@messageLine, (ref $self).' thrown');
	}
	push (@messageLine, ' at '.$frame->[$FILENAME].':'.$frame->[$LINE]);
	&printMessage(join ('', @messageLine), $outputHandle);
    }
}

sub printMessage {
    my ($message, $outputHandle) = @_;
    if (ref $outputHandle eq 'SCALAR') {
	$$outputHandle .= $message."\n";
    } elsif (ref $outputHandle eq 'ARRAY') {
	push (@$outputHandle, $message);
    } elsif (ref $outputHandle eq 'GLOB') {
	print $outputHandle $message."\n";
    } elsif (ref $outputHandle && $outputHandle->can('println')) {
	$outputHandle->println($message);
    } elsif (defined $outputHandle) {
	print $outputHandle $message."\n";
    } else {
	print STDERR $message."\n";
    }
}

# missingParm -- called by an Exception constructor to flag missing missing
# 		 constructor parameters.
# May make this cooler, but exceptions within exceptions are a pain.
sub missingParm {
    my ($self, $name) = @_;
    $self->{-exceptionConstructionException} = 
	new W3C::Util::ExceptionConstructionException((caller(1))[0,1,2], 
						      -missingParm => $name, 
						      -parentException => $self);
}

package W3C::Util::UnspecifiedException;
@W3C::Util::UnspecifiedException::ISA = qw(W3C::Util::Exception);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->{-error} = "$@:($!)" if (!$self->{-error});
    $self->fillInStackTrace;
    shift (@{$self->{STACK_FRAMES}});
    return $self;
}
sub getSpecificMessage {
    my ($self) = @_;
    my $curError = $self->getError ? ' (current perl error: '.$_[0]->getError().')' : '';
    return "Unspecified Exception$curError";}
sub getError {return $_[0]->{-error}}

package W3C::Util::ExceptionConstructionException;
sub new {
    my ($proto, $ex, $file, $line, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    die 'W3C::Util::ExceptionConstructionException (via '.$ex.') exception needs a "-missingParm" parameter' 
	if (!$self->{-missingParm});
    die 'W3C::Util::ExceptionConstructionException (via '.$ex.') exception needs a "-exceptionConstructionException" parameter' 
	if (!$self->{-parentException});
    return $self;
}
sub getSpecificMessage {return (ref $_[0]->{-parentException}).' exception needs a "'.$_[0]->{-missingParm}.'" parameter';}

package W3C::Util::FileException;
@W3C::Util::FileException::ISA = qw(W3C::Util::IOException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-filename') if (!exists $self->{-filename});
    $self->{-error} = $! if (!$self->{-error});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {&W3C::Util::Exception::throw(new W3C::Util::NotImplementedException());}
sub getFilename {return $_[0]->{-filename}}
sub getError {return $_[0]->{-error}}

package W3C::Util::FileOperationException;
@W3C::Util::FileOperationException::ISA = qw(W3C::Util::FileException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-operation') if (!exists $self->{-operation});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {return $_[0]->getOperation." exception on file \"".$_[0]->getFilename.'": '.$_[0]->getError;}
sub getOperation {return $_[0]->{-operation}}

package W3C::Util::FileNotFoundException;
@W3C::Util::FileNotFoundException::ISA = qw(W3C::Util::FileException);
sub getSpecificMessage {return "Can't open file \"".$_[0]->getFilename.'": '.$_[0]->getError;}

package W3C::Util::LibraryNotFoundException;
@W3C::Util::LibraryNotFoundException::ISA = qw(W3C::Util::FileException);
sub getSpecificMessage {return "Can't open library \"".$_[0]->getFilename.'": '.$_[0]->getError;}

package W3C::Util::FileCreationException;
@W3C::Util::FileCreationException::ISA = qw(W3C::Util::FileException);
sub getSpecificMessage {return "Can't create file \"".$_[0]->getFilename.'": '.$_[0]->getError;}

package W3C::Util::EOFException;
@W3C::Util::EOFException::ISA = qw(W3C::Util::IOException);
sub getSpecificMessage {return 'EOF'.($_[0]->getFilename ? ' on "'.$_[0]->getFilename.'"' : '')}
sub getFilename {return $_[0]->{-filename}}

package W3C::Util::FunctionException;
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    if (!$self->{-class} || !$self->{-method}) {
	if ($self->{-function}) {
	    my @segments = split ('::', $self->{-function});
	    $self->{-class} = join ('::', @segments[0..@segments-2]);
	    $self->{-method} = $segments[-1];
	} else {
	    no strict;
	    my $depth = defined $ {$class.'::_ClassDepth'} ? $ {$class.'::_ClassDepth'} : 1;
	    use strict;
	    my ($packageName, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require) = caller($depth);
#	    print join (' | ', ($packageName, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require)),"\n";
	    $subroutine = '- - main - -' if (!defined $subroutine);
	    $subroutine =~ m/(?:(.*?)::)?([^\:]+)$/;
	    my ($derivedPackage, $derivedMethod) = ($1, $2);
	    $self->{-class} = $derivedPackage if (!$self->{-class});
	    $self->{-method} = $derivedMethod if (!$self->{-method});
	    if (!$self->{-location}) {
		my ($packageName, $filename, $line, $subroutine, $hasargs, $wantarray, $evaltext, $is_require) = caller($depth-1);
		$self->{-location} = $line;
	    }
	}
    }
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {
    my ($self) = @_;
    my $post = $self->{-callingClass} ? ' for class '.ref $self->{-callingClass} : '';
    return 'function "'.$self->getFunction.'" is not implemented'.$self->_getObjectString.$post;
}
sub getClass {return $_[0]->{-class}}
sub getMethod {return $_[0]->{-method}}
sub getFunction {return $_[0]->getClass ? $_[0]->getClass.'::'.$_[0]->getMethod : $_[0]->getMethod}
sub getObject {return $_[0]->{-object}}
sub _getObjectString {return $_[0]->{-object} ? " for object $_[0]->{-object}" : ''}

package W3C::Util::ProgramFlowException;
@W3C::Util::ProgramFlowException::ISA = qw(W3C::Util::FunctionException);
sub getSpecificMessage {my $ret = 'should not arrive at "'.$_[0]->getFunction; 
			$ret .= ':'.$_[0]->getLocation if ($_[0]->getLocation); 
			$ret .= ' state:{'.$_[0]->getState.'}' if ($_[0]->getState); 
			return $ret.'"';}
sub getLocation {return $_[0]->{-location}}
sub getState {return $_[0]->{-state}}

@W3C::Util::DebugCheckException::ISA = qw(W3C::Util::ProgramFlowException);

package W3C::Util::PerlException;
@W3C::Util::PerlException::ISA = qw(W3C::Util::FunctionException);
$W3C::Util::PerlException::_ClassDepth = 2;
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    if (!$self->{-error}) {
	chomp ($@), $self->{-error} = $@.' - '.$! ;
    }
    $self->fillInStackTrace;
    return $self;
}

sub getSpecificMessage {return 'native perl exception "'.$_[0]->getError.'" in '.$_[0]->getFunction}
sub getError {return $_[0]->{-error}}

package W3C::Util::DieException;
@W3C::Util::DieException::ISA = qw(W3C::Util::Exception);
#$W3C::Util::DieException::_ClassDepth = 4; when this is a FunctionException
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-dieHandlerArg') if (!exists $self->{-dieHandlerArg});
    $self->fillInStackTrace;

    my $text = $self->{-dieHandlerArg};

    # Parse the die message. Could look like:
    # 'could not read "/asdf": No such file or directory at Makefile.PL line 82.'
    # 'could not read "/asdf": No such file or directory at Makefile.PL line 82, <STDIN> line 2.'
    # how about this format?
    # 'could not read "/asdf": No such file or directory at Makefile.PL line 82, <STDIN> line 2, <STDOUT> line 5.'
    if (my ($msg, $where) = $text =~ 
	m/^(.*?) at ((?:[^ ]+ line \d+\, )*[^ ]+ line \d+\.?)$/) {
	my ($file, $line, $coords) = $where =~ m/^([^ ]+) line (\d+)(.*)$/g;
	$msg .= $coords;

	$@ = $text;
	$self->{-message} = $msg;

	# Get rid of extra stack frames from calling Die handlers and
	# constructing Exceptions.
	for (my $sp = 1; $sp < 10; $sp++) {
	    if ($self->{STACK_FRAMES}[$sp][$FILENAME] eq $file && $self->{STACK_FRAMES}[$sp][$LINE] == $line) {
		splice (@{$self->{STACK_FRAMES}}, 0, $sp);
		last;
	    }
	}

    # Failed to parse line info. Just use the message.
    } else {
	chomp $text;
	$self->{-message} = $text;
    }

    return $self;
}

package W3C::Util::MethodNotImplementedException; # !!! do we need this and ProgramFlowException ?
@W3C::Util::MethodNotImplementedException::ISA = qw(W3C::Util::FunctionException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-object') if (!exists $self->{-object});
    $self->fillInStackTrace;
    return $self;
}

sub getSpecificMessage {return 'unimplemlemented method '.$_[0]->getClass.'::'.$_[0]->getMethod().' called on '.$_[0]->getObject();}
sub getObject {return $_[0]->{-object}}

package W3C::Util::UnexpectedObjectException;
@W3C::Util::UnexpectedObjectException::ISA = qw(W3C::Util::FunctionException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-object') if (!exists $self->{-object});
    $self->fillInStackTrace;
    return $self;
}

sub getSpecificMessage {return 'unexpected object '.$_[0]->getObject();}
sub getObject {return ref $_[0]->{-object}}

package W3C::Util::OutOfBoundsException;
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-name') if (!exists $self->{-name});
    $self->missingParm('-index') if (!exists $self->{-index});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {return 'variable "'.$_[0]->getName.'['.$_[0]->getIndex.']" is out of bounds';}
sub getName {return $_[0]->{-name}}
sub getIndex {return $_[0]->{-index}}

package W3C::Util::ParameterException;
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-parameter') if (!exists $self->{-parameter});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {
    my ($self) = @_;
    my $ret = 'parameter "'.$self->getParameter;
    if (exists $self->{-value}) {
	my $value = $self->getValue;
	$ret .= ": $value";
    }
    $ret .= '" not legal in this context';
    if ($self->getHint) {
	$ret .= ' ('.$self->getHint.')';
    }
    return $ret;
}
sub getParameter {return $_[0]->{-parameter}}
sub getValue {return $_[0]->{-value}};
sub getHint {return $_[0]->{-hint}};

package W3C::Util::ParameterFormatException;
@W3C::Util::ParameterFormatException::ISA = qw(W3C::Util::ParameterException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-format') if (!exists $self->{-format});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {
    my ($self) = @_;
    my $ret = $self->getParameter.' malformed. '.$self->getFormat;
    return $ret;
}
sub getFormat {return $_[0]->{-format}};

package W3C::Util::MissingParameterException;
@W3C::Util::MissingParameterException::ISA = qw(W3C::Util::ParameterException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {
    my ($self) = @_;
    my $ret = 'missing parameter "'.$self->getParameter;
    if ($self->getHint) {
	$ret .= '" ('.$self->getHint.')';
    } else {
	$ret .= '" required in this context';
    }
    return $ret;
}

package W3C::Util::ResourceException;
@W3C::Util::ResourceException::ISA = qw(W3C::Util::Exception);
use W3C::Util::Exception;
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-uri') if (!exists $self->{-uri});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {&W3C::Util::Exception::throw(new W3C::Util::FunctionException)} # pure virtual
sub getUri {return $_[0]->{-uri};}

package W3C::Util::NoSuchFileException;
@W3C::Util::NoSuchFileException::ISA = qw(W3C::Util::ResourceException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-file') if (!exists $self->{-file});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {return 'No such file: "'.$_[0]->{-file}.'"';}
sub getFile {return $_[0]->{-file};}

package W3C::Util::NoSuchResourceException;
@W3C::Util::NoSuchResourceException::ISA = qw(W3C::Util::ResourceException);
sub getSpecificMessage {return 'No such Resource: "'.$_[0]->{-uri}.'"';}

package W3C::Util::MalformedUriException;
@W3C::Util::MalformedUriException::ISA = qw(W3C::Util::ResourceException);
sub getSpecificMessage {return 'Malformed URI: "'.$_[0]->{-uri}.'"';}

package W3C::Util::StringEncodingException;
@W3C::Util::StringEncodingException::ISA = qw(W3C::Util::Exception);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-str') if (!exists $self->{-str});
    $self->missingParm('-encoding') if (!exists $self->{-encoding});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {return "expected $_[0]->{-encoding} of \"$_[0]->{-str}\"";}

package W3C::Util::BaseContextException;
@W3C::Util::BaseContextException::ISA = qw(W3C::Util::Exception);

sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-contextID') if (!exists $self->{-contextID});
    $self->fillInStackTrace;
    return $self;
}
sub ensure {
    my ($proto, $parms) = @_;
    my $class = ref($proto) || $proto;
    if ($parms->{-chainedException} && 
	(my $chainedCtx = $parms->{-chainedException}->{-contextID} && 
	 (my $ctx = $parms->{-contextID}))) {
	if ($chainedCtx != $ctx) {
	    return $class->new($parms);
	}
    } else {
	return $class->new($parms);
    }
}
sub getSpecificMessage {
    my ($self) = @_;
    my $errorMessage = $self->{-errorMessage} ? $self->{-errorMessage} : $self->exceptionClass.' string context:';
    if (wantarray) {
	my $location = $self->{-location} || '';
	return ($errorMessage, 
		"$location:$self->{-line}:$self->{-column}($self->{-pos})", 
		$self->{-ctxString}, $self->{-indicator});
    } else {
	return $errorMessage.$self->{-ctxString};
    }
}
sub exceptionClass {
    my ($self) = @_;
    return ref ($self->{-chainedException} ? $self->{-chainedException} : $self);
}
package W3C::Util::CachedContextException;
@W3C::Util::CachedContextException::ISA = qw(W3C::Util::BaseContextException);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-str') if (!exists $self->{-str});
    $self->missingParm('-pos') if (!exists $self->{-pos});
    ($self->{-head}, $self->{-lineHead}, $self->{-ctxString}, 
     $self->{-indicator}, $self->{-lineTail}, $self->{-tail}, 
     $self->{-line}, $self->{-column}) = 
	&W3C::Util::CachedContextException::getContextString($self->{-str}, $self->{-pos});
    $self->fillInStackTrace;
    return $self;
}
sub getContextString {
    my ($str, $pos, $max) = @_;
    if (!defined $max) {$max = 40;}

    my $iBeforeError = $max;
    my $startAt = $pos - $iBeforeError;
    if ($startAt < 0) {
	$iBeforeError += $startAt;
	$startAt = 0;
    }
    my $t = substr($str, 0, $pos);
    my ($beforeError, $head, $lineHead);
    if (reverse ($t) =~ m/^([^\n]*)\n(.*)/s) {
	($beforeError, $head) = (substr($str, 1+length $2, length $1), substr($str, 0, length $2));
    } else {
	$beforeError = substr ($str, $startAt, $iBeforeError);
    }
    if (length $beforeError > $iBeforeError) {
	$lineHead = substr($beforeError, 0, length ($beforeError) - $iBeforeError);
	$beforeError = substr($beforeError, length ($beforeError) - $iBeforeError, $iBeforeError);
    }

    my $iAfterError = $max;
    my $endAt = $pos + $iAfterError;
    if ($endAt > (length $str)) {
	$iAfterError -= ($endAt - (length $str));
	$endAt = (length $str);
    }
    $t = substr($str, $pos);
    my ($afterError, $tail) = $t =~ m/^([^\n]*)\n(.*)/s ? ($1, $2) : ($t, undef);
    my $lineTail = '';
    if (length $afterError > $iAfterError) {
	$lineTail = substr($afterError, $iAfterError);
	$afterError = substr($afterError, 0, $iAfterError);
    }

    $t = substr($str, 0, $pos);
    my $count = $t =~ m/\Z/m;
    my ($line, $column);
    for ($line = 0; $t =~ m/\n/gcs; $line++) {}
    for ($column = 0; $t =~ m/./gcs; $column++) {}

    return ($head, 
	    $lineHead, 
	    $beforeError.$afterError,
	    ('=' x ((length $beforeError)-1)).'^', 
	    $lineTail, 
	    $tail, 
	    $line, 
	    $column);
}

package W3C::Util::HttpMessage;
use vars qw(@ISA);
@ISA = qw(W3C::Util::Exception);

sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-statusCode') if (!exists $self->{-statusCode});
    $self->missingParm('-headers') if (!exists $self->{-headers});
    $self->missingParm('-body') if (!exists $self->{-body});
    $self->fillInStackTrace;
    return $self;
}

sub getSpecificMessage {return 'HTTP early return message';}

sub addHeader {
    my ($self, $header, $value) = @_;
    push (@{$self->{-headers}}, [$header, $value]);
}

sub toString {
    my ($self) = @_;
    my (@ret, $contentLength, $contentType);
    push (@ret, "Status: $self->{-statusCode}");
    foreach my $header (@{$self->{-headers}}) {
	if ($header->[0] =~ m/^Content-length$/i) {
	    $contentLength = $header->[1];
	} elsif ($header->[0] =~ m/^Content-type$/i) {
	    $contentType = $header->[1];
	}
	push (@ret, "$header->[0]: $header->[1]");
    }
    push (@ret, 'Content-length: '. length $self->{-body}) if (!defined $contentLength);
    push (@ret, 'Content-type: text/html') if (!defined $contentType);
    push (@ret, '');
    push (@ret, $self->{-body});
    return join ("\n", @ret);
}

package W3C::Util::SignalException;
@W3C::Util::SignalException::ISA = qw(W3C::Util::Exception);
sub new {
    my ($proto, @parms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@parms);
    $self->missingParm('-pid') if (!exists $self->{-pid});
    $self->missingParm('-signal') if (!exists $self->{-signal});
    $self->fillInStackTrace;
    return $self;
}
sub getSpecificMessage {return $_[0]->getPid.' got signal '.$_[0]->getSignal.' signal';}
sub getPid {return $_[0]->{-pid};}
sub getSignal {return $_[0]->{-signal};}

package W3C::Util::Exception;

1;

__END__

=head1 NAME

W3C::Util::Exception - throw and catch and useful exceptions.

=head1 SYNOPSIS

    use W3C::Util::Exception;
    @NegotiationException::ISA = qw(W3C::Util::Exception);
    eval {
	&iNeed('it yesterday');
    }; if ($@) {if (my $ex = &catch('NegotiationException')) {
	print "Try again with larger stick or carrot.\n";
    } elsif (my $ex = &catch('W3C::Util::Exception')) {
	warn 'got some random exception: '.$ex->getMessage."\n";
	$ex->toString;
	die "\n";
    } else {die $@;}}

    sub iNeed {
	throw(new NegotiationException(-message => 'What about my needs?'));
    }

=head1 DESCRIPTION

This module is part of the W3C::Utils CPAN module.

This probably won't be needed when die passes a first class object.

Create an exception class and derive it from W3C::Util::Exception.
Write a function that throws it.
Call the function from inside an eval.
At the end of the eval, add
    "if ($@) {"
Try each exception that could be thrown with
    "if (my $ex = &catch('NegotiationException')) {"
At the end, have an "
    "} elsif (my $ex = &catch('W3C::Util::Exception')) {"
to make sure you get all possible exceptions. (Note - this is one area
where language support could make sure you've covered all the bases.)
At the end, you may want to add
    "} else {die $@;}}"
to make sure that you catch any non-exception calls to die.

Uncaught exceptions may be found by putting an eval around your
program's main. Exceptions that are thrown and are caught by a an eval
will display with a leading block containing the exception's address
and toString value. For instance:
    "<W3C::Util::FileNotFoundException=HASH(0x8313e1c)> Can't
     open file "asdf": No such file or directory at 
     ../../../W3C/Util/Exception.pm line 34."
This should be save as long there are no '>'s allowed in object::print.

=head1 DIE Handling

By default W3C::Util::Exception does not set any DIE handlers. It is likely that you will want to include

      local($SIG{"__DIE__"}) = sub {&DieHandler(@_)};

in your main. This will cause perl to throw exceptions for situations like calls to non-existent methods or invalid reference use.

=head1 watch

Simple programs will probably just want to call &watch to get
rudimentary exception handling. The exceptions's toString method is
called and the results passed to the normal (__DEFAULT__) perl die
handler. This simply prints the message to standard error and exits
with a code of 1.

=head1 NOTES

I considered using a syntax like
    try (sub {
	&iNeed('it yesterday');
    }, 'NegotiationException', sub {
	print "Try again with larger stick or carrot.\n";
    }, 'W3C::Util::Exception', sub {
	warn 'got some random exception: '.$ex->getMessage."\n";
	$ex->toString;
	die "\n";
    });
but figured it would just complicate the control without improving the
interface significantly. Anyone have any good ideas here?

=head1 ContextExceptions

Suppose an exception occurs part way through parsing an x-included XML document
and the directive to parse that document was part way through a parsing query
string. Ideally, the exception message will appear something like:

  unknown namespace: "preson"
  file:/data/Bob.xml::8:35(74)
    <person:Record name="Bob Dobbs"><preson:homeAddr><addr:Address>
  ===================================^
  file:/data/People.xml::103:34(5184)
    <xincl:include href="joe.xml"/><xincl:include href="bob.xml"/>
  ==================================^
  file:/data/hr-report.alg::3:28(70)
    slurp (schema.xml) slurp (People.xml) slurp (post)
  ============================^
  W3C::Util::UnknownNamespaceException thrown at W3C/Util/NamespaceHandler.pm:235
  W3C::Util::NamespaceHandler::_getNs(...) at W3C/Util/NamespaceHandler.pm:217
  W3C::Util::NamespaceHandler::mapNamespace(...) at W3C/Util/NamespaceHandler.pm:213
  ...

We see three contexts which refine our search for the error: hr-report.alg read
People.xml which xincluded Bob.xml. Each parser is expected to catch Exceptions
and add a context to them. A ContextException is constructed with a reference
to the chainedException and the Locator. If the chainedException is also a
ContextException, the context from the chainedException is added to the
getMessage (and thereby toString) method unless the chainedException is for the
same context. This last case would occur if a parser trapped an exception it
has already thrown as it wound in this case:

  sub parse {
    eval {
	$p->interp("bad data");
    }; if ($@) {
	my $ex = &catch('W3C::Util::Exception') || new W3C::Util::PerlException();
	my $newEx = new MyContextException($self, {-chainedException => $ex, -locator => $self});
	$newEx->assumeStackTrace($ex);
	&throw($newEx);
    }
  }
  sub eval {
    if ($_[1] eq "bad data") {
	&throw(new new MyContextException($self, {-chainedException => $ex, -locator => $self});
    }
  }

=head1 AUTHOR

Eric Prud'hommeaux <eric@w3.org>

=head1 SEE ALSO

perl(1).

=cut
