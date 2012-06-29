#!/usr/bin/perl
use strict;
use warnings;

use Test::More qw(no_plan);
use_ok('W3C::Grammar::YaccParser') or exit;

# specifying a bogus grammar should fail

eval {
    my $p = new W3C::Grammar::YaccParser(1); # no integrity check
    $p->setFilename('nonexistent.ebnf');
    my ($g, $errs) = $p->Parse('asdf', 0x00);
};
like($@, qr/START/);

