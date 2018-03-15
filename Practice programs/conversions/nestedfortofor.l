%{
	#include<stdio.h>
	#include<stdlib.h>	
	int i,j,flag;
	char ini[100],cond[100],inc[100];
	char ans[1000];
%}

%s S1
%s S2
%s S3
%s S4
%s S5

%%

<INITIAL>("for(") {
	BEGIN S1;
}

<S1>([^;]*";") {
	strcpy(ini,yytext);
	ini[strlen(ini)-1]=',';	
	BEGIN S2;
}

<S2>([^;]*";") {
	strcpy(cond,yytext);
	cond[strlen(cond)-1]=',';
	BEGIN S3;
}

<S3>(.*")") {
	strcpy(inc,yytext);
	inc[strlen(inc)-1]=',';	
	BEGIN S4;
}


<S4>("for(".*")") {
	i=-1;
	flag=0;
	for(j=0;j<yyleng;j++){
		if(yytext[j]=='('){
			i++;
			ans[i]=yytext[j];	
			strcat(ans,ini);
			i+=strlen(ini);
			continue;
		}
		if(yytext[j]==';' && flag==0){
			i++;
			ans[i]=yytext[j];
			strcat(ans,cond);
			i+=strlen(cond);		
			flag=1;
			continue;
		}
		if(yytext[j]==';' && flag==1){
                        i++;
                        ans[i]=yytext[j];
                        strcat(ans,inc);
                        i+=strlen(inc);
                        flag=2;
                        continue;
                }
		i++;
		ans[i]=yytext[j];
	}
	BEGIN S5;
}

<S5>("{"\n?([^}]*\n)*"}") {
	strcat(ans,yytext);
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
