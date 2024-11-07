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
    #define QUOT 306

    char attr[256];
%}

ilit [0-9]+
id [a-zA-Z][a-zA-Z0-9]*
special [~!@#$%^&*-+=]+

%%

[ \t]+ {}                                          // eat white spaces
";"[^\n]*"\n" {}                                   // eat comments (all words from ';' to newline)
"(" { return LPAREN; }                             // start of List
")" { return RPAREN; }                             // end of List
"\"" { return QUOT; }                              // string until next \"
{ilit} { strcpy(attr, yytext); return NUM; }       // literal [0-9]+
{id} { strcpy(attr, yytext); return SYM; }         // id [a-zA-Z]+
{special} {}                                       // eat specials [~!@#$%^&*-+=]+

%%

int yywrap() {
    return 1;
}
```
