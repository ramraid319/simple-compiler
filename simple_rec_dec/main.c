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
void string();

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
        case QUOT:
            string();
            printf("%s", buf);
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

void string() {
    int i = 0;
    int tok = yylex();
    while(tok != QUOT) {
        strcpy(buf + i, attr);
        i += strlen(attr);
        buf[i++] = ' ';

        tok = yylex();
    }
}

int main() {
    while(loop--) {
        process_token();
    }
    return 0;
}
