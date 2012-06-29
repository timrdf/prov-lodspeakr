/* $Id: Langname_Scanner.ll,v 1.1 2008-04-06 17:10:46 eric Exp ${Langname}Scanner.ll 28 2007-08-20 10:27:39Z tb $ -*- mode: c++ -*- */
/** \file ${Langname}Scanner.ll Define the Flex lexical scanner */

%{ /*** C/C++ Declarations ***/

#include "${Langname}Parser.hh"
#include "${Langname}Scanner.hh"

/* import the parser's token type into a local typedef */
typedef ${Langname}NS::${Langname}Parser::token token;
typedef ${Langname}NS::${Langname}Parser::token_type token_type;

/* Work around an incompatibility in flex (at least versions 2.5.31 through
 * 2.5.33): it generates code that does not conform to C89.  See Debian bug
 * 333231 <http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=333231>.  */
#undef yywrap
#define yywrap()	1

/* By default yylex returns int, we use token_type. Unfortunately yyterminate
 * by default returns 0, which is not of token_type. */
#define yyterminate() return token::__EOF__

/* This disables inclusion of unistd.h, which is not available under Visual C++
 * on Win32. The C++ scanner uses STL streams instead. */
#define YY_NO_UNISTD_H

%}

/*** Flex Declarations and Options ***/

/* enable c++ scanner class generation */
%option c++

/* change the name of the scanner class. results in "${Langname}FlexLexer" */
%option prefix="${Langname}"

/* the manual says "somewhat more optimized" */
%option batch

/* enable scanner to generate debug output. disable this for release
 * versions. */
%option debug

/* no support for include files is planned */
%option noyywrap nounput 

/* enables the use of start condition stacks */
%option stack

/* The following paragraph suffices to track locations accurately. Each time
 * yylex is invoked, the begin position is moved onto the end position. */
%{
#define YY_USER_ACTION  yylloc->columns(yyleng);
%}

/* START patterns for ${Langname} terminals */
${TerminalPatterns}
/* END patterns for ${Langname} terminals */

/* START semantic actions for ${Langname} terminals */
%%
{PASSED_TOKENS}		{ /* yylloc->step(); @@ needed? useful? */ }
${TerminalActions}
<<EOF>>			{ yyterminate();}
%%
/* END semantic actions for ${Langname} terminals */

/* START ${Langname}Scanner */
namespace ${Langname}NS {

${Langname}Scanner::${Langname}Scanner(std::istream* in,
		 std::ostream* out)
    : ${Langname}FlexLexer(in, out)
{
}

${Langname}Scanner::~${Langname}Scanner()
{
}

void ${Langname}Scanner::set_debug(bool b)
{
    yy_flex_debug = b;
}

}
/* END ${Langname}Scanner */

/* This implementation of ${Langname}FlexLexer::yylex() is required to fill the
 * vtable of the class ${Langname}FlexLexer. We define the scanner's main yylex
 * function via YY_DECL to reside in the ${Langname}Scanner class instead. */

#ifdef yylex
#undef yylex
#endif

int ${Langname}FlexLexer::yylex()
{
    std::cerr << "in ${Langname}FlexLexer::yylex() !" << std::endl;
    return 0;
}

