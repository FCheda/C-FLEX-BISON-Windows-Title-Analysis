FUENTE = Window_Titles
PRUEBA = Window_Titles.txt


compileflex:
	flex $(FUENTE).l
	gcc -o $(FUENTE) lex.yy.c -lfl

all: compile run

compile:
	flex $(FUENTE).l
	bison -o $(FUENTE).tab.c $(FUENTE).y -yd
	gcc -o $(FUENTE) lex.yy.c $(FUENTE).tab.c -lfl -ly

clean:
	rm $(FUENTE) lex.yy.c $(FUENTE).tab.c $(FUENTE).tab.h

run:
	./$(FUENTE) < $(PRUEBA)
