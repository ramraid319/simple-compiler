all: main

main: lex.yy.c main.c
	gcc lex.yy.c main.c -o main

lex.yy.c: data.l
	flex data.l

clean:
	rm main lex.yy.c

zip: Makefile data.l main.c
	zip main.zip Makefile data.l main.c