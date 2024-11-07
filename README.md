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
    #define NUM 301
    #define SYM 302
    #define STR 303
    #define LPAREN 304
    #define RPAREN 305

    char attr[256];
%}

ilit [0-9]+
id [a-zA-Z][a-zA-Z0-9]*
special [~!@#$%^&*-+=]+
comment ";"[^\n]*"\n"
string \"[^\"]*\"

%%

[ \t]+ {}                                          // eat white spaces
"(" { return LPAREN; }                             // start of List
")" { return RPAREN; }                             // end of List
{string} { strcpy(attr, yytext + 1); attr[strlen(attr) - 1] = '\0'; return STR; }   // copy string
{ilit} { strcpy(attr, yytext); return NUM; }       // literal [0-9]+
{id} { strcpy(attr, yytext); return SYM; }         // id [a-zA-Z]+
{special} {}                                       // eat specials [~!@#$%^&*-+=]+
{comment} {}                                       // eat comments ";"[^\n]*"\n"


%%

int yywrap() {
    return 1;
}
```
