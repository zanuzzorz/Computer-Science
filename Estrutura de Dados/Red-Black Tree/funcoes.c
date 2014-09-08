/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados II
@Autor: Ricardo Zanuzzo
*/
#include<stdio.h>
#include<stdlib.h>
#include <stdbool.h>
#include "funcoes.h"

void Reset(STree *T){
	T->Raiz=NULL;
	return;
}

no *ExisteVo(no *n) {
	if (n!=NULL){
    		if (n->Pai != NULL){ 
    			if (n->Pai->Pai != NULL){ 
    				return n->Pai->Pai;
			}
		}
	}
	return NULL;
}

no *Irmao(no *n) {
	if (n != NULL){
    		if (n->Pai != NULL){ 
    			if (n == n->Pai->Esq){
        			return n->Pai->Dir;
    			}else{
        			return n->Pai->Esq;
			}
		}
	}
	return NULL;
}
no *Tio(no *n) {
	if (n != NULL){
    		if (n->Pai != NULL){ 
    			if (n->Pai->Pai != NULL){ 
    				return Irmao(n->Pai);
			}
		}
	}
	return NULL;
}

int NoCor(no *n) { //Esta Função é aplicada para sempre tratar NULL como preto.    
	return n == NULL ? 0 : n->cor;
}
void Inserir(STree *T,no *pN,int elemento){
	no *Aux;
	
	if(T->Raiz == NULL){
		pN->Dir = pN->Esq = pN->Pai= NULL;
		pN->cor=BLACK;
		T->Raiz=pN;
    	}else{
		if(Buscar(elemento,T)==true){
			printf("\n Elemento Já Cadastrado \n");
			return;
		}
		Aux = T->Raiz;
		while(Aux!=NULL){ 
			if(elemento < Aux->valor){ 
				if (Aux->Esq == NULL) {
					Aux->Esq = pN;
					break;
				}else{
					Aux = Aux->Esq;
				} 
			}else if(elemento > Aux->valor){ 
				if (Aux->Dir == NULL) {
					Aux->Dir = pN;
					break;
				}else{
					Aux = Aux->Dir;
				}
			}
		}
        pN->Pai = Aux;
	}
    	InserirCaso1(T,pN);
	AjustarLevel(T->Raiz);
	Verificar_Propriedades(T);
    	return;
}

void InserirCaso1(STree *t, no *n) {
    if (n->Pai == NULL)
        n->cor = BLACK;
    else
        InserirCaso2(t, n);
}
void InserirCaso2(STree *t, no *n) {
    if (NoCor(n->Pai) == BLACK)
        return; 
    else
        InserirCaso3(t, n);
}
void InserirCaso3(STree *t, no *n) {
    if (NoCor(Tio(n)) == RED) {
        n->Pai->cor = BLACK;
        Tio(n)->cor = BLACK;
        ExisteVo(n)->cor = RED;
        InserirCaso1(t, ExisteVo(n));
    } else {
        InserirCaso4(t, n);
    }
}
void InserirCaso4(STree *t, no *n) {
    if (n == n->Pai->Dir && n->Pai == ExisteVo(n)->Esq) {
        Lrotate(t, n->Pai);
        n = n->Esq;
    } else if (n == n->Pai->Esq && n->Pai == ExisteVo(n)->Dir) {
        Rrotate(t, n->Pai);
        n = n->Dir;
    }
    InserirCaso5(t, n);
}
void InserirCaso5(STree *t, no *n) {
    n->Pai->cor = BLACK;
    ExisteVo(n)->cor = RED;
    if (n == n->Pai->Esq && n->Pai == ExisteVo(n)->Esq) {
        Rrotate(t, ExisteVo(n));
    } else {
        if (n == n->Pai->Dir && n->Pai == ExisteVo(n)->Dir)
        Lrotate(t, ExisteVo(n));
    }
    t->Raiz->cor=BLACK;
}

void AjustarLevel(no *n){
	if(n==NULL)return;
	if(n->Pai==NULL){
		n->level=0;
	}else{
		n->level = n->Pai->level+1;
	}
	AjustarLevel(n->Esq);
	AjustarLevel(n->Dir);
}


void Lrotate(STree *T, no *pN){
	no *R;
	R = pN->Dir;
    SubstituirNo(T, pN, R);
    pN->Dir = R->Esq;
    if (R->Esq != NULL) {
        R->Esq->Pai = pN;
    }
    R->Esq = pN;
    pN->Pai = R;
}
void Rrotate(STree *T, no *pN){

    no *L; 
	L = pN->Esq;
    SubstituirNo(T, pN, L);
    pN->Esq = L->Dir;
    if (L->Dir != NULL) {
        L->Dir->Pai = pN;
    }
    L->Dir = pN;
    pN->Pai = L;
}

void SubstituirNo(STree *T, no *oldn, no *newn){
	
    if (oldn->Pai == NULL) {
        T->Raiz = newn;
    }else{
        if (oldn == oldn->Pai->Esq){
            oldn->Pai->Esq = newn;
        }else{
            oldn->Pai->Dir = newn;
		}
	}
    if (newn != NULL) {
        newn->Pai = oldn->Pai;
    }
}

bool Buscar(int K,STree *T){
	no *pAtual; 
	pAtual=T->Raiz; 
	
	if (T->Raiz==NULL){
        	return false;
    	}
	while(pAtual!=NULL){ 
		if(K == pAtual->valor){ 
			return true; 
		} 
		if(K<pAtual->valor){ 
			pAtual=pAtual->Esq; 
		}else if(K>pAtual->valor){ 
			pAtual=pAtual->Dir; 
		}
 
	} 
	return false;
}

no *RetornaNo(STree *t, int key) {
	no *n = t->Raiz;

	if (Buscar(key,t) == true) {
		while(n!=NULL){ 
			if(key == n->valor){ 
				return n; 
		} 
		if(key < n->valor){ 
			n=n->Esq; 
		}else if(key > n->valor){ 
			n=n->Dir; 
		} 
	} 
    	}else{
		printf("\n Número Digitado não Existe na Árvore!\n");
		return n=NULL;
	}
    	return n;
}

void Remover(STree *t, int valor){
	no *filho;
	no *n = RetornaNo(t, valor); //Retorna Nó que sera Removido
	
	
	if (n == NULL) return;
	if (n->Esq != NULL && n->Dir != NULL) {
		 no *pred = MaiorNo(n->Esq); //Predecessor
		 n->valor   = pred->valor;
		 n = pred;
	}

	if(n->Esq == NULL || n->Dir == NULL)
		filho = n->Dir == NULL ? n->Esq  : n->Dir;
	if (NoCor(n) == BLACK) {
	 	n->cor = NoCor(filho);
	 	RemoveCaso1(t, n);
	}	
	SubstituirNo(t, n, filho);
	free(n);
	AjustarLevel(t->Raiz);
	if(t->Raiz!=NULL){
		t->Raiz->cor=BLACK;
	}
	Verificar_Propriedades(t);
}

no *MaiorNo(no *n) {
    if (n != NULL)
    while (n->Dir != NULL) {
        n = n->Dir;
    }
    return n;
}

void RemoveCaso1(STree *t, no *n) {
    if (n->Pai == NULL)
        return;
    else
        RemoveCaso2(t, n);
}

void RemoveCaso2(STree *t, no *n) {
	if (NoCor(Irmao(n)) == RED) {
        	n->Pai->cor= RED;
        	Irmao(n)->cor= BLACK;
        	if (n == n->Pai->Esq){
            		Lrotate(t, n->Pai);
        	}else{
            		Rrotate(t, n->Pai);
    		}
    	}
    	RemoveCaso3(t, n);
}

void RemoveCaso3(STree *t, no *n) {
	if (NoCor(n->Pai) == BLACK &&
	    NoCor(Irmao(n)) == BLACK &&
	    NoCor(Irmao(n)->Esq) == BLACK &&
	    NoCor(Irmao(n)->Dir) == BLACK){
		Irmao(n)->cor= RED;
		RemoveCaso1(t, n->Pai);
    	}else{
		RemoveCaso4(t, n);
	
	}
}

void RemoveCaso4(STree *t, no *n) {
	if (NoCor(n->Pai) == RED &&
	    NoCor(Irmao(n)) == BLACK &&
	    NoCor(Irmao(n)->Esq) == BLACK &&
	    NoCor(Irmao(n)->Dir) == BLACK){
		Irmao(n)->cor= RED;
		n->Pai->cor= BLACK;
    	}else{
        	RemoveCaso5(t, n);
	}
}

void RemoveCaso5(STree *t, no *n) {
    	if (n == n->Pai->Esq &&
	    NoCor(Irmao(n)) == BLACK &&
	    NoCor(Irmao(n)->Esq) == RED &&
	    NoCor(Irmao(n)->Dir) == BLACK){
	    Irmao(n)->cor= RED;
		Irmao(n)->Esq->cor= BLACK;
		Rrotate(t, Irmao(n));
    	}else if (n == n->Pai->Dir &&
             	  NoCor(Irmao(n)) == BLACK &&
                  NoCor(Irmao(n)->Dir) == RED &&
                  NoCor(Irmao(n)->Esq) == BLACK){
        		Irmao(n)->cor= RED;
        		Irmao(n)->Dir->cor= BLACK;
        		Lrotate(t, Irmao(n));
    	}
    	RemoveCaso6(t, n);
}

void RemoveCaso6(STree *t, no *n) {
    Irmao(n)->cor = NoCor(n->Pai);
    n->Pai->cor= BLACK;
    if (n == n->Pai->Esq) {
        if (NoCor(Irmao(n)->Dir) == RED)
        	Irmao(n)->Dir->cor= BLACK;
        	Lrotate(t, n->Pai);
    }else{
        if (NoCor(Irmao(n)->Esq) == RED)
        	Irmao(n)->Esq->cor= BLACK;
       	 	Rrotate(t, n->Pai);
    }
}

bool Verificar_Propriedades(STree *t) {
	if (Verificar_Propriedade_1(t->Raiz) == true){
		if (Verificar_Propriedade_2(t->Raiz) == true){
			if (Verificar_Propriedade_3(t->Raiz) == true){
				if (Verificar_Propriedade_4(t->Raiz) == true){
					return true;
				}
			}
		}
	}
	return false;
}
bool Verificar_Propriedade_1(no *n) {            
	if(NoCor(n) == RED || NoCor(n) == BLACK);
	if (n == NULL) return true;

	if (Verificar_Propriedade_1(n->Esq)== true){
		if (Verificar_Propriedade_1(n->Dir)== true){
			return true;
		}
	}
	return false;
}

bool Verificar_Propriedade_2(no *Raiz) {    
    	if(NoCor(Raiz) == BLACK){
		return true;
    	}
	return false;	
}
bool Verificar_Propriedade_3(no *n) {
	bool b1,b2,b3;


	if (n == NULL) return true;

	if (NoCor(n) == RED)
	if (NoCor(n->Esq)   == BLACK)
	if (NoCor(n->Dir)  == BLACK)
	if (NoCor(n->Pai) == BLACK)
		b1 = true;

	b2 = Verificar_Propriedade_3(n->Esq);
	b3 = Verificar_Propriedade_3(n->Dir);
	
	if(b1==true && b2==true && b3==true){
		return true;
	}
	return false;
}

bool Verificar_Propriedade_4(no *Raiz) {
	int Contar_Nos_Pretos = -1;
	if (Verificar_Propriedade_4_Salvar(Raiz, 0, &Contar_Nos_Pretos)== true){
		return true;
	}
	return false;	
}

bool Verificar_Propriedade_4_Salvar(no *n, int numPretos, int *pContNosPretos){
	if (NoCor(n) == BLACK) {
		numPretos++;
	}
	if (n == NULL) {
		if (*pContNosPretos == -1) {
		    	*pContNosPretos = numPretos;
		}else{
		    	if (numPretos == *pContNosPretos);
		}
		return true;
	}
	if(Verificar_Propriedade_4_Salvar(n->Esq,  numPretos, pContNosPretos)==true){
		if(Verificar_Propriedade_4_Salvar(n->Dir, numPretos, pContNosPretos)==true){
			return true;
		}
	}
	return false;
}

void Imprimir(STree *T,no *Nodo){ 
		
	if(Nodo!= NULL){
		Listar(Nodo,Nodo->level);
		Imprimir(T,Nodo->Esq); 
		Imprimir(T,Nodo->Dir); 
	}  
	return; 
}

void Listar(no *p, int nivel){
	int i;

	if(p==NULL)return;
  
	Listar(p->Dir, nivel+1);
	for(i=0;i<nivel;i++){
		if(p->level != -1){
			printf("     ");
		}
	}
  	if(p->Pai==NULL){
		printf("#");
	}
	if(p->cor == BLACK && p->level != -1){
		printf("[%d]\n\n",p->valor);
	}else if(p->cor == RED && p->level != -1){
		printf("(%d)\n\n",p->valor);
	}
	Listar(p->Esq,nivel+1);
}

void PrintNivel(no *p, int nivel){
 	 if(p == NULL){
    		return;
  	}
	if(p->level == nivel){
		if(p->cor==BLACK){
			printf("[%d]  ",p->valor);
		}else{
			printf("(%d)  ",p->valor);
		}
		
	}
	PrintNivel(p->Esq,nivel);
	PrintNivel(p->Dir,nivel);
	return;
}

void EmOrdem(no *Nodo){
	if(Nodo == NULL)
    	return;
	EmOrdem(Nodo->Esq);
	if(Nodo->cor==BLACK){
		printf(" %d ",Nodo->valor);
	}else{
		printf(" %d ",Nodo->valor);
	}
	EmOrdem(Nodo->Dir);
}
