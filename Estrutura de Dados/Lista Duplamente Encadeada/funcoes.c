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

void Insere(SLista *pLista, SNodo *pNodo, unsigned int Cod){
	unsigned int num;
	SNodo *pAtual, *pAnterior;

	if(pLista->FirstNodo==NULL){ //verificar se a  Lista esta Vazio 
		if(Cod<=0){
			printf("\nCódigo Invalido!\n");
			return;
		}
		pLista->FirstNodo=pNodo;
		pLista->LastNodo=pNodo;
		pNodo->Proximo=NULL;
		pNodo->Anterior=NULL;
		pLista->TamanhoLista++;
		printf("\n Primeiro Elemento Cadastrado com Sucesso! \n");
		return;
	}
	pAtual=pLista->FirstNodo;
	for(num=0;num< pLista->TamanhoLista || pAtual!=NULL;num++){
		if(Cod==pAtual->SDados.ID){
			printf("\n Código: %d já Existe na Lista!\n",pAtual->SDados.ID);
			free(pNodo);
			return;
		}
		if(Cod< pAtual->SDados.ID){ //Caso o Codigo Inserido seja Menor que o Existente Atualmente na Lista.
			pAnterior=pAtual->Anterior;
			pNodo->Anterior=pAtual->Anterior;
			pNodo->Proximo=pAtual;

			if(pAnterior==NULL){//A lista não esta Vazia mas o Elemento nº 1 não foi Alocado ainda
		  		pLista->FirstNodo=pNodo;
		  		pAtual->Anterior=pNodo;
		  		printf("\n Código: %d Armazenado com Sucesso!\n",Cod);
		  		pLista->TamanhoLista++;
	  			return;
			}else{//A lista não esta Vazio e o Elemento não é o 1º a ser inserido
	 			pAnterior->Proximo=pNodo;
	 			pAtual->Anterior=pNodo;
	 			printf("\n Código: %d Armazenado com Sucesso!!\n",Cod);
				 pLista->TamanhoLista++;
				 return;
			}
		}else{
			pAtual=pAtual->Proximo;//Contiará percorrendo a lista. 
		}
	}
	pAnterior=pLista->LastNodo;
	pAnterior->Proximo=pNodo;
	pNodo->Proximo=NULL;
	pNodo->Anterior=pAnterior;
	pLista->LastNodo=pNodo;
	printf("\n Código: %d Armazenado com Sucesso!!!",Cod);
	printf("\n E Atualmente é o Ultimo Código da Lista!\n");
	pLista->TamanhoLista++;
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
	for(num=1;num<= pLista->TamanhoLista || pAtual==NULL;num++){//Fara um Laço para percorrer a Lista.
		if(pAtual->SDados.ID==Cod){//Quando Encontrar o Codigo Selecionado para Remover fara as Verficações para a Remoção.
			pProximo=pAtual->Proximo;

			if(pLista->FirstNodo==pLista->LastNodo){//Quando haver somente 1 Elemento da Lista, fara um Reset na Lista para torna-la Nula. 
			  	printf("\nFoi Removido o Unico Elemento Existente,a Lista ficara vazia! \n");
			  	Reset(pLista);
			  	break;
			}else if(pAtual->Anterior==NULL && pAtual->Proximo!=NULL){ // Remover o 1º Elemento de uma Lista com mais de 1 Elemento
				printf("\nO Primeiro Elemento da Lista, Código %d Foi Removido\n!",Cod);
			  	pProximo->Anterior=NULL;
				  pLista->FirstNodo=pProximo;
				  pLista->TamanhoLista--;
				  break;
			}
			if(pAtual->Anterior!=NULL && pAtual->Proximo==NULL){// Remover o Ultimo Elemento de uma Lista com mais de 1 Elemento 
				  printf("\nO Ultimo Elemento da Lista, Código %d Foi Removido\n!",Cod);
				  pAnterior=pAtual->Anterior;
				  pAnterior->Proximo=NULL;
				  pLista->LastNodo=pAnterior;
				  pLista->TamanhoLista--;
				  break;
			}else{//Remover um Nó no meio de outros Nós.
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
				return;
			}
		}
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
		printf("\nID: %d\nNome: %s\n",tmp->SDados.ID,tmp->SDados.nome);
		tmp=tmp->Proximo;
	}
	return;
}

bool Merge(SLista *pListaUm, SLista *pListaDois,SLista *pListaM){
	unsigned int cont;
      	SNodo *pL1,*pL2,*pNodo=NULL,*pAtual=NULL,*pAnterior=NULL;

      	pL1=pListaUm->FirstNodo;
      	pL2=pListaDois->FirstNodo;
	      
	if(pListaUm->FirstNodo==NULL && pListaDois->FirstNodo==NULL){//Caso as duas Listas estejam vazias
		printf("\nAtenção: As duas Listas estão Vazias!\n");
		free(pNodo);
		return 0;
	}
      	if(pListaDois->FirstNodo==NULL && pListaUm->FirstNodo!=NULL){//Se Lista 2 for vazia e Lista1 Não	
 	 	for(cont=0;cont<pListaUm->TamanhoLista;cont++){
  			pNodo=(SNodo*)malloc(sizeof(SNodo));
  			*pNodo=*pL1;
  			if(cont==0){
			  pListaM->FirstNodo=pNodo;
			  pNodo->Proximo=NULL;
			  pNodo->Anterior=NULL;	    
  			}else{
			    pNodo->Anterior=pAnterior;
			    pNodo->Proximo=pAnterior->Proximo;
			    pAnterior->Proximo=pNodo;
		  	}
			pAnterior=pNodo;
			pListaM->LastNodo=pNodo;
			pListaM->TamanhoLista++;
			pL1=pL1->Proximo;
		}
		
	printf("\nA Lista 2 esta Vazia, a Nova Lista receberá o Valor da Lista 1! \n");
	return 1;

	}else if(pListaDois->FirstNodo!=NULL && pListaUm->FirstNodo==NULL){//Se Lista 1 for vazia e Lista2 Não	    
		for(cont=0;cont<pListaDois->TamanhoLista;cont++){
		    pNodo=(SNodo*)malloc(sizeof(SNodo));
		    *pNodo=*pL2;
			if(cont==0){
			      pListaM->FirstNodo=pNodo;
			      pNodo->Proximo=NULL;
			      pNodo->Anterior=NULL;	      
	 		}else{
				pNodo->Anterior=pAnterior;
				pNodo->Proximo=pAnterior->Proximo;
				pAnterior->Proximo=pNodo;
      			}
		      pAnterior=pNodo;
		      pListaM->LastNodo=pNodo;
		      pListaM->TamanhoLista++;
    		}
    		printf("\nA Lista 1 esta Vazia, a Nova Lista receberá o Valor da Lista 2! \n");
		return 1;

	}else{//Se as Duas Listas Não Estiverem vazias

		for(cont=0;cont<pListaUm->TamanhoLista;cont++){ //o For é usado para Copiar a Lista 1 para a lista Merge.
			pNodo=(SNodo*)malloc(sizeof(SNodo));
			*pNodo=*pL1;
			if(cont==0){ //Se for a primeira cópia, vai ser o 1º indice.
				pListaM->FirstNodo=pNodo; //Primeiro nodo vai ser o proprio nodo
				pListaM->LastNodo=pNodo;
				pAtual=pListaM->FirstNodo;
				pAnterior=pAtual;
				pAnterior->Proximo=NULL; 
				pAnterior->Anterior=NULL; 

			}else{ //caso não seja a primeira
				pAnterior->Proximo=pNodo; 
				pAtual=pNodo;
				pAtual->Anterior=pAnterior;
				pAtual=pAtual->Proximo;
				pAnterior=pAnterior->Proximo;
				pListaM->LastNodo=pNodo; //atualiza o ultimo nó.
			}
			pListaM->TamanhoLista++;
			pL1=pL1->Proximo;
		}
  
		pAtual=pListaM->FirstNodo;
		pL2=pListaDois->FirstNodo;
      		for(cont=0;cont< pListaDois->TamanhoLista && pL2!=NULL;){ //copia a 2ª lista e ordena 
			pNodo=(SNodo*)malloc(sizeof(SNodo));
			*pNodo=*pL2;
			if(pNodo->SDados.ID == pAtual->SDados.ID){//Se o ID da Lista 1 for Igual ao da Lista 2
				cont++;//Incrementa a variavel Cont
				pL2=pL2->Proximo;//Avança de Nodo
			}else if(pNodo->SDados.ID < pAtual->SDados.ID){ // se o ID for menor que o Atual.
				if(pAtual->Anterior==NULL){ //primeiro da lista.
					pAtual->Anterior=pNodo;
					pNodo->Proximo=pAtual;
					pListaM->FirstNodo=pNodo;
					pNodo->Anterior=NULL;
					pListaM->TamanhoLista++;	    
					pL2=pL2->Proximo;
					cont++;
	  			}else{ //Não é o primeiro nem o último elemento.
					pAnterior=pAtual->Anterior;
					pAnterior->Proximo=pNodo;
					pNodo->Proximo=pAtual;
					pNodo->Anterior=pAnterior;
					pAtual->Anterior=pNodo;
					pListaM->TamanhoLista++;
					pL2=pL2->Proximo;
					cont++;
				}
	  
			}else if (pNodo->SDados.ID > pAtual->SDados.ID){ // se for maior
				if(pAtual->Proximo==NULL){ //Se for o último, Atualiza o novo Ultimo
					pAtual->Proximo=pNodo;
					pNodo->Anterior=pAtual;
					pNodo->Proximo=NULL;
					pListaM->TamanhoLista++;
					pListaM->LastNodo=pNodo;
					pL2=pL2->Proximo;
					cont++;
				}else{
				pAtual=pAtual->Proximo;
				}
			}
    		}    
 		printf("\nMerge estre a Lista 1 e 2 Realizado com Sucesso!\n");
		return 1;
	}
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
	printf("\nLista foi Limpa com Sucesso!\n");
	return;
}
