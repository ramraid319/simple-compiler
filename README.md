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
    #define ILITERAL  301
    #define SYMBOL    302
    #define STRING    303
    #define OPERATOR  304

    char operator;
%}

niliteral -[0-9]+
iliteral "+"?[0-9]+
symbol [a-zA-Z][a-zA-Z0-9]*
special [~!@#$%^&=]+
comment ";"[^\n]*"\n"
string \"[^\"]*\"
operator "+"|"-"|"*"|"/"

%%

/* return type of token */

[ \t]+ {}                                    // eat white spaces
"(" { return '('; }
")" { return ')'; }
{string} { return STRING; }
{niliteral} { return ILITERAL; }
{iliteral} { return ILITERAL; }
{symbol} { return SYMBOL; }
{special} {}                                 // eat specials
{comment} {}                                 // eat comments from ';' to '\n'
{operator} { return OPERATOR; }

%%

int yywrap() {
    return 1;
}

```
