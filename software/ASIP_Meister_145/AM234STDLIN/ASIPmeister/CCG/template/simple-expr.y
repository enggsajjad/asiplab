
%{

/*
 * Copyright (c) 2007 NEC Corpoartion.
 * All rights reserved.
 * Use and distribution of this program without permission are not allowed.
 *
 * This is part of CCG (C compiler generator).
 * 
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

/*#define UNIT_TEST*/

typedef  int64_t (*get_symbol_value_func_t) (const char *str);

static int64_t simple_expr_result = 0;
static get_symbol_value_func_t get_symbol_value_func = 0;

/* simple-expr.l */
void libccg_string_buff_clear (void);
void libccg_string_buff_append (const char *str);
int yylex (void);
/* simple-expr.y */
static int64_t  get_symbol_value (const char *str);
int libccg_simple_expr_parse (const char *str, int64_t *value, get_symbol_value_func_t func);
int yyerror (char *s);

%}

%union
{
  char     *str;
  int64_t  value;
}

/* BISON Declarations */
%token <value> NUMBER_T
%token <value> OP_ADD_T
%token <value> OP_SUB_T
%token <value> OP_MUL_T
%token <value> OP_DIV_T
%token <value> OP_MOD_T
%token <value> LEFT_PAR_T
%token <value> RIGHT_PAR_T
%token <value> OP_LSHIFT_T
%token <value> OP_RSHIFT_T
%token <value> OP_AND_T
%token <value> OP_OR_T
%token <value> OP_XOR_T
%token <value> OP_NOT_T
%token <value> OP_END_T
%token <str>   SYMBOL_T

%type  <value> root
%type  <value> expression

%left OP_OR_T   OP_XOR_T
%left OP_AND_T
%left OP_LSHIFT_T  OP_RSHIFT_T
%left OP_SUB_T  OP_ADD_T
%left OP_MUL_T  OP_DIV_T  OP_MOD_T

%left UNARY_PLUS  /* plus    --unary plus */
%left UNARY_NEG   /* negation--unary minus */
%left UNARY_NOT   /* not     --unary not */


/* Grammar */
%%
root
    : expression  { simple_expr_result = $1;  return 0; }
    | error       { simple_expr_result = 0;   return 1; }
    ;

expression
    : NUMBER_T                             { $$ = $1;       }
    | SYMBOL_T                             { $$ = get_symbol_value ($1); }
    | expression OP_ADD_T expression       { $$ = $1 + $3;  }
    | expression OP_SUB_T expression       { $$ = $1 - $3;  }
    | expression OP_MUL_T expression       { $$ = $1 * $3;  }
    | expression OP_DIV_T expression       { $$ = $1 / $3;  }
    | expression OP_MOD_T expression       { $$ = $1 % $3;  }
    | expression OP_LSHIFT_T expression    { $$ = $1 << $3; }
    | expression OP_RSHIFT_T expression    { $$ = $1 >> $3; }
    | expression OP_AND_T expression       { $$ = $1 & $3;  }
    | expression OP_OR_T expression        { $$ = $1 | $3;  }
    | expression OP_XOR_T expression       { $$ = $1 ^ $3;  }
    | OP_ADD_T expression %prec UNARY_PLUS { $$ = $2;      }
    | OP_SUB_T expression %prec UNARY_NEG  { $$ = -$2;      }
    | OP_NOT_T expression %prec UNARY_NOT  { $$ = ~$2;      }
    | LEFT_PAR_T expression RIGHT_PAR_T    { $$ = $2;       }
    ;

%%

#ifndef UNIT_TEST
int
yyerror (char *s)
{
  return (int)s;
}
#else  /*UNIT_TEST*/
int
yyerror (char *s)
{
  printf ("%s\n",s);
  return 1;
}
#endif /*UNIT_TEST*/


/* Return the value of the given format token symbol.
 * If the symbol is not defined or thre is no way to resolve the
 * symbol, we return 0 as its default value. */
static int64_t
get_symbol_value (const char *str)
{
  if (get_symbol_value_func)
    return get_symbol_value_func (str);
  else
    return 0;
}

/* Parse the string STR and store it into VALUE.  This function
 * returns 0 if parsing the string successfully. Otherwise return
 * 1. */
int
libccg_simple_expr_parse (
  const char *str,
  int64_t *value,
  get_symbol_value_func_t func )
{
  int flag_parse_error;
  get_symbol_value_func = func;
  libccg_string_buff_clear ();
  libccg_string_buff_append (str);
  flag_parse_error = yyparse ();
  *value = simple_expr_result;
  return flag_parse_error;
}


#ifdef UNIT_TEST
int
main (int argc, char *argv[])
{
  int64_t y;
  int flag_error;
  
  flag_error = libccg_simple_expr_parse ("0", &y, 0);
  if (!flag_error)
    printf ("%lld\n", y);

  return 0;
}
#endif /*UNIT_TEST*/

//int libccg_lex(void); /* defined in simple-expr-scanner.c */

#include "simple-expr-scanner.c"
