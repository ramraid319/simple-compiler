%{
    #include <stdlib.h>
    #include "y.tab.h"
%}
%%
"+"?[0-9]+              {yylval = atoi(yytext); return(NUMBER);}
-[0-9]+                 {yylval = atoi(yytext); return(NUMBER);}
[a-zA-Z][a-zA-Z0-9]*    return(SYMBOL);
\"[^\"]*\"              return(STRING);
";"[^\n]*"\n"   ;
[~!@#$%^&=]+    ;
[ \t]  ;
\(     return('(');
\)     return(')');
\+     return('+');
\-     return('-');
\*     return('*');
\/     return('/');

\n     return(0);
.      {printf("'%c': illegal character\n", yytext[0]);  exit(-1);}
%%
int yywrap() {return 1;}