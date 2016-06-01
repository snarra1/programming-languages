all : calc

calc :
	flex -l calc.l
	bison -dv calc.y
	gcc lex.yy.c calc.tab.c -o calc -lfl

clean :
	rm -f *.h *.c *.o *.output calc
