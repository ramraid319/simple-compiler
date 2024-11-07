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

[ \t]+ {}
";"[^\n]*"\n" {}
"(" { return LPAREN; }
")" { return RPAREN; }
"\"" { return QUOT; }
{ilit} { strcpy(attr, yytext); return NUM; }
{id} { strcpy(attr, yytext); return SYM; }
{special} {}

%%

int yywrap() {
    return 1;
}
