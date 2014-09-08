/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados I
@Autor: Ricardo Zanuzzo
*/

#include<stdio.h>
#include<stdlib.h>
#include <stdbool.h>
#include "funcoes.h"

/*
----------------------------------------------------------------------------------------------------------------------------
Aplicação das Funções
----------------------------------------------------------------------------------------------------------------------------
*/

void Insere(SLista *pLista, SNodo *pNodo){
	SNodo *pAtual;

	if(pLista==NULL){ //verificar se a  Lista esta Vazio 
		printf("\nLista Vazia\n");
		return;
	
	}else if(pLista->FirstNodo==NULL){//1º Elemento
		pLista->FirstNodo=pNodo;
		pLista->LastNodo=pNodo;
		pAtual=pLista->FirstNodo;
		pAtual->Proximo=NULL;
		pAtual->Anterior=NULL;
		pLista->TamanhoLista++;
		printf("\n Primeiro Elemento Cadastrado com Sucesso! \n");
		return;
	}else{
		pNodo->Anterior=pLista->LastNodo;
		pLista->LastNodo->Proximo=pNodo;
		pLista->LastNodo=pNodo;
		pNodo->Proximo=NULL;
		printf("\n Cadastro Efetuado com Sucesso!\n");
		pLista->TamanhoLista++;
		return;
	}
	return;
}
void Remove(SLista *pLista, int Cod){
	unsigned int num;
	SNodo *pAtual, *pAnterior, *pProximo;

	if(pLista->FirstNodo==NULL){ //Verifica se a Lista esta Vazia
		printf("\nA Lista esta Vazia!\n");
		return;
	}
	pAtual=pLista->FirstNodo;
	for(num=0;num<= pLista->TamanhoLista || pAtual==NULL;num++){//Fara um Laço para percorrer a Lista.
		if(pAtual->SDados.ID==Cod){//Inicia as Verficações para a Remoção do codigo selecionado.
			pProximo=pAtual->Proximo;
			if(pLista->FirstNodo==pLista->LastNodo){
			//Quando haver somente 1 Elemento da Lista, fara um Reset na Lista para torna-la Nula. 
			  	printf("\nFoi Removido o Unico Elemento Existente,a Lista ficara vazia! \n");
			  	Reset(pLista);
			  	return;
			}else if(pLista->FirstNodo->SDados.ID==Cod && pAtual->Proximo!=NULL){ 
			// Remover o 1º Elemento de uma Lista com mais de 1 Elemento
				printf("\nO Primeiro Elemento da Lista, Código %d Foi Removido\n!",Cod);
	  			pAtual=NULL;
				pLista->FirstNodo=pProximo;
				pLista->TamanhoLista--;
				break;
			}
			if(pLista->LastNodo->SDados.ID==Cod && pAtual->Proximo==NULL){
			// Remover o Ultimo Elemento de uma Lista com mais de 1 Elemento 
			  	printf("\nO Ultimo Elemento da Lista, Código %d Foi Removido\n!",Cod);
			    	pAtual=pLista->LastNodo;
				printf("\n1\n");
				pLista->LastNodo=pLista->LastNodo->Anterior;
				printf("\n4\n");
				pLista->LastNodo->Proximo=NULL;
				printf("\n5\n");
			  	pLista->TamanhoLista--;
			  	break;
			}else{//Remover um Nodo no pivo de outros Nodos.
				pAnterior=pAtual->Anterior;
				pProximo=pAtual->Proximo;
				pProximo->Anterior=pAnterior;
				pAnterior->Proximo=pProximo;
			  	pLista->TamanhoLista--;
			  	printf("\nCódigo %d Removido com Sucesso! \n",Cod);
			  	break;
			}
			}else{
				pAtual=pAtual->Proximo;
				if(pAtual==NULL){
				printf("\nID não Registrada na Lista!\n");
				break	;
			}
		}
	}	
	printf("\n6\n");
	if(pLista->TamanhoLista==0){
		Reset(pLista);
	}
	free(pAtual);
}


void Reset(SLista *pLista){
	pLista->FirstNodo=NULL;
	pLista->LastNodo=NULL;
	pLista->TamanhoLista=0;
	return;
}

void Imprime(SLista *pLista){
	system("clear");
	unsigned int cont;
	SNodo *tmp; //Percorre a Lista

	tmp=pLista->FirstNodo;
	if(tmp==NULL){
		printf("\nLista esta Vazia !\n");
		return;
	}
		printf("\nListando....\n");
	for(cont=0;cont<pLista->TamanhoLista;cont++){
		printf("\nID: %d\n",tmp->SDados.ID);
		tmp=tmp->Proximo;
	}
	return;
}

void Clear(SLista *pLista){
	SNodo *pNodo,*pAtual;
	unsigned int cont;

	pAtual=pLista->FirstNodo;
	if(pLista->FirstNodo==NULL){
		printf("\nA lista esta Vazia!\n");
		return;
	}
	for(cont=0;cont < pLista->TamanhoLista || pAtual !=NULL;cont++){//Percorre a lista
		pNodo=pAtual->Proximo;
		free(pAtual);//Limpa o conteudo do nodo
		pAtual=pNodo;
		pLista->TamanhoLista--;
	}
	Reset(pLista);
	printf("Lista foi Limpa com Sucesso!\n");
	return;
}

bool CopiaLista(SLista *LOrigem, SLista *LDestino){
	int cont,tamanho;
   	SNodo *pO; //Nodo para percorrer a lista
    	SNodo *pD;//Nodo auxiliar
	
	pO=LOrigem->FirstNodo;
	tamanho=LOrigem->TamanhoLista;
	if(LOrigem->FirstNodo==NULL){ //verificar se a  Lista esta Vazio 
		return 0;
	}   
    	for(cont=0;cont<LOrigem->TamanhoLista;cont++){//Percorre toda a lista
		pO=(SNodo*)malloc(sizeof(SNodo));
        	Insere(LDestino,pO);//Insere na lista Destino o valor contido na Lista Origem
       	 	pO=pO->Proximo;//Avança para o proximo Nodo
    	}
   
    	pD=LDestino->FirstNodo;
    	pO=LOrigem->FirstNodo;
   
    	for(cont=0;cont<LOrigem->TamanhoLista;cont++){//Percorre toda a lista
        	pD->SDados.ID=pO->SDados.ID; //atribui o Valor do ID da origem para o destino
        	pO=pO->Proximo;// avança para o proximo Nodo de origem
        	pD=pD->Proximo;//avança para o proximo Nodo de destino
    	}
	LDestino->TamanhoLista=tamanho;
	return 1; 	
}

bool InsertionSort(SLista *pLista, int tamanho){
	int temp;	
	SNodo *pI,*pJ,*pAtual,*pProximo;
	

	if(pLista->FirstNodo==NULL){ //verificar se a  Lista esta Vazio 
		printf("\nLista Vazia\n");
		return 0;
	}else if(pLista->FirstNodo->Proximo==NULL){//verificar se tem apenas 1 elemento na Lista
		printf("\nA Lista Contem Apenas 1 ID, Lista já Ordenada!\n");
		return 0;
	}else{
				
		for(pJ=pLista->FirstNodo->Proximo;pJ!=NULL;pJ=pJ->Proximo){//Laço para percorrer a lista
			temp=pJ->SDados.ID;
			pI=pJ->Anterior;				//O nodo pI vai representar do item da esquerda do pJ
			pAtual=pI->Proximo;				//O nodo pAtual vai receber o proximo item do PI 
			while(pI!=NULL && pI->SDados.ID > temp){  
				pProximo=pI->Proximo;	       
				pProximo->SDados.ID = pI->SDados.ID;
				if(pI==pLista->FirstNodo){
					pAtual=pI;
					pI=NULL;
				}else{
					pI=pI->Anterior;
					pAtual=pI->Proximo;
				}
			}
			pAtual->SDados.ID = temp;
			if(pJ->Proximo == NULL){
				printf("\nIsertionSort: Ordenação Realizada com Sucesso!\n");
				return 1;
			}
		}
	}
	return 0; 
} 

bool QuickSort(SLista *pLista, int inicio, int fim){
	int cont,pivo,temp,i,j;
	pivo=temp=0;
	SNodo *pI,*pJ,*pPivo,*aux;
 	
   	i=inicio;
	j=fim;
	pivo = fim;	
	if(pLista->FirstNodo==NULL){ //verificar se a  Lista esta Vazio 
		printf("\nLista Vazia\n");
		return 0;
	}
	if(pLista->FirstNodo->Proximo==NULL){//verificar se tem apenas 1 elemento na Lista
		printf("\nA Lista Contem Apenas 1 ID, Lista já Ordenada!\n");
		return 0;
	}
	for(cont=0,pI=pLista->FirstNodo;cont<inicio;){//Encontra a Posição do pI.
		pI=pI->Proximo;
		cont++;
	}
	for(cont=0,pJ=pLista->FirstNodo;cont<fim;){//Encontra a Posição do pJ.
		pJ=pJ->Proximo;
		cont++;
	}
	for(cont=0,aux=pLista->FirstNodo;cont<=pivo;cont++,aux=aux->Proximo){//Encontra valor que esta posição do pivo.
		pPivo=aux;				
		pPivo->SDados.ID=aux->SDados.ID;
	}	
   	do{
	      	while(pI->SDados.ID < pPivo->SDados.ID){
			pI=pI->Proximo;
			i++;
		}
	      	while(pJ->SDados.ID > pPivo->SDados.ID){
			pJ=pJ->Anterior;
			j--;
		}
	      	if(i <= j ){
			temp = pI->SDados.ID;
			pI->SDados.ID = pJ->SDados.ID;
			pJ->SDados.ID = temp;
			pI=pI->Proximo;
			pJ=pJ->Anterior;
			i++;
			j--;
	      	}
   	}while(i <= j);

   	if(inicio < j){
      		QuickSort(pLista, inicio, j);
   	}
	if(i < fim){
		QuickSort(pLista, i, fim);		      	
	}
	printf("\nQuickSort: Ordenação Realizada com Sucesso!\n");
	return 1;
}
