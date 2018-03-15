%{
	#include<stdio.h>
	#include<stdlib.h>
	int i,j;
	int flag;
	char temp[100];
	char ans[100];
%}

%s S1
%s S2
%s S3
%s S4

%%

<INITIAL>("if(".*")") {
	strcpy(ans,"switch(");
	j=0;
	flag=0;
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='('){
			flag=1;
			continue;
		}
		if(flag==1 && yytext[i]=='='){
			flag=2;
			break;
		}
		else if(flag==1){
			temp[j]=yytext[i];
			j++;
		}
	}	
	temp[j]='\0';
	strcat(ans,temp);
	strcat(ans,"){\ncase ");
	j=0;
	while(i<yyleng-1){
		if(yytext[i]=='='){
			i++;
			continue;
		}
		temp[j]=yytext[i];	
		j++;
		i++;
	}
	strcat(ans,temp);
	strcat(ans,":");
	BEGIN S1;
}

<S1>("{"\n?([^}]*\n)*"}") {
	strcat(ans,yytext);
	BEGIN S2;
}

<S2>("else if(".*")") {
	for(i=0;i<yyleng;i++){
		if(yytext[i]=='='){
			break;
		}	
	}
	j=0;
	while(i<yyleng-1){
		if(yytext[i]=='='){
			i++;
			continue;	
		}
		temp[j]=yytext[i];	
		j++;
		i++;
	}
	temp[j]='\0';
	strcat(ans,"\ncase ");
	strcat(ans,temp);
	strcat(ans,":");
	BEGIN S3;
}

<S2>("else") {
	strcat(ans,"\ndefault:");
	BEGIN S4;
}

<S3>("{"\n?([^}]*\n)*"}") {
	strcat(ans,yytext);
	BEGIN S2;
}

<S4>("{"\n?([^}]*\n)*"}") {
	strcat(ans,yytext);
	strcat(ans,"\n}");
	BEGIN INITIAL;
}


. ;

\n ;

%%

int main(){
	yylex();
	printf("%s\n",ans);

	return 0;
}
