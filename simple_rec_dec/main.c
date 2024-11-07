#include <stdio.h>
#include <string.h>

#define NUM 301
#define SYM 302
#define LPAREN 303
#define RPAREN 304

int loop = 100;
extern char attr[];

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
