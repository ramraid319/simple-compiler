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

[ \t]+ {}
"(" { return LPAREN; }
")" { return RPAREN; }
{string} { strcpy(attr, yytext + 1); attr[strlen(attr) - 1] = '\0'; return STR; }
{ilit} { strcpy(attr, yytext); return NUM; }
{id} { strcpy(attr, yytext); return SYM; }
{special} {}
{comment} {}


%%

int yywrap() {
    return 1;
}
