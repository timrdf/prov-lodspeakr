/* $Id: Langname_Scanner.l,v 1.1 2008-04-06 17:10:48 eric Exp ${Langname}Scanner.ll 28 2007-08-20 10:27:39Z tb $ -*- mode: c++ -*- */
/** \file ${Langname}Scanner.ll Define the Flex lexical scanner */

%{ /*** C/C++ Declarations ***/

#include "${Langname}Enums.h"
#include "${Langname}Parser.h"

%}

/*** Flex Declarations and Options ***/

/* change the name of the scanner class. results in "${Langname}FlexLexer" */
%option prefix="${Langname}"

/* the manual says "somewhat more optimized" */
%option batch

/* enable scanner to generate debug output. disable this for release
 * versions. */
%option debug

/* no support for include files is planned */
%option noyywrap nounput 

/* START patterns for ${Langname} terminals */
${TerminalPatterns}
/* END patterns for ${Langname} terminals */

/* START semantic actions for ${Langname} terminals */
%%
{PASSED_TOKENS}
${TerminalActions}
<<EOF>>			{ yyterminate();}
%%
char* getContextString(char* m)
{
  #define _SIZE 80
  char* ptr = (yy_buffer_stack)[(yy_buffer_stack_top)]->yy_ch_buf + strlen((yy_buffer_stack)[(yy_buffer_stack_top)]->yy_ch_buf);
  int len;
  for (len = 0; ptr > (yy_buffer_stack)[(yy_buffer_stack_top)]->yy_ch_buf && *(ptr-1) != '\n' && len < _SIZE-1; --ptr, ++len);
  return ptr;
}

