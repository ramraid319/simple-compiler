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

[ \t]+ {}
";"[^\n]*"\n" {}
"(" { return LPAREN; }
")" { return RPAREN; }
{ilit} { strcpy(attr, yytext); return NUM; }
{id} { strcpy(attr, yytext); return SYM; }
{special} {}

%%

int yywrap() {
    return 1;
}
