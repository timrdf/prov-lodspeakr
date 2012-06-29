# $Id: Makefile,v 1.4 2008-04-12 04:10:11 eric Exp $

# recipies:
#   normal build:
#     make ${Langname}
#   force the use of the tracing facilities (and redirect to stdout):
#     HAVE_BOOST=1 TRACE_FD=1 make -W ${Langname}Parser.yy test
#   have valgrind start a debugger (works as M-x gdb invocation command):
#     valgrind --db-attach=yes --leak-check=yes ${Langname} ${Langname}.txt
#   same, if you aren't working in gdb:
#     HAVE_BOOST=1 TRACE_FD=1 make valgrind
#   debugging in emacs:
#     gdb --annotate=3 ${Langname}    (set args ${Langname}.txt)

ifdef HAVE_BOOST
LIBS=-lboost_iostreams
DEFS=-DHAVE_BOOST
else
LIBS=
DEFS=
endif

GPP=g++ -DYYTEXT_POINTER=1 $(DEFS) -W -Wall -Wextra -ansi -g -c
LINK=g++ -W -Wall -Wextra -ansi -g $(LIBS) -o

${Langname}Parser.cc ${Langname}Parser.hh location.hh position.hh stack.hh: ${Langname}Parser.yy
	bison -o ${Langname}Parser.cc ${Langname}Parser.yy

#/bin/sh ../scripts/ylwrap parser.yy y.tab.c parser.cc y.tab.h parser.h y.output parser.output -- bison -y  

${Langname}Scanner.cc: ${Langname}Scanner.ll ${Langname}Parser.hh
	flex -o ${Langname}Scanner.cc ${Langname}Scanner.ll

#/bin/sh ../scripts/ylwrap scanner.ll lex.yy.c scanner.cc -- flex  -olex.yy.c

${Langname}Parser.o: ${Langname}Parser.cc ${Langname}Parser.hh ${Langname}Scanner.hh
	$(GPP)  -o ${Langname}Parser.o ${Langname}Parser.cc

${Langname}Scanner.o: ${Langname}Scanner.cc ${Langname}Scanner.hh
	$(GPP)  -o ${Langname}Scanner.o ${Langname}Scanner.cc

#lib${Langname}.a: ${Langname}Parser.o ${Langname}Scanner.o
#	ar cru lib${Langname}.a ${Langname}Parser.o ${Langname}Scanner.o
#	ranlib lib${Langname}.a

#${Langname}Test.o: ${Langname}Test.cc
#	$(GPP)  -o ${Langname}Test.o ${Langname}Test.cc

#${Langname}Test: ${Langname}Test.o lib${Langname}.a
#	$(LINK) ${Langname}Test ${Langname}Test.o lib${Langname}.a

${Langname}: ${Langname}Parser.o ${Langname}Scanner.o
	$(LINK) ${Langname} ${Langname}Parser.o ${Langname}Scanner.o

test: ${Langname}
	./${Langname} ${Langname}.txt 

valgrind: ${Langname}
	valgrind --leak-check=yes ./${Langname} ${Langname}.txt 

clean:
	rm -f ${Langname} lib${Langname}.a ${Langname}Parser.o ${Langname}Scanner.o ${Langname}Parser.cc ${Langname}Parser.hh ${Langname}Scanner.cc location.hh position.hh stack.hh

