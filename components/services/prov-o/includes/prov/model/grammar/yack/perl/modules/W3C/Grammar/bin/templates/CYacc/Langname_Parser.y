/* $Id: Langname_Parser.y,v 1.2 2008-04-06 18:15:14 eric Exp ${Langname}Parser.yy 19 2007-08-19 20:36:24Z tb $ -*- mode: c++ -*- */
/** \file ${Langname}Parser.yy Contains the Bison parser source */

/*** yacc/bison Declarations ***/

/* Require bison 2.3 or later */
%require "2.3"

/* add debug output code to generated parser. disable this for release
 * versions. */
%debug

/* start symbol is named "start" */
%start ${Startname}

/* write out a header file containing the token defines */
%defines

/* set the parser's class identifier */
%define "parser_class_name" "${Langname}Parser"

%{ /*** C/C++ Declarations ***/

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include <malloc.h>
#include "${Langname}Enums.h"
#include "${Langname}Parser.h"

void yyerror(char *m);

int ${Langname}_lex(void);
void ${Langname}_error(char *);
typedef struct _Buf {
    char* data;
    int len;
} Buf;
Buf* makeBuf0 ();
Buf* makeBuf1 (char *str);
Buf* makeBuf (int count, ...);
void destroyBuf (Buf*);
char *str(Buf*);

Semval* StupidGlobal;
%}
%union {
    Semval* semval;
};

/* START TokenBlock */
/* Terminals */
${TerminalTokens}

/* Productions */
${ProductionTypes}
/* END TokenBlock */
%{
//#include "${Langname}Driver.hh"
//#include "${Langname}Scanner.hh"
//#undef yylex
#define yylex ${Langname}lex
%}
%% /*** Grammar Rules ***/

 /*** BEGIN ${Langname} - Change the grammar rules below ***/
${ProductionActions}

 /*** END ${Langname} - Change the grammar rules above ***/

%% /*** Additional Code ***/

Class_t Classes[] = {
    {"_INVISIBLE_", 0, 0}, 
    {"_TERMINAL_", 0, 0}, 
    /* Productions */
${ProductionClasses}
    /* Terminals */
${TerminalClasses}
};

const char const * toString (Semval* semval) {
    char* ret;
    const char const ** rets;
    size_t size = 0;
    size_t i;

    switch (Classes[semval->type].type) {
    case _GenProduction:
    case _Production:
	if (semval->size == 0)
	    size = 0;
	else
	    rets = malloc(sizeof(const char const *) * semval->size);
	for (i = 0; i < semval->size; i++) {
	    rets[i] = toString(semval->vals[i]);
	    size += 1+strlen(rets[i]);
	}
	ret = malloc(size + 1);
	ret[0] = 0;
	for (i = 0; i < semval->size; i++) {
	    strcat(ret, " ");
	    strcat(ret, rets[i]);
	}
	if (semval->size != 0)
	    free(rets);
	return ret;
    case _Constant:
    case _Terminal:
	ret = malloc(sizeof(char*)*semval->size + 1);
	strncpy(ret, semval->str, semval->size + 1);
	return ret;
    default:
	fprintf(stderr, "how do i toString a %d?\n", semval->type);
    }
}

#define tab 2
const char const * yit = "yacker:implicit-terminal";
#define lyit strlen(yit)
#define ns "\n xmlns=\"http://www.w3.org/2005/01/yacker/uploads/katherine/\"\n xmlns:yacker=\"http://www.w3.org/2005/01/yacker/\""
#define lns sizeof(ns)-1	/* strlen(ns) */

const char const * toXml (Semval* semval, unsigned depth) {
    char* ret;
    const char const ** rets;
    size_t size = 0;
    size_t i;

    unsigned leaderLen = depth*tab;
    char* leader = malloc(leaderLen+1);
    for (i = 0; i < leaderLen; i++) leader[i] = ' ';
    leader[leaderLen] = 0;

    switch (Classes[semval->type].type) {
    case _GenProduction:
    case _Production:
	/* Calculate size of namespaces and embedded elements. */
	if (semval->size == 0)
	    size = 0;
	else
	    rets = malloc(sizeof(const char const *) * semval->size);
	for (i = 0; i < semval->size; i++) {
	    rets[i] = toXml(semval->vals[i], Classes[semval->type].type == _Production ? depth+1 : depth);
	    size += strlen(rets[i]);
	}
	if (depth == 0)
	    size += lns;

	ret = malloc(leaderLen*2 + Classes[semval->type].size*2+8 + size);
	if (Classes[semval->type].type == _Production)
	    sprintf(ret, "%s<%s%s>\n", leader, Classes[semval->type].name, depth == 0 ? ns : "");
	else
	    ret[0] = 0;

	for (i = 0; i < semval->size; i++)
	    strcat(ret, rets[i]);

	if (semval->size != 0)
	    free(rets);
	if (Classes[semval->type].type == _Production)
	    sprintf(ret+leaderLen+1+Classes[semval->type].size+2+size, "%s</%s>\n", leader, Classes[semval->type].name);
	break;
    case _Constant:
	ret = malloc(leaderLen+lyit*2+6 + semval->size);
	sprintf(ret, "%s<%s>%s</%s>\n", leader, yit, semval->str, yit);
	break;
    case _Terminal:
	ret = malloc(leaderLen+Classes[semval->type].size*2+6 + semval->size);
	sprintf(ret, "%s<%s>%s</%s>\n", leader, Classes[semval->type].name, semval->str, Classes[semval->type].name);
	break;
    default:
	fprintf(stderr, "how do i toXml a %d?\n", semval->type);
    }
    return ret;
}

FILE* _Trace = NULL;

Semval* constructProduction (const Classes_e type, size_t argc, ...) {
    Semval* ret = malloc(sizeof(Semval));
    va_list semvals;
    size_t argNo, valsNo;
    Semval* semval;
    const char const * str;

    ret->type = type;
    ret->size = argc;

    /* Appropriate type? */
    if (Classes[type].type != _Production && 
	Classes[type].type != _GenProduction) {
	fprintf(stderr, "constructProduction(%d, %d, ...). Classes[type] (%d) != _Production (%d)", type, argc, Classes[type], _Production);
    }

    /* Trace */
    if (_Trace)
	fprintf(_Trace, "  %s:", Classes[type].name);
    va_start(semvals, argc);
    for (argNo = 0; argNo < argc; argNo++) {
	semval = va_arg(semvals, Semval*);

	/* By default, each argument represents a series of parameter. */
	int semvalSize = 1;

	/* Productions created for *, +, ? or ()s are represented
	 * as a series of n parameters. */
	if (Classes[semval->type].type == _GenProduction) {
	    semvalSize = semval->size; /* copying elements from an array */

	    /* Absorb the nested created production when the production
	     * is an expansion for a *, + or ?, e.g.
	     foo_Star: foo_Star foo */
	    if (semval->type == type) {
		ret->size -= 1;
		ret->size += semvalSize;
	    }
	}
	if (_Trace)
	    fprintf(_Trace, " %s(%d)", Classes[semval->type].name, semvalSize);
    }
    va_end(semvals);
    if (_Trace)
	fprintf(_Trace, "\n");

    if (argc) {
	ret->vals = malloc(sizeof(Semval*) * ret->size);
	va_start(semvals, argc);
	for (argNo = valsNo = 0; argNo < argc; argNo++) {
	    semval = va_arg(semvals, Semval*);
	    if (Classes[semval->type].type == _GenProduction) {
		short absorbSemval = semval->type == type;
		size_t j;
		for (j = 0; j < semval->size; j++) {
		    Semval* nestedSemval = semval->vals[j];
		    if (absorbSemval)
			/* If absorbing the argument, take each of its
			 * constructor args. */
			ret->vals[valsNo++] = nestedSemval;

		    if (_Trace && semval->size > 0) {
			/* Regardless of absorption, display each
			 * generated argument separately. */
			str = toString(nestedSemval);
			fprintf(_Trace, "    %s(%d): %s\n", 
				Classes[semval->type].name, j, str);
			free ((char*)str);
		    }
		}
		if (absorbSemval) {
		    /* If we absorbed the nested production, free it. */
		    if (semval->size)
			free (semval->vals);
		    free (semval);
		} else {
		    /* If not absorbing the argument, add it to the
		     * constructor args. */
		    ret->vals[valsNo++] = semval;
		}
	    } else {
		ret->vals[valsNo++] = semval;
		if (_Trace && semval->size > 0) {
		    str = toString(semval);
		    fprintf(_Trace, "    %s(%d): %s\n", Classes[semval->type].name, 0, str);
		    free ((char*)str);
		}
	    }
	}
	va_end(semvals);
    }
    free ((char*)toString(ret));
    free ((char*)toXml(ret, 0));
    return ret;
}

Semval* constructTerminal (const Classes_e type, const char const * str) {
    Semval* ret = malloc(sizeof(Semval));
    if (_Trace)
	fprintf(_Trace, "shift (%s, %s)\n", Classes[type].name, str);
    ret->type = type;
    ret->size = strlen(str);
    ret->str = malloc(ret->size+1);
    strncpy((char*)ret->str, str, ret->size+1);
    free ((char*)toString(ret));
    free ((char*)toXml(ret, 0));
    return ret;
}

void yyerror (char *m) /* ${Langname}_ */
{
  fprintf(stderr,"error %s at \"%s\"\n", m, getContextString(m));
}

#include <stdlib.h>
extern FILE *${Langname}in, *${Langname}out;
int main(int argc, char* argv[]) {
    char* tmp;
    if (tmp = getenv("TRACE_FD")) {
	int fd;
	sscanf(tmp, "%d", &fd);
	if (!(_Trace = fdopen(fd, "a")))
	    fprintf(stderr, "couldn't open trace fd %d\n", fd);
    }

    const char* inputId;
    if (argc > 1) {
	inputId = argv[1];
	${Langname}in = fopen(argv[1], "r");
    } else {
	inputId = "<stdin>";
	${Langname}in = stdin;
    }

    ${Langname}set_debug(0); /* prevent lex from printing tokens */
    int result = yyparse(); /* @@ ${Langname}_ */

    if (result)
	fprintf(stderr, "Error: %s did not contain a valid ${Langname} string.\n", inputId);
    else
	fprintf(stdout, "%s", toXml(StupidGlobal, 0));

    if (_Trace)
	close(_Trace);

    return result;
}
