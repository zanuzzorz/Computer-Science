/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados I
@Autor: Ricardo Zanuzzo
*/

/*
----------------------------------------------------------------------------------------------------------------------------
Struct das Funções
----------------------------------------------------------------------------------------------------------------------------
*/

typedef struct{ // Struct para Armazenar as informações dos Usuarios
	int ID;
	char nome[40];
}info;

typedef struct SN{// Struct para Armazenar as informações dos Nodos de uma Lista duplamente Encadeada
	info SDados;
	struct SN *Proximo;
	struct SN *Anterior;
}SNodo;

typedef struct {// Struct para Armazenar as informações da Lista duplamente Encadeada
	unsigned int TamanhoLista;
	SNodo *FirstNodo;
	SNodo *LastNodo;
}SLista;

/*
----------------------------------------------------------------------------------------------------------------------------
Prototipos das Funções
----------------------------------------------------------------------------------------------------------------------------
*/

//Função que Insere  um novo Cadastro na lista
void Insere(SLista *pLista, SNodo *pNodo, unsigned int Cod);

//Função que Remove  um Cadastro da lista
void Remove(SLista *pLista, int Cod);

//Função que Reseta a Lista, colocando seus valores Nulos.
void Reset(SLista *pLista);

//Função que Lista  os Cadastro Armazenados na lista
void Imprime(SLista *pLista);

//Função que faz a Intercalação de 2 Listas dupamente encadeadas, criando uma 3ª lista com seus cadastros. 
bool Merge(SLista *pListaUm, SLista *pListaDois,SLista *pListaM);

//Função que Apaga todos Cadastro da lista
void Clear(SLista *pLista);
