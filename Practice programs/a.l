%{
	#include<stdio.h>
	#include<stdlib.h>
	char s[100][100];
	int i,n;
	int c;
%}

pat [0-9]+

%%

{pat} {
	printf(" \" %s \" ",yytext);
}

. ;

\n ;

%%

int yywrap(){
	c++;
	if(c==n+1){
		return 1;
	}
	else{
		yyin = fopen(s[c],"r");
		return 0;
	}
}

int main(){
	printf("Enter number : ");
	scanf("%d",&n);
	printf("Enter the files : ");
	for(i=1;i<=n;i++){
		scanf("%s",s[i]);
	}
	c=0;
	yylex();
	return 0;
}
