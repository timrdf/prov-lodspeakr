#!/usr/bin/perl -w
use strict;
use warnings;
use lib 't/lib';

use Test::More qw(no_plan);
use TestRunner qw(test_yml foreach_parser);

my $buildTestDir = 't/buildTestDir';
mkdir($buildTestDir);
foreach_parser {
    my ($genspec) = @_;
    if ($ENV{TEST_YML}) {
        test_yml($genspec, $buildTestDir, $ENV{TEST_YML});
    } else {
        for (sort glob('t/*.yml')) {
            print "\n######## $_ #######\n";
            test_yml($genspec, $buildTestDir, $_);
        }
    }    
};
rmdir($buildTestDir);
