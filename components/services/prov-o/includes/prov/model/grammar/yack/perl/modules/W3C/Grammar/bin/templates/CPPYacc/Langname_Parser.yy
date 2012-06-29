/* $Id: Langname_Parser.yy,v 1.8 2008-04-21 01:46:20 eric Exp ${Langname}Parser.yy 19 2007-08-19 20:36:24Z tb $ -*- mode: c++ -*- */
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

/* use newer C++ skeleton file */
%skeleton "lalr1.cc"

/* namespace to enclose parser in */
%name-prefix="${Langname}NS"

/* set the parser's class identifier */
%define "parser_class_name" "${Langname}Parser"

/* keep track of the current position within the input */
%locations
%initial-action
{
    // initialize the initial location object
    @$.begin.filename = @$.end.filename = &driver.streamname;
};

/* The driver is passed by reference to the parser and to the scanner. This
 * provides a simple but effective pure interface, not relying on global
 * variables. */
%parse-param { class Driver& driver }

/* verbose error messages */
%error-verbose

%{ /*** C/C++ Declarations ***/

extern std::ostream* _Trace;

#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <exception>
#include <cassert>

/* START ClassBlock */
namespace yacker {
class _Base {
private:
    const char* productionName;
public:
    _Base (const char* productionName) : productionName(productionName) { }
    const char* getProductionName() { return productionName; };
    virtual std::string toStr(std::ofstream* out = NULL) = 0;
    virtual std::string toXml(size_t depth, std::ofstream* out = NULL) = 0;
    virtual size_t size () { return 1; }
    virtual _Base* getElement (size_t) { return this; }
    virtual ~_Base() { }
};
class _Production : public _Base {
protected:
    _Production (const char* productionName) : _Base(productionName) { }
    void makeArray(_Base** target[], ...);
    void trace(unsigned creditToSelf = 0);
public:
    virtual bool transparent() { return false; } // in general, productions are not transparent.
    virtual _Base* operator [] (size_t i) = 0;
    virtual _Base* getElement (size_t i) = 0;
    virtual std::string toStr(std::ofstream* out = NULL);
    virtual std::string toXml(size_t depth, std::ofstream* out = NULL);
};

class _GenProduction : public _Production {
protected:
    _GenProduction (const char* productionName) : _Production(productionName) { }
    ~_GenProduction () {}
};

extern bool TransparentGroupProductions;
extern bool TransparentMultiplicityProductions;
template <typename T> class _ProductionVector : public _GenProduction {
    std::vector<T> data;
public:
    _ProductionVector (const char* productionName) : _GenProduction(productionName) {
	trace();
    }
    _ProductionVector (const char* productionName, T v) : _GenProduction(productionName) {
	data.push_back(v);
	trace(size()-1);
    }
    ~_ProductionVector () {
	for (size_t i = 0; i < size(); i++)
	    delete data[i];
    }
    virtual bool transparent() { return TransparentMultiplicityProductions; }

    void push_back(T v) {
	data.push_back(v);
	trace(size()-1);
    }
    size_t size() { return data.size(); }
    virtual T operator [] (size_t i) { return data[i]; }
    _Base* getElement (size_t i) { return data[i]; }
};
class _GroupProduction : public _GenProduction {
protected:
    _GroupProduction (const char* productionName) : _GenProduction (productionName) { }
    virtual bool transparent() { return TransparentGroupProductions; }
};
class _Token : public _Base {
private:
    const char* matched;

protected:
    _Token (const char* productionName, const char* matched) : _Base(productionName), matched(copyOf(matched)) { }
public:
    ~_Token () { delete[] matched; }

protected:
    void trace();

private:
    static char* copyOf (const char* copyMe) {
	char* ret = new char[strlen(copyMe)+1];
	strcpy(ret, copyMe);
	return ret;
    }
public:
    virtual std::string toStr(std::ofstream* out = NULL);
    virtual std::string toXml(size_t depth, std::ofstream* out = NULL);
};
class _Terminal : public _Base {
protected:
    const char* terminal;
    _Terminal (const char* productionName, const char* p) : _Base(productionName) {
	terminal = new char[strlen(p) + 1];
	strcpy((char*)terminal, p); // @@ should initialize as member
    }
    ~_Terminal () {
	delete[] terminal;
    }
    void trace();
public:
    virtual std::string toStr(std::ofstream* out = NULL);
    virtual std::string toXml(size_t depth, std::ofstream* out = NULL);
};

} // namespace yacker

namespace ${Langname}NS {
${ProductionClassDecls}
${TerminalClassDecls}

${ProductionClasses}
${TerminalClasses}
}
class ProgramFlowException : public std::exception  {
private:
    const char* msg;
public:
    ProgramFlowException(const char* msg) : msg(msg) { }

    // This declaration is not useless:
    // http://gcc.gnu.org/onlinedocs/gcc-3.0.2/gcc_6.html#SEC118
    virtual ~ProgramFlowException() throw() { }

    // See comment in eh_exception.cc.
    virtual const char* what () { return msg; }
};
/* END ClassBlock */

namespace ${Langname}NS {

/** The Driver class brings together all components. It creates an instance of
 * the ${Langname}Parser and ${Langname}Scanner classes and connects them. Then the input stream is
 * fed into the scanner object and the parser gets it's token
 * sequence. Furthermore the driver object is available in the grammar rules as
 * a parameter. Therefore the driver class contains a reference to the
 * structure into which the parsed data is saved. */
class ${Langname}Context {
public:
    ~${Langname}Context()
    {
    }
};

class Driver
{
public:
    /// construct a new parser driver context
    Driver(${Langname}Context& context);

    /// enable debug output in the flex scanner
    bool trace_scanning;

    /// enable debug output in the bison parser
    bool trace_parsing;

    /// stream name (file or input stream) used for error messages.
    std::string streamname;

    /** Invoke the scanner and parser for a stream.
     * @param in	input stream
     * @param sname	stream name for error messages
     * @return		true if successfully parsed
     */
    bool parse_stream(std::istream& in,
		      const std::string& sname = "stream input");

    /** Invoke the scanner and parser on an input string.
     * @param input	input string
     * @param sname	stream name for error messages
     * @return		true if successfully parsed
     */
    bool parse_string(const std::string& input,
		      const std::string& sname = "string stream");

    /** Invoke the scanner and parser on a file. Use parse_stream with a
     * std::ifstream if detection of file reading errors is required.
     * @param filename	input file name
     * @return		true if successfully parsed
     */
    bool parse_file(const std::string& filename);

    // To demonstrate pure handling of parse errors, instead of
    // simply dumping them on the standard error output, we will pass
    // them to the driver using the following two member functions.

    /** Error handling with associated line number. This can be modified to
     * output the error e.g. to a dialog box. */
    void error(const class location& l, const std::string& m);

    /** General error handling. This can be modified to output the error
     * e.g. to a dialog box. */
    void error(const std::string& m);

    /** Pointer to the current lexer instance, this is used to connect the
     * parser to the scanner. It is used in the yylex macro. */
    class ${Langname}Scanner* lexer;

    /** Reference to the context filled during parsing of the expressions. */
    ${Langname}Context& context;
    ${Goalname}* root;
};

} // namespace ${Langname}NS

%}

 /*** BEGIN ${Langname} - Change the grammar's tokens below ***/

%union {
    /* Terminals */
${TerminalDeclarations}
    /* Productions */
${ProductionDeclarations}
}

%{
#include "${Langname}Scanner.hh"
%}
%token			__EOF__	     0	"end of file"
/* START TokenBlock */
/* Terminals */
${TerminalTokens}
/* Productions */
${ProductionTypes}
/* END TokenBlock */

//%destructor { delete $$; } BlankNode

 /*** END ${Langname} - Change the grammar's tokens above ***/

%{
#include <stdarg.h>
#include "${Langname}Scanner.hh"

/* this "connects" the bison parser in the driver to the flex scanner class
 * object. it defines the yylex() function call to pull the next token from the
 * current lexer object of the driver context. */
#undef yylex
#define yylex driver.lexer->lex
%}

%% /*** Grammar Rules ***/

 /*** BEGIN ${Langname} - Change the grammar rules below ***/
${ProductionActions}

 /*** END ${Langname} - Change the grammar rules above ***/

%% /*** Additional Code ***/

void ${Langname}NS::${Langname}Parser::error(const ${Langname}Parser::location_type& l,
			    const std::string& m)
{
    driver.error(l, m);
}

/* START yacker-specific test harness */

namespace yacker {
std::ostream* _Trace = NULL;

std::string _Production::toStr(std::ofstream* out) {
    std::stringstream ret;
    for (size_t i = 0; i < size(); i++) {
	if (i > 0)
	    ret << " ";
	ret << getElement(i)->toStr(out);
    }
    return ret.str();
}

#define TAB "  "
char const * yit = "yacker:implicit-terminal";
#define ns "\n xmlns=\"http://www.w3.org/2005/01/yacker/uploads/${Langname}/\"\n xmlns:yacker=\"http://www.w3.org/2005/01/yacker/\""

std::string _Production::toXml (size_t depth, std::ofstream* out) {
    std::stringstream ret;
    if (!transparent()) {
	for (size_t i = 0; i < depth; i++)
	    ret << TAB;
	ret << "<" << getProductionName() << ">" << std::endl;
    }
    for (size_t i = 0; i < size(); i++) {
	_Base* base = getElement(i);
	if (base != NULL)
	    ret << base->toXml(transparent() ? depth : depth+1, out);
    }
    if (!transparent()) {
	for (size_t i = 0; i < depth; i++)
	    ret << TAB;
	ret << "</" << getProductionName() << ">" << std::endl;
    }
    return ret.str();
}

void _Production::makeArray (_Base** target[], ...) {
    va_list bases;
    va_start(bases, target);
    for (size_t argNo = 0; argNo < size(); argNo++)
	target[argNo] = va_arg(bases, _Base**);
    va_end(bases);    
}
void _Production::trace (unsigned creditToSelf) {
    if (!_Trace)
	return;
    *_Trace << "  " << getProductionName() << ":";
    if (creditToSelf > 0)
	*_Trace << " " << getProductionName() << "(" << creditToSelf << ")";

    for (size_t argNo = creditToSelf; argNo < size(); argNo++) {
	_Base* parm = getElement(argNo);
	*_Trace << " " << parm->getProductionName() << "(" << parm->size() << ")";
    }
    *_Trace << std::endl;

    for (size_t argNo = 0; argNo < size(); argNo++) {
	_Base* parm = getElement(argNo);
	size_t parmSize = parm->size();
	for (size_t j = 0; j < parmSize; j++)
	    *_Trace << "    " << (creditToSelf && argNo < size()-1 ? getProductionName() : parm->getProductionName()) << "(" << (creditToSelf && argNo < size()-1 ? argNo : j) << "): " << parm->getElement(j)->toStr() << std::endl;
    }
}

void _Token::trace() {
    if (!_Trace)
	return;
    *_Trace << "shift (" << getProductionName() << ", " << matched << ")" << std::endl;
}

void _Terminal::trace() {
    if (!_Trace)
	return;
    *_Trace << "shift (" << getProductionName() << ", " << terminal << ")" << std::endl;
}

std::string _Token::toStr(std::ofstream*) {
    std::string ret(matched);
    return ret;
}
std::string _Token::toXml(size_t depth, std::ofstream*) {
    std::stringstream ret;
    for (size_t i = 0; i < depth; i++)
	ret << TAB;
    ret << "<" << yit << ">" << matched << "</" << yit << ">" << std::endl;
    return ret.str();
}

std::string _Terminal::toStr(std::ofstream*) {
    std::string ret(terminal);
    return ret;
}
std::string _Terminal::toXml(size_t depth, std::ofstream*) {
    std::stringstream ret;
    for (size_t i = 0; i < depth; i++)
	ret << TAB;
    ret << "<" << getProductionName() << ">" << terminal << "</" << getProductionName() << ">" << std::endl;
    return ret.str();
}

} // namespace yacker

/* END yacker-specific test harness */

/* START Driver (@@ stand-alone would allow it to be shared with other parsers */

namespace ${Langname}NS {

Driver::Driver(class ${Langname}Context& _context)
    : trace_scanning(false),
      trace_parsing(false),
      context(_context)
{
}

bool Driver::parse_stream(std::istream& in, const std::string& sname)
{
    streamname = sname;

    ${Langname}Scanner scanner(&in);
    scanner.set_debug(trace_scanning);
    this->lexer = &scanner;

    ${Langname}Parser parser(*this);
    parser.set_debug_level(trace_parsing);
    return (parser.parse());
}

bool Driver::parse_file(const std::string &filename)
{
    std::ifstream in(filename.c_str());
    return parse_stream(in, filename);
}

bool Driver::parse_string(const std::string &input, const std::string& sname)
{
    std::istringstream iss(input);
    return parse_stream(iss, sname);
}

void Driver::error(const class location& l,
		   const std::string& m)
{
    std::cerr << l << ": " << m << std::endl;
}

void Driver::error(const std::string& m)
{
    std::cerr << m << std::endl;
}

${ProductionDestructors}
} // namespace ${Langname}NS

/* END Driver */

/* START main */

#include <stdio.h>
// #include "${Langname}Frob.h"

#include <stdlib.h>
#include <ostream>
#include <fstream>

#ifdef HAVE_BOOST
#include <boost/iostreams/stream.hpp>
#include <boost/iostreams/device/file_descriptor.hpp>
#endif /* HAVE_BOOST */

bool yacker::TransparentGroupProductions = false;
bool yacker::TransparentMultiplicityProductions = false;

int main(int argc,char** argv) {

    ${Langname}NS::${Langname}Context context;
    ${Langname}NS::Driver driver(context);

#ifdef HAVE_BOOST
    boost::iostreams::stream_buffer<boost::iostreams::file_descriptor_sink>* buf = NULL;
    if (char* tmp = getenv("TRACE_FD")) {
	std::istringstream is(tmp);
	int fd;
	is >> fd;
	buf = new boost::iostreams::stream_buffer<boost::iostreams::file_descriptor_sink>(fd);
	if (!(yacker::_Trace = new std::ostream(buf)))
	    std::cerr << "couldn't open trace fd " << fd << std::endl;
    }
#endif /* HAVE_BOOST */

    std::istream* yyin;
    const char* inputId;
    if (argc > 1) {
	inputId = argv[1];
	yyin = new std::ifstream(argv[1], std::ifstream::in);
    } else {
	inputId = "<stdin>";
	yyin = &std::cin;
    }

    std::string str(inputId);
    int result = driver.parse_stream(*yyin, str);

    if (argc > 1)
	delete yyin;

    if (result)
	std::cerr << "Error: " << inputId << " did not contain a valid SPARQLfed string." << std::endl;
    else {
	try {
	    std::string xml = driver.root->toXml(0);
	    std::cout << xml;
	    delete driver.root;
	} catch (ProgramFlowException& e) {
	    std::cout << "Standard exception: " << e.what() << std::endl;
	} catch (std::exception& e) {
	    std::cout << "Standard exception: " << e.what() << std::endl;
	}
    }

#ifdef HAVE_BOOST
    delete buf; // this delete breaks cout!
#endif /* HAVE_BOOST */

    if (yacker::_Trace)
	delete yacker::_Trace;

    return result;
};

/* END main */

