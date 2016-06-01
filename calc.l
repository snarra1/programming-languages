%{
	#include "calc.tab.h"
	#include <stdio.h>
	#include <string.h>
	int yylineno;
	char *str;
%}

A [a-zA-Z]
D [0-9]

%%

[\n] {}
[\t] {}
[ ]  {}
"main"		return (MAIN);
"print"		return (PRINT);
"prints"	return (PRINTS);
[a-z](A|D)* 	{
		//	 printf("\n ID is %s\n\n",yytext);
		 str = malloc(sizeof(char)*(strlen(yytext)+1));
		 strcpy(str,yytext);
		 yylval.s_val=str;
		 return (ID);
		}
{A}+ 		{
		 //	printf("\n STR is %s\n\n",yytext);
		 str = malloc(sizeof(char)*(strlen(yytext)+1));
		 strcpy(str,yytext);
		 yylval.s_val = str;
		 return (STR);
		}
[+|-]?{D}+	{
		 yylval.i_val = atoi(yytext);
		 return (NUM);
		}


"+" 	{return (PLUS);}
"-" 	{return (MINUS);}
"="	{return (ASGN);}
";" 	{return (SEMI);}
"+="	{return (PLUSEQU);}
"_+" 	{return (MINUSEQU);}
"("	{return (OPB1);}
")"	{return (CLB1);}
"{"	{return (OPB2);}
"}"	{return (CLB2);}
[^,.]  return (*yytext);

. {
	yyerror("\n Invalid Symbol",yylineno);
	return 0;
  }

%%
int yywrap()
{
	return 1;
}
