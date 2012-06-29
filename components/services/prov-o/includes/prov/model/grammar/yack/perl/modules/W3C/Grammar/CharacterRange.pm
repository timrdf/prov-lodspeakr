# -*- Mode: cperl; coding: utf-8; cperl-indent-level: 4 -*-
# Copyright ©2004 W3C® (MIT, INRIA, Keio University),

#Last update $Date: 2005-09-17 09:52:49 $ by $Author: eric $. $Revision: 1.4 $

use strict;
my $REVISION = '$Id: CharacterRange.pm,v 1.4 2005-09-17 09:52:49 eric Exp $';
package W3C::Grammar::CharacterRange::FlatRangeList;
use W3C::Util::Exception;
sub new {
    my ($proto) = @_;
    my $class = ref($proto) || $proto;
    my $self = {Ordered => []};
    bless ($self, $class);
    return $self;
}
sub _ensureEntry {
    my ($self, $character) = @_;
    my $ret = [];
    for (my $i = 0; $i < @{$self->{Ordered}}; $i++) {
	if ($character == $self->{Ordered}[$i][0]) {
	    return $self->{Ordered}[$i];
	} elsif ($character < $self->{Ordered}[$i][0]) {
	    splice (@{$self->{Ordered}}, $i, 0, $ret);
	    return $ret;
	}
    }
    push (@{$self->{Ordered}}, $ret);
    return $ret;
}
sub addRange {
    my ($self, $l, $r) = @_;
    $l = ord($l);
    $r = ord($r);
    my $spot = $self->_ensureEntry($l);
    if (@$spot && $spot->[1] >= $r) {
	# there was already a sufficient range
    } else {
	$spot->[0] = $l;
	$spot->[1] = $r;
    }
}
sub getAscendingRanges {
    my ($self) = @_;
    return $self->{Ordered};
}
sub toString {
    my ($self, %flags) = @_;
    my @ret;
    for (my $i = 0; $i < @{$self->{Ordered}}; $i++) {
	my ($b, $t) = @{$self->{Ordered}[$i]};
	my $entry = $b == $t ? $b : "$b - $t";
	push (@ret, "$i: $entry\n");
    }
    return wantarray ? @ret : join("\n", @ret);
}

sub _substractRange { # static
    my ($from, $excl) = @_;
    my $exclI = 0;
    my ($xB, $xT) = @{$excl->[$exclI]};
  FROM:
    for (my $fromI = 0; $fromI < @$from; $fromI++) {
	my ($fB, $fT) = @{$from->[$fromI]};

	# skip froms below the next excl
	if ($xB > $fT) {
	    next;
	}

	# skip exlcs below the next from
	while ($fB > $xT) {
	    if (++$exclI >= @$excl) {
		last FROM;
	    }
	    ($xB, $xT) = @{$excl->[$exclI]};
	}

	# remove the current entry
	splice(@$from, $fromI--, 1);

	# add one below 
	if ($xB-1 > $fB) {
	    splice(@$from, ++$fromI, 0, [$fB, $xB-1]);
	}

	# add intermediates for next excls that fit in from range
	while ($exclI < @$excl-1 && 		# there's another excl
	       $fT > $excl->[$exclI+1][0]) {	# who's bottom < fromT
	    my $lastTop = $xT;
	    ($xB, $xT) = @{$excl->[++$exclI]};
	    if ($xB-1 >= $lastTop+1) {
		splice(@$from, ++$fromI, 0, [$lastTop+1, $xB-1]);
	    }
	}

	# add one above 
	if ($fT > $xT+1) {
	    splice(@$from, ++$fromI, 0, [$xT+1, $fT]);
	}
    }
}

package W3C::Grammar::CharacterRange;

sub compileUTF8range {
    my ($bot, $top, $printChar) = @_;

    my $utf8rules = 
      [
       [[    0x00,     0x7f], [0x00],  
	[0x7f]], 
       [[    0x80,    0x7ff], [0xc2, 0x80], 
	[0xdf, 0xbf]], 
       [[   0x800,    0xfff], [0xe0, 0xa0, 0x80], 
	[0xe0, 0xbf, 0xbf]], 
       [[  0x1000,   0xcfff], [0xe1, 0x80, 0x80],  
	[0xec, 0xbf, 0xbf]], 
       [[  0x1000,   0xcfff], [0xe1, 0x80, 0x80],  
	[0xec, 0xbf, 0xbf]], 
       [[  0xd000,   0xd7ff], [0xed, 0x80, 0x80],  
	[0xed, 0x9f, 0xbf]], 
       [[  0xe000,   0xffff], [0xee, 0x80, 0x80],  
	[0xef, 0xbf, 0xbf]], 
       [[ 0x10000,  0x3ffff], [0xf0, 0x90, 0x80, 0x80],  
	[0xf0, 0xbf, 0xbf, 0xbf]], 
       [[ 0x40000,  0xfffff], [0xf1, 0x80, 0x80, 0x80],  
	[0xf3, 0xbf, 0xbf, 0xbf]], 
       [[0x100000, 0x10ffff], [0xf4, 0x80, 0x80, 0x80],  
	[0xf4, 0xbf, 0xbf, 0xbf]], 
      ];

    $printChar ||= sub {
	my ($ch) = @_;
	my $hex = sprintf ("%02X", $ch);
	return "\\x$hex";
    };

    return _compileRange($utf8rules, $printChar, $bot, $top);
}
sub compileUTF16range {
    my ($bot, $top, $printChar) = @_;

    my $utf16rules = 
    [
     [[  0x0000,   0xffff], [0x0000],  # minus 0xD800 - 0xDFFF reserved for surrogates
			    [0xffff]], 
     [[ 0x10000, 0x10ffff], [0xd7c0, 0x0000],  
			    [0xdbff, 0xdfff]], 
    ];

    $printChar ||= sub {
	my ($ch) = @_;
	my $hex = sprintf ("%04X", $ch);
	return "\\x$hex";
    };

    return _compileRange($utf16rules, $printChar, $bot, $top);
}

# This algorithm is responsible for counting and transitions between different regions of contiguous encoding. The counting works on in an arbitrary sequence of bases...
sub _compileRange {
    my ($rules, $printChar, $bot, $top) = @_;
    my $botRuleNo = &_find($rules, $bot);
    my $topRuleNo = &_find($rules, $top);
    my $ret;
    if ($botRuleNo == $topRuleNo) {
	$ret = &_expandRange($rules, $printChar, $botRuleNo, $bot, $top);
    } else {
	my $bRule = $rules->[$botRuleNo];
	my $tRule = $rules->[$topRuleNo];

	my @ranges;
	my $t;

	# Expand the bottom rule (including stair-steps)
	(undef, undef, $t) = &_expandRange($rules, $printChar, $botRuleNo, $bot, chr($bRule->[0][1]));
	push (@ranges, $t);

	# Expland each rule in between the bottom and top.
	for (my $i = $botRuleNo+1; $i < $topRuleNo; $i++) {
	    (undef, undef, $t) = &_expandRange($rules, $printChar, $i, chr($rules->[$i][0][0]), chr($rules->[$i][0][1]));
	    push (@ranges, $t);
	}

	# Expand the top rule.
	(undef, undef, $t) = &_expandRange($rules, $printChar, $topRuleNo, chr($tRule->[0][0]), $top);
	push (@ranges, $t);
	$ret = join('|', @ranges);;
    }
    return $ret;
}

# Find which rule subsumes the codepoint.
sub _find {
    my ($rules, $point) = @_;
    for (my $i = 0; $i < @$rules; $i++) {
	if (ord($point) >= $rules->[$i][0][0] && 
	    ord($point) <= $rules->[$i][0][1]) {
	    return $i;
	}
    }
    die;
}

# Expand the characters between $bot and $top. ruleNo must subsume both characters.
sub _expandRange {
    my ($rules, $printChar, $ruleNo, $bot, $top) = @_;
    &utf8::encode($bot);
    &utf8::encode($top);
    my $botBytes = [unpack('C*', $bot)];
    my $topBytes = [unpack('C*', $top)];
    my $bytes = scalar @$botBytes;
    my $rule = $rules->[$ruleNo];
    return &_walk([@{$rule->[1]}], [@{$rule->[2]}], $botBytes, $topBytes, $printChar);
}
my $SEQ = '';
sub _walk {
    my ($bRules, $tRules, $botBytes, $topBytes, $printChar) = @_;
    my $bRule = shift (@$bRules);
    my $tRule = shift (@$tRules);
    my $botByte = shift (@$botBytes);
    my $topByte = shift (@$topBytes);
    my $b = &$printChar($botByte);
    my $t = &$printChar($topByte);
    my $rb = &$printChar($bRule);
    my $rt = &$printChar($tRule);

    if (!@$bRules) {
	return ($botByte != $bRule, $topByte != $tRule, $botByte == $topByte ? "$b" : "[$b-$t]");
    }

    # Do a tentative walk of remaining chars. Sets $splitB and $splitT.
    my ($splitB, $splitT, $range) = &_walk([@$bRules], [@$tRules], [@$botBytes], [@$topBytes], $printChar);

    if ($botByte == $topByte) {
	return ($splitB, $splitT, "($b$SEQ$range)");
    }

    my @ret;
    my $topStr = '';

    if ($splitB) {
	# Walk the bottom as if the top char is the top rule.
	my (undef, undef, $bRange) = &_walk([@$bRules], [@$tRules], [@$botBytes], [@$tRules], $printChar);
	push (@ret,"($b$SEQ$bRange)");
	$botByte++;
	$b = &$printChar($botByte);
    } elsif ($botByte > $bRule) {
	$splitB = 1; # our callers have to worry about stair-stepping
    }

    if ($splitT) {
	# Walk the bottom as if the bottom char is the bottom rule.
	my (undef, undef, $tRange) = &_walk([@$bRules], [@$tRules], [@$bRules], [@$topBytes], $printChar);
	$topStr = "($t$SEQ$tRange)";
	$topByte--;
	$t = &$printChar($topByte);
    } elsif ($topByte > $tRule) {
	$splitT = 1; # our callers have to worry about stair-stepping
    }

    # Walk intermediate sub-rules.
    if ($topByte > $botByte) {
	my $r1 = &_walkFull([@$bRules], [@$tRules], $printChar);
	push (@ret, "([$b-$t]$SEQ$r1)");
    }
    if ($topStr) {
	push (@ret, $topStr);
    }
    return ($splitB, $splitT, join("|", @ret));
}

# Include all chars between $bot and $top .
sub _walkFull {
    my ($bot, $top, $printChar) = @_;
    my $b = &$printChar(shift @$bot);
    my $t = &$printChar(shift @$top);
    my $ret = $b eq $t ? $b : "[$b-$t]";
    if (@$bot) {
	my $r = &_walkFull($bot, $top, $printChar);
	return "$ret$SEQ$r";
    } else {
	return $ret;
    }
}

1;

__END__

=head1 NAME

W3C::Grammar::CharacterRange - Utilities for handling character classes.

=head1 SYNOPSIS

  use W3C::Grammar::CharacterRange;
  $t = W3C::Grammar::CharacterRange::compileUTF8range($lc, $rc);


=head1 DESCRIPTION


This module is part of the W3C::Grammar CPAN module.

=head1 METHODS

=head2 CharacterRange:

=head2 compileUTF8range(lower, upper)

return a string expressing the range of the lower to the upper UTC codes expressed as UTF-8 validating byte sequences.

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
