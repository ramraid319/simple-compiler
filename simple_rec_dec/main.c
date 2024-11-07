#include <stdio.h>
#include <string.h>

#define NUM 301
#define SYM 302
#define STR 303
#define LPAREN 304
#define RPAREN 305
#define QUOT 306

int loop = 100;
extern char attr[];
char buf[256];

int yylex();

void process_token();
void data();
void list();

void process_token() {
    int tok = yylex();
    data(tok);
    printf("\n");
}

void data(int tok) {
    switch (tok) {
        case NUM:
            printf("%s", attr);
            break;
        case SYM:
            printf("%s", attr);
            break;
        case STR:
            printf("\"%s\"", attr);
            break;
        case LPAREN:
            list();
            break;
        case RPAREN:
            break;
        default:
            break;
    }
}

void list() {
    int tok = yylex();

    if(tok == RPAREN) {
        printf("NIL");
    }
    else {
        printf("(");
        data(tok);
        printf(" . ");
        list();
        printf(")");
    }

}

int main() {
    while(loop--) {
        process_token();
    }
    return 0;
}
