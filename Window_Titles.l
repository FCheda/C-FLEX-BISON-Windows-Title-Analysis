%{
#include <stdlib.h>
#include "Window_Titles.tab.h"
%}
version [0-9]+(\.?[0-9]+|{simpleletter}+)+
simpleletter [a-z|A-Z|á-ź|Á-Ź|ñ|Ñ|_]
letter    [a-z|A-Z|á-ź|Á-Ź|ñ|Ñ|_|-]
basicletter	  [a-z]
word	  ({letter}|[0-9])+
delim     :|,|-|" "|\[|\]|\.|~
simbol    [\t\n<<EOF>>]
separador " - " 
file {word}(\.{letter}+)+
program {word}({word}|" "|"("|")"|\+)*{version}?(\[{word}\])?
ruta ({word}":/"|{word}"://"|{word}":\\")?("/"|"\\"|{word})+("/"|"\\"|{word}|(\.)|\,|\?|=|#)*
rutafile {ruta}(\.{letter}+)+
error .
%%
{delim} {}
{separador} {}
{file} {yylval.valStr = strdup(yytext);return BFILE;}
{program} {yylval.valStr = strdup(yytext);return BPROGRAM;}
{ruta} {yylval.valStr = strdup(yytext);return BRUTA;}
{rutafile} {yylval.valStr = strdup(yytext);return BRUTAFILE;}
{simbol} {return BENDLINE;}
{error} {}
%%

