%{
int flag,palincount=0;
%}
%%
[a-zA-Z]+ {
        int i,j;
        j=yyleng-1;
        flag=0;
        printf("%d %d",yylval,yyval);
        for(i=0;i<yyleng;i++,j--){
                if(yytext[i]!=yytext[j]){
                        flag=1;
                        break;
                }
        }
        if(flag==0)palincount++;
}
[ ] {}
\n {}
%%
int main()
{
yylex();
printf("There were %d no of palindromes",palincount);
return 0;
}
