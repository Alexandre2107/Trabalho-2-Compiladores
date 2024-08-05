%token T_INICIO T_FIM T_PROGRAMA T_IDENTIF T_INTEIRO T_LOGICO T_LEIA T_ESCREVA T_ENQTO T_FACA T_FIMENQTO T_ATRIB T_SE T_ENTAO T_SENAO T_FIMSE T_VEZES T_DIV T_MAIS T_MENOS T_MAIOR T_MENOR T_IGUAL T_E T_OU T_NUMERO
T_V T_F T_NAO T_ABRE T_FECHA

%{
    #include<stdio.h>
    void yyerror(char *);
    int yylex(void);
    
    extern FILE *yyin;
%}


%%


programa:
            cabecalho variaveis T_INICIO lista_comandos T_FIM;         

cabecalho:
            T_PROGRAMA T_IDENTIF;

variaveis:
            declaracao_variaveis
            | 
            ;

declaracao_variaveis:
            tipo lista_variaveis declaracao_variaveis
            | tipo lista_variaveis
            ;

tipo:
            T_LOGICO
            | T_INTEIRO
            ;

lista_variaveis:
            T_IDENTIF lista_variaveis
            | T_IDENTIF
            ; 

lista_comandos:
            comando lista_comandos
            | 
            ;

comando:
            entrada_saida
            | repeticao
            | selecao
            | atribuicao
            ;

entrada_saida:
            leitura | escrita
            |
            ;

leitura:
            T_LEIA T_IDENTIF
            |
            ;

escrita:
            T_ESCREVA expressao
            |
            ;

repeticao:
            T_ENQTO expressao T_FACA lista_comandos T_FIMENQTO
            |
            ;

atribuicao:
        T_IDENTIF T_ATRIB expressao
        |
        ;

selecao:
            T_SE expressao T_ENTAO lista_comandos T_SENAO lista_comandos T_FIMSE
            |
            ;

expressao:
            expressao T_VEZES expressao
            | expressao T_DIV expressao
            | expressao T_MAIS expressao
            | expressao T_MENOS expressao
            | expressao T_MAIOR expressao
            | expressao T_MENOR expressao
            | expressao T_IGUAL expressao
            | expressao T_E expressao
            | expressao T_OU expressao
            | termo
            ;

termo:
            T_IDENTIF
            | T_NUMERO
            | T_V
            | T_F
            | T_NAO termo
            | T_ABRE expressao T_FECHA
            ;

%%


void yyerror(char *s){
    printf("%s\n", s);
}


int main(void){
    FILE *fp;
    int i;
    fp = fopen("./avaliacao.simples", "r");
    yyin = fp;
    yyparse();
    return 0;
}

