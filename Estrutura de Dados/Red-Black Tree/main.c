/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados II
@Autor: Ricardo Zanuzzo
*/

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "funcoes.h"

int main(){	

	int Menu,num,busca,Del;
	Menu=num=busca=Del=0;

	no *Nodo;
	STree Tree;

	system("clear");
	Reset(&Tree);
	
	while(Menu!=8){
	Menu=0;
	printf(	"\nSelecione uma das Opções:\n"
		" 1- Inserir Elemento \n"
		" 2- Remover Elemento \n"
		" 3- Listar EmOrdem  \n"
		" 4- Listar Nivel  \n" 
		" 5- Buscar Elemento\n"
		" 6- Imprimir Arvore\n"
		" 7- Verificar Propriedades \n"	
		" 8- Sair \n"
		"\n=>");
	scanf("%d",&Menu);
	switch (Menu){
		case 1:
			system("clear");
			printf("\nDigite um Número:\n");
			scanf("%d",&num);
			Nodo=(no *)malloc(sizeof(no));
			Nodo->valor=num;
			Nodo->cor=RED;
			Inserir(&Tree,Nodo,num);
			break;
		case 2:
			system("clear");
			printf("\nRemover...\n");
			if(Tree.Raiz!=NULL){
				Listar(Tree.Raiz,Tree.Raiz->level);
			}
			printf("\nDigite um Elemento a ser Removido!\n");
			scanf	("%d",&Del);			
			Remover(&Tree,Del);
			break;	
		case 3:
			system("clear");
			printf("\nListar Elementos Em Ordem...\n\n");
			EmOrdem(Tree.Raiz);
			printf("\n");	
			break;
		case 4:
			system("clear");
			printf("\nDigite o Nivel Arvore para Imprimir:\n");
			scanf("%d",&num);
			system("clear");
			printf("\nListando Elementos do Nivel %d: \n",num);
			PrintNivel(Tree.Raiz,num);
			printf("\n");
			break;

		case 5:
			system("clear");
			printf("\nBuscar...\n");
			if(Tree.Raiz!=NULL){
				Listar(Tree.Raiz,Tree.Raiz->level);
			}
			printf("\nDigite o Número para Buscar na Arvore:\n");
			scanf("%d",&num);
			if(Buscar(num,&Tree)==1)
				printf("\n True \n");
			else
				printf("\n False \n");
			break;

		case 6:
			system("clear");
			printf("\n# =Raiz / [] =Nodo Preto / () =Nodo Vermelho \n");
			printf("\nListar Elementos...\n\n");
			if(Tree.Raiz!=NULL)
			Listar(Tree.Raiz,Tree.Raiz->level);
			break;
		case 7:
			system("clear");
			printf("\nNova Árvore Rubro-Negra Criada, Respeita as Propriedades?\n");
			if(Tree.Raiz==NULL){
				printf("\nÁrvore Vazia\n");
			}else{
				if (Verificar_Propriedades(&Tree)==1){
					printf("\nTrue\n");
				}else{
					printf("\nFalse\n");
				}
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
