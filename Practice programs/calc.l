%{
#include <stdlib.h>
void yyerror(char *);
int yywrap();
extern int yylval;
#include "y.tab.h"
%}
%%

[a-z] {
yylval = *yytext - 'a';
return VARIABLE; }


[0-9]+ {
 yylval = atoi(yytext);
 return INTEGER;
}

[-+()=/*\n] { return *yytext; }

[ \t]
;
. yyerror("invalid character");


%%

void yyerror(char *s){
	printf("%s\n",s);
}

int yywrap(void) {
	return 1;
}

