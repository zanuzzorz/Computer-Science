/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados I
@Autor: Ricardo Zanuzzo
*/

/*
----------------------------------------------------------------------------------------------------------------------------
Main com as Chamadas das Funções
----------------------------------------------------------------------------------------------------------------------------
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "funcoes.c"


int main(){
  int numLista,Del,Menu,Retorno;
  numLista=Del=Menu=0;
  SLista ListaUM, ListaDois,ListaMerge;
  SNodo *pNodo;
  
  Reset(&ListaUM);
  Reset(&ListaDois);
/*
----------------------------------------------------------------------------------------------------------------------------
Menu de interação com o usuario, onde sera ativado uma das 7 opções que podem ser selecionadas.
----------------------------------------------------------------------------------------------------------------------------
*/  
  system("clear");
  while(Menu!=7){
    Menu=0;
    printf("\nSelecione uma das Opções:\n"
	    " 1- (Insert) Inserir um novo Cadastro\n"
	    " 2- (Remove) Remover um Cadastro \n"
	    " 3- (Merge)  Fazer a Intercalação das Listas\n"
	    " 4- (Print)  Mostrar o Conteúdo das Listas\n" 
	    " 5- (Size)   Mostrar a Quantidade Atual de Cadastros\n" 
	    " 6- (Clear)  Limpar uma das Listas\n"
	    " 7- (Exit)   Sair\n"); 
      printf("\n=>");
      scanf("%d",&Menu);
      switch (Menu){
	  case 1://Chama a Função Insere
		system("clear");
		pNodo=(SNodo*)malloc(sizeof(SNodo));//Alocação do tipo SNodo para o  novo Nodo a ser inserido;
		printf("\nDigite o Código de Usuário (ID):\n");
		scanf("%d",&pNodo->SDados.ID);
		printf("Digite o Nome do Usuário:\n");
		scanf("%s",pNodo->SDados.nome);
		printf("\nEm qual Lista deseja Armazenar o Cadastro? 1 ou 2\n");
		scanf("%d",&numLista);
	
		if(numLista==1){
		Insere(&ListaUM,pNodo,pNodo->SDados.ID);
		break;		  
		}else if(numLista==2){
		Insere(&ListaDois,pNodo,pNodo->SDados.ID);
		break;
		}else{
		printf("\n ERRO: Lista Inválida!\n");
		break;
		}
		break;
	    
	    case 2:
		system("clear");
		printf("\nEm qual Lista deseja Remover um Cadastro? 1 ou 2\n");
		scanf("%d",&numLista);

		if(numLista==1){
		Imprime(&ListaUM);
		printf("\nDigite o ID a ser Removido!\n");
		scanf("%d",&Del);
		Remove(&ListaUM,Del);

		}else if(numLista==2){
		Imprime(&ListaUM);
		printf("\nDigite o ID a ser Removido!\n");
		scanf("%d",&Del);
		Remove(&ListaDois,Del);
		}else{
		printf("\n ERRO: Lista Inválida!\n");
		}
		break;
	    
	  case 3:
		Reset(&ListaMerge);
		Retorno=Merge(&ListaUM,&ListaDois,&ListaMerge);
		if(Retorno!=0){
			printf("\nDeseja Imprimir a Nova Lista Criada ?:\n"
			  " 1- SIM \n"
			  " 2- NÃO \n");
			  scanf("%d",&numLista);
			  if(numLista==1){
			    Imprime(&ListaMerge); 
			  }else{
			    break;
			  }
		}
		break;
	    
	  case 4:
		system("clear");
		printf("\nQual das Listas Deseja Imprimir:\n"
		  " 1- Lista Um \n"
		  " 2- Lista Dois \n"
		  " 3- Merge da Lista Um e Dois \n");
		scanf("%d",&numLista);
		if(numLista<1 && numLista>3){
		printf("Opção Invalida!");
		}
		if(numLista==1){
		Imprime(&ListaUM);
		}
		if(numLista==2){
		Imprime(&ListaDois);
		}
		if(numLista==3){
		Imprime(&ListaMerge);
		}
		break;
	  case 5:
		system("clear");
		printf("\nQual das Listas Deseja Verificar o Tamanho:\n"
		  " 1- Lista Um \n"
		  " 2- Lista Dois \n"
		  " 3- Merge da Lista Um e Dois \n");
		scanf("%d",&numLista);
		if(numLista==1){
		printf("O Tamanho da Lista %d é Atualmente: %d\n",numLista,ListaUM.TamanhoLista); 
		}
		if(numLista==2){
		printf("O Tamanho da Lista %d é Atualmente: %d\n",numLista,ListaDois.TamanhoLista); 
		}
		if(numLista==3){
		printf("O Tamanho da Lista %d é Atualmente: %d\n",numLista,ListaMerge.TamanhoLista); 
		}
		break;
			    
	  case 6:
		system("clear");
		printf("\nQual das Listas Deseja Limpar:\n"
		  " 1- Lista Um \n"
		  " 2- Lista Dois \n"
		  " 3- Merge da Lista Um e Dois \n");
		scanf("%d",&numLista);
		if(numLista<1 && numLista>3){
		printf("Opção Invalida!");
		}
		if(numLista==1){
		Clear(&ListaUM);
		}
		if(numLista==2){
		Clear(&ListaDois);
		}
		if(numLista==3){
		Clear(&ListaMerge);
		}
		break;

	  case 7:
		printf("Aplicativo Encerrado com Sucesso!\n");
		return 0;
	  break;
	  
	  default:
	    	printf("\nOpção Invalida!\n");
	  break;
      }
  }
     
     return 0;
}
