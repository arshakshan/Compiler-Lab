%{
	#include<stdio.h>
	#include<stdlib.h>
	char ans[100];
%}

%s S1
%s S2
%s S3
%s S5
%s S4

%%

<INITIAL>("for(") {
	BEGIN S1;	
}

<S1>([^;]*";") {
	strcat(ans,yytext);
	strcat(ans,"\nwhile(");
	BEGIN S2;
}

<S2>([^;]*";") {
	strcat(ans,yytext);
	ans[strlen(ans)-1] =')';
	strcat(ans,"{\n");
	BEGIN S3;
}

<S3>(.*")") {
	strcat(ans,yytext);
	ans[strlen(ans)-1] = ';';
	strcat(ans,"\n");
	BEGIN S4;
}

<S4>("{"\n?) {
	BEGIN S5;
}

<S5>("}") {
	strcat(ans,yytext);
	BEGIN INITIAL;
}

<S5>(.*) {
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
