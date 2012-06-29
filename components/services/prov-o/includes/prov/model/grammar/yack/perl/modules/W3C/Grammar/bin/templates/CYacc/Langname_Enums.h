typedef enum {
    _Production = 0, 
    _GenProduction, 
    _Constant, 
    _Terminal
} Class_e;

typedef struct {
    const char const * name;
    size_t size;
    const Class_e type;
} Class_t;

/* START ClassBlock */
typedef enum {
  _INVISIBLE_, 
  _TERMINAL_, 
  /* Productions */
${ProductionClassDecls}
  /* Terminals */
${TerminalClassDecls}
  } Classes_e;
extern Class_t Classes[];
/* END ClassBlock */
typedef struct semval_s Semval;
struct semval_s {
    Classes_e type;
    size_t size;
    union {
	Semval** vals;
	const char const * str;
    };
};
Semval* constructProduction(const Classes_e type, size_t size, ...);
Semval* constructTerminal(const Classes_e type, const char const * str);
