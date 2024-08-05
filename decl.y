%token T_INICIO T_FIM T_PROGRAMA T_IDENTIF T_INTEIRO T_LOGICO T_LEIA T_ESCREVA T_ENQTO T_FACA T_FIMENQTO T_ATRIB T_SE T_ENTAO T_SENAO T_FIMSE T_VEZES T_DIV T_MAIS T_MENOS T_MAIOR T_MENOR T_IGUAL T_E T_OU T_NUMERO
T_V T_F T_NAO T_ABRE T_FECHA

%{
    #include<stdio.h>
    void yyerror(char *);
    int yylex(void);
    
    extern FILE *yyin;
%}


%%


program:
            header variables T_INICIO command_list T_FIM {printf("\nProgram recognized successfully!\n");};         

header:
            T_PROGRAMA T_IDENTIF;

variables:
            variable_declaration
            | 
            ;

variable_declaration:
            type variable_list variable_declaration
            | type variable_list
            ;

type:
            T_LOGICO
            | T_INTEIRO
            ;

variable_list:
            T_IDENTIF variable_list
            | T_IDENTIF
            ; 

command_list:
            command command_list
            | 
            ;

command:
            input_output
            | repetition
            | selection
            | assignment
            ;

input_output:
            read | write
            |
            ;

read:
            T_LEIA T_IDENTIF
            |
            ;

write:
            T_ESCREVA expression
            |
            ;

repetition:
            T_ENQTO expression T_FACA command_list T_FIMENQTO
            |
            ;

assignment:
        T_IDENTIF T_ATRIB expression
        |
        ;

selection:
            T_SE expression T_ENTAO command_list T_SENAO command_list T_FIMSE
            |
            ;

expression:
            expression T_VEZES expression
            | expression T_DIV expression
            | expression T_MAIS expression
            | expression T_MENOS expression
            | expression T_MAIOR expression
            | expression T_MENOR expression
            | expression T_IGUAL expression
            | expression T_E expression
            | expression T_OU expression
            | term
            ;

term:
            T_IDENTIF
            | T_NUMERO
            | T_V
            | T_F
            | T_NAO term
            | T_ABRE expression T_FECHA
            ;

%%


void yyerror(char *s){
    printf("%s\n", s);
}


int main(void){
    FILE *fp;
    int i;
    fp = fopen("./teste.txt", "r");
    yyin = fp;
    yyparse();
    return 0;
}