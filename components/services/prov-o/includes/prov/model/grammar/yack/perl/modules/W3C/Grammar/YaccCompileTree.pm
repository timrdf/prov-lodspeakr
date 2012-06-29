#!/usr/bin/perl
#Copyright Keio University, 2005.
#Written by Eric Prud'hommeaux for the World Wide Web Consortium
#This file is PUBLIC DOMAIN.

# YaccCompileTree.pm -- Object definitions for populating an yacc parse tree.
# 
# $Id: YaccCompileTree.pm,v 1.110 2008-04-21 01:46:22 eric Exp $

# Issues and dreams:
#   encoding is distinct from escaping is distinct from parser language name:
#     name   translator	encode	quoter
#     perl	yapp	-	DQuoteRegexp
#     c		lex/y	utf-8	LexQuote
#     n3	llparse	utf-16*	N3Quote
#     python	???	utf-16*	PyQuote
#     java	javacc	-	<JavaCCQuoter>
#     * no encoding necessary if running on the wide version of python

use strict;
package W3C::Grammar::YaccCompileTree;
use W3C::Util::Exception;
require Exporter;
@W3C::Grammar::YaccCompileTree::ISA = qw(Exporter);

use vars qw(@EXPORT_OK $Symbol2Name $Name2Symbol
	    $DefaultPrecedence $MAX_PREC $LEFT $RIGHT
	    $PassedTokensName $BASE_FILE $BASE_HTTP);
@EXPORT_OK = qw($DefaultPrecedence $MAX_PREC $LEFT $RIGHT $PassedTokensName $Symbol2Name $Name2Symbol);

($LEFT, $RIGHT) = (1, 2);
$PassedTokensName = 'PASSED_TOKENS';
my $PassedTokensName = $PassedTokensName;

$MAX_PREC = 9;
my $MAX_PREC = $MAX_PREC;
$DefaultPrecedence = {
    '||' => [9, $LEFT],
    '^' => [8, $LEFT],
    '.' => [7, $LEFT],
    '&&' => [7, $LEFT],
    '<' => [5, $LEFT],
    '<=' => [5, $LEFT],
    '>' => [5, $LEFT],
    '>=' => [5, $LEFT],
    '==' => [5, $LEFT],
    '+' => [3, $RIGHT],
    '-' => [3, $RIGHT],
    '*' => [2, $LEFT],
    '/' => [2, $LEFT],
    '!' => [1, $RIGHT],
    NEG => [1, $RIGHT],
};
my $DefaultPrecedence = $DefaultPrecedence;
$Symbol2Name = {'||' => 'OR', 
	       '&&' => 'AND', 
	       ' ' => 'SPACECHAR', 
		"\t" => 'TAB', 
		"\r" => 'RETURN', 
		"\n" => 'LINEFEED', 
	       ',' => 'COMMA', 
	       ':' => 'COLON', 
	       ';' => 'SEMI', 
	       # '=' => 'ASSIGN', 
	       '=' => 'EQUAL', 
	       "\\" => 'BACKSLASH', # '==' => 'EQUAL', 
	       '!=' => 'NEQUAL', 
	       '=~' => 'MATCH', 
	       '~~' => 'MATCH2', 
	       '!~' => 'NMATCH', 
	       '^^' => 'DTYPE', 
	       '^' => 'CARROT', 
	       '+' => 'PLUS', 
	       '-' => 'MINUS', 
	       '*' => 'TIMES', 
	       '/' => 'DIVIDE', 
	       '%' => 'MODULO', 
	       '~' => 'KINDA', 
	       '!' => 'NOT', 
	       '&' => 'AMP', 
	       '|' => 'PIPE', 
	       '@' => 'AT', 
	       '[' => 'LBRACKET', 
	       ']' => 'RBRACKET', 
	       '{' => 'LCURLEY', 
	       '}' => 'RCURLEY', 
	       '(' => 'LPAREN', 
	       ')' => 'RPAREN', 
	       '<' => 'LT', 
	       '>' => 'GT', 
	       '<=' => 'LE', 
	       '>=' => 'GE', 
	       '<<' => 'LREIF', 
	       '>>' => 'RREIF', 
	       '.' => 'DOT', 
	       '?' => 'OPT', 
	       '#' => 'AT', 
	       '' => 'NUTTIN', 
	       '$' => 'DOLLAR', 
	       '\\\\' => 'BACKSLASHS', 
	       '\\\\p{' => 'PTHINGY', 
	       '\\\\P{' => 'PTHINGY2', 
	       '0' => 'DIGIT0', 
	       '1' => 'DIGIT1', 
	       '2' => 'DIGIT2', 
	       '3' => 'DIGIT3', 
	       '4' => 'DIGIT4', 
	       '5' => 'DIGIT5', 
	       '6' => 'DIGIT6', 
	       '7' => 'DIGIT7', 
	       '8' => 'DIGIT8', 
	       '9' => 'DIGIT9', 
	   };
$Name2Symbol = {};
foreach my $key (keys %$Symbol2Name) {
    $Name2Symbol->{$Symbol2Name->{$key}} = $key;
}

sub NameMap {
    my ($str) = @_;
    my @ret;
    my $len = length ($str);

    # Traverse string looking for the widest token names.
    for (my ($l, $w) = (0, $len); $l < $len;) {
	my $substr = substr ($str, $l, $w);
	if (defined (my $mapped = &_map($substr))) {
	    push (@ret, $mapped);
	    $l += $w;
	    $w = $len - $l;
	} else {
	    if (!--$w) {
		# &throw(new W3C::Util::Exception(-message => "no map for \"$substr\" in \"$str\""));
		push(@ret, sprintf("H_%X_", ord($substr)));
		$l += 1;
		$w = $len - $l;
	    }
	}
    }
    return join ('_', @ret);
}
sub _map { # static
    my ($str) = @_;
    return ($str =~ m/^\w+$/) ? $str : $Symbol2Name->{$str};
}

sub format {
    my ($in, $add) = @_;
    my @lines = split("\n", $in);
    return join ("\n", $lines[0], map {"$add$_"} @lines[1..@lines-1]);
}
sub main::_defaultPrec {
    my ($ob, %flags) = @_;
    if (!exists $flags{-parentPrec}) {
	$flags{-parentPrec} = $MAX_PREC;
    }
    if (!exists $flags{-precTable}) {
	$flags{-precTable} = $DefaultPrecedence;
	$flags{-parentPrec} = $MAX_PREC+1;
    }
    return ($ob, %flags);
}

# forward declarations
package W3C::Grammar::YaccCompileTree::Production;
package W3C::Grammar::YaccCompileTree::RuleOptions;
package W3C::Grammar::YaccCompileTree::Solution;
package W3C::Grammar::YaccCompileTree::LiteralSolution;
package W3C::Grammar::YaccCompileTree::CODE;

# Output language specifiers
package W3C::Grammar::GenSpec;
use W3C::Util::Exception;
sub new {
    my ($proto, $la, $derivation, $tokens, $name, $expandTerminals) = @_;
    my $class = ref($proto) || $proto;
    $name || &throw();
    my $self = {
	Derivation => $derivation, 
	LA => $la, 
	Tokens => $tokens, 
	Name => $name, 
	Filename => '', 
	HeadCode => [], 
	TailCode => [], 
	LexDecls => [], 
	ProdDecls => [], 
	Actions => undef, 
	Productions => undef, 
	Labels => undef, 
	UnusedActions => undef, 
	MissingActions => [], 
	ExpandTerminals => $expandTerminals};
    bless ($self, $class);
    return $self;
}
sub LL {
    my ($self) = @_;
    return $self->{Derivation} eq 'LL';
}
sub LR {
    my ($self) = @_;
    return $self->{Derivation} eq 'LR';
}
sub getName {
    my ($self) = @_;
    return $self->{Name};
}
sub getFilename {
    my ($self) = @_;
    return $self->{Filename};
}
sub getExpandTerminals {
    my ($self) = @_;
    return $self->{ExpandTerminals}
}
sub toggleExpandTerminals {
    my ($self) = @_;
    $self->{ExpandTerminals} ^= 1;
}
sub read {
    my ($self, $code, $filename) = @_;
    $self->{Filename} = $filename;
    $self->{Actions} = {};
    $self->{Productions} = {};
    $self->{Labels} = [];

	my %flags = (LineNumbers => 0, 
		     Types => 0, 
		     OrigCode => 0, 
		     Comments => 1, 
		     Yacc => 1, 
		     GenSpec => $self, 
		     Stubs => $self, 
		     Class => $filename);

    $code->toString(%flags, AddActions => 1);
    $self->{UnusedActions} = {map {$_ => undef} @{$self->{Labels}}};
    foreach my $headCode (@{$code->getHead()}) {
	if ($headCode->isa('W3C::Grammar::YaccCompileTree::HEADCODE')) {
	    my $str = $self->_skipMyStuff('TokenBlock', $headCode->toString());
	    if ($str !~ m/^\s$/) {
		push (@{$self->{HeadCode}}, $str);
	    }
	}
    }
    my $tailCode = $self->_skipMyStuff('LexerBlock', $code->getTail());
}
sub _skipMyStuff {
    my ($self, $target, $str) = @_;
    while ($str =~ m/\G.*?\n([\# ]*START $target.*?\n)/gcs) {
	my $start = (pos $str) - length($1);
	if ($str !~ m/\G.*?\n([\# ]*END $target.*?\n)$/gcs) {
	    &throw(new W3C::Util::Exception(-message => "end of $target at $start not found"));
	}
	my $end = (pos $str) - length($1);
	my $before = substr($str, 0, $start);
	my $after = substr($str, pos $str);
	$str = "$before$after";
	pos $str = $start;
    }
    return $str;
}
sub addProduction {
    my ($self, $label, $seq) = @_;
    if (my $first = $self->{Productions}{$label}) {
	my $lineNo = $seq->getLineNo();
	my $firstLineNo = $first->getLineNo();
	my $ex = new W3C::Util::Exception(-message => "duplicate declaration of $label at line $lineNo, first at $firstLineNo");
	warn($ex->getMessage());
    } else {
	$self->{Productions}{$label} = $seq;
    }
}
sub addAction {
    my ($self, $label, $code) = @_;
    if (my $first = $self->{Actions}{$label}) {
	my $lineNo = $code->getLineNo();
	my $firstLineNo = $first->getLineNo();
	&throw(new W3C::Util::Exception(-message => "duplicate action for $label at line $lineNo, first at $firstLineNo"));
    }
    $self->{Actions}{$label} = $code;
    push (@{$self->{Labels}}, $label);
}
sub getAction {
    my ($self, $name) = @_;
    return $self->{Actions} ? $self->{Actions}{$name} : undef;
}
sub getUnusedActions {
    my ($self) = @_;
    return grep {exists $self->{UnusedActions}{$_}} @{$self->{Labels}};
}
sub getMissingActions {
    my ($self) = @_;
    return @{$self->{MissingActions}};
}
sub getActionStr {
    my ($self, $productionName, $argNames, $particles, $startRule, $addLineDirective, $callConstructor, $ruleNo, $nests, $deleteRuleNo, $isaMultProd, $macros) = @_;

    if (my $actions = $self->{Actions}) {
	my $name = join(' ', map {"$_"} $productionName, @$particles);
	if (my $action = $actions->{$name}) {
	    delete $self->{UnusedActions}{$name};
	    if (my $str = $action->toString()) {
		my $lineDirective = $addLineDirective ? 
		    $self->getLineDirective($action->getFilename(), $action->getLineNo()) : 
		    '';
		return "\n{${lineDirective}$str}";
	    } else {
		return "\n";
	    }
	} elsif (exists $self->{Productions}{$name}) {
	    # There was a production for it but it had no code.
	    # We don't warn about this common scenario.
	} else {
	    my $ret = $self->getEchoAction($argNames, $startRule, $productionName, $callConstructor);
	    push (@{$self->{MissingActions}}, $name);
	    $actions->{$name} = $ret;
	    return $ret;
	}
    } else {
	my $ruleSuffix = '';
	my $deleteTail = 0;
	if (defined $ruleNo) {
	    $ruleSuffix = "_rule$ruleNo";
	    $deleteTail = $ruleNo == $deleteRuleNo;
	}
	$self->manageParentRules($productionName, $callConstructor, $ruleNo, $nests, $deleteRuleNo, $isaMultProd, $ruleSuffix, $deleteTail, $macros);
	return $self->getEchoAction($argNames, $startRule, $productionName, $callConstructor, $ruleSuffix, $deleteTail, $isaMultProd, $macros, $nests);
    }
}
sub manageParentRules {}
sub getLineDirective {
    my ($self, $file, $lineNo) = @_;
    return "";
}
sub addProductionDecl {
    my ($self, $prod) = @_;
    push (@{$self->{ProdDecls}}, $prod);
}
sub addLexDecl {
    my ($self, $name, $fold, $macros) = @_;
    push (@{$self->{LexDecls}}, [$name, $fold]);
}
sub clearLexDecls {
    my ($self) = @_;
    $self->{LexDecls} = [];
}
sub printCharPLAN {
    my ($self, $ch) = @_;
    return $self->{PrintChar}(chr($ch));
}
sub printRangePLAN {
    my ($self, $b, $t) = @_;
    return $self->{PrintRange}(chr($b), chr($t));
}
sub getTarget {
    my ($self, $name) = @_;
    return $name;
}
sub getCompileUTF8 {
    return 0;
}
sub copyTemplates {
    my ($self, $templateDir, $uploads, $macros) = @_;
    opendir(TD, $templateDir) || &throw(new W3C::Util::FileOperationException(-filename => "$templateDir", -operation => 'openDir'));
    foreach my $source (readdir(TD)) {
	next if ($source eq '.' || $source eq '..');
	my $target = ($source =~ m/^Langname_(.+)$/) ? "$macros->{'Langname'}$1" : $source;
	open(SRC, "$templateDir/$source") || &throw(new W3C::Util::FileOperationException(-filename => "$templateDir/$source", -operation => 'open'));
	open(TRG, ">$uploads/$target") || &throw(new W3C::Util::FileOperationException(-filename => "$uploads/$target", -operation => 'open for writing'));
	local $/ = undef;
	# Sustitute macros like [[some lead ${AMacro} some trail]].
	my $body = <SRC>;
	while ($body =~ m/\G(.*?)\$\{([a-zA-Z]+)\}/gcs) {
	    my ($lead, $macro) = ($1, $2);
	    my $value = exists $macros->{$macro} ? $macros->{$macro} : "!! no $macro macro found !!";
	    print TRG $lead, $value;
	}
	# Copy remainder of template.
	if ($body =~ m/\G(.*)\Z/gcs) {
	    print TRG $1;
	}
	close SRC;
	close TRG;
    }
}
sub _templateStr {
    my ($self, $templateFile, $substs) = @_;
    if (!open(TEMPLATE, $templateFile)) {
	&throw(new W3C::Util::FileOperationException(-filename => $templateFile, -operation => 'open'));
    }
    local $/ = undef;
    my $template = <TEMPLATE>;
    close(TEMPLATE);
    foreach my $pair (@$substs) {
	my ($from, $to) = @$pair;
	$template =~ s/$from/$to/g;
    }
    return $template;
}
sub comment {
    my ($self, $text) = @_;
    return $self->startComment().$text.$self->endComment();
}

package W3C::Grammar::GenSpec::Perl;
@W3C::Grammar::GenSpec::Perl::ISA = 'W3C::Grammar::GenSpec';
use W3C::Util::Exception;
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    return $class->SUPER::new('LA', 'LR', 1, 'perl', 0);
}
sub getLineDirective {
    my ($self, $file, $lineNo) = @_;
    $lineNo+=2;
    return "\n#line $lineNo \"$file\"";
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor, $ruleSuffix, $deleteTail, $isaMultProd, $macros, $nests) = @_;
    my $argsStr = join(', ', map {"\$$_->[1]"} @$argNames);
    my $printStr = join(', ', map {"\$$_->[1]"} @$argNames);
    my $lengthsStr = join(', ', map {"scalar \@\$$_->[1]"} @$argNames);
    my $namesStr = join(' ', map {"$_->[1](%d)"} @$argNames);
    my $constructor = $callConstructor ? "new $callConstructor($printStr)" : "[$printStr]";
    my $retStr = $callConstructor ? "\$ret" : "\$ret";
    my $dumpParmsStr = '';
    foreach my $argName (@$argNames) {
	$dumpParmsStr .= "    for(my \$_i = 0; \$_i < \@\$$argName->[1]; \$_i++) {\$self->trace(sprintf(\"    $argName->[1](\$_i): %s\", join(' ', \$${argName}->[\$_i]->toString)));}\n";
    }
    my $traceStr = join(', ', "'$productionName'", map {"'$_->[1]', \$$_->[1]"} @$argNames);
    return "{\n    my (\$self, $argsStr) = \@_;\n    my \$ret = $constructor;\n    \$self->traceProduction($traceStr);\n    return $retStr;\n}";
}
sub getHeadCode {
    my ($self, $productions, $productionList, $terminalPatterns, $startProduction, %flags) = @_;
    foreach my $rule (@$terminalPatterns) {
	my ($name, $index, $dependsOn, $str) = @$rule;
	$flags{Macros}{TerminalTokens} .= $str;
    }

    my @classDecls;
    foreach my $prod (@{$self->{ProdDecls}}) {
	my $name = $prod->getIdent->getToken;
	my $class = $prod->isa('W3C::Grammar::YaccCompileTree::GenProduction') ? '_GenProduction' : '_Production';
	push (@classDecls, "\@${name}::ISA = qw($class);");
	$flags{Macros}{ProductionClasses} .= "\@${name}::ISA = qw($class);\n";
    }

    foreach my $pair (@{$self->{LexDecls}}) {
	my ($name, $fold) = @$pair;
	my $foldStr = $fold ? 'i' : '';
	$flags{Macros}{TerminalDeclarations} .= "              [0, qr/\$$name/$foldStr, '$name'],\n";
	my $class = ($name =~ m/^[IG]T_/) ? '_Constant' : '_Terminal'; # @@@ hack -- get from caller
	push (@classDecls, "\@${name}::ISA = qw($class);");
	$flags{Macros}{TerminalClasses} .= "\@${name}::ISA = qw($class);\n";
    }
    $flags{Macros}{ProductionActions} = $productions;
    return '';
}
sub getTarget {
    my ($self, $name) = @_;
    return "${name}.pm";
}
sub makeMakefile {
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
    print $MAKE "PARSERS = ${name}.pm\n\n";
    print $MAKE "parsers: \$(PARSERS)\n\n";
    print $MAKE "\$(PARSERS): %.pm: %.yp
	yapp -v -s -o \$\@ \$<\n\n";
}
sub getExecString {
    my ($self, $path, $name) = @_;
    return "perl -I$path -M$name -e test";
}
sub getTemplateDir {"templates/PerlYapp";}
sub createGrammar {
    my ($self, $g, $genNamesFunc, $uploads, $name, $templateDir, %flags) = @_;
    $g->yaccify($genNamesFunc, $self);

    my $macros = {};
    my $ret = $g->toString(%flags, Macros => $macros,
			   EndProductionString => ';');
    # print LY $g->toString(%flags, EndProductionString => ';');
    $macros->{'Langname'} = $name;
#    $macros->{'TerminalDeclarations'} = join('', map {"              [0, qr/\$$_->[0]/i, '$_->[1]'],\n"} @{$self->{LexDecls}});
    $self->copyTemplates($self->getTemplateDir(), $uploads, $macros);
}
sub startComment {'#'}
sub endComment {''}

package W3C::Grammar::GenSpec::Python;
@W3C::Grammar::GenSpec::Python::ISA = 'W3C::Grammar::GenSpec';
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    return $class->SUPER::new('', 'LL', 1, 'python', 1);
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor) = @_;
    my $argsStr = join(', ', map {"\$$_->[1]"} @$argNames);
    my $printStr = join('+', map {"$_->[1]"} @$argNames);
#    return @$argNames ? "        {{return $printStr}}" : '';
    return "        {{return $printStr}}";
}
sub getHeadCode {
    my ($self, $productions, $productionList, $terminalPatterns, $startProduction, %flags) = @_;
    my $ret;
    foreach my $headCode (@{$self->{HeadCode}}) {
	$ret .= "%{$headCode%}\n\n";
    }
    foreach my $rule (@$terminalPatterns) {
	my ($name, $index, $dependsOn, $str) = @$rule;
	$ret .= $str;
    }
    $ret .= "\n\n$productions";
    return $ret;
}
sub makeMakefile {
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
    my $startProductionName = $g->getStartProductionName();
    print $MAKE "PARSERS = $name\n\n";
    print $MAKE "parsers: \$(PARSERS)\n\n";
    print $MAKE "\$(PARSERS): %: %.g
	yapps \$< $name
	sed \"s/>>sys.stderr, 'Args:  <rule> \\[<filename>\\]'/parse('$startProductionName', stdin.read())/1\"  <\$\@ >\$\@.t
	mv \$\@.t \$\@\n\n";
}
sub getExecString {
    my ($self, $path, $name) = @_;
    return "python $path/$name";
}
sub createGrammar {
    my ($self, $g, $genNamesFunc, $uploads, $name, $templateDir, %flags) = @_;
    # Build the .yp file:
    if (!open(LY, ">$uploads/$name.g")) {
	&throw(new W3C::Util::FileOperationException(-filename => "$name.g", -operation => 'open'));
    }
    print LY "parser $name:\n";

    # Start with the yacc-ified output.
    print LY $g->toString(%flags, EndProductionString => '');

    close (LY);
}
sub startComment {'#'}
sub endComment {''}

package W3C::Grammar::GenSpec::N3;
@W3C::Grammar::GenSpec::N3::ISA = 'W3C::Grammar::GenSpec';
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    return $class->SUPER::new('', 'LL', 1, 'n3', 1);
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor) = @_;
    my $argsStr = join(' ', map {$_->[1]} @$argNames);
    return " ( $argsStr ) "; # pass $argsStr
}
sub getHeadCode {
    my ($self, $productions, $productionList, $terminalPatterns, $startProduction, %flags) = @_;
    my $ret = "\n";
    my $startProductionName = $startProduction->getIdent()->getToken();	    
    foreach my $rule (@$terminalPatterns) {
	my ($name, $index, $dependsOn, $str) = @$rule;
	$ret .= $str;
    }
    $ret .= "$startProductionName cfg:tokens ( ".join ("\n              ", map {$_->[0]} @{$self->{LexDecls}})." ) . \n\n";
    $ret .= "\n$productions%%\n\n";
    return $ret;
}
sub makeMakefile {
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
    my $startProductionName = $g->getStartProductionName();
    print $MAKE "PARSERS = $name\n\n";
    print $MAKE "parsers: \$(PARSERS)\n\n";
    print $MAKE "\$(PARSERS): %: %.g
	cwm blah blah blah \$< $name\n\n";
}
sub createGrammar {
    my ($self, $g, $genNamesFunc, $uploads, $name, $templateDir, %flags) = @_;
    $g->yaccify($genNamesFunc, $self);

    # Build the .yp file:
    if (!open(LY, ">$uploads/$name.n3")) {
	&throw(new W3C::Util::FileOperationException(-filename => "$name.n3", -operation => 'open'));
    }

    # Start with the yacc-ified output.
    print LY $g->toString(%flags, EndProductionString => ';');

    # Set the name (for the constructor in the template).
    print LY "my \$LanguageName = '$name';\n";

    # Append the template
    my $template = "$templateDir/YappTemplate";
    if (open(TEMPLATE, $template)) {
	local $/ = undef;
	my $text = <TEMPLATE>;
	if ($flags{SuppressLineDirectives}) {
	    $text =~ s/^\#line [^\n]+\n//gm;
	}
	print LY $text;
	close(TEMPLATE);
    } else {
	&throw(new W3C::Util::FileOperationException(-filename => $template, -operation => 'open'));
    }
}
sub startComment {'"""'}
sub endComment {'"""'}

package W3C::Grammar::GenSpec::C_;
@W3C::Grammar::GenSpec::C_::ISA = 'W3C::Grammar::GenSpec';
use W3C::Util::Exception;

sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    return $class->SUPER::new('LA', 'LR', 1, 'c', 0);
}
sub _lexAction {
    my ($self, $name, $terminal) = @_;
    return "yylval.semval = constructTerminal(e_$terminal, yytext); return $terminal;"; # @@ ${name}_lval
}
sub getClassblock() {
    my ($self) = @_;
}
sub getSemval() {
    my ($self) = @_;
}
sub _rValue {
    my ($self, $argNames) = @_;
    if (@$argNames == 0) {
	return 'makeBuf0()';
    } elsif (@$argNames == 1) {
	return '$1';
    } else {
	my $argIndex = 0;
	my $argsStr = @$argNames ? 
	    join(', ', scalar @$argNames, map {'$'.++$argIndex} @$argNames) : 
	    '';
	return "makeBuf($argsStr)";
     }
}
sub getLineDirective {
    my ($self, $file, $lineNo) = @_;
    $lineNo+=2;
    return "\n#line $lineNo \"$file\"";
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor, $ruleSuffix, $deleteTail, $isaMultProd, $macros, $nests) = @_;
    $callConstructor ||= '_INVISIBLE_';
    my $argIndex = 0;
    my $argsStr = join(', ', "e_$callConstructor", scalar @$argNames, map {"\$".++$argIndex} @$argNames);
    my $assign = $startRule ? $self->_getRootObject() : '$$';
    return "{\n    $assign = constructProduction($argsStr);\n}\n";
}
sub _getRootObject { return 'StupidGlobal' }
sub getHeadCode {
    my ($self, $productions, $productionList, $terminalPatterns, $startProduction, %flags) = @_;
    foreach my $rule (@$terminalPatterns) {
	my ($name, $index, $dependsOn, $str) = @$rule;
	my $encoded = $str;
	$flags{Macros}{TerminalPatterns} .= $encoded;
    }
    foreach my $pair (@{$self->{LexDecls}}) {
	my ($name, $fold) = @$pair;
	my $match = "{$name}";
	my $comment = '';
	if (my $text = $self->{TerminalExpansions}{$name}) {
	    $match = $text;
	    $comment = " /* Work-around referenced look-ahead bug in flex++ */";
	}
	my $lexAction = $self->_lexAction($flags{Class}, $name);
	$flags{Macros}{TerminalActions} .= "$match		{$lexAction}$comment\n";
    }

    $self->generateTokens($flags{Macros}, $flags{Grammar}, $productionList);
    $flags{Macros}{ProductionActions} = $productions;
    return '';
}
sub generateTokens {
    my ($self, $macros, $g, $productionList) = @_;

    my @classes;
    push (@classes, "{\"_INVISIBLE_\", 0, 0}, \n", "{\"_TERMINAL_\", 0, 0}, \n");
    for (my $i = 0; $i < @{$self->{ProdDecls}}; $i++) {
	my $prodName = $self->{ProdDecls}[$i]->getIdent->getToken;
	my $ctype = $self->{ProdDecls}[$i]->isa('W3C::Grammar::YaccCompileTree::GenProduction') ? '_GenProduction' : '_Production';
	my $assign = $i == 0 ? ' = 2' : '';
	$macros->{'ProductionClassDecls'} .= "  e_$prodName$assign,  \n";
	my $size = length($prodName);
	$macros->{'ProductionClasses'} .= "    {\"$prodName\", $size, $ctype}, \n";
    }
    for (my $i = 0; $i < @{$self->{LexDecls}}; $i++) {
	my ($lexName, $fold) = @{$self->{LexDecls}[$i]};
	my $comma = $i < @{$self->{LexDecls}}-1 ? ',' : '';
	$macros->{'TerminalClassDecls'} .= "  e_$lexName$comma \n";
	my $class = ($lexName =~ m/^[IG]T_/) ? '_Constant' : '_Terminal'; # @@@ hack -- get from caller
	my $size = length($lexName);
	$macros->{'TerminalClasses'} .= "    {\"$lexName\", $size, $class}, \n";
    }
    $main::cheat = "Class_t Classes[] = {\n    ".join('    ', @classes)."};\n";

    foreach my $pair (@{$self->{LexDecls}}) {
	my ($lexName, $fold) = @$pair;
	$macros->{TerminalTokens} .=  "%token <semval> $lexName\n";
    }

    foreach my $production (@$productionList) {
	$macros->{ProductionTypes} .= "%type <semval> $production\n";
    }
}
sub makeMakefile { ##
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
}
sub getExecString {
    my ($self, $path, $name) = @_;
    return "$path/$name";
}
sub getCompileUTF8 {
    return 1;
}
sub getTemplateDir {"templates/CYacc";}
sub createGrammar {
    my ($self, $g, $genNamesFunc, $uploads, $name, $templateDir, %flags) = @_;
    $g->yaccify($genNamesFunc, $self);

    my $macros = {};
    my $ret = $g->toString(%flags, Macros => $macros,
			   EndProductionString => ';');
    $macros->{'Langname'} = $name;
    $macros->{'Goalname'} = $self->{StartRuleType};
    $macros->{'Startname'} = $g->getStartProductionName();
    $macros->{'TerminalDeclarations'} = join('', map {"    $_->[0]* p_$_->[0];\n"} @{$self->{LexDecls}});
    $macros->{'ProductionDeclarations'} = join('', map {'    '.($self->_getProdDecl($_, $g))} @{$self->{ProdDecls}});
    $self->copyTemplates($self->getTemplateDir(), $uploads, $macros);
}
sub _getProdDecl { # static
    my ($self, $production, $g) = @_;
    my $m = $production->getIdent->getTokenName;
    return "$m* p_$m;\n"					       
}
sub startComment {'/*'}
sub endComment {'*/'}

package W3C::Grammar::GenSpec::CPP;
@W3C::Grammar::GenSpec::CPP::ISA = 'W3C::Grammar::GenSpec::C_';
use W3C::Util::Exception;
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new();
    $self->{Name} = 'cpp';
    return $self;
}
sub _rValue {
    my ($self, $argNames) = @_;
    if (@$argNames == 0) {
	return 'new Buf()';
    } elsif (@$argNames == 1) {
	return '$1';
    } else {
	my $argIndex = 0;
	my $argsStr = @$argNames ? 
	    join(', ', scalar @$argNames, map {'$'.++$argIndex} @$argNames) : 
	    '';
	return "new Buf($argsStr)";
     }
}
sub _lexAction {
    my ($self, $name, $lexName) = @_;
    return "yylval->p_$lexName = new $lexName(yytext); return token::$lexName;";
}
sub getClassblock() {
    my ($self) = @_;
    return join('', (map {"class $_;\n"} @{$self->{ClassDecls}}), "\n", @{$self->{ClassDefns}});
}
sub getSemval() {
    my ($self) = @_;
    return 
      "    /* Terminals */\n".join('', map {"    $_->[0]* p_$_->[0];\n"} @{$self->{LexDecls}}).
      "    /* Productions */\n".join('', map {"    $_* p_$_;\n"} map {$_->getIdent->getTokenName} @{$self->{ProdDecls}});
}
sub makeMakefile { ##
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
}
sub getTemplateDir {"templates/CPPYacc";}
sub manageParentRules {
    my ($self, $productionName, $callConstructor, $ruleNo, $nests, $deleteRuleNo, $isaMultProd, $ruleSuffix, $deleteTail, $macros) = @_;
    if (defined $ruleNo) {
	my $ruleName = "$callConstructor$ruleSuffix";
	push (@{$self->{RuleSubClasses}{$callConstructor}}, $ruleName);
	if ($ruleNo == 0) {
	    if (!$isaMultProd) {
		$macros->{ProductionClassDecls} .= "class $callConstructor;\n";
	    }
	    my $defn;
	    if ($isaMultProd) {
		my $parmDecls = join(', ', map {"$_* p_$_"} ($productionName, $nests));
		my $parmArgv = join(', ', 2, map {"p_$_"} $productionName, $nests);
		$defn = '';
		$macros->{ProductionDestructors} .= '';
	    } else {
		$defn = "class $productionName : public yacker::_GroupProduction {
public:
    $productionName () : yacker::_GroupProduction (\"$productionName\") {}
};
";
	    }
	    $macros->{ProductionClasses} .=  "$defn";
	}
	# push (@{$self->{ClassDecls}}, $ruleName); # @@@ symmetrical, but not needed
    } else {
	$macros->{ProductionClassDecls} .= "class $callConstructor;\n";
    }
}
sub addLexDecl {
    my ($self, $name, $fold, $macros) = @_;
    push (@{$self->{LexDecls}}, [$name, $fold]);
    $macros->{TerminalClassDecls} .= "class $name;\n";
    my $word = ($name =~ m/^[IG]T_(.*)/) ? $1 : ''; # @@@ hack -- get from caller
    my $defn = $word ? "class $name : public yacker::_Token {
public:
    $name (const char* text) : yacker::_Token(\"$word\", text) { trace(); }
};
" : "class $name : public yacker::_Terminal {
public:
    $name(const char* p_$name) : yacker::_Terminal(\"$name\", p_$name) { trace(); }
};
";
    $macros->{TerminalClasses} .= $defn;
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor, $ruleSuffix, $deleteTail, $isaMultProd, $macros, $nests) = @_;
    my $assign = '$$';
    my $argIndex = 0;
    my $argsStr = join(', ', map {"\$".++$argIndex} @$argNames);
    if ($isaMultProd) {
	if ($ruleSuffix =~ m/0$/) {
	    return "{\n    $assign = new yacker::_ProductionVector<$nests*>(\"$productionName\", $argsStr);\n}\n";
	} else {
	    return "{\n    \$1->push_back(\$2);\n    $assign = \$1;\n}\n";
	}
    }
    $callConstructor ||= '_INVISIBLE_';
    if ($startRule) {
	$assign = 'driver.root';
	$self->{StartRuleType} = $productionName;
    }
    my $parmCount = scalar @$argNames;
    my $parmDecls = join(', ', map {
	$_->[2] && $_->[2]->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 
	"yacker::_ProductionVector<$_->[2]{Nests}*>* p_$_->[2]{Nests}s" : 
	"$_->[0]* p_$_->[1]"
			 } @$argNames);
    my $parmArgv = join(', ', map {
	$_->[2] && $_->[2]->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 
	"&m_$_->[2]{Nests}s" : 
	"&m_$_->[1]"
			} @$argNames);
    my $baseClass = $ruleSuffix ? $callConstructor : 'yacker::_Production';
    my $destructorDecl = "    ~$productionName$ruleSuffix();\n";
    my $delMembers = $isaMultProd ? '' : join('', map {
	$_->[2] && $_->[2]->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 
	"    delete m_$_->[2]{Nests}s;\n" : 
	"    delete m_$_->[1];\n"
					      } @$argNames);
    $macros->{ProductionDestructors} .= "$productionName${ruleSuffix}::~$productionName$ruleSuffix () {\n$delMembers}\n";
    my $getProdName = $ruleSuffix ? '' : "    virtual const char* getProductionName () { return \"$productionName\"; }\n";
    my $memberDecls = $isaMultProd ? '' : join('', map {
	$_->[2] && $_->[2]->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 
	"    yacker::_ProductionVector<$_->[2]{Nests}*>* m_$_->[2]{Nests}s;\n" : 
	"    $_->[0]* m_$_->[1];\n"
					       } @$argNames);
    my $privates = $memberDecls || $getProdName ? "private:\n    _Base** _members[$parmCount];\n$memberDecls$getProdName" : '';
    my $baseArgs = join(', ', map {"p_$_->[1]"} @$argNames);
    my $baseConstructor = $isaMultProd ? " : \n    $callConstructor($baseArgs)" : 
	$startRule ? " : yacker::_Production(\"$productionName\")" : '';
    my $memberAssigns = $isaMultProd ? '' : join('', map {
	$_->[2] && $_->[2]->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 
	"	m_$_->[2]{Nests}s = p_$_->[2]{Nests}s;\n" : 
	"	m_$_->[1] = p_$_->[1];\n"
						 } @$argNames);
    my $deletes = $deleteTail ? "	delete p_$productionName;\n" : '';
    my $memberArgv = join(', ', $parmCount, map {"m_$_->[1]"} @$argNames);
    my $toXDecls = $isaMultProd ? '' : "    virtual size_t size () { return $parmCount; }
    virtual _Base* operator [] (size_t i) { return *_members[i]; }
    virtual _Base* getElement (size_t i) { return *_members[i]; }
";
    my $defn = "class $productionName$ruleSuffix : public $baseClass {
${privates}public:
    $productionName$ruleSuffix ($parmDecls)$baseConstructor {
$memberAssigns	makeArray(_members, $parmArgv);
	trace();
$deletes    }
$destructorDecl$toXDecls};
";
    $macros->{ProductionClasses} .= $defn;
    return "{\n    $assign = new $callConstructor$ruleSuffix($argsStr);\n}\n";
}
sub _getRootObject { return 'driver.root' }
sub generateTokens {
    my ($self, $macros, $g, $productionList) = @_;
    foreach my $pair (@{$self->{LexDecls}}) {
	my ($lexName, $fold) = @$pair;
	$macros->{TerminalTokens} .= "%token <p_$lexName> $lexName\n";
    }

    foreach my $production (@$productionList) {
	my $p = $g->getProductionByName($production);
	my $type = $production;
	if ($p->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi')) {
	    $type = "$p->{Nests}s";
	}
	$macros->{ProductionTypes} .= "%type <p_$type> $production\n";
    }
}
sub _getProdDecl {
    my ($self, $production, $g) = @_;
    if ($production->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi')) {
	return "yacker::_ProductionVector<$production->{Nests}*>* p_$production->{Nests}s;";
    } else {
	my $m = $production->getIdent->getTokenName;
	return "$m* p_$m;\n"					       
    }
}

package W3C::Grammar::GenSpec::Java;
@W3C::Grammar::GenSpec::Java::ISA = 'W3C::Grammar::GenSpec';
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    return $class->SUPER::new('', 'LL', 1, 'java', 0);
}
sub getEchoAction {
    my ($self, $argNames, $startRule, $productionName, $callConstructor) = @_;
}
sub makeMakefile {
    my ($self, $MAKE, $templateDir, $name, $g) = @_;
    my $startProductionName = $g->getStartProductionName();
    print $MAKE "PARSERS = $name\n\n";
    print $MAKE "parsers: \$(PARSERS)\n\n";
    print $MAKE "\$(PARSERS): %: %.g
	java blah blah blah \$< $name\n\n";
}
sub startComment {'/*'}
sub endComment {'*/'}


package W3C::Grammar::YaccCompileTree::Particle;
use W3C::Util::Exception;
sub new {
    my ($proto, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    $particleParms[0] || &throw();
    my $self = {};
    $self->{Parser} = $particleParms[0];
    bless ($self, $class);
    # $self->check();
    return $self;
}
sub toString {
    &throw(new W3C::Util::MethodNotImplementedException(-object => $_[0], 
	     -function => 'W3C::Grammar::YaccCompileTree::Particle::toString'));
}
sub check {
    my ($self) = @_;
    $self->toString();
}
sub getFilename {
    my ($self) = @_;
    return $self->{Parser}->getFilename();
}

package W3C::Grammar::YaccCompileTree::Text;
@W3C::Grammar::YaccCompileTree::Text::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;

sub new {
    my ($proto, $text, $lineNo, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Text} = $text;
    $self->{LineNo} = $lineNo;
    $self->check();
    return $self;
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = $self->{Text};
    if ($flags{LineNumbers}) {
	$ret .= " ($self->{LineNo})";
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::WHITESPACE;
@W3C::Grammar::YaccCompileTree::WHITESPACE::ISA = 'W3C::Grammar::YaccCompileTree::Text';
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = '';
    if ($flags{WhiteSpace}) {
	$ret .= $self->SUPER::toString(%flags);
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::COMMENT;
@W3C::Grammar::YaccCompileTree::COMMENT::ISA = 'W3C::Grammar::YaccCompileTree::Text';
sub new {
    my ($proto, $leadWS, $text, $lineNo, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($text, $lineNo, @particleParms);
    $self->{LeadWS} = $leadWS;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    return [];
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = '';
    if ($flags{Comments}) {
	$ret = $self->{LeadWS};
	#$ret .= $self->prefix(%flags);
	$ret .= $flags{GenSpec}->comment($self->SUPER::toString(%flags));
	#$ret .= $self->postfix(%flags);
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::PerlComment;
@W3C::Grammar::YaccCompileTree::PerlComment::ISA = 'W3C::Grammar::YaccCompileTree::COMMENT';
sub prefix {'#'}
sub postfix {''}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ch = '';
    my $line = $self->{LineNo};
    my $ws = $self->{LeadWS};
    my $parser = $self->{Parser};
    my $nLit = new W3C::Grammar::YaccCompileTree::LLITERAL("$ws$ch", $line, $parser);
    return new W3C::Grammar::YaccCompileTree::LiteralSolution($nLit);
}

package W3C::Grammar::YaccCompileTree::CComment;
@W3C::Grammar::YaccCompileTree::CComment::ISA = 'W3C::Grammar::YaccCompileTree::COMMENT';
sub prefix {'/*'}
sub postfix {'*/'}

package W3C::Grammar::YaccCompileTree::TokenBase;
@W3C::Grammar::YaccCompileTree::TokenBase::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;

sub new {
    my ($proto, $token, $lineNo, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Token} = $token;
    $self->{LineNo} = $lineNo;
    $self->check();
    return $self;
}
sub getToken {
    my ($self) = @_;
    return $self->{Token};
}
sub getLineNo {
    my ($self) = @_;
    return $self->{LineNo};
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    return $self->{Token};
}
sub toString999 {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = $self->prefix();
    my $str = $self->{Token};
    if (my $quoter = $flags{Quoter}) {
	$str = &{$quoter}($str);
    }
    $ret .= $flags{Markup} eq 'html' ? "<span class=\"prod\"><a class=\"grammarRef\" href=\"#prod-$flags{LanguageName}$str\">$str</a></span>" : $str;
    if ($flags{LineNumbers}) {
	$ret .= " ($self->{LineNo})";
    }
    $ret .= $self->postfix();
    return $ret;
}
sub prefix {''}
sub postfix {''}

@W3C::Grammar::YaccCompileTree::TAILCODE::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';

package W3C::Grammar::YaccCompileTree::IDENT;
@W3C::Grammar::YaccCompileTree::IDENT::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
use W3C::Util::Exception;
sub new {
    my ($proto, $token, $lineNo, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($token, $lineNo, @particleParms);
    $self->{Reference} = undef;
    $self->check();
    return $self;
}
sub setTerminal {
    my ($self, $terminalNess) = @_;
    $self->{Terminalness} = $terminalNess;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    if (defined $self->{Reference}) {
	return;
    }
    my $name = $self->getToken();
    my $production = $grammar->getProductionByName($name);
    if (!$production) {
	&throw(new W3C::Util::Exception(-message => "found no production called \"$name\" at $self->{LineNo}"));
    }
    $self->{Reference} = $production;
    $self->{Reference}->resolveIDENTS($grammar);
}
sub getDistinguishedToken {
    my ($self) = @_;
    return $self->SUPER::getToken(); # $self->_distinguish($self->SUPER::getToken());
}
sub getTokenName {
    my ($self) = @_;
    return $self->getToken();
}
sub getToken2 {
    my ($self) = @_;
    return &W3C::Grammar::YaccCompileTree::NameMap($self->{Token});
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return $self->{Reference}->flattenCharacterClass($target);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $name = $self->getToken();
    my $production = $grammar->getProductionByName($name);
    if (!$production) {
	&throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
    }
    if ($production != $self->{Reference}) {&throw(new W3C::Util::Exception(-message => "$self production confusion: $production != $self->{Reference} for ".$self->toString()));}
    return $production->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = $self->prefix();

    my $name = $self->_distinguish($self->{Token}); # @@@ $self->SUPER::toString(%flags));
    if (my $quoter = $flags{Quoter}) {
	$name = &{$quoter}($name);
    }

    if (my $lang = $flags{Stubs}) {
	if (exists $flags{TerminalDependsOn}) {
	    $flags{TerminalDependsOn}{$name} = $self;
	}
	if ($flags{GenSpec}->getExpandTerminals() && $flags{InTerminal}) { # && $self->{Terminalness}) { #$flags{TerminalRefs}) { #
	    my $grammar = $flags{Grammar};
	    my $name2 = $self->getToken();
	    my $production = $grammar->getProductionByName($name2);
	    my %newFlags = map {$_ => $flags{$_}} grep {$_ ne 'TerminalPatterns'} keys %flags;
	    my $expandedSub = $production->toString(%newFlags);
	    $ret .= "(?:$expandedSub)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    $ret .= $flags{TerminalRefs} ? "(?:\${$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    $ret .= $flags{TerminalRefs} ? "({$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    $ret .= $flags{TerminalRefs} ? "(?:{$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    $ret .= $flags{TerminalRefs} ? "(?:{$name})" : $name;
	} else {
	    &throw(new W3C::Util::ProgramFlowException());
	}
    } elsif (exists $flags{Markup} && $flags{Markup} eq 'html') {
	my $name = $self->_distinguish($self->{Token});
	$ret .= $self->{InTerminal} ? # $self->{Terminalness} ? 
	    "&lt;<span class=\"term\"><a class=\"grammarRef\" href=\"#term-$flags{LanguageName}$name\">$self->{Token}</a></span>&gt;" : 
	    "<span class=\"prod\"><a class=\"grammarRef\" href=\"#prod-$flags{LanguageName}$name\">$name</a></span>";
    } else {
	$ret .= $name;
    }
    $ret .= $self->postfix();
    return $ret;
}
sub _distinguish {
    my ($self, $str) = @_;
    return $str; # $self->{Terminalness} ? "T_$str" : $str;
}
sub toString999 {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = $self->prefix();
    my $str = $self->{Token};
    if (my $quoter = $flags{Quoter}) {
	$str = &{$quoter}($str);
    }
    $ret .= $flags{Markup} eq 'html' ? "<span class=\"prod\"><a class=\"grammarRef\" href=\"#prod-$flags{LanguageName}$str\">$str</a></span>" : $str;
    if ($flags{LineNumbers}) {
	$ret .= " ($self->{LineNo})";
    }
    $ret .= $self->postfix();
	if (exists $flags{TerminalDependsOn}) {
	    $flags{TerminalDependsOn}{$self->{Token}} = $self;
	}
    return $ret;
}

package W3C::Grammar::YaccCompileTree::LITERAL;
@W3C::Grammar::YaccCompileTree::LITERAL::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
use W3C::Util::Exception;
sub getToken {
    my ($self) = @_;
    return &W3C::Grammar::YaccCompileTree::NameMap($self->{Token});
}
sub getText {
    my ($self) = @_;
    return $self->{Token};
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    my $t = $self->getText();
    $target->addRange($t, $t);
    return 1;
}

package W3C::Grammar::YaccCompileTree::LLITERAL;
@W3C::Grammar::YaccCompileTree::LLITERAL::ISA = 'W3C::Grammar::YaccCompileTree::LITERAL';
use W3C::Util::Exception;
sub getTokenName {
    my ($self) = @_;
    my $name = $self->{Token};
    if ($name =~ m/^[a-zA-Z_][a-zA-Z_0-9]*$/) {
	# IT_ for internal token, i.e. quoted text
	return "IT_$name";
    } else {
	# IT_ for generated (internal) token, i.e. quoted non-name chars like ";"
	if (my $mapped = &W3C::Grammar::YaccCompileTree::NameMap($name)) { # make sure every non-char pattern has a string name
	    return "GT_$mapped";
	} else {
	    &throw(new W3C::Util::Exception(-message => "no map for \"$name\""));
	}
    }
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    return new W3C::Grammar::YaccCompileTree::LiteralSolution($self);
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = $self->prefix();
    my $str = $self->{Token};
    if ($flags{TerminalPatterns}) {
	my $name = $self->getTokenName();
	my $pattern = $self->{Token};
	if (my $quoter = $flags{Quoter}) {
	    $pattern = &{$quoter}($pattern);
	}
	if (!grep {$_->[0] eq $name} @{$flags{TerminalPatterns}}) {
	    # Create the terminal.
	    my $assign;
	    if (my $lang = $flags{Stubs}) {
		if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
		    $assign = "my \$$name = \"$pattern\";\n";
		} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
		    $pattern = $pattern =~ m/^[A-Z]+$/ ? join('', map {'['.chr($_).chr($_+32).']'} unpack('c*', $pattern)) : "\"$pattern\"";
		    $assign = "$name		$pattern\n";
		} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
		    $pattern = "\"$pattern\"";
		    $assign = " $name	cfg:matches	$pattern;\n	a cfg:Token . \n";
		} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
		    $pattern = "'$pattern'";
		    # $assign = "t_$name = u$pattern\n";
		    $assign = "    token $name: $pattern\n";
		} else {
		    &throw(new W3C::Util::ProgramFlowException());
		}
	    }
	    push (@{$flags{TerminalPatterns}}, [$name, scalar @{$flags{TerminalPatterns}}, {}, $assign, 1, 0]);
	}
	if (exists $flags{TerminalDependsOn}) {
	    $flags{TerminalDependsOn}{$name} = $self;
	}
	return $name;
    } elsif ($str =~ m/^\\u([0-9a-fA-F]+)$/) {
	if (my $lang = $flags{Stubs}) {
	    if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
		$ret .= "\\x{$1}";
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
		$ret .= "\\x$1";
	    } else {
		&throw(new W3C::Util::ProgramFlowException());
	    }
	} else {
	    $ret .= $str;
	}
    } else {
	if (my $quoter = $flags{Quoter}) {
	    $str = &{$quoter}($str);
	}
	if (my $lang = $flags{Stubs}) {
	    if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
		$ret .= $str;
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
		# @@@ Need a flag for encoding
		if (ord($self->{Token}) > 0x7f) {
		    $str = $self->{Token};
		    &utf8::encode($str);
		    $ret .= $flags{Quoter}($str);
		    # $str = W3C::Grammar::CharacterRange::compileUTF8range($self->{Token}, $self->{Token}, sub {$flags{Quoter}(chr($_[0]), chr($_[1]))});
		} else {
		    $ret .= $flags{CharacterClass} ? $str : "\"$str\"";
		}
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
		$ret .= $str;
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
		$ret .= $str;
	    } else {
		&throw(new W3C::Util::ProgramFlowException());
	    }
	} elsif ($flags{SingleQuote}) {
	    my $str = $self->{Token};
	    if ($str =~ m/\'/) {
		&throw(new W3C::Util::Exception(-message => "deal with single quoted single quote"));
	    }
	    $ret .= "\'$str\'";
	} else {
	    # quote-escape the string
	    $str =~ s/\\/\\\\/g;
	    $str =~ s/\r/\\r/g;
	    $str =~ s/\n/\\n/g;
	    $str =~ s/\t/\\t/g;
	    if ($str =~ s/([^\x20-\x7f])/sprintf("#%04X",ord($1))/eg) {
		$ret .= $str;
	    } elsif (exists $flags{CharacterClass} && $flags{CharacterClass} && 
		     exists $flags{LexFormat} && $flags{LexFormat} eq 'XMLSpec') {
		$str =~ s/\"/\\\"/g;
		$ret .= "$str";
	    } elsif ($str =~ m/\"/ && $str !~ m/\'/) {
		$ret .= "'$str'";
	    } else {
		$str =~ s/\"/\\\"/g;
		$ret .= "\"$str\"";
	    }
	}
    }
    if ($flags{LineNumbers}) {
	$ret .= " ($self->{LineNo})";
    }
    $ret .= $self->postfix();
    return $ret;
}

@W3C::Grammar::YaccCompileTree::CODE::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';

package W3C::Grammar::YaccCompileTree::ASSOC;
@W3C::Grammar::YaccCompileTree::ASSOC::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
sub prefix {'%'}

@W3C::Grammar::YaccCompileTree::START::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
@W3C::Grammar::YaccCompileTree::EXPECT::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';

package W3C::Grammar::YaccCompileTree::HEADCODE;
@W3C::Grammar::YaccCompileTree::HEADCODE::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
sub prefix {"%{"}
sub postfix {"%}\n"}

package W3C::Grammar::YaccCompileTree::TOKEN;
@W3C::Grammar::YaccCompileTree::TOKEN::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
sub prefix {'%token'}

@W3C::Grammar::YaccCompileTree::TYPE::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
@W3C::Grammar::YaccCompileTree::UNION::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
@W3C::Grammar::YaccCompileTree::NUMBER::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';
@W3C::Grammar::YaccCompileTree::PREC::ISA = 'W3C::Grammar::YaccCompileTree::TokenBase';

package W3C::Grammar::YaccCompileTree::Terminal;
@W3C::Grammar::YaccCompileTree::Terminal::ISA = 'W3C::Grammar::YaccCompileTree::LITERAL';
use W3C::Util::Exception;
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    if (defined $self->{Reference}) {
	return;
    }
    my $name = $self->getToken();
    my $production = $grammar->getProductionByName($name);
    if (!$production) {
	&throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
    }
    $self->{Reference} = $production;
    $self->{Reference}->resolveIDENTS($grammar);
}
sub getToken {
    my ($self) = @_;
    return $self->_distinguish($self->SUPER::getToken());
}
sub getToken2 {
    my ($self) = @_;
    return $self->SUPER::getToken();
}
sub getDistinguishedToken {
    my ($self) = @_;
    return $self->_distinguish($self->SUPER::getToken());
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $name = $self->getToken();
    my $production = $grammar->getProductionByName($name);
    if (!$production) {
	&throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
    }
    if ($production != $self->{Reference}) {print new W3C::Util::Exception(-message => "$self production confusion: $production != $self->{Reference} for ".$self->toString())->toString(), "\n";}
    return $production->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    if (my $lang = $flags{Stubs}) {
	my $name = $self->_distinguish($self->{Token}); # @@@ $self->SUPER::toString(%flags));
	if (my $quoter = $flags{Quoter}) {
	    $name = &{$quoter}($name);
	}
	if (exists $flags{TerminalDependsOn}) {
	    $flags{TerminalDependsOn}{$name} = $self;
	}
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return $flags{TerminalRefs} ? "(?:\${$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return $flags{TerminalRefs} ? "({$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return $flags{TerminalRefs} ? "(?:{$name})" : $name;
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return $flags{TerminalRefs} ? "(?:{$name})" : $name;
	} else {
	    &throw(new W3C::Util::ProgramFlowException());
	}
    } elsif (exists $flags{Markup} && $flags{Markup} eq 'html') {
	my $name = $self->_distinguish($self->{Token});
	return "&lt;<span class=\"term\"><a class=\"grammarRef\" href=\"#term-$flags{LanguageName}$name\">$self->{Token}</a></span>&gt;";
    } else {
	return $self->{Token}
    }
}
sub _distinguish {
    my ($self, $str) = @_;
    return "T_$str";
}

package W3C::Grammar::YaccCompileTree::POS;
@W3C::Grammar::YaccCompileTree::POS::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $value, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Desc} = $self->pos();
    $self->{Value} = $value;
    $self->check();
    if ($value->isa('W3C::Grammar::YaccCompileTree::Symb')) {
	&throw(new W3C::Util::Exception(-message => $self->toString()));
    }
    return $self;
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    my $ret = [];
    foreach my $seq (@$opts) {
	push (@$ret, [@$seq, $self]);
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::Symb;
@W3C::Grammar::YaccCompileTree::Symb::ISA = 'W3C::Grammar::YaccCompileTree::POS';
use W3C::Util::Exception;
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    if (defined $self->{Reference}) {
	return;
    }
    my $val = $self->getValue();
    if (!$val->isa('W3C::Grammar::YaccCompileTree::LLITERAL')) {
    my $name = $val->getToken();
    my $production = $grammar->getProductionByName($name);
    if (!$production) {
	&throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
    }
    $self->{Reference} = $production;
    $self->{Reference}->resolveIDENTS($grammar);
    }
}
sub getLineNo {
    my ($self) = @_;
    return $self->{Value}->getLineNo();
};
sub pos {'SYMB'}
sub getProductionName {
    my ($self) = @_;
    my $str = $self->{Value}->getTokenName();
    return "_Q${str}_E";
}
sub getBareProductionName {
    my ($self) = @_;
    return $self->{Value}->getTokenName();
}
sub getValue {
    my ($self) = @_;
    return $self->{Value};
}
sub getElts {
    my ($self) = @_;
    return $self;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $val = $self->getValue();
    if ($val->isa('W3C::Grammar::YaccCompileTree::LLITERAL')) {
	my $ret = new W3C::Grammar::YaccCompileTree::Solution();
	$ret->concat(new W3C::Grammar::YaccCompileTree::LiteralSolution($val));
	return $ret;
    } else {
	my $name = $val->getToken();
	my $production = $grammar->getProductionByName($name);
	if (!$production) {
	    &throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
	}
	if ($production != $self->{Reference}) {&throw(new W3C::Util::Exception(-message => "$self production confusion: $production != $self->{Reference} for ".$self->toString()));}
	return $production->solve($policy, $grammar, $explore);
    }
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = '';
    if ($flags{Types}) {
	$ret .= "$self->{Desc} ";
    }
    $ret .= $self->{Value}->toString(%flags);
    return $ret;
}

package W3C::Grammar::YaccCompileTree::GenSymb;
@W3C::Grammar::YaccCompileTree::GenSymb::ISA = 'W3C::Grammar::YaccCompileTree::Symb';
use W3C::Util::Exception;
sub new {
    my ($proto, $value, $generator, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($value, @particleParms);
    $self->{Generator} = $generator;
    return $self;
}

package W3C::Grammar::YaccCompileTree::LSymb;
@W3C::Grammar::YaccCompileTree::LSymb::ISA = 'W3C::Grammar::YaccCompileTree::Symb';
use W3C::Util::Exception;
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{Value}->resolveIDENTS($grammar);
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return $self->{Value}->flattenCharacterClass($target);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    return $self->{Value}->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    # We want TerminalPatterns from productions:
    # Line 	   ::=    	Word* "end"
    # but not from Terminals:
    # <WORD> 	   ::=    	[ "a"-"z","A"-"Z" ]+
    # LSymb is only used in Terminals so hide the TerminalPatterns aggregator.
    %flags = (%flags, TerminalPatterns => undef);
    my $ret = '';
    if (exists $flags{GenSpec} && $flags{GenSpec}->getExpandTerminals()) {
	my $name = $self->getValue()->getToken();
	my $production = $flags{Grammar}->getProductionByName($name);
	if ($production) {
	    my $expanded = $production->toString(%flags);
	    $ret .= "(?:$expanded)"; # reached by W3C::Grammar::GenSpec::Python
	} else {
#	    &throw(new W3C::Util::Exception(-message => "$self found no production called \"$name\""));
	    $ret .= $self->{Value}->toString(%flags);
	}
    } else {
	$ret = $self->SUPER::toString(%flags);
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::Group;
@W3C::Grammar::YaccCompileTree::Group::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $open, $value, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Unused0} = undef; # not used
    $self->{Value} = $value;
    $self->{Group} = $open;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{Value}->resolveIDENTS($grammar);
}
sub getLineNo {
    my ($self) = @_;
    return $self->{Group}->getLineNo();
};
sub pos {'??Group??'}
sub getProductionName {
    my ($self) = @_;
    return $self->{Value}->getProductionName();
}
sub getNestedProduction {
    my ($self) = @_;
    return $self->{Value}->getBareProductionName();
}
sub getNameMod {'_Group'}
sub getElts {
    my ($self) = @_;
    return $self->{Value};
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    my $name = '_O'.$self->{Value}->getProductionName().'_C';

    my ($list, @args) = @$productionList;
    my $ruleOpts = new W3C::Grammar::YaccCompileTree::RuleOptions($self->{Value}->toDNF([[]], $productionList, $parserType), sub {return 0;}, $self->{Parser});
    my $ref = $list->getNextProductionName($name, $self, @args);
    $ref = $list->ensureProductionByName($name, $ref, $ruleOpts, $self, @args);

    # Tricky bit: become the identInfo; !!! un-java-able -- will need union
    my $old = {};
    foreach my $key (keys %$self) {
	$old->{$key} = $self->{$key};
	delete $self->{$key};
    }
    bless ($old, ref $self);
    foreach my $key (keys %$ref) {
	$self->{$key} = $ref->{$key};
    }
    bless ($self, ref $ref);
    $self->{Old} = $old;

    my $ret = [];
    foreach my $seq (@$opts) {
	push (@$ret, [@$seq, $ref]);
    }
    # $self->{Value} = 1;
    return $ret;
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return 0;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    return $self->{Value}->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return '('.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return '('.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return '('.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return '('.$self->{Value}->toString(%flags).')'; # MARK1X
	} else {&throw();}
    } else {
	my @ret;
	if ($flags{Types}) {
	    push (@ret, $self->{Unused0});
	}
	push (@ret, '(');
	push (@ret, $self->{Value}->toString(%flags));
	push (@ret, ')');
	return join (' ', @ret);
    }
}

package W3C::Grammar::YaccCompileTree::LGroup;
@W3C::Grammar::YaccCompileTree::LGroup::ISA = 'W3C::Grammar::YaccCompileTree::Group';
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return '(?:'.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return '('.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return '(?:'.$self->{Value}->toString(%flags).')';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return '(?:'.$self->{Value}->toString(%flags).')';
	} else {&throw();}
    } else {
	my @ret;
	if ($flags{Types}) {
	    push (@ret, $self->{Unused0});
	}
	push (@ret, '(');
	push (@ret, $self->{Value}->toString(%flags));
	push (@ret, ')');
	return join (' ', @ret);
    }
}

package W3C::Grammar::YaccCompileTree::Code;
@W3C::Grammar::YaccCompileTree::Code::ISA = 'W3C::Grammar::YaccCompileTree::POS';
sub pos {'CODE'}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
}
sub getLineNo999 {
    my ($self) = @_;
    return $self->{Value}->getLineNo();
};
sub getCode {
    my ($self) = @_;
    return $self->{Value};
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $ret = '';
    if ($flags{Code}) {
	if ($flags{Types}) {
	    $ret .= "$self->{Desc} ";
	}
	$ret .= $self->{Value}->toString(%flags);
    }
    if ($flags{AddActions}) {
	$flags{Stubs}->addAction($flags{ActionName}, $self->{Value});
    }
    return $ret;
}
# </POS>

# <Modifier>
package W3C::Grammar::YaccCompileTree::Modifier;
@W3C::Grammar::YaccCompileTree::Modifier::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $modified, $marker, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Modified} = $modified;
    $self->{DNFed} = 0; # new productions must be DNF
    $self->{Marker} = $marker;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{Modified}->resolveIDENTS($grammar);
}
sub getLineNo {
    my ($self) = @_;
    return $self->{Marker}->getLineNo();
};
sub _permute {
    my ($self, $baseText, $appendText) = @_;
}
sub getProductionName {
    my ($self) = @_;
    return $self->{Modified}->getProductionName().$self->getNameMod();
}
sub getNestedProduction {
    my ($self) = @_;
    return $self->{Modified}->getBareProductionName();
}
sub getPreferredPolicy {
    my ($self, $visited) = @_;
    return $self->preferredVisitations() > $visited->{$self}++ ? 1 : 0;
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;

    my $nestedOpts = $self->{Modified}->toDNF([[]], $productionList, $parserType);
    my ($leadRefs, $ref) = $self->getRhss($productionList, $nestedOpts, $parserType);

    # Tricky bit: become the identInfo; !!! un-java-able -- will need union
    my $old = {};
    foreach my $key (keys %$self) {
	$old->{$key} = $self->{$key};
	delete $self->{$key};
    }
    bless ($old, ref $self);
    foreach my $key (keys %$ref) {
	$self->{$key} = $ref->{$key};
    }
    bless ($self, ref $ref);
    $self->{Old} = $old;

    my $ret = [];
    foreach my $seq (@$opts) {
	push (@$ret, [@$seq, @$leadRefs, $ref]);
    }
    $self->{DNFed} = 1;
    return $ret;
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return 0;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ret = new W3C::Grammar::YaccCompileTree::Solution();
    while ($policy->getRuleNo($self)) {
	$ret->concat($self->{Modified}->solve($policy, $grammar, $explore));
    }
    # @@@ think hard about how we really decide when we've seen enough of a solution
    $policy->clearVisitations($self);
    return $ret;
}
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    my $str = $self->{Modified}->toString(%flags);
    my $postfix .= $self->postfix();
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return "(?:$str)$postfix";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return "($str)$postfix";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return "(?:$str)$postfix";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return "($str)$postfix";
	} else {&throw();}
    } else {
	return "($str)$postfix";
    }
}

package W3C::Grammar::YaccCompileTree::Star;
@W3C::Grammar::YaccCompileTree::Star::ISA = 'W3C::Grammar::YaccCompileTree::Modifier';
sub postfix {'*'}
sub getNameMod {'_Star'}
sub preferredVisitations {3}
sub getRhss {
    my ($self, $productionList, $opts, $parserType) = @_;
    my ($list, @args) = @$productionList;
    my $name = $self->getProductionName(); # better name after {Modifed}->toDNF
    my $identInfo = $list->getNextProductionName($name, $self, @args);

    my $ret = [];
    foreach my $seq (@$opts) {
	my $empty = [[]];
	my $loop_members = $parserType->LL() ? [[@$seq, $identInfo]] : [[$identInfo, @$seq]];
	push (@$ret, @$empty, @$loop_members);
    }
    my $prefVisits = $self->preferredVisitations();
    my $rhss = new W3C::Grammar::YaccCompileTree::RuleOptions($ret, sub {return $_[0] >= $prefVisits ? 0 : 1;}, $self->{Parser});
    return ([], $list->ensureProductionByName($name, $identInfo, $rhss, $self, @args));
}

package W3C::Grammar::YaccCompileTree::Opt;
@W3C::Grammar::YaccCompileTree::Opt::ISA = 'W3C::Grammar::YaccCompileTree::Modifier';
sub postfix {'?'}
sub getNameMod {'_Opt'}
sub preferredVisitations {1}
sub getRhss {
    my ($self, $productionList, $opts, $parserType) = @_;
    my ($list, @args) = @$productionList;
    my $name = $self->getProductionName(); # better name after {Modifed}->toDNF
    my $identInfo = $list->getNextProductionName($name, $self, @args);

    my $ret = [];
    foreach my $seq (@$opts) {
	my $empty = [[]];
	my $members = [$seq];
	push (@$ret, @$empty, @$members);
    }
    my $prefVisits = $self->preferredVisitations();
    my $rhss = new W3C::Grammar::YaccCompileTree::RuleOptions($ret, sub {return $_[0] >= $prefVisits ? 0 : 1;}, $self->{Parser});
    return ([], $list->ensureProductionByName($name, $identInfo, $rhss, $self, @args));
}

package W3C::Grammar::YaccCompileTree::Plus;
@W3C::Grammar::YaccCompileTree::Plus::ISA = 'W3C::Grammar::YaccCompileTree::Modifier';
sub postfix {'+'}
sub getNameMod {'_Plus'}
sub preferredVisitations {2}
sub getRhss {
    my ($self, $productionList, $opts, $parserType) = @_;
    my ($list, @args) = @$productionList;
    my $name = $self->getProductionName(); # better name after {Modifed}->toDNF
    my $identInfo = $list->getNextProductionName($name, $self, @args);

    my $ret = [];
    my @prefix;
    foreach my $seq (@$opts) {
	if ($parserType->LL()) {
	    my $empty = [[]];
	    push (@prefix, @$seq); # !!! Only works for single option. !!!
	    my $loop_members = [[@$seq, $identInfo]];
	    push (@$ret, @$empty, @$loop_members);
	} else {
	    my $one = [$seq];
	    my $loop_members = [[$identInfo, @$seq]];
	    push (@$ret, @$one, @$loop_members);
	}
    }
    my $prefVisits = $self->preferredVisitations();
    my $rhss = new W3C::Grammar::YaccCompileTree::RuleOptions($ret, sub {return $_[0] >= $prefVisits ? 0 : 1;}, $self->{Parser});
    return ([@prefix], $list->ensureProductionByName($name, $identInfo, $rhss, $self, @args));
}
# </Modifier>

package W3C::Grammar::YaccCompileTree::PrecDecl;
@W3C::Grammar::YaccCompileTree::PrecDecl::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
sub new {
    my ($proto, $precInfo, $typedecl, $symlist, $comments, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{PrecInfo} = $precInfo;
    $self->{TypeDecl} = $typedecl;
    $self->{SymList} = $symlist;
    $self->{Comments} = $comments;
    $self->check();
    return $self;
}
sub getTypedecl {
    my ($self) = @_;
    return $self->{PrecInfo};
}
sub getSymlist {
    my ($self) = @_;
    return $self->{TypeDecl};
}

sub toString {
    my ($self, %flags) = @_;
    my $ret = $self->{PrecInfo}->toString(%flags);
    if ($self->{TypeDecl}) {
	$ret .= ' '.$self->{TypeDecl}->toString(%flags);
    }
    foreach my $sym (@{$self->{SymList}}) {
	$ret .= ' '.$sym->toString(%flags);
    }
    foreach my $sym (@{$self->{Comments}}) {
	$ret .= $sym->toString(%flags);
    }
    return "$ret\n";
}

@W3C::Grammar::YaccCompileTree::TokenDecl::ISA = 'W3C::Grammar::YaccCompileTree::PrecDecl';
@W3C::Grammar::YaccCompileTree::AssocDecl::ISA = 'W3C::Grammar::YaccCompileTree::PrecDecl';

@W3C::Grammar::YaccCompileTree::Set::ISA = 'W3C::Grammar::YaccCompileTree::Particle';

package W3C::Grammar::YaccCompileTree::Rule;
@W3C::Grammar::YaccCompileTree::Rule::ISA = 'W3C::Grammar::YaccCompileTree::Set';
sub new {
    my ($proto, $rhs, $prec, $code, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{RHS} = $rhs;
    $self->{Prec} = $prec;
    $self->{Code} = $code; # may be epscode
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{RHS}->resolveIDENTS($grammar);
}
sub getRhs {
    my ($self) = @_;
    return $self->{RHS};
}
sub getPrec {
    my ($self) = @_;
    return $self->{Prec};
}
sub getCode {
    my ($self) = @_;
    return $self->{Code};
}
sub getProductionName {
    my ($self) = @_;
    return $self->{RHS}->getProductionName();
}
sub getBareProductionName {
    my ($self) = @_;
    return $self->getProductionName();
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    return $self->{RHS}->toDNF($opts, $productionList, $parserType);
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return $self->{RHS}->flattenCharacterClass($target);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    return $self->{RHS}->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = @_;
    my @ret;
    push (@ret, $self->{RHS} ? $self->{RHS}->toString(%flags) : "    # empty\n");
    if ($self->{Prec}) {
	push (@ret, "%prec $self->{Prec}");
    }
    my $ret = join(' ', @ret);
    if ($self->{Code}) {
	$ret .= "\n{".$self->{Code}->toString(%flags).'}';
    }    if ($flags{AddActions}) {&throw();}
    return $ret;
}

package W3C::Grammar::YaccCompileTree::EmptyRule;
@W3C::Grammar::YaccCompileTree::EmptyRule::ISA = 'W3C::Grammar::YaccCompileTree::Particle'; # not a Set
sub new {
    my ($proto, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
}
sub getProductionName {
    my ($self) = @_;
    return 'empty';
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    return [[]];
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ch = new W3C::Grammar::YaccCompileTree::LLITERAL('', 0, $self->{Parser});
    return new W3C::Grammar::YaccCompileTree::LiteralSolution($ch);
}
sub toString {
    my ($self, %flags) = @_;
    return '';
}

package W3C::Grammar::YaccCompileTree::LRule;
@W3C::Grammar::YaccCompileTree::LRule::ISA = 'W3C::Grammar::YaccCompileTree::Rule';

sub newNUKE {
    my ($proto, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
#    my $flatRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
#    $self->{RHS}->flattenCharacterClass($flatRangeList);
#    $flatRangeList = $flatRangeList->getAscendingRanges();

#    if ($self->{Negated}) {
#	$self->{FlatRanges} = [[0, 0x10ffff]];
#	&W3C::Grammar::CharacterRange::FlatRangeList::_substractRange($self->{FlatRanges}, $flatRangeList);
#    } else {
#	$self->{FlatRanges} = $flatRangeList;
#    }
#    foreach my $exclusion (@{$self->{Excluded}}) {
#	my $excludeRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
#	$exclusion->getLRangeList()->flattenCharacterClass($excludeRangeList);
#	&W3C::Grammar::CharacterRange::FlatRangeList::_substractRange($self->{FlatRanges}, $excludeRangeList->getAscendingRanges());
#    }
    $self->check();
    return $self;
}
sub toString {
    my ($self, %flags) = @_;
    my @ret;
    push (@ret, $self->{RHS} ? $self->{RHS}->toString(%flags, ) : "    # empty\n");
    my $ret = join(' ', @ret);
    if ($self->{Code}) {
	$ret .= "\n{".$self->{Code}->toString(%flags).'}';
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::FlatRule;
@W3C::Grammar::YaccCompileTree::FlatRule::ISA = 'W3C::Grammar::YaccCompileTree::Rule';
use W3C::Util::Exception;
sub getParticles {
    my ($self) = @_;
    return @{$self->{RHS}};
}
sub toString {
    my ($self, %flags) = @_;
    my @ret;
    my @lines;
    my $lastSeqIsCode = 0;
    my @particles = $self->getParticles();
    for (my $i = 0; $i < @particles; $i++) {
	my $seq = $particles[$i];
	push (@lines, $seq->toString(%flags, ActionName => join(' ', ($flags{ProductionName} || '<unknown>'), @lines)));
	$lastSeqIsCode = $seq->isa('W3C::Grammar::YaccCompileTree::Code');
    }
    push (@ret, join(' ', @lines));
    if ($flags{AddActions} && !$lastSeqIsCode) {
	# Note that the production was declared.
	$flags{Stubs}->addProduction(join(' ', $flags{ProductionName}, @lines), $self);
    }
    if ($self->{Prec}) {
	push (@ret, $self->{Prec});
    }
    my $ret = join(' ', @ret);
    if (my $lang = $flags{Stubs}) {
	my $argNames = [];
	my $argHash = {};
	foreach my $el ($self->getParticles()) {
	    if ($el->isa('W3C::Grammar::YaccCompileTree::Code')) {
	    } else {
		my $candidate = $el->getValue()->getTokenName();
		my $type = $candidate;
		# !!! horrible hack dealing with un-java-able hack below
		my $generator = $el->isa('W3C::Grammar::YaccCompileTree::GenSymb') ? 
		    $flags{Grammar}->getProductionByName($el->{Generator}{Old}->getProductionName()) : undef;
		while ($argHash->{$candidate}) {
		    $candidate .= '_';
		}
		$argHash->{$candidate} = $el;
		push (@$argNames, [$type, $candidate, $generator]);
	    }
	}
	if ($ret) {
	    $ret .= '	';
	}
	if ($flags{AddActions}) {
	} else {
	    $ret .= $lang->getActionStr($flags{ProductionName}, $argNames, \@lines, $flags{IsStartRule} && ${$flags{IsStartRule}}, !$flags{SuppressLineDirectives}, $flags{CallConstructor}, $flags{RuleNo}, $flags{Nests}, $flags{DeleteRuleNo}, $flags{IsaMultProd}, $flags{Macros});
	}
    } elsif ($self->{Code}) {
	$ret .= "\n{".$self->{Code}->toString(%flags).'}';    if ($flags{AddActions}) {&throw();}
    }
    return $ret;
}


package W3C::Grammar::YaccCompileTree::RuleOptions;
@W3C::Grammar::YaccCompileTree::RuleOptions::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
sub new {
    my ($proto, $list, $preferredPolicy, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Rules} = [];
    $self->{PreferredPolicy} = $preferredPolicy;
    foreach my $opt (@$list) {
	push (@{$self->{Rules}}, new W3C::Grammar::YaccCompileTree::FlatRule($opt, undef, undef, @particleParms));
    }
    $self->check();
    return $self;
}
sub getRules {
    my ($self) = @_;
    return $self->{Rules};
}
sub getPreferredPolicy {
    my ($self, $visited) = @_;
    return &{$self->{PreferredPolicy}}($visited->{$self}++);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ruleNo = $policy->getRuleNo($self);
    $policy->addBranch($ruleNo);
    my $solutions = {};
    my $ret = new W3C::Grammar::YaccCompileTree::Solution();
    foreach my $atom ($self->{Rules}[$ruleNo]->getParticles()) {
	my $name = $atom->getProductionName();
	my $soln = $atom->solve($policy, $grammar, $explore);
	if (my $t = $solutions->{$name}) {push (@$t, $soln);} else {$solutions->{$name} = [$soln];}
	$ret->concat($soln);
    }
    if ($explore) {
	if ($ruleNo > 0) {
	    $ret->setPrevOpt($self->_explore($ruleNo - 1, $solutions, $policy->clone(), $grammar));
	}
	if ($ruleNo < @{$self->{Rules}}-1) {
	    $ret->setNextOpt($self->_explore($ruleNo + 1, $solutions, $policy->clone(), $grammar));
	}
    }
    return $ret;
}
sub _explore {
    my ($self, $ruleNo, $solutions, $policy, $grammar) = @_;
    my $ret = new W3C::Grammar::YaccCompileTree::Solution();

    # Make a copy of the solutions so we can alter them as we calculate.
    my $copy = {};
    foreach my $name (keys %$solutions) {
	$copy->{$name} = [@{$solutions->{$name}}];
    }

    foreach my $atom ($self->{Rules}[$ruleNo]->getParticles()) {
	my $name = $atom->getProductionName();
	my $soln;
	if (my $t = $copy->{$name}) {
	    $soln = shift (@$t);
	    if (!@$t) {
		delete $copy->{$name};
	    }
	} else {
	    # Any ReferencePolicy should be exhausted by the first pass through the
	    # rules. getRuleNo calls should be hanled by the fallback policy.
	    $soln = $atom->solve($policy, $grammar, 0);
	    $ret->concat($soln);
	}
    }
    return $ret;
}
sub toString {
    my ($self, %flags) = @_;
    my $ret = '';
    my $follower = '    ';
    for (my $ruleNo = 0; $ruleNo < @{$self->{Rules}}; $ruleNo++) {
	my $rule = $self->{Rules}[$ruleNo];
	my %ruleNoFlags = ();
	if (@{$self->{Rules}} > 1) {
	    $ruleNoFlags{RuleNo} = $ruleNo;
	}
	my $ruleStr = $rule->toString(%flags, %ruleNoFlags);
#	if ($ruleStr eq "") {
#	    $ruleStr = "empty";
#        }
	$ret .= "$follower$ruleStr";
	if (UNIVERSAL::isa($flags{Stubs}, 'W3C::Grammar::GenSpec::N3')) {
	    $follower = "\n   ";
	} else {
	    $follower = "\n    | ";
	}
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::Sequence;
@W3C::Grammar::YaccCompileTree::Sequence::ISA = 'W3C::Grammar::YaccCompileTree::Set';
use W3C::Util::Exception;
sub new {
    my ($proto, $l, $r, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Left} = $l;
    $self->{Right} = $r;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{Left}->resolveIDENTS($grammar);
    $self->{Right}->resolveIDENTS($grammar);
}
sub getL {
    my ($self) = @_;
    return $self->{Left};
}
sub getR {
    my ($self) = @_;
    return $self->{Right};
}
sub getProductionName {
    my ($self) = @_;
    my @parts;
    foreach my $elt ($self->{Left}, $self->{Right}) {
	my $str = $elt->getProductionName();
	push (@parts, $str);
    }
    return join('_S', @parts);
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    my $ret = [];
    foreach my $seq (@$opts) {
	my $lDNF = $self->{Left}->toDNF([$seq], $productionList, $parserType);
	foreach my $subseq (@$lDNF) {
	    my $rDNF = $self->{Right}->toDNF([$subseq], $productionList, $parserType);
	    push (@$ret, @$rDNF);
	}
    }
    return $ret;
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return 0;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ret = new W3C::Grammar::YaccCompileTree::Solution();
    $ret->concat($self->{Left}->solve($policy, $grammar, $explore));
    $ret->concat($self->{Right}->solve($policy, $grammar, $explore));
    return $ret;
}
sub toString {
    my ($self, %flags) = @_;
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    return $flags{TerminalRefs} ? "$lStr$rStr" : "$lStr $rStr";
}

package W3C::Grammar::YaccCompileTree::LSequence;
@W3C::Grammar::YaccCompileTree::LSequence::ISA = 'W3C::Grammar::YaccCompileTree::Sequence';
use W3C::Util::Exception;
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ret = new W3C::Grammar::YaccCompileTree::Solution();
    $ret->concat($self->getL()->solve($policy, $grammar, $explore));
    $ret->concat($self->getR()->solve($policy, $grammar, $explore));
    return $ret;
}
sub toString {
    my ($self, %flags) = @_;
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return "$lStr$rStr";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return "$lStr$rStr";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return "$lStr$rStr";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return "$lStr$rStr";
	} else {&throw();}
    } else {
	return "$lStr $rStr";
    }
}

package W3C::Grammar::YaccCompileTree::Disjunction;
@W3C::Grammar::YaccCompileTree::Disjunction::ISA = 'W3C::Grammar::YaccCompileTree::Set';
use W3C::Util::Exception;
sub new {
    my ($proto, $l, $r, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{DisjLeft} = $l;
    $self->{DisjRight} = $r;
    $self->{DisjunctionCache} = undef; # nested disjunctions not yet cached.
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{DisjLeft}->resolveIDENTS($grammar);
    $self->{DisjRight}->resolveIDENTS($grammar);
}
sub addRightBranch { # static
    my ($l, $r, @particleParms) = @_;
    if (UNIVERSAL::isa($l, 'W3C::Grammar::YaccCompileTree::Disjunction')) {
	$l->{DisjRight} = &addRightBranch($l->{DisjRight}, $r, @particleParms);
	return $l;
    } else {
	$l ||= new W3C::Grammar::YaccCompileTree::EmptyRule(@particleParms);
	$r ||= new W3C::Grammar::YaccCompileTree::EmptyRule(@particleParms);
	return new W3C::Grammar::YaccCompileTree::Disjunction($l, $r, @particleParms);
    }
}
sub toDNF {
    my ($self, $opts, $productionList, $parserType) = @_;
    my $ret = [];
    foreach my $seq (@$opts) {
	my $lDNF = $self->{DisjLeft}->toDNF([$seq], $productionList, $parserType);
	my $rDNF = $self->{DisjRight}->toDNF([$seq], $productionList, $parserType);
	push (@$ret, @$lDNF, @$rDNF);
    }
    return $ret;
}
sub getL {
    my ($self) = @_;
    return $self->{DisjLeft};
}
sub getR {
    my ($self) = @_;
    return $self->{DisjRight};
}
sub getProductionName {
    my ($self) = @_;
    my @parts;
    foreach my $elt ($self->{DisjLeft}, $self->{DisjRight}) {
	my $str = $elt->getProductionName();
	if ($str =~ m/^\'([^\']*)\'$/) {
	    $str = $1;
	    if ($str !~ m/^\w+$/) {
		if (my $mapped = &W3C::Grammar::YaccCompileTree::NameMap($str)) {
		    $str = $mapped;
		} else {
		    &throw(new W3C::Util::Exception(-message => "no map for \"$str\""));
		}
	    }
	}
	push (@parts, $str);
    }
    return join('_Or', @parts);
}
sub getBareProductionName {
    my ($self) = @_;
    return '_O'.$self->getProductionName().'_C';
}
sub getPreferredPolicy {
    my ($self, $visited) = @_;
    return $visited->{$self}++ % @{$self->{DisjunctionCache}};
}
sub getNestedDisjunctions {
    my ($self) = @_;
    my @ret;
    foreach my $term ($self->{DisjLeft}, $self->{DisjRight}) {
	push (@ret, $term->isa('W3C::Grammar::YaccCompileTree::Disjunction') ? 
	      $term->getNestedDisjunctions() : 
	      $term);
    }
    return @ret;
}
sub cacheNestedDisjunctions {
    my ($self) = @_;
    if (!$self->{DisjunctionCache}) {
	$self->{DisjunctionCache} = [$self->getNestedDisjunctions()];
    }
    return @{$self->{DisjunctionCache}};
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my @opts = $self->cacheNestedDisjunctions();
    my $optNo = $policy->getRuleNo($self);
    return $opts[$optNo]->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = @_;
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return "(?:$lStr)|(?:$rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return "($lStr)|($rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return "(?:$lStr)|(?:$rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return "($lStr)|($rStr)";
	} else {&throw();}
    } else {
	return "$lStr | $rStr";
    }
}

package W3C::Grammar::YaccCompileTree::LDisjunction;
@W3C::Grammar::YaccCompileTree::LDisjunction::ISA = 'W3C::Grammar::YaccCompileTree::Disjunction';
use W3C::Util::Exception;
sub flattenCharacterClass {
    my ($self, $target) = @_;
    my $testRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
    my @opts = $self->cacheNestedDisjunctions();
    my $i = 0;
    foreach my $l ($testRangeList, $target) {		# try with a test range, the use real target
	for (my $i = 0; $i < @opts; $i++) {		#   for each opt
	    my $opt = $opts[$i];
	    if (!$opt->flattenCharacterClass($l)) {	#     if not flatten-able, the whole thing is not flatten-able
		return 0;
	    }
	}
    }
    return 1;						# it was flatten-able
}
sub getPreferredPolicy {
    my ($self, $visited) = @_;
    return $visited->{$self}++ % (exists $self->{FlattenedDisjunctionCache} ? @{$self->{FlattenedDisjunctionCache}} : @{$self->{DisjunctionCache}});
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $opts;
    if (exists $self->{FlattenedDisjunctionCache}) {
	$opts = $self->{FlattenedDisjunctionCache};
    } else {
	$opts = [$self->cacheNestedDisjunctions()];
	my $flatRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
	my $iMergeOpt = -1;
	for (my $i = 0; $i < @$opts; $i++) {
	    my $opt = $opts->[$i];
	    if ($opt->flattenCharacterClass($flatRangeList)) {
		if ($iMergeOpt > -1) {
		    splice(@$opts, $i, 1);
		    $i--;
		} else {
		    $iMergeOpt = $i;
		}
	    }
	}
	if ($iMergeOpt > -1) {
	    $opts->[$iMergeOpt] = &W3C::Grammar::YaccCompileTree::CharacterClass::subsume($flatRangeList->getAscendingRanges(), $self, $self->{Parser});
	}
	$self->{FlattenedDisjunctionCache} = $opts;
    }
    my $optNo = $policy->getRuleNo($self);
    return $opts->[$optNo]->solve($policy, $grammar, $explore);
}
sub newNUKE {
    my ($proto, $l, $r, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($l, $r, @particleParms);
    $self->check();
    return $self;
}
sub addRightBranch { # static
    my ($l, $r, @particleParms) = @_;
    if (UNIVERSAL::isa($l, 'W3C::Grammar::YaccCompileTree::Disjunction')) {
	$l->{DisjRight} = &addRightBranch($l->{DisjRight}, $r, @particleParms);
	return $l;
    } else {
	$l ||= new W3C::Grammar::YaccCompileTree::EmptyRule(@particleParms);
	$r ||= new W3C::Grammar::YaccCompileTree::EmptyRule(@particleParms);
	return new W3C::Grammar::YaccCompileTree::LDisjunction($l, $r, @particleParms);
    }
}
sub toString {
    my ($self, %flags) = @_;
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return "(?:$lStr)|(?:$rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return "($lStr)|($rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    return "($lStr)|($rStr)";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return "(?:$lStr)|(?:$rStr)";
	} else {&throw();}
    } else {
	return "$lStr | $rStr";
    }
}

package W3C::Grammar::YaccCompileTree::Production;
@W3C::Grammar::YaccCompileTree::Production::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $ident, $rules, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Ident} = $ident;
    $self->{Rulez} = $rules;
    $self->{DNFedForm} = undef; # DNF'd form
    $self->{Parser}->_AddRules($self);
    $self->check();
    return $self;
}
sub getProductionName {
    my ($self) = @_;
    return $self->{Rulez}->getProductionName();
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{Rulez}->resolveIDENTS($grammar);
}
sub getIdent {
    my ($self) = @_;
    return $self->{Ident};
}
sub getRules {
    my ($self) = @_;
    if (!$self->{DNFedForm}) { $self->_DNF(); }
    return $_{Ident}->{Rulez}->getRules();
}
sub _DNF {
    my ($self, $productionList, $parserType) = @_;
    $self->{Rulez} = new W3C::Grammar::YaccCompileTree::RuleOptions($self->{Rulez}->toDNF([[]], $productionList, $parserType), sub {return 0;}, $self->{Parser});
    $self->{DNFedForm} = $self->{Rulez};
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    return $self->{Rulez}->solve($policy, $grammar, $explore);
}
sub _callConstructor {
    my ($self) = @_;
    return $self->getIdent()->getToken();
}
sub toString {
    my ($self, %flags) = @_;
    my $ret;
    my $name = $self->getIdent()->getToken();
    %flags = (%flags, ProductionName => $name); # leave orig unmodified.

    if (exists $flags{Markup} && $flags{Markup} eq 'html') {
	my $prodNo = ${$flags{ProdNo}}++;
	$ret .= "<tbody class=\"prod\">
<tr valign=\"baseline\">
<td><a id=\"prod-$flags{LanguageName}$name\" name=\"prod-$flags{LanguageName}$name\"></a>[<span class=\"prodNo\">$prodNo</span>]&nbsp;&nbsp;&nbsp;</td>
<td><code class=\"production prod\">$name</code></td>
<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td>
<td><code class=\"content\">";
	my $tail = $self->{Rulez};
	while ($tail->isa('W3C::Grammar::YaccCompileTree::Disjunction')) {
	    $ret .= $tail->getL()->toString(%flags);
	    $ret .= "<br/>\n| ";
	    $tail = $tail->getR();
	}
	$ret .= $tail->toString(%flags);
	$ret .= "</code></td>\n</tr>\n</tbody>\n\n";
    } else {
	$ret .= $self->{Ident}->toString(%flags);

	if ($flags{ProductionList}) {
	    push (@{$flags{ProductionList}}, $ret);
	}
	$flags{CallConstructor} = $self->_callConstructor;
	if (my $lang = $flags{Stubs}) {
	    if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
		$ret .= ":\n";
		$ret .= $self->{Rulez}->toString(%flags, SingleQuote => 1);
		$ret .= $flags{EndProductionString};
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
		$ret .= ":\n";
		$ret .= $self->{Rulez}->toString(%flags, Nests => $self->{Nests}, 
						 DeleteRuleNo => $self->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 1 : -1, 
						 IsaMultProd => $self->isa('W3C::Grammar::YaccCompileTree::GenProduction_Multi') ? 1 : 0);
		$ret .= $flags{EndProductionString};
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
		$ret .= " cfg:mustBeOneSequence (";
		$ret .= $self->{Rulez}->toString(%flags);
		$ret .= " ) .\n\n";
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
		$ret = "    rule $ret:";
		$ret .= $self->{Rulez}->toString(%flags);
		$ret .= $flags{EndProductionString};
	    } else {&throw();}
	} else {
	    $ret .= ":\n";
	    $ret .= $self->{Rulez}->toString(%flags);
	    $ret .= $flags{EndProductionString} if ($flags{EndProductionString});
	}
    }
    if ($flags{IsStartRule} && ${$flags{IsStartRule}}) {
	${$flags{IsStartRule}} = 0;
	$flags{Grammar}->setStartProduction($self);
    }
    return $ret;
}


package W3C::Grammar::YaccCompileTree::GenProduction;
@W3C::Grammar::YaccCompileTree::GenProduction::ISA = 'W3C::Grammar::YaccCompileTree::Production';
sub new {
    my ($proto, $ident, $rules, $nests, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($ident, $rules, @particleParms);
    $self->{Nests} = $nests;
    return $self;
}
sub _callConstructor999 {
    return undef;
}

@W3C::Grammar::YaccCompileTree::GenProduction_Group::ISA = 'W3C::Grammar::YaccCompileTree::GenProduction';
@W3C::Grammar::YaccCompileTree::GenProduction_Multi::ISA = 'W3C::Grammar::YaccCompileTree::GenProduction';
@W3C::Grammar::YaccCompileTree::GenProduction_Star::ISA = 'W3C::Grammar::YaccCompileTree::GenProduction_Multi';
@W3C::Grammar::YaccCompileTree::GenProduction_Opt::ISA = 'W3C::Grammar::YaccCompileTree::GenProduction';
@W3C::Grammar::YaccCompileTree::GenProduction_Plus::ISA = 'W3C::Grammar::YaccCompileTree::GenProduction_Multi';


package W3C::Grammar::YaccCompileTree::Grammar;
@W3C::Grammar::YaccCompileTree::Grammar::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $head, $body, $tail, $noIntegrityCheck, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{Head} = $head;
    $self->{Body} = $body;
    $self->{Tail} = $tail;
    $self->{ProductionList} = {}; # list of productions
    $self->{NameFunction} = sub {
	    my ($grammar, $derivedName) = @_;
	    return $derivedName;
	};
    foreach my $production (@{$self->{Body}}) {
	if (!UNIVERSAL::isa($production, 'W3C::Grammar::YaccCompileTree::COMMENT')) {
	    my $token = $production->getIdent()->getToken();
	    # print "{$self}->{ProductionList}{$token} = [$production, undef]\n";
	    $self->{ProductionList}{$token} = [$production, undef];
	}
    }
    # If there's no @pass directive...
    if (!$self->{ProductionList}->{$PassedTokensName}) {
	# ...assume that we skip leading whitespace.
# @@@	push (@{$self->{Body}}, new SomeCoolParseTree()); #Well, throw and error for now.
    }
    if (!$noIntegrityCheck) {
	$self->{Body}[0]->resolveIDENTS($self);
    }
    $self->check();
    return $self;
}
sub getHead {
    my ($self) = @_;
    return $self->{Head};
}
sub getBody {
    my ($self) = @_;
    return $self->{Body};
}
sub getTail {
    my ($self) = @_;
    return $self->{Tail};
}
sub getNextProductionName {
    my ($self, $name, $excuse, $pIndex) = @_;
    my $productionName = &{$self->{NameFunction}}($self, $name);
    my $ident = new W3C::Grammar::YaccCompileTree::IDENT($productionName, $excuse->getLineNo(), $excuse->{Parser});
    return new W3C::Grammar::YaccCompileTree::GenSymb($ident, $excuse, $excuse->{Parser});
}
sub getProductionByName {
    my ($self, $name) = @_;
    # print "getProductionByName($name) => $self->{ProductionList}{$name}[0]\n";
    return $self->{ProductionList}{$name}[0];
}
sub ensureProductionByName {
    my ($self, $name, $ref, $rhss, $excuse, $pIndex) = @_;
    if (my $ret = $self->{ProductionList}{$name}) {
	return $ret->[1];
    }

    my $class = 'W3C::Grammar::YaccCompileTree::GenProduction'.$excuse->getNameMod();
    my $production = $class->new($ref->getValue(), $rhss, $excuse->getNestedProduction(), $excuse->{Parser});

    $self->{ProductionList}{$name} = [$production, $ref];
    splice (@{$self->{Body}}, $$pIndex+1, 0, $production);
    ++$$pIndex;
    return $ref;
}
sub yaccify {
    my ($self, $nameFunc, $parserType) = @_;
    if ($nameFunc) {
	$self->{NameFunction} = $nameFunc;
    }
    my @errors;
    for (my $i = 0; $i < @{$self->{Body}}; $i++) {
	my $rule = $self->{Body}[$i];
	if (!$rule->isa('W3C::Grammar::YaccCompileTree::COMMENT') && 
	    !$rule->isa('W3C::Grammar::YaccCompileTree::LexGoal')) {
	    eval {
		$rule->_DNF([$self, \$i], $parserType);
	    }; if ($@) {
		my $errorStr;
		if (my $ex = &catch('W3C::Util::Exception')) {
		    $errorStr = $ex->toString()
		} else {
		    $errorStr = $@;
		}
		my $ruleStr = $rule;
		eval {$ruleStr = $rule->toString()};
		push (@errors, "Error in rule $ruleStr:\n$errorStr");
	    }
	}
    }
    if (@errors) {
	&throw(new W3C::Util::Exception(-message => join ("\n===============\n", @errors)));
    }
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    # make pseudo-random selections repeatable
    srand($policy->getSeed());
    return $self->{Body}[0]->solve($policy, $grammar, $explore);
}
sub addTerminalExpansion {
    my ($self, $name, $value) = @_;
    $self->{TerminalExpansions}{$name} = $value;
}
sub setStartProduction {
    my ($self, $production) = @_;
    $self->{StartProduction} = $production;
}
sub getStartProductionName {
    my ($self) = @_;
    return $self->{StartProduction}->getIdent()->getToken();
}
sub toString {
    my ($self, %flags) = @_;
    my $ret = '';
    if (my $lang = $flags{Stubs}) {

	my $terminalPatterns = [];

	# We have to run the through the productions to collect terminals implied by literals ala
	#   age: 'age' <NUM>
	my $productions = '';
	my $productionList = [];
	my $dependencyList = {};
	my $quoter = $lang->isa('W3C::Grammar::GenSpec::Perl') ? \&DQuoteRegexp : 
	    $lang->isa('W3C::Grammar::GenSpec::Python') ? \&PyQuote : 
	    $lang->isa('W3C::Grammar::GenSpec::N3') ? \&N3Quote : 
	    $lang->isa('W3C::Grammar::GenSpec::C_') ? \&LexQuote : 
	    &throw(new W3C::Util::Exception(-message => "unknown language: \"$lang\""));
	my $isStartRule = 1;
	foreach my $production (@{$self->{Body}}) {
	    $productions .= $production->toString(%flags, 
						  TerminalPatterns => $terminalPatterns, 
						  TerminalDependsOn => $dependencyList, 
						  Quoter => $quoter, 
						  ProductionList => $productionList, 
						  IsStartRule => \ $isStartRule,
						  Grammar => $self);
	    $productions .= "\n\n";
	    if ($production->isa('W3C::Grammar::YaccCompileTree::Production')
		#&& !$production->isa('W3C::Grammar::YaccCompileTree::GenProduction')
		) {
		$lang->addProductionDecl($production);
	    }
	}
	my $junk = '';

	# Collect all the terminal patterns in the terminal definitions.
	foreach my $decl (@{$self->{Head}}) {
	    # should not get actual rules if $flags{TerminalPatterns} is set.
	    $junk .= $decl->toString(%flags, 
				    TerminalPatterns => $terminalPatterns, # build list of terminals.
				    TerminalRefs => 1 # in the lex rules, make terminals be variables.
				    );
	}

	my $namePointers = {};
	for (my $i = 0; $i < @$terminalPatterns; $i++) {
	    my ($name, $index, $dependsOn, $str, $fold) = @{$terminalPatterns->[$i]};
	    $namePointers->{$name} = $terminalPatterns->[$i];
	    $terminalPatterns->[$i][1] = $i;
	    if ($dependencyList->{$name}) {
		$lang->addLexDecl($name, $fold, $flags{Macros});
	    } # else only used to build other terminals
	}

	# Dump out the regexps as variables.
	#   <NUM> ::= ("\\0x" <HEX>) | <DEC>
	#   <HEX> ::= (["0"-"9","a"-"f","A"-"F"])+
	#   <DEC> ::= (["0"-"9"])+
	# becomes
	#   my $T_HEX = "[0-9a-fA-F]+";
	#   my $T_DEC = "[0-9]+";
	#   my $T_NUM = "(?:\\\\0x${T_HEX})|${T_DEC}";
	# Note ordering and escaping. Ordering happens below. Escaping happens in the atoms.

	# First sort to not have any forward references.
	for (my $i = 0; $i < @$terminalPatterns; $i++) {
	    my $termDef = $terminalPatterns->[$i];
	    my ($name, $index, $dependsOn, $str, $done) = @$termDef;
	    my $latestDepends = $i;
	    foreach my $depends (keys %$dependsOn) {
		if (!$namePointers->{$depends}) {
		    next; &throw(new W3C::Util::Exception(-message => "who uses \"$depends\"?"));
		}
		my ($Dname, $Dindex, $DdependsOn, $Dstr) = @{$namePointers->{$depends}};
		if ($Dindex > $latestDepends) {
		    $latestDepends = $Dindex;
		    if (0 && $done) {
			&throw(new W3C::Util::Exception(-message => "circular dependency between $name and $depends"));
		    }
		}
	    }
	    $termDef->[4] = 1; # mark done so we can find circular dependencies.
	    if ($latestDepends > $i) {
		# Have to move down past latest dependency.
		splice (@$terminalPatterns, $i, 1);
		splice (@$terminalPatterns, $latestDepends, 0, $termDef);
		# Fix the indexes for the just move and subsequent displaced elements.
		for (my $j = $i; $j < @$terminalPatterns; $j++) {
		    $terminalPatterns->[$j][1] = $j;
		}
		$i--; # start at the new element at this postion
	    }
	}

	$ret .= $lang->getHeadCode($productions, $productionList, $terminalPatterns, $self->{StartProduction}, (%flags, Grammar => $self));

    } else {
	if (exists $flags{Markup} && $flags{Markup} eq 'html') {
	    $ret .= "<table border=\"0\">\n<tbody><tr><td colspan=\"4\" class=\"grammarSection\"><h3><a id=\"productions\" name=\"productions\">Productions</a>:</h3></td></tr></tbody>\n\n";
	    foreach my $production (@{$self->{Body}}) {
		$ret .= $production->toString(%flags, Quoter => \&W3C::Grammar::YaccCompileTree::Grammar::HtmlQuote);
	    }
	    $ret .= "</table>\n";
	} else {
	    foreach my $decl (@{$self->{Head}}) {
		$ret .= $decl->toString(%flags);
		$ret .= "\n\n";
	    }
	    $ret .= "%%\n\n";
	    foreach my $production (@{$self->{Body}}) {
		$ret .= $production->toString(%flags);
		$ret .= "\n\n";
	    }
	    $ret .= "%%\n\n";
	}
    }
    return $ret;
}
# Encode first as a regexp, then as a ""'d string.
sub DQuoteRegexp { # static
    my ($val) = @_;

    # Regexps
    $val =~ s/\\/\\\\/g;
    $val =~ s/\//\\\//g;
    $val =~ s/\"/\\\"/g;
    $val =~ s/\'/\\\'/g;
    $val =~ s/\^/\\\^/g;
    $val =~ s/\$/\\\$/g;
    $val =~ s/\./\\\./g;
    $val =~ s/\+/\\\+/g;
    $val =~ s/\*/\\\*/g;
    $val =~ s/\|/\\\|/g;
    $val =~ s/\?/\\\?/g;
    $val =~ s/\[/\\\[/g;
    $val =~ s/\]/\\\]/g;
    $val =~ s/\{/\\\{/g;
    $val =~ s/\}/\\\}/g;
    $val =~ s/\(/\\\(/g;
    $val =~ s/\)/\\\)/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;

    # DQuotes
    $val =~ s/\\/\\\\/g;
    $val =~ s/\"/\\\"/g;
    $val =~ s/\$/\\\$/g;
    $val =~ s/\@/\\\@/g;
    $val =~ s/\%/\\\%/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;
    $val =~ s/([^\x20-\x7f])/sprintf("\\x{%04X}",ord($1))/eg;
    return $val;
}

sub LexQuote { # static
    my ($val) = @_;

    $val =~ s/\\/\\\\/g;
    $val =~ s/\[/\\\[/g;
    $val =~ s/\]/\\\]/g;
    $val =~ s/\"/\\\"/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;
    $val =~ s/([^\x20-\x7e])/sprintf("\\x%02X",ord($1))/eg;
    return $val;
}

sub PyQuote { # static
    my ($val) = @_;
    # Regexps
    $val =~ s/\\/\\\\/g;
    #$val =~ s/\"/\\\"/g;
    #$val =~ s/\'/\\\'/g;
    $val =~ s/\^/\\\^/g;
    $val =~ s/\$/\\\$/g;
    $val =~ s/\./\\\./g;
    $val =~ s/\+/\\\+/g;
    $val =~ s/\*/\\\*/g;
    $val =~ s/\|/\\\|/g;
    $val =~ s/\?/\\\?/g;
    $val =~ s/\[/\\\[/g;
    $val =~ s/\]/\\\]/g;
    $val =~ s/\{/\\\{/g;
    $val =~ s/\}/\\\}/g;
    $val =~ s/\(/\\\(/g;
    $val =~ s/\)/\\\)/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;

    $val =~ s/\\/\\\\/g;
    $val =~ s/\'/\\\'/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;
    $val =~ s/([^\x20-\x7f])/sprintf("\\u%04X",ord($1))/eg;
    return $val;
    #return "hello "
}


sub N3Quote { # static
    my ($val) = @_;
    #if ($val eq 'r') {die "How did I get an r?"; }
    # Regexps
    $val =~ s/\\/\\\\/g;
    #$val =~ s/\"/\\\"/g;
    #$val =~ s/\'/\\\'/g;
    $val =~ s/\^/\\\^/g;
    $val =~ s/\$/\\\$/g;
    $val =~ s/\./\\\./g;
    $val =~ s/\+/\\\+/g;
    $val =~ s/\*/\\\*/g;
    $val =~ s/\|/\\\|/g;
    $val =~ s/\?/\\\?/g;
    $val =~ s/\[/\\\[/g;
    $val =~ s/\]/\\\]/g;
    $val =~ s/\{/\\\{/g;
    $val =~ s/\}/\\\}/g;
    $val =~ s/\(/\\\(/g;
    $val =~ s/\)/\\\)/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;

    $val =~ s/\\/\\\\/g;
    $val =~ s/\"/\\\"/g;
    $val =~ s/\r/\\r/g;
    $val =~ s/\n/\\n/g;
    $val =~ s/\t/\\t/g;
    $val =~ s/([^\x20-\x7f])/sprintf("\\u%04X",ord($1))/eg;
    return $val;
}

sub HtmlQuote { # static
    my ($val) = @_;

    $val =~ s/&/&amp;/g;
    $val =~ s/\</&lt;/g;
    $val =~ s/\>/&gt;/g;
    # $val =~ s/\"/&quot;/g;
    return $val;
}

package W3C::Grammar::YaccCompileTree::LexGoal;
@W3C::Grammar::YaccCompileTree::LexGoal::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $ident, $rules, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{LGIdent} = $ident;
    $self->{LGRules} = $rules;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{LGRules}->resolveIDENTS($grammar);
}
sub getIdent {
    my ($self) = @_;
    return $self->{LGIdent};
}
sub getRules {
    my ($self) = @_;
    return $self->{LGRules};
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    return $self->{LGRules}->flattenCharacterClass($target);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    my $ret = $self->{LGRules}->solve($policy, $grammar, $explore);
    $ret->setSeparator('');
    return $ret;
}
sub __getDisplayTitle {
    my ($self) = @_;
    my $displayName = $self->{LGIdent}->getToken2();
    return "&lt;<code class=\"production term\">$displayName</code>&gt;";
}
sub _pythonDeclaration {
    my ($self, $name) = @_;
    return "token $name";
}

sub toString { # from Production;
    my ($self, %flags) = @_;
    my $ret = '';
    if (exists $flags{Markup} && $flags{Markup} eq 'html') {
	my $displayTitle = $self->__getDisplayTitle();
	my $distinguishedName = $self->{LGIdent}->getDistinguishedToken();
	my $prodNo = ${$flags{ProdNo}}++;
	$ret .= "<tbody class=\"term\">
<tr valign=\"baseline\">
<td><a id=\"term-$flags{LanguageName}$distinguishedName\" name=\"term-$flags{LanguageName}$distinguishedName\"></a>[<span class=\"prodNo\">$prodNo</span>]&nbsp;&nbsp;&nbsp;</td>
<td>$displayTitle</td>
<td>&nbsp;&nbsp;&nbsp;::=&nbsp;&nbsp;&nbsp;</td>
<td><code class=\"content\">";
	my $tail = $self->{LGRules};
	while ($tail->isa('W3C::Grammar::YaccCompileTree::Disjunction')) {
	    $ret .= $tail->getL()->toString(%flags);
	    $ret .= "<br/>\n| ";
	    $tail = $tail->getR();
	}
	$ret .= $tail->toString(%flags);
	$ret .= "</code></td>\n</tr>\n</tbody>\n\n";
    } elsif (my $lang = $flags{Stubs}) {
	my $name = $self->{LGIdent}->getToken();
	my $dependencyList = {};
	my $hasLookAhead = 0;
	my %callFlags = (%flags, TerminalDependsOn => $dependencyList, 
			 TerminalRefs => 1, 
			 InTerminal => 1, HasLookAhead => \$hasLookAhead);
	my $value = $self->{LGRules}->toString(%callFlags);

	if ($flags{TerminalPatterns}) {
	    my $str;
	    if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
		$str = "my \$$name = \"$value\";\n";
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
		if ($hasLookAhead) {
		    $flags{Grammar}->addTerminalExpansion($name, $value);
		    $str = '';
		} else {
		    $str = "$name		$value\n";
		}
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
		$str = "$name	cfg:matches	\"$value\";\n	a cfg:Token . \n";
	    } elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
		my $declaration = $self->_pythonDeclaration($name);
		$str = "    $declaration: '$value'\n";
	    } else {
		&throw(new W3C::Util::ProgramFlowException());
	    }
	    push (@{$flags{TerminalPatterns}}, [$name, scalar @{$flags{TerminalPatterns}}, $dependencyList, $str, 0, 0]);
	} else {
	    $ret = $value;
	}
    } else { # if ($self->[2]) {
	$ret .= $self->{LGIdent}->toString(%flags);
	$ret .= ":\n    ";
	$ret .= $self->{LGRules}->toString(%flags);
	$ret .= ';';
    }
    return $ret;
}

package W3C::Grammar::YaccCompileTree::Pass;
@W3C::Grammar::YaccCompileTree::Pass::ISA = 'W3C::Grammar::YaccCompileTree::LexGoal';

sub __getDisplayTitle {
    my ($self) = @_;
    return "<code class=\"production directive\">PASSED TOKENS</code>";
}
sub _pythonDeclaration {
    my ($self, $name) = @_;
    return "ignore";
}

# Lex classes
package W3C::Grammar::YaccCompileTree::CharacterClass;
@W3C::Grammar::YaccCompileTree::CharacterClass::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Grammar::CharacterRange;
use W3C::Util::Exception;
sub new {
    my ($proto, $lrangeList, $negated, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{LRangeList} = $lrangeList;
    $self->{Negated} = $negated;
    $self->{Excluded} = [];
#    $self->{WideRange} = 
#	    new W3C::Grammar::YaccCompileTree::List(
#		new W3C::Grammar::YaccCompileTree::Symb(
#		    new W3C::Grammar::YaccCompileTree::LLITERAL(0, $self->{Parser}->getLineNo(), $self->{Parser}), $self->{Parser}), 
#		new W3C::Grammar::YaccCompileTree::Symb(
#		    new W3C::Grammar::YaccCompileTree::LLITERAL(0x10FFFF, $self->{Parser}->getLineNo(), $self->{Parser}), $self->{Parser}), 
#						    $self->{Parser});
    my $flatRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
    $self->getLRangeList()->flattenCharacterClass($flatRangeList);
    $flatRangeList = $flatRangeList->getAscendingRanges();
    if ($self->{Negated}) {
	$self->{FlatRanges} = [[0, 0x10fffd]];
	&W3C::Grammar::CharacterRange::FlatRangeList::_substractRange($self->{FlatRanges}, $flatRangeList);
    } else {
	$self->{FlatRanges} = $flatRangeList;
    }
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
}

# replace (in the sense that the parser location is the same) an existing
# CharacterRange with one that includes all the extra chars in the
# flatRangeList.
sub subsume { # static
    my ($flatRangeList, $from, $parser) = @_;
    my $ret = {Parser => $parser, From => $from};
    $ret->{FlatRanges} = $flatRangeList;
    bless ($ret, 'W3C::Grammar::YaccCompileTree::CharacterClass');
    return $ret;
}
sub getLRangeList {
    my ($self) = @_;
    return $self->{LRangeList};
}
sub _getNegated {
    my ($self) = @_;
    return $self->{Negated};
}
sub excludeRange {
    my ($self, $exclusion) = @_;
    push (@{$self->{Excluded}}, $exclusion);
    my $excludeRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
    $exclusion->getLRangeList()->flattenCharacterClass($excludeRangeList);
    &W3C::Grammar::CharacterRange::FlatRangeList::_substractRange($self->{FlatRanges}, $excludeRangeList->getAscendingRanges());
}
sub getPreferredPolicy {
    my ($self, $visited) = @_;
    return ++$visited->{$self};
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    foreach my $range (@{$self->{FlatRanges}}) {
	my ($b, $t) = @$range;
	$target->addRange(chr($b), chr($t));
    }
    return 1;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;

    # know how big each range is
    my $all_widths = [];
    my $all_total = 0;
    my $all_ranges = $self->{FlatRanges}; # just used as a consistent name

    # know how big the ascii subset of each range is
    my $ascii_widths = [];
    my $ascii_total = 0;
    my $ascii_ranges = [];

    foreach my $range (@{$self->{FlatRanges}}) {
	my ($b, $t) = @$range;
	my $all_width = $t - $b + 1;
	push (@$all_widths, $all_width);
	$all_total += $all_width;
	if ($t > 127) {
	    $t = 127;
	}
	my $ascii_width = $b <= 127 ? $t - $b + 1 : 0;
	push (@$ascii_widths, $ascii_width);
	$ascii_total += $ascii_width;
	if ($ascii_width) {
	    push (@$ascii_ranges, [$b, $t]);
	}
    }

    my $ret = new W3C::Grammar::YaccCompileTree::Solution();
    my $optNo = $policy->getRuleNo($self);

    # make pseudo-random selections repeatable
    # srand($optNo);

    sub _randomPoint {
	my ($ranges, $total, $widths) = @_;
	# find a random spot in the total character space
	my $point = int(rand($total)); my $orig = $point;
	# find the corresponding range
	my $rangeNo = 0;
	while ($point >= $widths->[$rangeNo]) {
	    $point -= $widths->[$rangeNo];
	    $rangeNo++;
	}
	my ($b, $t) = @{$ranges->[$rangeNo]};
	return $b+$point;
    }
    my $ch = int(rand(100)) > $policy->getAsciiWeigt() || !$ascii_total ? 
	&_randomPoint($all_ranges, $all_total, $all_widths) : 
	&_randomPoint($ascii_ranges, $ascii_total, $ascii_widths);
    $ch = new W3C::Grammar::YaccCompileTree::LLITERAL(chr($ch), 0, $self->{Parser});
    my $soln = new W3C::Grammar::YaccCompileTree::LiteralSolution($ch);
    $ret->concat($soln);

    return $ret;
}
sub toString {
    my ($self, %flags) = @_;
    if ($self->{From}) {
	return join("\n", map {"[$_->[0] - $_->[1]]"} @{$self->{FlatRanges}})."\nFrom ".$self->{From}->toString(%flags);
    } else {
	return $self->toString1(%flags);
    }
}
sub toString1 {
    my ($self, %flags) = @_;
    my $excludedStr = @{$self->{Excluded}} ? (join (' - ', undef, map {$_->toString(%flags, CharacterClass => 1)} @{$self->{Excluded}})) : '';

    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Python') || 
	    $lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    my @ret;
	    foreach my $range (@{$self->{FlatRanges}}) {
		my ($l, $r) = @$range;
		my $lc = $flags{Quoter}(chr($l));
		my $rc = $flags{Quoter}(chr($r));
		push (@ret, $r > $l ? "$lc-$rc" : $lc);
	    }
	    return join('', '[', @ret, ']');
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3') || 
		 $lang->isa('W3C::Grammar::GenSpec::C_')) {
	    my @ret;
	    my $inBracket = 0;
	    foreach my $range (@{$self->{FlatRanges}}) {
		my ($l, $r) = @$range;
		my ($lc, $rc) = (chr($l), chr($r));
		if (($l > 0x7f) ||
		    ($r > 0x7f)) {
		    my $t = $lang->isa('W3C::Grammar::GenSpec::C_') ? 
			W3C::Grammar::CharacterRange::compileUTF8range($lc, $rc, sub {$flags{Quoter}(chr($_[0]))}) : 
			W3C::Grammar::CharacterRange::compileUTF16range($lc, $rc, sub {$flags{Quoter}(chr($_[0]))});
		    if ($inBracket) {
			if (substr($t, 0, 1) eq '[') {
			    # merge with the next range
			    $t = substr($t, 1);
			} else {
			    push (@ret, ']|');
			    $inBracket = 0;
			}
		    }
		    push (@ret, $t);
		} else {
		    $lc = $flags{Quoter}(chr($l));
		    $rc = $flags{Quoter}(chr($r));
		    if (!$inBracket) {
			push (@ret, '[');
			$inBracket = 1;
		    }
		    push (@ret, $r > $l ? "$lc-$rc" : $lc);
		}
	    }
	    if ($inBracket) {
		push (@ret, ']');
	    }
	    return join('', @ret);
	} else {&throw();}
    } elsif (exists $flags{LexFormat} && $flags{LexFormat} eq 'XMLSpec') {
	my $str = $self->getLRangeList()->toString(%flags, CharacterClass => 1);
	my $negStr = $self->_getNegated() ? '^' : '';
	return "[$negStr$str]$excludedStr";
    } else {
	my $str = $self->getLRangeList()->toString(%flags, CharacterClass => 1);
	my $negStr = $self->_getNegated() ? '~' : '';
	return "${negStr}[ $str ]$excludedStr";
    }
}

package W3C::Grammar::YaccCompileTree::List;
@W3C::Grammar::YaccCompileTree::List::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $l, $r, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{ListLeft} = $l;
    $self->{ListRight} = $r;
    $self->check();
    return $self;
}
sub getL {
    my ($self) = @_;
    return $self->{ListLeft};
}
sub getR {
    my ($self) = @_;
    return $self->{ListRight};
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    my $testRangeList = new W3C::Grammar::CharacterRange::FlatRangeList();
    return $self->{ListRight}->flattenCharacterClass($testRangeList) ?	# if right is flattenable
	$self->{ListLeft}->flattenCharacterClass($target) &&		# return left and right 
	$self->{ListRight}->flattenCharacterClass($target) : 
	0;								# else 0
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    # return the first element in the list
    return $self->{ListLeft}->solve($policy, $grammar, $explore);
}
sub toString {
    my ($self, %flags) = @_;
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl') || $lang->isa('W3C::Grammar::GenSpec::C_')) {
	    return "$lStr$rStr";
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3') || $lang->isa('W3C::Grammar::GenSpec::Python')) {
	    return "$lStr$rStr";
	} else {&throw();}
    } elsif (exists $flags{CharacterClass} && $flags{CharacterClass} && 
	     exists $flags{LexFormat} && $flags{LexFormat} eq 'XMLSpec') {
	return "$lStr$rStr";
    } else {
	return "$lStr,$rStr";
    }
}

package W3C::Grammar::YaccCompileTree::Range;
@W3C::Grammar::YaccCompileTree::Range::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $l, $r, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{RangeLeft} = $l;
    $self->{RangeRight} = $r;
    $self->check();
    return $self;
}
sub getL {
    my ($self) = @_;
    return $self->{RangeLeft};
}
sub getR {
    my ($self) = @_;
    return $self->{RangeRight};
}
sub flattenCharacterClass {
    my ($self, $target) = @_;
    $target->addRange($self->{RangeLeft}->getValue()->getText(), 
		      $self->{RangeRight}->getValue()->getText());
    return 1;
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;
    # return the bottom end of the range
    return new W3C::Grammar::YaccCompileTree::LiteralSolution($self->{RangeLeft}->getValue());
}
sub toString {
    my ($self, %flags) = @_;
    my $l = $self->getL()->getValue()->getText();
    my $r = $self->getR()->getValue()->getText();
    if (exists $flags{GenSpec} && $flags{GenSpec}->getCompileUTF8() && $flags{CollectRanges} && 
	(($l && ord($l) > 0x7f) ||
	 ($r && ord($r) > 0x7f))) {
	require W3C::Grammar::CharacterRange;
	my $expansion = W3C::Grammar::CharacterRange::compileUTF8range($l, $r, sub {$flags{Quoter}(chr($_[0]), chr($_[1]))});
	push (@{$flags{CollectRanges}}, $expansion);
	return '';
    }
    my $lStr = $self->getL()->toString(%flags);
    my $rStr = $self->getR()->toString(%flags);
    return "$lStr-$rStr";
}

package W3C::Grammar::YaccCompileTree::LookAhead;
@W3C::Grammar::YaccCompileTree::LookAhead::ISA = 'W3C::Grammar::YaccCompileTree::Particle';
use W3C::Util::Exception;
sub new {
    my ($proto, $lookAhead, @particleParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@particleParms);
    $self->{LookAhead} = $lookAhead;
    $self->check();
    return $self;
}
sub resolveIDENTS {
    my ($self, $grammar) = @_;
    $self->{LookAhead}->resolveIDENTS($grammar);
}
sub solve {
    my ($self, $policy, $grammar, $explore) = @_;				  # @@@ should return a decision tree for calling production
    my $ch = new W3C::Grammar::YaccCompileTree::LLITERAL('', 0, $self->{Parser}); # but then, how to write that in the BNF?
    return new W3C::Grammar::YaccCompileTree::LiteralSolution($ch);		  # can then auto-generate the lookahead.
}										  # it will be novel grammar work.
sub toString {
    my ($self, %flags) = &main::_defaultPrec(@_);
    if (my $lang = $flags{Stubs}) {
	if ($lang->isa('W3C::Grammar::GenSpec::Perl')) {
	    return '(?=('.$self->{LookAhead}->toString(%flags).'))'; # store look-ahead in $1
	} elsif ($lang->isa('W3C::Grammar::GenSpec::C_')) {
	    ${$flags{HasLookAhead}} = 1;
	    return '/'.$self->{LookAhead}->toString(%flags);
	} elsif ($lang->isa('W3C::Grammar::GenSpec::N3')) {
	    # &throw();
	    return '(?=('.$self->{LookAhead}->toString(%flags).'))';
	} elsif ($lang->isa('W3C::Grammar::GenSpec::Python')) {
	    # &throw();
	    return '(?=('.$self->{LookAhead}->toString(%flags).'))';
	} else {&throw();}
    } else {
	my @ret;
	if ($flags{Types}) {
	    push (@ret, $self->{Unused0});
	}
	push (@ret, '/ ');
	push (@ret, $self->{LookAhead}->toString(%flags));
	return join (' ', @ret);
    }
}

package W3C::Grammar::YaccCompileTree::SolutionPolicy;
use W3C::Util::Exception;
sub new {
    my ($proto, $seed, $limit, $asciiWeight) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Branches => [], Seed => $seed, 	Limit => $limit, AsciiWeight => $asciiWeight};
    bless ($self, $class);
    return $self;
}
sub addBranch {
    my ($self, $branch) = @_;
    push (@{$self->{Branches}}, $branch);
}
sub getSeed {
    my ($self) = @_;
    return $self->{Seed};
}
sub getLimit {
    my ($self) = @_;
    return $self->{Limit};
}
sub getAsciiWeigt {
    my ($self) = @_;
    return $self->{AsciiWeight};
}
sub clone {
    my ($self) = @_;
    my $ret = {%$self};
    my $class = ref $self;
    bless ($ret, $class);
    return $ret;
}

package W3C::Grammar::YaccCompileTree::RandomPolicy;
@W3C::Grammar::YaccCompileTree::RandomPolicy::ISA = qw(W3C::Grammar::YaccCompileTree::SolutionPolicy);
use W3C::Util::Exception;
sub new {
    my ($proto, $seed, $limit, $asciiWeight) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($seed, $limit, $asciiWeight);
    return $self;
}

package W3C::Grammar::YaccCompileTree::RepresentativePolicy;
@W3C::Grammar::YaccCompileTree::RepresentativePolicy::ISA = qw(W3C::Grammar::YaccCompileTree::SolutionPolicy);
use W3C::Util::Exception;
sub new {
    my ($proto, $seed, $limit, $asciiWeight) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new($seed, $limit, $asciiWeight);
    $self->{Visited} = {};
    return $self;
}
sub getRuleNo {
    my ($self, $ruleOptions) = @_;
    return (scalar %{$self->{Visited}} > $self->{Limit}) ? 0 : $ruleOptions->getPreferredPolicy($self->{Visited});
}
sub clearVisitations {
    my ($self, $visitor) = @_;
    $self->{Visited}{$visitor} = 0;
}

package W3C::Grammar::YaccCompileTree::ReferencePolicy;
@W3C::Grammar::YaccCompileTree::ReferencePolicy::ISA = qw(W3C::Grammar::YaccCompileTree::SolutionPolicy);
use W3C::Util::Exception;
sub new {
    my ($proto, $referenceString, $fallbackPolicy) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new();
    $self->{FallbackPolicy} = $fallbackPolicy;
    return $self;
}

package W3C::Grammar::YaccCompileTree::Solution;
use W3C::Util::Exception;
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Seq => [], Prev => undef, Next => undef, Separator => undef};
    bless ($self, $class);
    return $self;
}
sub setPrevOpt {
    my ($self, $prevOpt) = @_;
    $self->{Prev} = $prevOpt;
}
sub setNextOpt {
    my ($self, $nextOpt) = @_;
    $self->{Next} = $nextOpt;
}
sub setSeparator {
    my ($self, $separator) = @_;
    $self->{Separator} = $separator;
}
sub concat {
    my ($self, $soln) = @_;
    die if (!$soln || !$soln->can('getHtml'));
    push (@{$self->{Seq}}, $soln);
}
sub getHtml {
    my ($self, $separator) = @_;
    if (defined $self->{Separator}) {
	$separator = $self->{Separator};
    }
    my @ret = '';
    foreach my $subSolution (@{$self->{Seq}}) {
#	if ($subSolution->isa('W3C::Grammar::YaccCompileTree::Solution')) {
	    push (@ret, $subSolution->getHtml($separator));
#	} else {
#	    push (@ret, $subSolution->getToken());
#	}
    }
    if ($self->{Prev}) {
	my $prev = $self->{Prev}->getHtmlLink($separator);
	push (@ret, "<sub><a href=\"$prev\">-</a></sub>");
    }
    if ($self->{Next}) {
	my $next = $self->{Next}->getHtmlLink($separator);
	push (@ret, "<super><a href=\"$next\">+</a></super>");
    }
    return join ($separator, @ret);
}

package W3C::Grammar::YaccCompileTree::LiteralSolution;
#@W3C::Grammar::YaccCompileTree::LiteralSolution::ISA('W3C::Grammar::YaccCompileTree::Solution');
sub new {
    my ($proto, $literal) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Literal => $literal};
    bless ($self, $class);
    return $self;
}
sub setSeparator {
    my ($self, $separator) = @_;
}
sub getHtml {
    my ($self, $separator) = @_;
    return $self->{Literal}->getText();
}


1;

__END__

=head1 NAME

W3C::Grammar::YaccCompileTree - RDF query objects

=head1 SYNOPSIS

  # in a parser...
  use W3C::Grammar::YaccCompileTree;
  my $t1 = new W3C::Grammar::YaccCompileTree::Decl([$p1, $s1, $o1], 
				$constraints1, $self);
  my $t2 = new W3C::Grammar::YaccCompileTree::Decl([$p2, $s2, $o2], 
				$constraints2, $self);
  my $conj = new W3C::Grammar::YaccCompileTree::Conjunction($t1, $t2, $self)

=head1 DESCRIPTION

Parsers generate YaccCompileTrees and hand them to the Yacc2 object. Yacc2
calls the compile tree to perforn queries/assertions/rules.

This module is part of the W3C::Rdf CPAN module.

=head1 METHODS

    $atomDictionary, $namespaceHandler, 
	$sources, $rdfApp, $sourceAttrib, $flags

=head2 immediateEvaluate($resultSet)

Perform compile-time evaluations.

no return value

=head2 delayedEvaluate($resultSet)

Perform post-compile-time (pass 2) evaluations. This is for query languages
that require a second pass to do things like resolve namespace prefixes that
are declared after a dependent qname is first used.

no return value

=head2 val($triple, $premise, $row)

Perform the query evaluation. I don't remember what the hell the $premise is,
but it sure looks important.

returns an interned RDF Atom

=head1 AUTHOR

Eric Prud'hommeaux <eric@w3.org>

=head1 SEE ALSO

W3C::Rdf::Yacc2(1) W3C::Rdf::YaccParser(1) W3C::Rdf::Atom(1) perl(1).

=cut
