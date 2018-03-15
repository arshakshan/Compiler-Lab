%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%{
#include<stdio.h>
int sym[26];
%}
%%
program:
program statement '\n'
|
;
statement:
expr                    { printf("%d\n", $1); }
| VARIABLE '=' expr     { sym[$1] = $3; }
;

expr:
INTEGER
| VARIABLE              { $$=sym[$1];}
| expr '+' expr         { $$=$1 + $3; }
| expr '-' expr         { $$=$1 - $3; }
| expr '*' expr         { $$=$1 * $3; }
| expr '/' expr         { $$=$1 / $3; }
| '(' expr ')'          { $$=$2; }
;

%%

int main(void) {
yyparse();
return 0;
}

