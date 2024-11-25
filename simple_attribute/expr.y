%{
    #include <stdio.h>
    #include <ctype.h>
    int yylex();
    int yyerror(char *s);
%}
%token NUMBER
%token SYMBOL
%token STRING
%%
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

%%

int main() {
    yyparse();
    return 0;
}
int yyerror(char *s) {
    printf("%s\n", s);
    return -1;
}