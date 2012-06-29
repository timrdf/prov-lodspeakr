# YAML test runner for XML::Grammar.  Takes .yml files
# containing a schema and applies it to one or more files evaluating
# the results as specified.  Just look at t/*.yml and you'll get the
# idea.

package TestRunner;
use strict;
use warnings;

use Test::Builder;
my $Test = Test::Builder->new;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = ('test_yml', 'foreach_parser');

use YAML qw(LoadFile);
use W3C::Grammar::YaccParser;
use W3C::Util::Filter;
use W3C::Util::Exception;
use Cwd qw(cwd);

use Data::Dumper;

sub foreach_parser (&) {
    my $tests = shift;

    my @path = split(':', $ENV{PATH});
    my @genspecs = ();
    push (@genspecs, new W3C::Grammar::GenSpec::Perl()) if (grep { -e "$_/perl" } @path);
    if (grep { -e "$_/yacc" } @path) {
	push (@genspecs, new W3C::Grammar::GenSpec::C_()) if (grep { -e "$_/bison" } @path);
	push (@genspecs, new W3C::Grammar::GenSpec::CPP()) if (grep { -e "$_/bison++" } @path);
    }
    push (@genspecs, new W3C::Grammar::GenSpec::Python()) if (grep { -e "$_/python" } @path);

    # run tests with all available parser languages
    foreach my $genspec (@genspecs) {
        my $name = ref $genspec;
        print STDERR "\n\n                ======> Testing against $name ".
          "<======\n\n";
        $tests->($genspec);
    }
}

sub test_yml {
    my ($genspec, $uploads, $file) = @_;
    my ($name) = $file =~ /(\w+)\.yml$/;
    my @data = LoadFile($file);

    # write out the schema file
    my $ebnf = shift @data;
    my $ebnfFile = "$uploads/$name.ebnf";
    open(my $fh, '>', $ebnfFile) or die $!;
    print $fh $ebnf;
    close($fh) or die $!;

    my $templateDir = 'bin';
    my %flags = (LineNumbers => 0, 
		 Types => 0, 
		 OrigCode => 0, 
		 Comments => 1, 
		 Yacc => 1, 
		 GenSpec => $genspec, 
		 Stubs => $genspec, 
		 SuppressLineDirectives => 0, 
		 Class => $name);

    my ($results, $error);
    # generate a parser from the EBNF.
    eval { 
	my $p = new W3C::Grammar::YaccParser(1); # no integrity check
	$p->setFilename($ebnfFile);
	my ($g, $errs) = $p->Parse($ebnf, 0x00);
	$genspec->createGrammar($g, undef, $uploads, $name, $templateDir, %flags);
	open(my $MAKE, '>', "$uploads/Makefile") || die "unable to create Makefile";
	$genspec->makeMakefile($MAKE, $templateDir, $name, $g);
	close($MAKE);
	$genspec->makeAuxilliaryFiles($uploads, $templateDir, $name);
	$genspec->clearLexDecls(); # so they don't accumulate over each pass.

	# perform the system calls to build the parser.
	my $target = $genspec->getTarget($name);
	($results) = 
	    W3C::Util::SyncFilter->new("make -C $uploads $target", undef)->execute(4096, 1);
	if (my @errors = $results->getByFlavor('stderr')) {
	    $error = join('', map {$_->getData()} @errors);
	    die "\$(make -C $uploads $target) failed: $error";
	}
    };
    if ($@) {
	my $errStr = $@;
	if (my $ex = &catch('W3C::Util::Exception')) {
	    $@ = $errStr; # restore the exception from before the call to catch.
	    $errStr = $ex->toString();
	}
	print STDERR "$name.yml: grammar construction ====> $errStr\n";
    } else {
	my $num = 0;
	while(@data) {
	    my $text = shift @data;
	    my $result = shift @data;
	    chomp($result);
	    $num++;

	    eval {
		# perform the system calls to parse $text.
		my $argv0 = $genspec->getExecString($uploads, $name);
		($results, $error) = 
		    W3C::Util::Filter->new($argv0, $text)->execute(4096, 1);
		die "\$($argv0) failed: $error" if $error;
	    };
	    my $err = $@;
	    my $errStr = $@;
	    if ($@) {
		if (my $ex = &catch('W3C::Util::Exception')) {
		    $errStr = $ex->toString();
		    $@ = $err; # restore the exception from before the call to catch.
		}
	    }

	    if ($result =~ m!^FAIL\s*(?:/(.*?)/)?$!) {
		my $re = $1;
		$Test->ok($err, "$name.yml: block $num should fail validation");
		if ($re) {
		    if ($err) {
			$Test->like($err, qr/$re/, 
				    "$name.yml: block $num should fail matching /$re/");
		    } else {
			$Test->ok(0, "$name.yml: block $num should fail matching /$re/");
		    }
		}
	    } else {
		$Test->ok(not($err), "$name.yml: block $num should pass validation");
		print STDERR "$name.yml: block $num ====> $errStr\n" if $err;
	    }
	}
    }
    # cleanup
    `rm $uploads/*`;
}


1;
