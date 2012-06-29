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
package W3C::Grammar::_YaccParser;
use vars qw ( @ISA );
use strict;

@ISA= qw ( Parse::Yapp::Driver );
# use Parse::Yapp::Driver; @@ replaced by W3C::Util::YappDriver

#line 4 "YaccParser.yp"

require 5.004;

use Carp;

    use W3C::Util::Exception;
    use W3C::Util::YappDriver;
    use W3C::Grammar::YaccCompileTree qw($PassedTokensName);
    #use W3C::Grammar::LexLexer;
    @ISA= qw (W3C::Util::YappDriver);

my($input,$lexlevel,$nberr,@lineno,$prec,$labelno);
my($head,$tail,$Token,$Terminals,$NonTerminals,$rules,$PrecedenceTerminals,$start,$nullable);
my($expect);
my $NoSemiNeeded = 0;
my $Messages = [];

my $LexMode = 0; # not lexing lex
my $CharClass = undef; # not lexing a character class



sub new {
        my($class)=shift;
        ref($class)
    and $class=ref($class);

    my($self)=$class->SUPER::new( yyversion => '1.05',
                                  yystates =>
[
	{#State 0
		ACTIONS => {
			"%%" => -6,
			"\n" => 4,
			'EXPECT' => 3,
			'COMMENT' => 6,
			'TYPE' => 5,
			'UNION' => 9,
			'START' => 10,
			'error' => 12,
			'TOKEN' => 13,
			"[" => 14,
			'ASSOC' => 16,
			'HEADCODE' => 15
		},
		GOTOS => {
			'head' => 1,
			'decl' => 11,
			'yapp' => 2,
			'headsec' => 7,
			'decls' => 8
		}
	},
	{#State 1
		ACTIONS => {
			'PASS' => -88,
			"%%" => 18,
			'TERMINAL' => -88,
			'IDENT' => -88,
			'COMMENT' => 19,
			'error' => 22,
			"[" => 24
		},
		GOTOS => {
			'body' => 21,
			'ordinalOpt' => 17,
			'rulesec' => 23,
			'rules' => 20
		}
	},
	{#State 2
		ACTIONS => {
			'' => 25
		}
	},
	{#State 3
		ACTIONS => {
			'NUMBER' => 26
		}
	},
	{#State 4
		DEFAULT => -12
	},
	{#State 5
		ACTIONS => {
			"<" => 28
		},
		DEFAULT => -24,
		GOTOS => {
			'typedecl' => 27
		}
	},
	{#State 6
		DEFAULT => -13
	},
	{#State 7
		ACTIONS => {
			"%%" => 29
		}
	},
	{#State 8
		ACTIONS => {
			"%%" => -7,
			"\n" => 4,
			'EXPECT' => 3,
			'COMMENT' => 6,
			'TYPE' => 5,
			'UNION' => 9,
			'START' => 10,
			'error' => 12,
			'TOKEN' => 13,
			"[" => 14,
			'ASSOC' => 16,
			'HEADCODE' => 15
		},
		GOTOS => {
			'decl' => 30
		}
	},
	{#State 9
		ACTIONS => {
			'CODE' => 31
		}
	},
	{#State 10
		ACTIONS => {
			'IDENT' => 32
		},
		GOTOS => {
			'ident' => 33
		}
	},
	{#State 11
		DEFAULT => -9
	},
	{#State 12
		ACTIONS => {
			"\n" => 34
		}
	},
	{#State 13
		ACTIONS => {
			"<" => 28
		},
		DEFAULT => -24,
		GOTOS => {
			'typedecl' => 35
		}
	},
	{#State 14
		ACTIONS => {
			'NUMBER' => 37
		},
		DEFAULT => -90,
		GOTOS => {
			'ordinal' => 36
		}
	},
	{#State 15
		ACTIONS => {
			"\n" => 38
		}
	},
	{#State 16
		ACTIONS => {
			"<" => 28
		},
		DEFAULT => -24,
		GOTOS => {
			'typedecl' => 39
		}
	},
	{#State 17
		ACTIONS => {
			'PASS' => 40,
			'IDENT' => 42,
			'TERMINAL' => 41
		}
	},
	{#State 18
		DEFAULT => -64
	},
	{#State 19
		DEFAULT => -76
	},
	{#State 20
		DEFAULT => -66
	},
	{#State 21
		ACTIONS => {
			'TAILCODE' => 43
		},
		DEFAULT => -135,
		GOTOS => {
			'tail' => 44
		}
	},
	{#State 22
		ACTIONS => {
			";" => 45
		}
	},
	{#State 23
		ACTIONS => {
			'PASS' => -88,
			"%%" => 46,
			'TERMINALS' => 47,
			'TERMINAL' => -88,
			'IDENT' => -88,
			'COMMENT' => 19,
			'error' => 22,
			"[" => 24
		},
		GOTOS => {
			'ordinalOpt' => 17,
			'rules' => 48
		}
	},
	{#State 24
		ACTIONS => {
			'NUMBER' => 37
		},
		DEFAULT => -90,
		GOTOS => {
			'ordinal' => 49
		}
	},
	{#State 25
		DEFAULT => 0
	},
	{#State 26
		ACTIONS => {
			"\n" => 50
		}
	},
	{#State 27
		ACTIONS => {
			'IDENT' => 32
		},
		GOTOS => {
			'identlist' => 51,
			'ident' => 52
		}
	},
	{#State 28
		ACTIONS => {
			'IDENT' => 53
		}
	},
	{#State 29
		DEFAULT => -5
	},
	{#State 30
		DEFAULT => -8
	},
	{#State 31
		ACTIONS => {
			"\n" => 54
		}
	},
	{#State 32
		DEFAULT => -4
	},
	{#State 33
		ACTIONS => {
			"\n" => 55
		}
	},
	{#State 34
		DEFAULT => -21
	},
	{#State 35
		ACTIONS => {
			'LITERAL' => 57,
			'IDENT' => 32
		},
		GOTOS => {
			'symlist' => 59,
			'symbol' => 56,
			'ident' => 58
		}
	},
	{#State 36
		ACTIONS => {
			"]" => 60
		}
	},
	{#State 37
		ACTIONS => {
			'IDENT' => 61
		},
		DEFAULT => -91
	},
	{#State 38
		DEFAULT => -17
	},
	{#State 39
		ACTIONS => {
			'LITERAL' => 57,
			'IDENT' => 32
		},
		GOTOS => {
			'symlist' => 62,
			'symbol' => 56,
			'ident' => 58
		}
	},
	{#State 40
		ACTIONS => {
			":" => 63
		},
		GOTOS => {
			'ruleMarker' => 64
		}
	},
	{#State 41
		ACTIONS => {
			":" => 63
		},
		GOTOS => {
			'ruleMarker' => 65
		}
	},
	{#State 42
		ACTIONS => {
			":" => 63
		},
		GOTOS => {
			'ruleMarker' => 66
		}
	},
	{#State 43
		DEFAULT => -136
	},
	{#State 44
		DEFAULT => -1
	},
	{#State 45
		DEFAULT => -77
	},
	{#State 46
		DEFAULT => -63
	},
	{#State 47
		ACTIONS => {
			'PASS' => -88,
			'error' => 71,
			'IDENT' => -88,
			"[" => 24,
			'COMMENT' => 69
		},
		GOTOS => {
			'termsec' => 70,
			'ordinalOpt' => 67,
			'terms' => 68
		}
	},
	{#State 48
		DEFAULT => -65
	},
	{#State 49
		ACTIONS => {
			"]" => 72
		}
	},
	{#State 50
		DEFAULT => -20
	},
	{#State 51
		ACTIONS => {
			"\n" => 73,
			'IDENT' => 32
		},
		GOTOS => {
			'ident' => 74
		}
	},
	{#State 52
		DEFAULT => -29
	},
	{#State 53
		ACTIONS => {
			">" => 75
		}
	},
	{#State 54
		DEFAULT => -18
	},
	{#State 55
		DEFAULT => -16
	},
	{#State 56
		DEFAULT => -27
	},
	{#State 57
		DEFAULT => -2
	},
	{#State 58
		DEFAULT => -3
	},
	{#State 59
		ACTIONS => {
			'LITERAL' => 57,
			'IDENT' => 32
		},
		DEFAULT => -10,
		GOTOS => {
			'CMNTS' => 77,
			'symbol' => 76,
			'ident' => 58
		}
	},
	{#State 60
		ACTIONS => {
			'TERMINAL' => 78
		}
	},
	{#State 61
		DEFAULT => -92
	},
	{#State 62
		ACTIONS => {
			'LITERAL' => 57,
			'IDENT' => 32
		},
		DEFAULT => -10,
		GOTOS => {
			'CMNTS' => 79,
			'symbol' => 76,
			'ident' => 58
		}
	},
	{#State 63
		ACTIONS => {
			":" => 80
		},
		DEFAULT => -93
	},
	{#State 64
		DEFAULT => -73,
		GOTOS => {
			'@8-3' => 81
		}
	},
	{#State 65
		DEFAULT => -70,
		GOTOS => {
			'@6-3' => 82
		}
	},
	{#State 66
		DEFAULT => -67,
		GOTOS => {
			'@4-3' => 83
		}
	},
	{#State 67
		ACTIONS => {
			'PASS' => 84,
			'IDENT' => 85
		}
	},
	{#State 68
		DEFAULT => -79
	},
	{#State 69
		DEFAULT => -86
	},
	{#State 70
		ACTIONS => {
			'PASS' => -88,
			"%%" => 86,
			'error' => 71,
			'IDENT' => -88,
			"[" => 24,
			'COMMENT' => 69
		},
		GOTOS => {
			'ordinalOpt' => 67,
			'terms' => 87
		}
	},
	{#State 71
		ACTIONS => {
			";" => 88
		}
	},
	{#State 72
		DEFAULT => -89
	},
	{#State 73
		DEFAULT => -19
	},
	{#State 74
		DEFAULT => -28
	},
	{#State 75
		DEFAULT => -25
	},
	{#State 76
		DEFAULT => -26
	},
	{#State 77
		ACTIONS => {
			"\n" => 89,
			'COMMENT' => 90
		}
	},
	{#State 78
		ACTIONS => {
			":" => 91
		}
	},
	{#State 79
		ACTIONS => {
			"\n" => 92,
			'COMMENT' => 90
		}
	},
	{#State 80
		ACTIONS => {
			"=" => 93
		}
	},
	{#State 81
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -105,
		GOTOS => {
			'termrhs' => 102,
			'lmodifiableelt' => 94,
			'termrhselts' => 99,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termrhss' => 100,
			'termmodifiedelt' => 107,
			'termrule' => 108,
			'resolvableelt1' => 109
		}
	},
	{#State 82
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -105,
		GOTOS => {
			'termrhs' => 102,
			'lmodifiableelt' => 94,
			'termrhselts' => 99,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termrhss' => 110,
			'termmodifiedelt' => 107,
			'termrule' => 108,
			'resolvableelt1' => 109
		}
	},
	{#State 83
		ACTIONS => {
			"/" => 124,
			'CODE' => 123,
			'LITERAL' => 57,
			'IDENT' => 32,
			'COMMENT' => 113,
			'TERMINAL' => 112,
			"(" => 125,
			"[" => 118
		},
		DEFAULT => -103,
		GOTOS => {
			'symbol' => 122,
			'rhs' => 111,
			'rule' => 115,
			'modifiedelt' => 114,
			'ident' => 58,
			'rhss' => 116,
			'rhselt' => 117,
			'rhselts' => 119,
			'modifiableelt' => 120,
			'code' => 121
		}
	},
	{#State 84
		ACTIONS => {
			":" => 63
		},
		GOTOS => {
			'ruleMarker' => 126
		}
	},
	{#State 85
		ACTIONS => {
			":" => 63
		},
		GOTOS => {
			'ruleMarker' => 127
		}
	},
	{#State 86
		DEFAULT => -62
	},
	{#State 87
		DEFAULT => -78
	},
	{#State 88
		DEFAULT => -87
	},
	{#State 89
		DEFAULT => -14
	},
	{#State 90
		DEFAULT => -11
	},
	{#State 91
		ACTIONS => {
			":" => 128
		}
	},
	{#State 92
		DEFAULT => -15
	},
	{#State 93
		DEFAULT => -94
	},
	{#State 94
		ACTIONS => {
			"?" => 131,
			"+" => 129,
			"*" => 130
		},
		DEFAULT => -120
	},
	{#State 95
		DEFAULT => -115
	},
	{#State 96
		DEFAULT => -51
	},
	{#State 97
		DEFAULT => -50
	},
	{#State 98
		DEFAULT => -49
	},
	{#State 99
		DEFAULT => -106
	},
	{#State 100
		ACTIONS => {
			'EOProduction' => 132,
			"|" => 133
		}
	},
	{#State 101
		DEFAULT => -52,
		GOTOS => {
			'@2-1' => 134
		}
	},
	{#State 102
		ACTIONS => {
			'PREC' => 135
		},
		DEFAULT => -102,
		GOTOS => {
			'prec' => 136
		}
	},
	{#State 103
		ACTIONS => {
			"(" => 104,
			"/" => 103,
			"[" => 101,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96
		},
		GOTOS => {
			'resolvableelt' => 106,
			'lmodifiableelt' => 137,
			'resolvableelt1' => 109
		}
	},
	{#State 104
		ACTIONS => {
			"/" => 103,
			'CODE' => 123,
			'COMMENT' => 141,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'lrhs' => 143,
			'lrhss' => 138,
			'lrule' => 139,
			'lmodifiableelt' => 140,
			'lmodifiedelt' => 144,
			'lrhselt' => 145,
			'lrhselts' => 146,
			'resolvableelt' => 106,
			'resolvableelt1' => 109,
			'code' => 142
		}
	},
	{#State 105
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -110,
		GOTOS => {
			'termrhselts' => 147,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termmodifiedelt' => 107,
			'lmodifiableelt' => 94,
			'resolvableelt1' => 109
		}
	},
	{#State 106
		DEFAULT => -47
	},
	{#State 107
		DEFAULT => -114
	},
	{#State 108
		DEFAULT => -98
	},
	{#State 109
		ACTIONS => {
			"-" => 148
		},
		DEFAULT => -44
	},
	{#State 110
		ACTIONS => {
			'EOProduction' => 149,
			"|" => 133
		}
	},
	{#State 111
		ACTIONS => {
			'PREC' => 135
		},
		DEFAULT => -100,
		GOTOS => {
			'prec' => 150
		}
	},
	{#State 112
		DEFAULT => -125
	},
	{#State 113
		DEFAULT => -113
	},
	{#State 114
		DEFAULT => -111
	},
	{#State 115
		DEFAULT => -96
	},
	{#State 116
		ACTIONS => {
			'EOProduction' => 151,
			"|" => 152
		}
	},
	{#State 117
		ACTIONS => {
			"/" => 124,
			'CODE' => 123,
			'LITERAL' => 57,
			'IDENT' => 32,
			'COMMENT' => 113,
			'TERMINAL' => 112,
			"(" => 125,
			"[" => 118
		},
		DEFAULT => -108,
		GOTOS => {
			'symbol' => 122,
			'rhselt' => 117,
			'rhselts' => 153,
			'modifiedelt' => 114,
			'ident' => 58,
			'code' => 121,
			'modifiableelt' => 120
		}
	},
	{#State 118
		DEFAULT => -127,
		GOTOS => {
			'@14-1' => 154
		}
	},
	{#State 119
		DEFAULT => -104
	},
	{#State 120
		ACTIONS => {
			"+" => 155,
			"*" => 156,
			"?" => 157
		},
		DEFAULT => -116
	},
	{#State 121
		DEFAULT => -112
	},
	{#State 122
		DEFAULT => -124
	},
	{#State 123
		DEFAULT => -134
	},
	{#State 124
		ACTIONS => {
			"(" => 104,
			"/" => 103,
			"[" => 101,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96
		},
		GOTOS => {
			'resolvableelt' => 106,
			'lmodifiableelt' => 158,
			'resolvableelt1' => 109
		}
	},
	{#State 125
		ACTIONS => {
			"/" => 124,
			'CODE' => 123,
			'LITERAL' => 57,
			'IDENT' => 32,
			'COMMENT' => 113,
			'TERMINAL' => 112,
			"(" => 125,
			"[" => 118
		},
		DEFAULT => -103,
		GOTOS => {
			'symbol' => 122,
			'rhs' => 111,
			'rule' => 115,
			'modifiedelt' => 114,
			'ident' => 58,
			'rhss' => 159,
			'rhselt' => 117,
			'rhselts' => 119,
			'modifiableelt' => 120,
			'code' => 121
		}
	},
	{#State 126
		DEFAULT => -83,
		GOTOS => {
			'@12-3' => 160
		}
	},
	{#State 127
		DEFAULT => -80,
		GOTOS => {
			'@10-3' => 161
		}
	},
	{#State 128
		ACTIONS => {
			"=" => 162
		}
	},
	{#State 129
		DEFAULT => -123
	},
	{#State 130
		DEFAULT => -121
	},
	{#State 131
		DEFAULT => -122
	},
	{#State 132
		DEFAULT => -74,
		GOTOS => {
			'@9-6' => 163
		}
	},
	{#State 133
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -105,
		GOTOS => {
			'termrhs' => 102,
			'termrhselts' => 99,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termmodifiedelt' => 107,
			'termrule' => 164,
			'lmodifiableelt' => 94,
			'resolvableelt1' => 109
		}
	},
	{#State 134
		ACTIONS => {
			'CARROT' => 170,
			'LITERAL' => 165
		},
		GOTOS => {
			'charclass' => 166,
			'lRangeElem' => 167,
			'lrangeList' => 168,
			'lRange' => 169
		}
	},
	{#State 135
		ACTIONS => {
			'LITERAL' => 57,
			'IDENT' => 32
		},
		GOTOS => {
			'symbol' => 171,
			'ident' => 58
		}
	},
	{#State 136
		ACTIONS => {
			'CODE' => 123
		},
		DEFAULT => -132,
		GOTOS => {
			'epscode' => 173,
			'code' => 172
		}
	},
	{#State 137
		DEFAULT => -46
	},
	{#State 138
		ACTIONS => {
			"|" => 175,
			")" => 174
		}
	},
	{#State 139
		DEFAULT => -31
	},
	{#State 140
		ACTIONS => {
			"?" => 178,
			"+" => 176,
			"*" => 177
		},
		DEFAULT => -40
	},
	{#State 141
		DEFAULT => -39
	},
	{#State 142
		DEFAULT => -38
	},
	{#State 143
		DEFAULT => -32
	},
	{#State 144
		DEFAULT => -37
	},
	{#State 145
		ACTIONS => {
			"/" => 103,
			'CODE' => 123,
			'COMMENT' => 141,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -35,
		GOTOS => {
			'lrhselt' => 145,
			'lmodifiedelt' => 144,
			'lrhselts' => 179,
			'resolvableelt' => 106,
			'lmodifiableelt' => 140,
			'resolvableelt1' => 109,
			'code' => 142
		}
	},
	{#State 146
		DEFAULT => -34
	},
	{#State 147
		DEFAULT => -109
	},
	{#State 148
		ACTIONS => {
			"[" => 101,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96
		},
		GOTOS => {
			'resolvableelt' => 180
		}
	},
	{#State 149
		DEFAULT => -71,
		GOTOS => {
			'@7-6' => 181
		}
	},
	{#State 150
		ACTIONS => {
			'CODE' => 123
		},
		DEFAULT => -132,
		GOTOS => {
			'epscode' => 182,
			'code' => 172
		}
	},
	{#State 151
		DEFAULT => -68,
		GOTOS => {
			'@5-6' => 183
		}
	},
	{#State 152
		ACTIONS => {
			"/" => 124,
			'CODE' => 123,
			'LITERAL' => 57,
			'IDENT' => 32,
			'COMMENT' => 113,
			'TERMINAL' => 112,
			"(" => 125,
			"[" => 118
		},
		DEFAULT => -103,
		GOTOS => {
			'symbol' => 122,
			'rhs' => 111,
			'rule' => 184,
			'modifiedelt' => 114,
			'ident' => 58,
			'rhselt' => 117,
			'rhselts' => 119,
			'modifiableelt' => 120,
			'code' => 121
		}
	},
	{#State 153
		DEFAULT => -107
	},
	{#State 154
		ACTIONS => {
			'CARROT' => 170,
			'LITERAL' => 165
		},
		GOTOS => {
			'charclass' => 185,
			'lRangeElem' => 167,
			'lrangeList' => 168,
			'lRange' => 169
		}
	},
	{#State 155
		DEFAULT => -119
	},
	{#State 156
		DEFAULT => -117
	},
	{#State 157
		DEFAULT => -118
	},
	{#State 158
		DEFAULT => -130
	},
	{#State 159
		ACTIONS => {
			"|" => 152,
			")" => 186
		}
	},
	{#State 160
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -105,
		GOTOS => {
			'termrhs' => 102,
			'lmodifiableelt' => 94,
			'termrhselts' => 99,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termrhss' => 187,
			'termmodifiedelt' => 107,
			'termrule' => 108,
			'resolvableelt1' => 109
		}
	},
	{#State 161
		ACTIONS => {
			"/" => 103,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			'COMMENT' => 95,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -105,
		GOTOS => {
			'termrhs' => 102,
			'lmodifiableelt' => 94,
			'termrhselts' => 99,
			'termrhselt' => 105,
			'resolvableelt' => 106,
			'termrhss' => 188,
			'termmodifiedelt' => 107,
			'termrule' => 108,
			'resolvableelt1' => 109
		}
	},
	{#State 162
		ACTIONS => {
			"/" => 103,
			'CODE' => 123,
			'COMMENT' => 141,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'lrhs' => 143,
			'lrhss' => 189,
			'lrule' => 139,
			'lmodifiableelt' => 140,
			'lmodifiedelt' => 144,
			'lrhselt' => 145,
			'lrhselts' => 146,
			'resolvableelt' => 106,
			'resolvableelt1' => 109,
			'code' => 142
		}
	},
	{#State 163
		DEFAULT => -75
	},
	{#State 164
		DEFAULT => -97
	},
	{#State 165
		DEFAULT => -61
	},
	{#State 166
		ACTIONS => {
			"]" => 190
		}
	},
	{#State 167
		ACTIONS => {
			'RANGEOP' => 191
		},
		DEFAULT => -59
	},
	{#State 168
		ACTIONS => {
			'LITERAL' => 165
		},
		DEFAULT => -55,
		GOTOS => {
			'lRangeElem' => 167,
			'lRange' => 192
		}
	},
	{#State 169
		DEFAULT => -57
	},
	{#State 170
		ACTIONS => {
			'LITERAL' => 165
		},
		GOTOS => {
			'lRangeElem' => 167,
			'lrangeList' => 193,
			'lRange' => 169
		}
	},
	{#State 171
		DEFAULT => -131
	},
	{#State 172
		DEFAULT => -133
	},
	{#State 173
		DEFAULT => -101
	},
	{#State 174
		DEFAULT => -45
	},
	{#State 175
		ACTIONS => {
			"/" => 103,
			'CODE' => 123,
			'COMMENT' => 141,
			'LITERAL' => 98,
			'IDENT' => 97,
			'TERMINAL' => 96,
			"(" => 104,
			"[" => 101
		},
		DEFAULT => -33,
		GOTOS => {
			'lrhs' => 143,
			'lrule' => 194,
			'lmodifiableelt' => 140,
			'lmodifiedelt' => 144,
			'lrhselt' => 145,
			'resolvableelt' => 106,
			'lrhselts' => 146,
			'resolvableelt1' => 109,
			'code' => 142
		}
	},
	{#State 176
		DEFAULT => -43
	},
	{#State 177
		DEFAULT => -41
	},
	{#State 178
		DEFAULT => -42
	},
	{#State 179
		DEFAULT => -36
	},
	{#State 180
		DEFAULT => -48
	},
	{#State 181
		DEFAULT => -72
	},
	{#State 182
		DEFAULT => -99
	},
	{#State 183
		DEFAULT => -69
	},
	{#State 184
		DEFAULT => -95
	},
	{#State 185
		ACTIONS => {
			"]" => 195
		}
	},
	{#State 186
		DEFAULT => -126
	},
	{#State 187
		ACTIONS => {
			'EOProduction' => 196,
			"|" => 133
		}
	},
	{#State 188
		ACTIONS => {
			'EOProduction' => 197,
			"|" => 133
		}
	},
	{#State 189
		ACTIONS => {
			'EOProduction' => 198,
			"|" => 175
		}
	},
	{#State 190
		DEFAULT => -53,
		GOTOS => {
			'@3-4' => 199
		}
	},
	{#State 191
		ACTIONS => {
			'LITERAL' => 165
		},
		GOTOS => {
			'lRangeElem' => 200
		}
	},
	{#State 192
		DEFAULT => -58
	},
	{#State 193
		ACTIONS => {
			'LITERAL' => 165
		},
		DEFAULT => -56,
		GOTOS => {
			'lRangeElem' => 167,
			'lRange' => 192
		}
	},
	{#State 194
		DEFAULT => -30
	},
	{#State 195
		DEFAULT => -128,
		GOTOS => {
			'@15-4' => 201
		}
	},
	{#State 196
		DEFAULT => -84,
		GOTOS => {
			'@13-6' => 202
		}
	},
	{#State 197
		DEFAULT => -81,
		GOTOS => {
			'@11-6' => 203
		}
	},
	{#State 198
		DEFAULT => -22,
		GOTOS => {
			'@1-9' => 204
		}
	},
	{#State 199
		DEFAULT => -54
	},
	{#State 200
		DEFAULT => -60
	},
	{#State 201
		DEFAULT => -129
	},
	{#State 202
		DEFAULT => -85
	},
	{#State 203
		DEFAULT => -82
	},
	{#State 204
		DEFAULT => -23
	}
],
                                  yyrules  =>
[
	[#Rule 0
		 '$start', 2, undef
	],
	[#Rule 1
		 'yapp', 3,
sub
#line 31 "YaccParser.yp"
{   my ($self, $head, $body, $tail) = @_;
    return new W3C::Grammar::YaccCompileTree::Grammar($head, $body, $tail, $self->YYData->{NoIntegrityCheck}, $self);
}
	],
	[#Rule 2
		 'symbol', 1,
sub
#line 40 "YaccParser.yp"
{   my ($self, $literalInfo) = @_;
    my ($literal, $lineNo) = ($literalInfo->getToken(), $literalInfo->getLineNo());
    if (!exists($self->YYData->{Symbols}{$literal})) {
	$self->YYData->{Symbols}{$literal} = $lineNo;
	$Terminals->{$literal} = undef;
    }
    return $literalInfo;
}
	],
	[#Rule 3
		 'symbol', 1, undef
	],
	[#Rule 4
		 'ident', 1,
sub
#line 53 "YaccParser.yp"
{   my ($self, $idenifierInfo) = @_;
    my ($identifier, $lineNo) = ($idenifierInfo->getToken(), $idenifierInfo->getLineNo());
    if (!exists($self->YYData->{Symbols}{$identifier})) {
	$self->YYData->{Symbols}{$identifier} = $lineNo;
	$Terminals->{$identifier} = undef;
    }
    return $idenifierInfo;
}
	],
	[#Rule 5
		 'head', 2,
sub
#line 67 "YaccParser.yp"
{   my ($self, $headsec) = @_;
    return $headsec;
}
	],
	[#Rule 6
		 'headsec', 0,
sub
#line 74 "YaccParser.yp"
{   []}
	],
	[#Rule 7
		 'headsec', 1, undef
	],
	[#Rule 8
		 'decls', 2,
sub
#line 80 "YaccParser.yp"
{   my ($self, $decls, $decl) = @_;
    return [@$decls, $decl];
}
	],
	[#Rule 9
		 'decls', 1,
sub
#line 84 "YaccParser.yp"
{   my ($self, $decl) = @_;
    return [$decl];
}
	],
	[#Rule 10
		 'CMNTS', 0,
sub
#line 91 "YaccParser.yp"
{   []}
	],
	[#Rule 11
		 'CMNTS', 2,
sub
#line 93 "YaccParser.yp"
{   my ($self, $cmnts, $comment) = @_;
    return [ @$cmnts, $comment ];
}
	],
	[#Rule 12
		 'decl', 1, undef
	],
	[#Rule 13
		 'decl', 1, undef
	],
	[#Rule 14
		 'decl', 5,
sub
#line 103 "YaccParser.yp"
{   my ($self, $tokenInfo, $typedecl, $symlist, $comments) = @_;
    for (@$symlist) {
	my($symbol, $lineno)=@$_;
	if (exists $Token->{$symbol}) {
	    _SyntaxError(0,
			 "Token $symbol redefined: ".
			 "Previously defined line $self->YYData->{Symbols}{$symbol}",
			 $lineno);
	    next;
	}
	$Token->{$symbol}=$lineno;
	$Terminals->{$symbol} = [ ];
    }
    return new W3C::Grammar::YaccCompileTree::TokenDecl($tokenInfo, $typedecl, $symlist, $comments, $self);
}
	],
	[#Rule 15
		 'decl', 5,
sub
#line 119 "YaccParser.yp"
{   my ($self, $assocInfo, $typedecl, $symlist, $comments) = @_;
    for (@$symlist) {
	my($symbol, $lineno)=@$_;
	if (defined $Terminals->{$symbol}[0]) {
	    _SyntaxError(1,
			 "Precedence for symbol $symbol redefined: ".
			 "Previously defined line $self->YYData->{Symbols}{$symbol}",
			 $lineno);
	    next;
	}
	my ($assoc, $lineNoXXX) = @$assocInfo;
	$Token->{$symbol} = $lineno;
	$Terminals->{$symbol} = [ $assoc, $prec ];
    }
    ++$prec;
    return new W3C::Grammar::YaccCompileTree::AssocDecl($assocInfo, $typedecl, $symlist, $comments, $self);
}
	],
	[#Rule 16
		 'decl', 3,
sub
#line 137 "YaccParser.yp"
{   my ($self, $startInfo, $identInfo, undef) = @_;
    my ($foo, $bar) = @$identInfo;
    $start=$foo;
    return $identInfo;
}
	],
	[#Rule 17
		 'decl', 2,
sub
#line 143 "YaccParser.yp"
{   my ($self, $headcode, undef) = @_;
    push(@$head, $start);
    return $headcode;
}
	],
	[#Rule 18
		 'decl', 3,
sub
#line 148 "YaccParser.yp"
{   return undef; #ignore
}
	],
	[#Rule 19
		 'decl', 4,
sub
#line 154 "YaccParser.yp"
{   my ($self, $type, $typedecl, $identlist, undef) = @_;
    for ( @$identlist ) {
	my($symbol,$lineno)=@$_;
	if (exists $NonTerminals->{$symbol}) {
	    _SyntaxError(0,
			 "Non-terminal $symbol redefined: ".
			 "Previously defined line $self->YYData->{Symbols}{$symbol}",
			 $lineno);
	    next;
	}
	delete $Terminals->{$symbol};   #not a terminal
	$NonTerminals->{$symbol} = undef;    #is a non-terminal
    }
}
	],
	[#Rule 20
		 'decl', 3,
sub
#line 169 "YaccParser.yp"
{   my ($self, $expect, $numberInfo) = @_;
    my ($number, $lineNo) = @$numberInfo;
    $expect=$number;
    return undef;
}
	],
	[#Rule 21
		 'decl', 2,
sub
#line 175 "YaccParser.yp"
{   my ($self, $error, undef) = @_;
    $self->YYErrok;
}
	],
	[#Rule 22
		 '@1-9', 0,
sub
#line 178 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 23
		 'decl', 10,
sub
#line 179 "YaccParser.yp"
{   my ($self, undef, $ordinal, undef, $identInfo, undef, undef, undef, $rhss, undef, undef) = @_;
    return new W3C::Grammar::YaccCompileTree::LexGoal($identInfo, $rhss, $self);
}
	],
	[#Rule 24
		 'typedecl', 0, undef
	],
	[#Rule 25
		 'typedecl', 3, undef
	],
	[#Rule 26
		 'symlist', 2,
sub
#line 191 "YaccParser.yp"
{   my ($self, $symlist, $symbol) = @_;
    push(@$symlist,$symbol);
    return $symlist;
}
	],
	[#Rule 27
		 'symlist', 1,
sub
#line 196 "YaccParser.yp"
{   my ($self, $symbol) = @_;
    return [ $symbol ];
}
	],
	[#Rule 28
		 'identlist', 2,
sub
#line 204 "YaccParser.yp"
{   my ($self, $identlist, $ident) = @_;
    push(@$identlist, $ident);
    return $identlist;
}
	],
	[#Rule 29
		 'identlist', 1,
sub
#line 210 "YaccParser.yp"
{   my ($self, $ident) = @_;
    return [ $ident ];
}
	],
	[#Rule 30
		 'lrhss', 3,
sub
#line 218 "YaccParser.yp"
{   my ($self, $rhss, undef, $rule) = @_;
    return W3C::Grammar::YaccCompileTree::LDisjunction::addRightBranch($rhss, $rule, $self);
}
	],
	[#Rule 31
		 'lrhss', 1, undef
	],
	[#Rule 32
		 'lrule', 1,
sub
#line 226 "YaccParser.yp"
{   my ($self, $rhs) = @_;
    my $code = undef;

    if (defined $rhs && 0 &&	# !!! Disabled code
	$rhs->[-1]->isa('W3C::Grammar::YaccCompileTree::Code')) {
	$code = (pop (@$rhs))->getCode();
    }

    return new W3C::Grammar::YaccCompileTree::LRule($rhs, undef, $code, $self);
}
	],
	[#Rule 33
		 'lrhs', 0, undef
	],
	[#Rule 34
		 'lrhs', 1, undef
	],
	[#Rule 35
		 'lrhselts', 1, undef
	],
	[#Rule 36
		 'lrhselts', 2,
sub
#line 246 "YaccParser.yp"
{   my ($self, $rhselt, $rhselts) = @_;
    return new W3C::Grammar::YaccCompileTree::LSequence($rhselt, $rhselts, $self);
}
	],
	[#Rule 37
		 'lrhselt', 1, undef
	],
	[#Rule 38
		 'lrhselt', 1,
sub
#line 254 "YaccParser.yp"
{   my ($self, $code) = @_;
    return new W3C::Grammar::YaccCompileTree::Code($code, $self);
}
	],
	[#Rule 39
		 'lrhselt', 1, undef
	],
	[#Rule 40
		 'lmodifiedelt', 1, undef
	],
	[#Rule 41
		 'lmodifiedelt', 2,
sub
#line 264 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Star($elt, $marker, $self);
}
	],
	[#Rule 42
		 'lmodifiedelt', 2,
sub
#line 268 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Opt($elt, $marker, $self);
}
	],
	[#Rule 43
		 'lmodifiedelt', 2,
sub
#line 272 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Plus($elt, $marker, $self);
}
	],
	[#Rule 44
		 'lmodifiableelt', 1, undef
	],
	[#Rule 45
		 'lmodifiableelt', 3,
sub
#line 281 "YaccParser.yp"
{   my ($self, $open, $rhselts, undef) = @_;
    return UNIVERSAL::isa($rhselts, 'W3C::Grammar::YaccCompileTree::Set') ? 
    new W3C::Grammar::YaccCompileTree::LGroup($open, $rhselts, $self) : 
    $rhselts;
}
	],
	[#Rule 46
		 'lmodifiableelt', 2,
sub
#line 287 "YaccParser.yp"
{   my ($self, undef, $lookAhead) = @_;
    return new W3C::Grammar::YaccCompileTree::LookAhead($lookAhead, $self);
}
	],
	[#Rule 47
		 'resolvableelt1', 1, undef
	],
	[#Rule 48
		 'resolvableelt1', 3,
sub
#line 295 "YaccParser.yp"
{   my ($self, $resolvableelt, undef, $lrhselts) = @_;
    $resolvableelt->excludeRange($lrhselts);
    return $resolvableelt;
}
	],
	[#Rule 49
		 'resolvableelt', 1,
sub
#line 303 "YaccParser.yp"
{   my ($self, $symbol) = @_;
    return new W3C::Grammar::YaccCompileTree::LSymb($symbol, $self);
}
	],
	[#Rule 50
		 'resolvableelt', 1,
sub
#line 307 "YaccParser.yp"
{   my ($self, $terminal) = @_;
    return new W3C::Grammar::YaccCompileTree::LSymb($terminal, $self);
}
	],
	[#Rule 51
		 'resolvableelt', 1,
sub
#line 311 "YaccParser.yp"
{   my ($self, $terminal) = @_;
    return new W3C::Grammar::YaccCompileTree::LSymb($terminal, $self);
}
	],
	[#Rule 52
		 '@2-1', 0,
sub
#line 314 "YaccParser.yp"
{ $CharClass = 0; }
	],
	[#Rule 53
		 '@3-4', 0,
sub
#line 314 "YaccParser.yp"
{ $CharClass = undef; }
	],
	[#Rule 54
		 'resolvableelt', 5,
sub
#line 315 "YaccParser.yp"
{   my ($self, undef, undef, $charclass, undef, undef) = @_;
    return $charclass;
}
	],
	[#Rule 55
		 'charclass', 1,
sub
#line 322 "YaccParser.yp"
{   my ($self, $lrangeList) = @_;
    return new W3C::Grammar::YaccCompileTree::CharacterClass($lrangeList, 0, $self);
}
	],
	[#Rule 56
		 'charclass', 2,
sub
#line 326 "YaccParser.yp"
{   my ($self, undef, $lrangeList) = @_;
    return new W3C::Grammar::YaccCompileTree::CharacterClass($lrangeList, 1, $self);
}
	],
	[#Rule 57
		 'lrangeList', 1, undef
	],
	[#Rule 58
		 'lrangeList', 2,
sub
#line 342 "YaccParser.yp"
{   my ($self, $list, $lRange) = @_;
    return new W3C::Grammar::YaccCompileTree::List($list, $lRange, $self);
}
	],
	[#Rule 59
		 'lRange', 1, undef
	],
	[#Rule 60
		 'lRange', 3,
sub
#line 350 "YaccParser.yp"
{   my ($self, $list, undef, $lRange) = @_;
    return new W3C::Grammar::YaccCompileTree::Range($list, $lRange, $self);
}
	],
	[#Rule 61
		 'lRangeElem', 1,
sub
#line 357 "YaccParser.yp"
{   my ($self, $symbol) = @_;
    return new W3C::Grammar::YaccCompileTree::LSymb($symbol, $self);
}
	],
	[#Rule 62
		 'body', 4,
sub
#line 365 "YaccParser.yp"
{   my ($self, $rulesec, undef, $termsec, undef) = @_;
    if (!$start) {
	$start = $rules->[1][0];
    }

    if (ref $NonTerminals->{$start}) {
    } else {
	_SyntaxError(2,"Start symbol $start not found ".
		     "in rules section",$_[2][1]);
	$rules->[0]=[ '$start', [ $start, chr(0) ], undef, undef ];
    }
    return [@$rulesec, @$termsec];
}
	],
	[#Rule 63
		 'body', 2,
sub
#line 379 "YaccParser.yp"
{   my ($self, $rulesec, undef) = @_;
    if (!$start) {
	$start = $rules->[1][0];
    }

    if (ref $NonTerminals->{$start}) {
    } else {
	_SyntaxError(2,"Start symbol $start not found ".
		     "in rules section",$_[2][1]);
	$rules->[0]=[ '$start', [ $start, chr(0) ], undef, undef ];
    }
    return $rulesec;
}
	],
	[#Rule 64
		 'body', 1,
sub
#line 393 "YaccParser.yp"
{
    _SyntaxError(2,"No rules in input grammar",$_[1][1]);
}
	],
	[#Rule 65
		 'rulesec', 2,
sub
#line 400 "YaccParser.yp"
{   my ($self, $rulesec, $rules) = @_;
    return [ @$rulesec, $rules ];
}
	],
	[#Rule 66
		 'rulesec', 1,
sub
#line 404 "YaccParser.yp"
{   my ($self, $rules) = @_;
    return [ $rules ];
}
	],
	[#Rule 67
		 '@4-3', 0,
sub
#line 410 "YaccParser.yp"
{$NoSemiNeeded = 1;}
	],
	[#Rule 68
		 '@5-6', 0,
sub
#line 410 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 69
		 'rules', 7,
sub
#line 411 "YaccParser.yp"
{   my ($self, undef, $identInfo, undef, undef, $rhss, undef) = @_;
    return new W3C::Grammar::YaccCompileTree::Production($identInfo, $rhss, $self);
}
	],
	[#Rule 70
		 '@6-3', 0,
sub
#line 414 "YaccParser.yp"
{$NoSemiNeeded = 1;}
	],
	[#Rule 71
		 '@7-6', 0,
sub
#line 414 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 72
		 'rules', 7,
sub
#line 415 "YaccParser.yp"
{   my ($self, undef, $identInfo, undef, undef, $rhss, undef, undef) = @_; # lrhss
    return new W3C::Grammar::YaccCompileTree::LexGoal($identInfo, $rhss, $self);
}
	],
	[#Rule 73
		 '@8-3', 0,
sub
#line 418 "YaccParser.yp"
{$NoSemiNeeded = 1;}
	],
	[#Rule 74
		 '@9-6', 0,
sub
#line 418 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 75
		 'rules', 7,
sub
#line 419 "YaccParser.yp"
{   my ($self, undef, $identInfo, undef, undef, $rhss, undef) = @_;
    $identInfo->setTerminal(1);
    return new W3C::Grammar::YaccCompileTree::Pass($identInfo, $rhss, $self);
}
	],
	[#Rule 76
		 'rules', 1, undef
	],
	[#Rule 77
		 'rules', 2,
sub
#line 425 "YaccParser.yp"
{   my ($self) = @_;
    $_[0]->YYErrok;
}
	],
	[#Rule 78
		 'termsec', 2,
sub
#line 432 "YaccParser.yp"
{   my ($self, $termsec, $terms) = @_;
    return [ @$termsec, $terms ];
}
	],
	[#Rule 79
		 'termsec', 1,
sub
#line 436 "YaccParser.yp"
{   my ($self, $terms) = @_;
    return [ $terms ];
}
	],
	[#Rule 80
		 '@10-3', 0,
sub
#line 442 "YaccParser.yp"
{$NoSemiNeeded = 1;}
	],
	[#Rule 81
		 '@11-6', 0,
sub
#line 442 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 82
		 'terms', 7,
sub
#line 443 "YaccParser.yp"
{   my ($self, undef, $identInfo, undef, undef, $rhss, undef) = @_;
    $identInfo->setTerminal(1);
    return new W3C::Grammar::YaccCompileTree::LexGoal($identInfo, $rhss, $self);
}
	],
	[#Rule 83
		 '@12-3', 0,
sub
#line 447 "YaccParser.yp"
{$NoSemiNeeded = 1;}
	],
	[#Rule 84
		 '@13-6', 0,
sub
#line 447 "YaccParser.yp"
{$NoSemiNeeded = 0;}
	],
	[#Rule 85
		 'terms', 7,
sub
#line 448 "YaccParser.yp"
{   my ($self, undef, $identInfo, undef, undef, $rhss, undef) = @_;
    $identInfo->setTerminal(1);
    return new W3C::Grammar::YaccCompileTree::Pass($identInfo, $rhss, $self);
}
	],
	[#Rule 86
		 'terms', 1, undef
	],
	[#Rule 87
		 'terms', 2,
sub
#line 454 "YaccParser.yp"
{   my ($self) = @_;
    $_[0]->YYErrok;
}
	],
	[#Rule 88
		 'ordinalOpt', 0, undef
	],
	[#Rule 89
		 'ordinalOpt', 3, undef
	],
	[#Rule 90
		 'ordinal', 0, undef
	],
	[#Rule 91
		 'ordinal', 1, undef
	],
	[#Rule 92
		 'ordinal', 2, undef
	],
	[#Rule 93
		 'ruleMarker', 1, undef
	],
	[#Rule 94
		 'ruleMarker', 3, undef
	],
	[#Rule 95
		 'rhss', 3,
sub
#line 477 "YaccParser.yp"
{   my ($self, $rhss, undef, $rule) = @_;
    return W3C::Grammar::YaccCompileTree::Disjunction::addRightBranch($rhss, $rule, $self);
}
	],
	[#Rule 96
		 'rhss', 1, undef
	],
	[#Rule 97
		 'termrhss', 3,
sub
#line 485 "YaccParser.yp"
{   my ($self, $rhss, undef, $rule) = @_;
    return W3C::Grammar::YaccCompileTree::LDisjunction::addRightBranch($rhss, $rule, $self);
}
	],
	[#Rule 98
		 'termrhss', 1, undef
	],
	[#Rule 99
		 'rule', 3,
sub
#line 493 "YaccParser.yp"
{   my ($self, $rhs, $prec, $epscode) = @_;
    return new W3C::Grammar::YaccCompileTree::Rule($rhs, $prec, $epscode, $self);
}
	],
	[#Rule 100
		 'rule', 1,
sub
#line 497 "YaccParser.yp"
{   my ($self, $rhs) = @_;
    my $code = undef;

    if (defined $rhs && 0 &&	# !!! Disabled code
	$rhs->[-1]->isa('W3C::Grammar::YaccCompileTree::Code')) {
	$code = (pop (@$rhs))->getCode();
    }

    return UNIVERSAL::isa($rhs, 'W3C::Grammar::YaccCompileTree::Set') ? 
      new W3C::Grammar::YaccCompileTree::Rule($rhs, undef, $code, $self) : 
	$rhs;
}
	],
	[#Rule 101
		 'termrule', 3,
sub
#line 513 "YaccParser.yp"
{   my ($self, $rhs, $prec, $epscode) = @_;
    return new W3C::Grammar::YaccCompileTree::Rule($rhs, $prec, $epscode, $self);
}
	],
	[#Rule 102
		 'termrule', 1,
sub
#line 517 "YaccParser.yp"
{   my ($self, $rhs) = @_;
    my $code = undef;

    if (defined $rhs && 0 &&	# !!! Disabled code
	$rhs->[-1]->isa('W3C::Grammar::YaccCompileTree::Code')) {
	$code = (pop (@$rhs))->getCode();
    }

    return new W3C::Grammar::YaccCompileTree::Rule($rhs, undef, $code, $self);
}
	],
	[#Rule 103
		 'rhs', 0, undef
	],
	[#Rule 104
		 'rhs', 1, undef
	],
	[#Rule 105
		 'termrhs', 0, undef
	],
	[#Rule 106
		 'termrhs', 1, undef
	],
	[#Rule 107
		 'rhselts', 2,
sub
#line 541 "YaccParser.yp"
{   my ($self, $rhselt, $rhselts) = @_;
    return new W3C::Grammar::YaccCompileTree::Sequence($rhselt, $rhselts, $self);
}
	],
	[#Rule 108
		 'rhselts', 1, undef
	],
	[#Rule 109
		 'termrhselts', 2,
sub
#line 549 "YaccParser.yp"
{   my ($self, $rhselt, $rhselts) = @_;
    return new W3C::Grammar::YaccCompileTree::Sequence($rhselt, $rhselts, $self);
}
	],
	[#Rule 110
		 'termrhselts', 1, undef
	],
	[#Rule 111
		 'rhselt', 1, undef
	],
	[#Rule 112
		 'rhselt', 1,
sub
#line 558 "YaccParser.yp"
{   my ($self, $code) = @_;
    return new W3C::Grammar::YaccCompileTree::Code($code, $self);
}
	],
	[#Rule 113
		 'rhselt', 1, undef
	],
	[#Rule 114
		 'termrhselt', 1, undef
	],
	[#Rule 115
		 'termrhselt', 1, undef
	],
	[#Rule 116
		 'modifiedelt', 1, undef
	],
	[#Rule 117
		 'modifiedelt', 2,
sub
#line 572 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Star($elt, $marker, $self);
}
	],
	[#Rule 118
		 'modifiedelt', 2,
sub
#line 576 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Opt($elt, $marker, $self);
}
	],
	[#Rule 119
		 'modifiedelt', 2,
sub
#line 580 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Plus($elt, $marker, $self);
}
	],
	[#Rule 120
		 'termmodifiedelt', 1, undef
	],
	[#Rule 121
		 'termmodifiedelt', 2,
sub
#line 588 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Star($elt, $marker, $self);
}
	],
	[#Rule 122
		 'termmodifiedelt', 2,
sub
#line 592 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Opt($elt, $marker, $self);
}
	],
	[#Rule 123
		 'termmodifiedelt', 2,
sub
#line 596 "YaccParser.yp"
{   my ($self, $elt, $marker) = @_;
    return new W3C::Grammar::YaccCompileTree::Plus($elt, $marker, $self);
}
	],
	[#Rule 124
		 'modifiableelt', 1,
sub
#line 603 "YaccParser.yp"
{   my ($self, $symbol) = @_;
    return new W3C::Grammar::YaccCompileTree::Symb($symbol, $self);
}
	],
	[#Rule 125
		 'modifiableelt', 1,
sub
#line 607 "YaccParser.yp"
{   my ($self, $terminal) = @_;
    return new W3C::Grammar::YaccCompileTree::Symb($terminal, $self);
}
	],
	[#Rule 126
		 'modifiableelt', 3,
sub
#line 611 "YaccParser.yp"
{   my ($self, $open, $rhselts, undef) = @_;
    return UNIVERSAL::isa($rhselts, 'W3C::Grammar::YaccCompileTree::Set') ? 
    new W3C::Grammar::YaccCompileTree::Group($open, $rhselts, $self) : 
    $rhselts;
}
	],
	[#Rule 127
		 '@14-1', 0,
sub
#line 616 "YaccParser.yp"
{ $CharClass = 0; }
	],
	[#Rule 128
		 '@15-4', 0,
sub
#line 616 "YaccParser.yp"
{ $CharClass = undef; }
	],
	[#Rule 129
		 'modifiableelt', 5,
sub
#line 617 "YaccParser.yp"
{   my ($self, $bracket, undef, $charclass, undef, undef) = @_;
    my $charclassStr = $charclass->toString();
    _SyntaxError(1, "character classes must only appear in a terminal (found $charclassStr)",
		 $bracket->getLineNo());
    return $charclass;
}
	],
	[#Rule 130
		 'modifiableelt', 2,
sub
#line 624 "YaccParser.yp"
{   my ($self, $slash, $lookAhead) = @_;
    my $lookAheadStr = $lookAhead->toString();
    _SyntaxError(1, "lookahead must only appear in a terminal (found $lookAheadStr)",
		 $slash->getLineNo());
    return new W3C::Grammar::YaccCompileTree::LookAhead($lookAhead, $self);
}
	],
	[#Rule 131
		 'prec', 2,
sub
#line 634 "YaccParser.yp"
{   my ($self, $prec, $symbol) = @_;
    if (!defined $Terminals->{$_[2][0]}) {
	_SyntaxError(1,"No precedence for symbol $_[2][0]",
		     $_[2][1]);
	return undef;
    }

    ++$$PrecedenceTerminals{$_[2][0]};
    $Terminals->{$_[2][0]}[1];
}
	],
	[#Rule 132
		 'epscode', 0,
sub
#line 647 "YaccParser.yp"
{   return undef;
}
	],
	[#Rule 133
		 'epscode', 1,
sub
#line 650 "YaccParser.yp"
{   my ($self, $code) = @_;
    return $code;
}
	],
	[#Rule 134
		 'code', 1,
sub
#line 657 "YaccParser.yp"
{   my ($self, $code) = @_;
    return $code;
}
	],
	[#Rule 135
		 'tail', 0, undef
	],
	[#Rule 136
		 'tail', 1,
sub
#line 666 "YaccParser.yp"
{   my ($self, $tailcode) = @_;
    return $tail = $tailcode;
}
	]
],
                                  @_);
    bless($self,$class);
}

#line 672 "YaccParser.yp"

sub _Error {
    my ($self, @parms) = @_;
    my($value)=$self->YYCurval;

    $self->YYData->{INPUT} = $$input;
    $self->YYData->{my_LASTPOS} = pos $$input;
    &throw(new W3C::Util::YappDriver::MesgYappContextException($self, @parms));
    my($what)= $Token ? "input: '$$value[0]'" : "end of input";

    _SyntaxError(1,"Unexpected $what",$$value[1]);
}

use constant SEC_head => 0;
use constant SEC_body => 1;
use constant SEC_tail => 2;

sub _Lexer {
    my ($self) = @_;

    if ($self->YYData->{Fake} eq 'bodyTransition') {
	$self->YYData->{Fake} = 'tailTransition';
        ++$lexlevel;
        return('%%', [ '%%', $lineno[0] ]);
    }

    #At EOF
    if (pos($$input) >= length($$input)) {
	if ($NoSemiNeeded) {
	    $NoSemiNeeded = 0;
	    return ('EOProduction', 'EOProduction')
	}
	if ($self->YYData->{Fake} eq 'tailTransition') {
	    $self->YYData->{Fake} = '';
	    ++$lexlevel;
	    return('%%', [ '%%', $lineno[0] ]);
	}

	return('',[ undef, -1 ]);
    }

    #In Character Class
    if (defined $CharClass) {
	my $ret;
	if ($CharClass == 0 && $$input =~ m/\G(\^)/gc) {
	    $ret = ['CARROT' , new W3C::Grammar::YaccCompileTree::LLITERAL($1, $lineno[0], $self)];
	} elsif ($$input =~ m/\G\#x([0-9A-Fa-f]+)/gc) {
	    my $char = chr(hex($1));
	    $ret = ['LITERAL' , new W3C::Grammar::YaccCompileTree::LLITERAL($char, $lineno[0], $self)];
	} elsif ($$input =~ m/\G(\\.)/gc) {
	    my $str = $1;
	$str =~ s/\\\\/\\/g;
	$str =~ s/\\\"/\"/g;
	$str =~ s/\\r/\r/g;
	$str =~ s/\\n/\n/g;
	$str =~ s/\\t/\t/g;
	    $ret = ['LITERAL' , new W3C::Grammar::YaccCompileTree::LLITERAL($str, $lineno[0], $self)];
	} elsif ($$input =~ m/\G(\-)(?!\])/gc) {
	    my $char = $1;
	    $ret = ['RANGEOP' , new W3C::Grammar::YaccCompileTree::TOKEN($char, $lineno[0], $self)];
	} elsif ($$input =~ m/\G(\])/gc) {
	    my $char = $1;
	    $ret = [']' , new W3C::Grammar::YaccCompileTree::TOKEN($char, $lineno[0], $self)];
	} elsif ($$input =~ m/\G(.)/gc) {
	    my $char = $1;
	    $ret = ['LITERAL' , new W3C::Grammar::YaccCompileTree::LLITERAL($char, $lineno[0], $self)];
	} else {
	    $self->_Error(-errorMessage => "unexpected end of input in character class");
	}
	$CharClass++;
	return @$ret;
    }

    #In a LEX decl
    if ($LexMode) {
	$$input =~ m/\G\s*/gc;
	return _LexLexer($input, undef);
    }

    #In TAIL section
    if ($lexlevel > SEC_body) {
        my($pos)=pos($$input);

        $lineno[0]=$lineno[1];
        $lineno[1]=-1;
        pos($$input)=length($$input);
        return('TAILCODE', new W3C::Grammar::YaccCompileTree::TAILCODE(substr($$input, $pos), $lineno[0], $self));
    }

    # Handle COMMENTs and whitespace.
    if ($NoSemiNeeded && ($lexlevel == SEC_head || $lexlevel == SEC_body) && $$input=~m{
\G(\s+) (?= ((?:\[\d \s* [\d\w]*\]|/\*|\#(?![xX]?[0-9a-fA-F])))	# needs to include line feed in consumed \s+
        | (?: (?: [A-Za-z_][A-Za-z0-9_]* )
              | \< (?:[^\>]+) \>) \s*\:
        | (?: %% )
        | (?: \Z )
        | (?= \@ ) )}xsgc) {
        my ($blanks) = ($1);
        $lineno[1]+= $blanks=~tr/\n//;
	$lineno[0]=$lineno[1];
	return('EOProduction', 'EOProduction');
    } elsif ($$input=~m{\G((\s*)\#((?:[^x])[^\n]*))}xsgc) {
	my ($blanks, $leadWS, $text) = ($1, $2, $3);
        $lineno[1]+= $blanks=~tr/\n//;
	$lineno[0]=$lineno[1];
	return ('COMMENT', new W3C::Grammar::YaccCompileTree::PerlComment($leadWS, $text, $lineno[0], $self));
    } elsif ($$input=~m{\G((\s*)/\*(.*?)\*/)}xsgc) {
	my ($blanks, $leadWS, $text) = ($1, $2, $3);
        $lineno[1]+= $blanks=~tr/\n//;
	$lineno[0]=$lineno[1];
	return ('COMMENT', new W3C::Grammar::YaccCompileTree::CComment($leadWS, $text, $lineno[0], $self));
    } elsif ($lexlevel == SEC_head && $$input=~m{\G([\t\ ]+)}xsgc || 
	     ($lexlevel != SEC_head || $NoSemiNeeded) && $$input=~m{\G(\s+)}xsgc) {
        my ($blanks) = ($1);
        $lineno[1]+= $blanks=~tr/\n//;

        #Maybe now at EOF
    if (pos($$input) >= length($$input)) {
	if ($NoSemiNeeded) {
	    $NoSemiNeeded = 0;
	    return ('EOProduction', 'EOProduction')
	}
	if ($self->YYData->{Fake} eq 'tailTransition') {
	    $self->YYData->{Fake} = '';
	    ++$lexlevel;
	    return('%%', [ '%%', $lineno[0] ]);
	}

	return('',[ undef, -1 ]);
    }
    }

    $lineno[0]=$lineno[1];

    if ($$input=~/\G\@terminals/gc) {
	return('TERMINALS', new W3C::Grammar::YaccCompileTree::IDENT('', $lineno[0], $self));
    }

    if ($$input=~/\G\@pass/gc) {
	return('PASS', new W3C::Grammar::YaccCompileTree::IDENT($PassedTokensName, $lineno[0], $self));
    }

    if ($$input=~/\G([A-Za-z_][A-Za-z0-9_]*)/gc) {
	my $name = $1;
	my $ident = $self->YYData->{KnownIdents}{$name};
	if (!$ident) {
	    $ident = new W3C::Grammar::YaccCompileTree::IDENT($name, $lineno[0], $self);
	    $self->YYData->{KnownIdents}{$name} = $ident;
	}
	return('IDENT', $ident);
    }

    if ($$input=~/\G\'((?:[^\'\\]|\\\\|\\\'|\\)+?)\'/gc) {
	if ($1 eq "'error'") {
            _SyntaxError(0,"Literal 'error' ".
			 "will be treated as error token",$lineno[0]);
            return('IDENT', new W3C::Grammar::YaccCompileTree::IDENT('error', $lineno[0], $self));
        }
	my $str = $1;
	$str =~ s/\\\\/\\/g;
	$str =~ s/\\\"/\"/g; # @@@ forgiving mode
	$str =~ s/\\\'/\'/g;
	$str =~ s/\\r/\r/g; # @@@ forgiving mode
	$str =~ s/\\n/\n/g; # @@@ forgiving mode
	$str =~ s/\\t/\t/g; # @@@ forgiving mode
        return('LITERAL', new W3C::Grammar::YaccCompileTree::LLITERAL($str, $lineno[0], $self));
    }

    if ($$input=~/\G\#x([0-9A-Fa-f]+)/gc) {
	my $ch = chr(hex($1));
        return('LITERAL', new W3C::Grammar::YaccCompileTree::LLITERAL($ch, $lineno[0], $self));
    }

    if ($$input=~/\G\"((?:[^\\\"]|(?:\\.))*)\"/gc) {
	if ($1 eq "'error'") {
            _SyntaxError(0,"Literal 'error' ".
			 "will be treated as error token",$lineno[0]);
            return('IDENT', new W3C::Grammar::YaccCompileTree::IDENT('error', $lineno[0], $self));
        }
	my $str = $1;
	$str =~ s/\\\\/\\/g;
	$str =~ s/\\\"/\"/g;
	$str =~ s/\\\'/\'/g; # @@@ forgiving mode
	$str =~ s/\\r/\r/g;
	$str =~ s/\\n/\n/g;
	$str =~ s/\\t/\t/g;
        return('LITERAL', new W3C::Grammar::YaccCompileTree::LLITERAL($str, $lineno[0], $self));
    }

    if ($$input=~/\G\<([^\>]+)\>/gc) {
	my $value = $1;
	if ($value =~ m/\"/) {
	    my $pieces = [];
	    while ($value =~ /\G\"((?:[^\\\"]|(?:\\.))*)\"\s*/gc) {
		my $str = $1;
		$str =~ s/\\\\/\\/g;
		$str =~ s/\\\"/\"/g;
		$str =~ s/\\r/\r/g;
		$str =~ s/\\n/\n/g;
		$str =~ s/\\t/\t/g;
		push (@$pieces, $str);
	    }
	    my $all = join(' ', @$pieces);
	    return('LITERAL', new W3C::Grammar::YaccCompileTree::LLITERAL($all, $lineno[0], $self));
	} elsif ($value eq "'error'") {
            _SyntaxError(0,"Literal 'error' ".
			 "will be treated as error token",$lineno[0]);
            return('IDENT', new W3C::Grammar::YaccCompileTree::IDENT('error', $lineno[0], $self));
        } else {
	    return('TERMINAL', new W3C::Grammar::YaccCompileTree::Terminal($value, $lineno[0], $self));
	}
    }

    if ($$input=~/\G(%%)/gc) {
        ++$lexlevel;
        return($1, [ $1, $lineno[0] ]);
    }

    if ($$input=~/\G{/gc) {
        my($level,$from,$code);

        $from=pos($$input);

        $level=1;
        while($$input=~/([{}])/gc) {
	    if (substr($$input,pos($$input)-1,1) eq '\\') { #Quoted
		next;
	    }
	    if ($level += ($1 eq '{' ? 1 : -1)) {
	    } else {
		last;
	    }
        }
	if ($level) {
	    _SyntaxError(2,"Unmatched { opened line $lineno[0]",-1);
	}
        $code = substr($$input,$from,pos($$input)-$from-1);
        $lineno[1]+= $code=~tr/\n//;
        return('CODE', new W3C::Grammar::YaccCompileTree::CODE($code, $lineno[0], $self));
    }

    if ($lexlevel == SEC_head) { # In head section
	if ($$input=~/\G%(left|right|nonassoc)/gc) {
	    return('ASSOC', new W3C::Grammar::YaccCompileTree::ASSOC($1, $lineno[0], $self));
	}
	if ($$input=~/\G%(start)/gc) {
	    return('START', new W3C::Grammar::YaccCompileTree::START(undef, $lineno[0], $self));
	}
	if ($$input=~/\G%(expect)/gc) {
	    return('EXPECT', new W3C::Grammar::YaccCompileTree::EXPECT(undef, $lineno[0], $self));
	}
	if ($$input=~/\G%{/gc) {
	    my($code);

	    if ($$input !~ /\G(.*?)%\}/sgc) {
		_SyntaxError(2,"Unmatched %{ opened line $lineno[0]",-1);
	    }

	    $code=$1;
	    $lineno[1]+= $code=~tr/\n//;
	    return('HEADCODE', new W3C::Grammar::YaccCompileTree::HEADCODE($code, $lineno[0], $self));
	}
	if ($$input=~/\G%(token)/gc) {
	    return('TOKEN', new W3C::Grammar::YaccCompileTree::TOKEN(undef, $lineno[0], $self));
	}
	if ($$input=~/\G%(type)/gc) {
	    return('TYPE', new W3C::Grammar::YaccCompileTree::TYPE(undef, $lineno[0], $self));
	}
	if ($$input=~/\G%(union)/gc) {
	    return('UNION', new W3C::Grammar::YaccCompileTree::UNION(undef, $lineno[0], $self));
	}
	if ($$input=~/\G([0-9]+)/gc) {
	    return('NUMBER', new W3C::Grammar::YaccCompileTree::NUMBER($1, $lineno[0], $self));
	}
    } else {		# In rule section
	if ($$input=~/\G%(prec)/gc) {
	    return('PREC', new W3C::Grammar::YaccCompileTree::PREC(undef, $lineno[0], $self));
	}
	if ($$input=~/\G([0-9]+)/gc) { # added
	    return('NUMBER', new W3C::Grammar::YaccCompileTree::NUMBER($1, $lineno[0], $self));
	}
    }

    #Always return something
    if ($$input !~ /\G(.)/sg) {
	$self->_Error(-errorMessage => "matched no characters")
    }
    my $char = $1;

    if ($NoSemiNeeded && $char eq ';') {
	$NoSemiNeeded = 0;
	return('EOProduction', 'EOProduction');
    }

    if ($char eq "\n") {
	++$lineno[1];
    }

    return ( $char , new W3C::Grammar::YaccCompileTree::TokenBase($char, $lineno[0], $self));

}

sub _SyntaxError {
    my($level,$message,$lineno)=@_;

    $message= "*".
#              [ 'Warning', 'Error', 'Fatal' ]->[$level].
              "* $message, at ".
              ($lineno < 0 ? "eof" : "line $lineno").
              ".\n";

    if ($level > 1) {
	my $messagesStr = &getMessages();
	die "$messagesStr\n*Fatal* $message";
    }

    push (@$Messages, [$level, $message]);

    if ($level > 0) {
	++$nberr;
    }

    if ($nberr == 20) {
	my $messagesStr = &getMessages();
	die "$messagesStr\n*Fatal* Too many errors detected.";
    }
}
sub getLineNo {
    return $lineno[0];
}
sub getMessages {
    return join('', map {($_->[0] ? 'Error' : 'Warning').": $_->[1]"} @$Messages);
}
sub W3C::Grammar::YaccCompileTree::IDENT::_getProductionByName {
    my ($self) = @_;
    my $lhs = $self->getToken();
    return $NonTerminals->{$lhs};
}

sub _AddRules {
    my($self, $production) = @_;
    my $lhs = $production->getIdent()->getToken();
    my $lineno = $production->getIdent()->getLineNo();
    my $rhss = (); # $production->getRules();
    push(@$rules,[ $lhs, [ ], undef, undef ]);

    if (ref($NonTerminals->{$lhs})) {
	my $pref = $self->YYData->{Symbols}{$lhs};
        _SyntaxError(1,"Non-terminal $lhs redefined: ".
                       "Previously declared line $pref",$lineno);
        return;
    }

    if (ref($Terminals->{$lhs})) {
        my($where) = exists($Token->{$lhs}) ? $Token->{$lhs} : $self->YYData->{Symbols}{$lhs};
        _SyntaxError(1,"Non-terminal $lhs previously ".
		     "declared as token line $where",$lineno);
        return;
    }

    if (ref($NonTerminals->{$lhs})) {      #declared through %type
    } else {
	$self->YYData->{Symbols}{$lhs} = $lineno;   #Say it's declared here
	delete($Terminals->{$lhs});   #No more a terminal
    }
    $NonTerminals->{$lhs} = [];       #It's a non-terminal now

    my($epsrules)=0;        #To issue a warning if more than one epsilon rule

    for my $rhs1 (@$rhss) {
	my $rhs = $rhs1->getRhs();
	my $prec = $rhs1->getPrec();
	my $code = $rhs1->getCode();
        my($tmprule)=[ $lhs, [ ], $prec, $code ]; #Init rule

	if (!@$rhs) {
            ++$$nullable{$lhs};
            ++$epsrules;
        }

        for (my $i = 0; $i < @$rhs; $i++) {
	    my $ob = $rhs->[$i];
	    if (!$ob->isa('W3C::Grammar::YaccCompileTree::Text')) {
		if ($ob->isa('W3C::Grammar::YaccCompileTree::Code')) {
		    my($name)='@'.++$labelno."-$i";
		    push(@$rules,[ $name, [], undef, $ob ]);
		    push(@{$$tmprule[1]},$name);
		    next;
		}
		my $value = $ob->getValue();
		push(@{$$tmprule[1]},$$value[0]);
	    }
        }
        push(@$rules,$tmprule);
        push(@{$NonTerminals->{$lhs}},$#$rules);
    }

    if ($epsrules > 1) {
	_SyntaxError(0,"More than one empty rule for symbol $lhs",$lineno);
    }
    return $production;
}

sub Parse {
    my ($self, $inputParm, $debug) = @_;

    my($parsed)={};

    $input=\$inputParm;

    $lexlevel = SEC_head;
    @lineno=(1,1);
    $nberr=0;
    $prec=0;
    $labelno=0;

    $head=();
    $tail="";

    $self->YYData->{Symbols} = {};
    $self->YYData->{KnownIdents} = {};
    $Token={};
    $Terminals={};
    $NonTerminals={};
    $rules=[ undef ];   #reserve slot 0 for start rule
    $PrecedenceTerminals={};

    $start="";
    $nullable={};
    $expect=0;

    pos($$input)=0;

    $/ = undef;
    my $ret = $self->YYParse(yylex => \&_Lexer, yyerror => \&_Error, yydebug => $debug);

    if ($nberr) {
	_SyntaxError(2,"Errors detected: No output",-1);
    }

    @$parsed{ 'HEAD', 'TAIL', 'RULES', 'NTERM', 'TERM',
              'NULL', 'PREC', 'SYMS',  'START', 'EXPECT' }
    =       (  $head,  $tail,  $rules,  $NonTerminals,  $Terminals,
               $nullable, $PrecedenceTerminals, $self->YYData->{Symbols}, $start, $expect);
    my $messages = [@$Messages];
    $Messages = [];
    undef($input);
    undef($lexlevel);
    undef(@lineno);
    undef($nberr);
    undef($prec);
    undef($labelno);

    undef($head);
    undef($tail);

    #undef($self->YYData->{Symbols});
    undef($Token);
    undef($Terminals);
    undef($NonTerminals);
    undef($rules);
    undef($PrecedenceTerminals);

    undef($start);
    undef($nullable);
    undef($expect);

    return ($ret, $messages);
    $parsed;
}

package W3C::Grammar::YaccParser;
@W3C::Grammar::YaccParser::ISA = 'W3C::Grammar::_YaccParser';

sub new {
    my ($proto, $noIntegrityCheck, @yappParms) = @_;
    my $class = ref($proto) || $proto;
    my $self = $class->SUPER::new(@yappParms);
    $self->YYData->{NoIntegrityCheck} = $noIntegrityCheck;
    $self->YYData->{Fake} = '';
    return $self;
}

sub fake {
    my ($self, $fake) =@_;
    $self->YYData->{Fake} = $fake;
}

sub setFilename {
    my ($self, $filename) = @_;
    $self->{Filename} = $filename;
}

sub getFilename {
    my ($self) = @_;
    return $self->{Filename};
}


1;
