%{
	#include "calc.tab.h"
	#include <stdio.h>

	typedef struct{ //Symbol table holds variables and their values
		char *name;
		int value;
	}sym_table;

	void putsym(char *var_name, int var_val);
	int getsym(char *var_name);
	void inc(char *var_name, int var_val);
	void dec(char *var_name, int var_val);
	extern FILE *yyin;
	extern int yylineno;
	int cnt=0,temp;
	sym_table sym[100];

%}

%token PLUSEQU MINUSEQU OPB1 OPB2 CLB1 CLB2 NUM SEMI PLUS MINUS PRINT PRINTS ID MAIN STR ASGN

%union{
	int i_val;
	char *s_val;
}

%type<i_val> NUM E stmt 
%type<s_val> STR ID

%left PLUS MINUS

%%

Prog : 	 MAIN OPB1 CLB1 OPB2 stmts CLB2
	|
	;
	
stmts : stmt SEMI stmts
	|
	;
stmt :	ID ASGN E 
	{
		printf("\n Debug of ID : %s=%d\n",$1,$3); 
		putsym($1,$3);
		
	}
	ID PLUSEQU E
	{
		inc($1,$3);
	}
	ID MINUSEQU E
	{
		dec($1,$3);
	}
	|PRINT E
	{
		print("\n %d\n",$2);
		fprintf(stdout,"\n %d\n",$2);
	}
	|PRINTS '"' STR '"'
	{
		fprintf(stdout,"\n %s\n",$3);
	}
	;

E :
	E PLUS E
        {
                $$ = $1 + $3;
        }

	| E MINUS E
        {
                $$ = $1 - $3;
        }
	| NUM
        {
                $$ = $1;
        }
	| MINUS E
	{
		$$ = -$2;
	}
	| OPB1 E CLB1
	{
		$$ = $2;
	}
	| ID
	{
		printf("%s\n", $1);
		$$ = getsym($1);
	}
	;

%%

int yyerror(char *s, int LineNo)
{
	fprintf(stderr,"\n Syntax error at line %d ", yylineno);
	return 1;
}

int main()
{	
	yyin=fopen("input","r");
	if(yyin==NULL)
	{
		printf("\n Error opening file!!");
	}
	else
	{
		do{
			yyparse();
		}while(!feof(yyin));
	}
	return 0;
}

	//putsym function definition
void putsym(char *var_name, int var_val)
{
	int i,flag=0;
	for(i=0;i<cnt;i++)
	{
		if(sym[i].name==var_name)
		{
		 sym[i].value = var_val;
		 flag = 1;
		}
	}
	if(flag!=1)
	{
		sym[cnt].name=var_name;
		sym[cnt].value=var_val;
		cnt++;
	}
}

	 //getsym function definition
int getsym(char *var_name)
{
        int i;
        for(i=0;i<cnt;i++)
        {
                if(var_name==sym[i].name)
                {
                 return (sym[i].value);
                }
        }
}

 	//inc function definition
void inc(char *var_name, int var_val)
{
        int i;
        for(i=0;i<cnt;i++)
        {
                if(var_name==sym[i].name)
                {
                 sym[i].value = sym[i].value + var_val;
                }
        }
}

	//dec function definition

void dec(char *var_name, int var_val)
{
	int i;
	for(i=0;i<cnt;i++)
	{
		if(var_name==sym[i].name)
		{
                 sym[i].value = sym[i].value - var_val;
		}
	}
}
