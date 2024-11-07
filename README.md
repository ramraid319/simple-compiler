# simple_compiler
🗡 Lets study compiler 🛡

## simple_rec_dec

A simple Recursive Decsent Parser

```
<data> ::= <integer>
         | <symbol>
         | <list>
         ;
<list> ::= "(" { <data> } ")"
         ;
```

### data.l

```lex
%{
    #include <stdio.h>
    #include <string.h>
    #define NUM 301
    #define SYM 302
    #define LPAREN 303
    #define RPAREN 304

    char attr[256];
%}

ilit [0-9]+
id [a-zA-Z]+
special [~!@#$%^&*-+=]+

%%

[ \t]+ {}                                          // eat white spaces
";"[^\n]*"\n" {}                                   // eat comments (all words from ';' to newline)
"(" { return LPAREN; }                             // start of List
")" { return RPAREN; }                             // end of List
{ilit} { strcpy(attr, yytext); return NUM; }       // literal [0-9]+
{id} { strcpy(attr, yytext); return SYM; }         // id [a-zA-Z]+
{special} {}                                       // eat specials [~!@#$%^&*-+=]+

%%

int yywrap() {
    return 1;
}

```
