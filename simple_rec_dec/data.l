%{
    #include <stdio.h>
    #include <string.h>
    #define ILITERAL  301
    #define SYMBOL    302
    #define STRING    303
    #define OPERATOR  304

%}

niliteral -[0-9]+
iliteral "+"?[0-9]+
symbol [a-zA-Z][a-zA-Z0-9]*
special [~!@#$%^&=]+
comment ";"[^\n]*"\n"
string \"[^\"]*\"
operator "+"|"-"|"*"|"/"

%%

[ \t]+ {}
"(" { return '('; }

")" { return ')'; }
{string} { return STRING; }
{niliteral} { return ILITERAL; }
{iliteral} { return ILITERAL; }
{symbol} { return SYMBOL; }
{special} {}
{comment} {}
{operator} { return OPERATOR; }

%%

int yywrap() {
    return 1;
}
