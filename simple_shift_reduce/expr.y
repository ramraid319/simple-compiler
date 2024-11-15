%{
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);
%}
%token NUMBER
%%
Expr    : Expr '+' Term {puts("E -> E + T");}
        | Expr '-' Term {puts("E -> E - T");}
        | Term          {puts("E -> T");}
        ;
Term    : Term '*' Factor {puts("T -> T * F");}
        | Term '/' Factor {puts("T -> T / F");}
        | Factor          {puts("T -> F");}
        ;
Factor  : NUMBER        {puts("F -> n");}
        ;
%%

int main() {
    yyparse();
}
int yyerror(char *s) {
    printf("%s\n", s);
}