%{
    #include <stdio.h>
    int yylex();
    int yyerror(char *s);
%}
%token NUMBER
%token SYMBOL
%token STRING
%%
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

%%

int main() {
    yyparse();
}
int yyerror(char *s) {
    printf("%s\n", s);
}