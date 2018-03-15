%{
	#include<stdio.h>
	#include<stdlib.h>
	char ans[100];
%}

%s S1
%s S2
%s S3
%s S4

%%

<INITIAL>(.*) {
	strcpy(ans,"for(");
	strcat(ans,yytext);
	BEGIN S1;	
}

<S1>("while(") {
	BEGIN S2;
}

<S2>(.*")") {
	strcat(ans,yytext);
	ans[strlen(ans)-1] = ';';
	BEGIN S3;
}

<S3>(.*"(++|--)".*) {
	strcat(ans,yytext);
	ans[strlen(ans)-1] = ')';
	strcat(ans,"{\n");
	BEGIN S4;
}

<S4>("}") {
	strcat(ans,yytext);
	BEGIN INITIAL;
}

<S4>(.*) {
	strcat(ans,yytext);
	strcat(ans,"\n");
}

. ;

\n ;

%%

int main(){
	yylex();
	printf("%s\n",ans);

	return 0;
}
