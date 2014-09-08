/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados I
@Autor: Ricardo Zanuzzo
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "funcoes.c"


int main(){
	unsigned int Del,Menu,Retorno,numLista,zero;
	Del=Menu=Retorno=numLista=zero=0;
	SLista Lista,ListaInsertion,ListaQuick;
	SNodo *pNodo;

	Reset(&Lista);
	Reset(&ListaInsertion);
	Reset(&ListaQuick);
/*
----------------------------------------------------------------------------------------------------------------------------
Menu de interação com o usuario, onde sera ativado uma das 8 opções que podem ser selecionadas.
----------------------------------------------------------------------------------------------------------------------------
*/  
	system("clear");
	while(Menu!=8){
	Menu=0;
	printf(	"\nSelecione uma das Opções:\n"
		" 1- (Insert) Inserir um novo Cadastro\n"
		" 2- (Remove) Remover um Cadastro \n"
		" 3- (Print)  Mostrar o Conteúdo das Listas\n" 
		" 4 -(Sort 01) Fazer Ordenação da Lista com Insertion Sort \n"
		" 5 -(Sort 02) Fazer Ordenação da Lista com Quick Sort \n"
		" 6- (Size)   Mostrar a Quantidade Atual de Cadastros\n" 
		" 7- (Clear)  Limpar uma das Listas\n"
		" 8- (Exit)   Sair\n"
		"\n=>");
	scanf("%d",&Menu);
	switch (Menu){
		case 1://Chama a Função Insere
			system("clear");
			pNodo=(SNodo*)malloc(sizeof(SNodo));//Alocação do tipo SNodo para o  novo Nodo a ser inserido;
			printf("\nDigite o Código de Usuário (ID):\n");
			scanf("%d",&pNodo->SDados.ID);
			Insere(&Lista,pNodo);
			if(Retorno==1){
				Retorno=0;
			}
			break;
		case 2:
			system("clear");
			printf("\nRemover...\n");
			Imprime(&Lista);
			printf("\nDigite o ID a ser Removido!\n");
			scanf("%d",&Del);			
			Remove(&Lista,Del);
			break;
			
		case 3:
			system("clear");
			printf(	"\nQual Lista deseja Imprimir: \n"
				"1- Lista Normal\n"
				"2- Lista Ordenada por INSERTION SORT\n"
				"3- Lista Ordenada por QUICK SORT\n"
				"\n=> ");
			scanf("%d", & numLista);
			if(numLista==1){
				Imprime(&Lista);
				break;
			}else if(numLista==2){
				Imprime(&ListaInsertion);
				break;
			}else if(numLista==3){
				Imprime(&ListaQuick);
				break;
			}else{
				printf("\nOpção invalida !\n");
			}
			break;
		case 4:
			Reset(&ListaInsertion);
			CopiaLista(&Lista,&ListaInsertion);
			Retorno=InsertionSort(&ListaInsertion,Lista.TamanhoLista);
			if(Retorno!=0){
				printf(	"\nDeseja Imprimir a Nova Lista Ordenada ?:\n"
		  			" 1- SIM \n"
		  			" 2- NÃO \n");
		  		scanf("%d",&numLista);
		  		if(numLista==1){
		    			Imprime(&ListaInsertion); 
		 		}else{
		    			break;
		  		}
			}
			break;
		case 5:
			Reset(&ListaQuick);
			CopiaLista(&Lista,&ListaQuick);
			Retorno=QuickSort(&ListaQuick,zero,Lista.TamanhoLista-1);
			if(Retorno!=0){
				printf(	"\nDeseja Imprimir a Nova Lista Ordenada ?:\n"
		  			" 1- SIM \n"
		  			" 2- NÃO \n");
		  		scanf("%d",&numLista);
		  		if(numLista==1){
		    			Imprime(&ListaQuick); 
		 		}else{
		    			break;
		  		}
			}

			break;

		case 6:
			system("clear");
			printf("O Tamanho da Lista é Atualmente: %d\n",Lista.TamanhoLista); 
			break;
		    
		case 7:
			system("clear");
			printf(	"\nQual Lista deseja Limpar: \n"
				"1- Lista Normal\n"
				"2- Lista Ordenada por INSERTION SORT\n"
				"3- Lista Ordenada por QUICK SORT\n"
				"4- Limpar Todas as Listas\n"
				"\n=> ");
			scanf("%d", & numLista);
			if(numLista==1){
				Clear(&Lista);
			}else if(numLista==2){
				Clear(&ListaInsertion);
				Retorno=0;
			}else if(numLista==3){
				Clear(&ListaQuick);
				Retorno=0;
			}else if(numLista==4){
				Clear(&Lista);
				Clear(&ListaInsertion);
				Clear(&ListaQuick);
				Retorno=0;
			}else{
				printf("\nOpção invalida !\n");
			}
			break;
		case 8:
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
