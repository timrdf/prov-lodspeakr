
.SUFFIXES : .cc .y .l $(SUFFIXES)

.c.o :
	gcc -g  -I . -I$(CENTERCCLIBDIR)/incl -c  $*.c

.y.c :
	bison -d -o $*.c $*.y
.l.c :
	flex  -o$*.c -P${Langname}_ $*.l
.y.h :
	bison -d -o $*.c $*.y
.l.h :
	flex  -o$*.c -P${Langname}_ $*.l

${Langname}Parser.o : ${Langname}Parser.c ${Langname}Parser.h

${Langname}Scanner.o : ${Langname}Scanner.c ${Langname}Parser.h

${Langname}Parser.c : ${Langname}Parser.y

${Langname}Scanner.c : ${Langname}Scanner.l

${Langname}Parser.h : ${Langname}Parser.y

${Langname} : ${Langname}Parser.o ${Langname}Scanner.o
	gcc -Wno-deprecated -g -o $@ ${Langname}Parser.o ${Langname}Scanner.o

