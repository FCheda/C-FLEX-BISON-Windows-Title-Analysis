%{
#include <stdio.h>
#include <string.h>
void yyerror (char const *);
%}
%union{
    char* valStr;
}
%token <valStr> BFILE
%token <valStr> BPROGRAM
%token <valStr> BRUTA
%token <valStr> BRUTAFILE
%token BENDLINE
%token BERROR
%token BFIN
%type <valStr> ruta
%start S
%%
S : windowtitle|S windowtitle;
windowtitle : BPROGRAM BFILE BENDLINE {printf("Programa: %s \t Archivo: %s \n",$1,$2);}
	     |BFILE BPROGRAM BENDLINE {printf("Programa: %s \t Archivo: %s \n",$2,$1);}
	     |BFILE BENDLINE {printf("Programa: UNKNOWN \t Archivo: %s \n",$1);}
	     |ruta BFILE BPROGRAM BENDLINE {printf("Programa: %s \t Ruta: %s \t Archivo: %s\n",$3,$1,$2);}
	     |BPROGRAM ruta BFILE BPROGRAM BENDLINE {printf("Programa: %s \t Ruta: %s \t Archivo: %s \t ExtraInfo: %s \n",$4,$2,$3,$1);}
	     |BPROGRAM ruta BPROGRAM BENDLINE {printf("Programa: %s \t Ruta: %s \t ExtraInfo: %s \n",$3,$2,$1);}
	     |ruta BPROGRAM BENDLINE {printf("Programa: %s \t Ruta: %s\n",$2,$1);}
	     |BPROGRAM ruta BENDLINE {printf("Programa: %s \t Ruta: %s\n",$1,$2);}
	     |BPROGRAM BENDLINE {printf("Programa: %s \t Archivo: Not Found \n",$1);}
	     |error{printf("ERROR!! \n");}
	     ;    	     
ruta: BRUTA {$$=$1;}
      |BRUTAFILE {$$=$1;}
      |BRUTA BRUTA {$$=strcat($1,$2);}
      |BRUTA BRUTAFILE {$$=strcat($1,$2);}
      ;
%%
int main() {
	yyparse();
	return 0;
}
/*void yyerror (char const *message) { fprintf (stderr, "%s\n", message);}*/
 
