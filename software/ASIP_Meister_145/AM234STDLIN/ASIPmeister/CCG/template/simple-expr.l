
%{

/*
 * Copyright (c) 2007 NEC Corpoartion.
 * All rights reserved.
 * Use and distribution of this program without permission are not allowed.
 *
 * This is part of CCG (C compiler generator).
 * 
 */

#include <string.h>

#undef   YY_INPUT
#define  YY_INPUT(buffer,result,max_size)   libccg_yy_input(buffer,&result,max_size)
void libccg_yy_input(char* buffer, int* result, int max_size);

%}



%%

[ \r\t]  /* Ignore white spaces. */;

"+"    return (OP_ADD_T);
"-"    return (OP_SUB_T);
"*"    return (OP_MUL_T);
"/"    return (OP_DIV_T);
"%"    return (OP_MOD_T);
"("    return (LEFT_PAR_T);
")"    return (RIGHT_PAR_T);
"<<"   return (OP_LSHIFT_T);
">>"   return (OP_RSHIFT_T);
"&"    return (OP_AND_T);
"|"    return (OP_OR_T);
"^"    return (OP_XOR_T);
"~"    return (OP_NOT_T);
"\n"   return (OP_END_T);

[1-9][0-9]* {
  yylval.value = strtoll (&yytext[0],0,10);
  return (NUMBER_T);
}
0[0-9]* {
  yylval.value = strtoll (&yytext[0],0,8);
  return (NUMBER_T);
}
"0x"[0-9a-f_]+ {
  yylval.value = strtoll (&yytext[0],0,16);
  return (NUMBER_T);
}
"0b"[01_]+ {
  int i;
  int len = strlen (&yytext[0]);
  int value = 0;
  int pow = 1;
  for ( i=len-1 ; 0<=i ; i-- )
  {
    if (yytext[i] == '1')
    {
      value += pow;
      pow = pow << 1;
    }
    else if (yytext[i] == '0')
    {
      pow = pow << 1;
    }
  }
  yylval.value = value;
  return (NUMBER_T);
}

[a-zA-Z_][0-9a-zA-Z_]* {
  yylval.str = &yytext[0];
  return (SYMBOL_T);
}

.      return (yytext[0]);

%%

/* Buffer to keep instruction words. */
#define MY_STRING_BUFFER_SIZE   (1024) /* buffer to keep instruction words */
typedef struct string_buffer_t
{
  char buff[MY_STRING_BUFFER_SIZE]; /* Actual buffer */
  int  size;        /* Size of NULL terminated words in buff[] */
  int  counter;     /* Counter to locate the position for reading */
} string_buffer_t;

static string_buffer_t string_buffer;


/* Clear the buffer to store expressions */
void
libccg_string_buff_clear (void)
{
  string_buffer.buff[0] = 0;
  string_buffer.size = 0;
  string_buffer.counter = 0;

  yyrestart (0);
}

/* Append a string to the buffer for expressions */
void
libccg_string_buff_append (const char *str)
{
  int length = strlen (&str[0]);
  if ((string_buffer.size+length) < MY_STRING_BUFFER_SIZE)
  {
    strncat (&string_buffer.buff[0],&str[0],length);
    string_buffer.size += length;
  }
}

int
yywrap (void)
{
  return 1;
}

void
libccg_yy_input (
  /* Output: array to store characters */
  char* buffer,
  /* Output: number of characters stored in 'buffer' */
  int*  result,
  /* Input:  maximum number of characters */
  int   max_size )
{
  int num = max_size;

  if ( string_buffer.size<max_size )
    num = string_buffer.size;

  if ( 0<num )
  {
    int pos = string_buffer.counter;
    memcpy (&buffer[0], &(string_buffer.buff[pos]), num);
    string_buffer.counter += num;
  }

  *result = num;
}
