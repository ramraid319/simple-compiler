# simple_compiler
🗡 Lets study compiler 🛡

## simple_rec_dec

A simple Recursive Decsent Parser

```
<data> ::= <integer>
         | <symbol>
         | <list>
         | <string>
         ;
<list> ::= "(" { <data> } ")"
         ;
<string> ::= "\"" { <data> } "\""
         ;
```

### data.l

```lex

%{
    #include <stdio.h>
    #include <string.h>
    #define ILITERAL  301
    #define SYMBOL    302
    #define STRING    303
    #define OPERATOR  304

    char operator;
%}

niliteral -[0-9]+
iliteral "+"?[0-9]+
symbol [a-zA-Z][a-zA-Z0-9]*
special [~!@#$%^&=]+
comment ";"[^\n]*"\n"
string \"[^\"]*\"
operator "+"|"-"|"*"|"/"

%%

// return type of token

[ \t]+ {}                                    // eat white spaces
"(" { return '('; }
")" { return ')'; }
{string} { return STRING; }
{niliteral} { return ILITERAL; }
{iliteral} { return ILITERAL; }
{symbol} { return SYMBOL; }
{special} {}                                 // eat specials
{comment} {}                                 // eat comments from ';' to '\n'
{operator} { return OPERATOR; }

%%

int yywrap() {
    return 1;
}

```
## simple_shift_reduce
also we can use shift_reduce (LR Parser)

#### expr.y
```yacc
Input   : Expr          {puts("Input -> Expr");}
        | STRING        {puts("Input -> STRING");}
        | Data          {puts("Input -> Data");}
        ;

List    : '(' Data ')'  {puts("List -> (Data)");}
        | '('')'        {puts("List -> NIL");}
        | Data Data     {puts("List -> Data Data");}
        ;

Data    : Factor        {puts("Data -> Factor");}
        | SYMBOL        {puts("Data -> SYMBOL");}
        | List          {puts("Data -> List");}
        ;

Expr    : Expr '+' Term {puts("Expr -> Expr + Term");}
        | Expr '-' Term {puts("Expr -> Expr - Term");}
        | Term          {puts("Expr -> Term");}
        ;
Term    : Term '*' Factor {puts("Term -> Term * Factor");}
        | Term '/' Factor {puts("Term -> Term / Factor");}
        | Factor          {puts("Term -> Factor");}
        ;
Factor  : NUMBER        {puts("Factor -> NUMBER");}
        ;
```

#### num.l
```lex
%{
    #include <stdlib.h>
    #include "y.tab.h"
%}
%%
"+"?[0-9]+              return(NUMBER);
-[0-9]                  return(NUMBER);
[a-zA-Z][a-zA-Z0-9]*    return(SYMBOL);
\"[^\"]*\"              return(STRING);
";"[^\n]*"\n"   ;
[~!@#$%^&=]+    ;
[ \t]  ;
\(     return('(');
\)     return(')');
\+     return('+');
\-     return('-');
\*     return('*');
\/     return('/');

\n     return(0);
.      {printf("'%c': illegal character\n", yytext[0]);  exit(-1);}
%%
int yywrap() {return 1;}
```

## simple_attribute
we can use attributes using yylval.

#### expr.y

```yacc
Line    : Exp           { $$ = $1; printf("%d\n", $$);}

Exp     : '+' Exp Term  { $$ = $2 + $3; }
        | '-' Exp Term  { $$ = $2 - $3; }
        | Term          { $$ = $1; }
        ;
Term    : '*' Term Fact { $$ = $2 * $3; }
        | '/' Term Fact { $$ = $2 / $3; }
        | Fact          { $$ = $1; }
        ;
Fact    : '(' Exp ')'   { $$ = $2; }
        | NUMBER        { $$ = $1; }
        ;
```

in lex code, assign yytext to yylval before return your token.
```num.l
"+"?[0-9]+              {yylval = atoi(yytext); return(NUMBER);}
-[0-9]+                 {yylval = atoi(yytext); return(NUMBER);}
```
