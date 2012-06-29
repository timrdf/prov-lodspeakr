# BEGIN {unshift@INC,('../..');}

use ExtUtils::MakeMaker;
use Config;
use English;
use strict;

my $REVISION = '$Id: Makefile.PL,v 1.4 2007-01-22 19:37:34 eric Exp $ ';

my @extras = ();

push(@extras,
     CAPI => 'TRUE')
    if ($PERL_VERSION >= 5.005 and $OSNAME eq 'MSWin32'
	and $Config{archname} =~ /-object\b/i);

push(@extras,
     ABSTRACT => "some handy tools work playing with yacc grammars",
     AUTHOR   => 'Eric Prud\'hommeaux (eric@w3.org)')
    if ($ExtUtils::MakeMaker::Version >= 5.4301);

WriteMakefile(CONFIGURE => \ &configure);

sub configure {
    my $exes = [qw(bin/yacker)];

    my $input = {PREREQS => {'Parse::Yapp' => 0, 'YAML' => 0}};

    return {  NAME         => 'W3C::Grammar::Kit',
              VERSION => 1.0,
              PREREQ_PM    => $input->{PREREQS},
              dist         => {COMPRESS => 'gzip', SUFFIX => '.gz'},
	      EXE_FILES    => $exes,
	      @extras};
}

sub MY::postamble {
    return <<EOF;

PARSERS = YaccParser.pm YackerSymbolParser.pm

YAPPS := \$(patsubst \%.pm,\%.yp,\$(PARSERS))

parsers: \$(PARSERS)

\$(PARSERS): \%.pm: \%.yp Makefile
	yapp -m W3C::Grammar::_\$(basename \$\@) -v -o \$\@ -b '/usr/bin/perl' \$\<
	perl -pi -e "s/use Parse::Yapp::Driver;/# use Parse::Yapp::Driver; @@ replaced by W3C::Util::YappDriver/g" \$\@
	perl -pi -e "s/^\\#line ([\\d+]) \\"\$<\\"/\\#line \\\\1 \\"..\\/\$<\\"/" \$@

Makefile: Makefile.PL
	perl Makefile.PL

EOF
}

