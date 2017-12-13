%{
int flag,patcount=0;
%}
%%
(aaa) {
        yyless(1);
        patcount++;
}
[^(aaa)] {}
%%
int main()
{
yylex();
printf("There were %d no of patterns",patcount);
return 0;
}

