/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados II
@Autor: Ricardo Zanuzzo
*/

// IMPLEMENTAÇÃO DA ÁRVORE B +  EM C.

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
 
// Ordem Default será 4.
#define ORDEM_PADRAO 4
 
// Mínimo 3 e Máximo 20.
// Ordem arbitrária.
#define MIN_ORDEM 3
#define MAX_ORDEM 20
 
// Structs
typedef struct registro {
    int valor;
}registro;
 
 
typedef struct nodo{
    void ** ponteiros;
    int * chaves;
    struct nodo * pai;
    bool folha;
    int num_chaves;
    struct nodo * proximo;
}nodo;
 
 
int ordem = ORDEM_PADRAO;
nodo * queue = NULL;
bool verbose_output = false;
 
// Prototipos das Funções.
 
void mensagem_1( void );
void mensagem_2( void );
void mensagem_3( void );
void enqueue( nodo * nodovo_nodo );
nodo * dequeue( void );
int height( nodo * raiz );
int path_to_raiz(nodo *raiz, nodo * filho );
void imprimir_level (nodo* raiz );
void display( nodo * raiz );
void encontrar_imprimir(nodo * raiz, int Chave, bool verbose);
void encontrar_imprimir_range(nodo * raiz, int range1, int range2, bool verbose);
int encontrar_range( nodo * raiz, int Chave_start, int Chave_end, bool verbose,
int returned_chaves[], void * returned_ponteiros[]);
nodo * encontrar_Folha( nodo * raiz, int Chave, bool verbose );
registro * encontrar(nodo * raiz, int Chave, bool verbose);
bool Buscar(nodo * raiz, int Chave, bool verbose);
int cut( int length );

 
// INSERÇÃO.
registro * make_registro(int valor);
nodo * make_nodo( void );
nodo * make_Folha( void );
int get_left_index(nodo * pai, nodo * left);
nodo * inserir_into_Folha( nodo * Folha, int Chave, registro * pointer );
nodo * inserir_into_Folha_after_divisaoting(nodo * raiz, nodo * Folha, int Chave, registro * pointer);
nodo * inserir_into_nodo(nodo * raiz, nodo * pai,
        int left_index, int Chave, nodo * right);
nodo * inserir_nodo_apos_divisao(nodo * raiz, nodo * pai, int left_index,
        int Chave, nodo * right);
nodo * inserir_nodo_pai(nodo * raiz, nodo * left, int Chave, nodo * right);
nodo * inserir_na_nova_raiz(nodo * left, int Chave, nodo * right);
nodo * iniciar_nova_arvore(int Chave, registro * pointer);
nodo * inserir( nodo * raiz, int Chave, int valor );
 
// Remover.
int obter_indice_vizinho( nodo * n );
nodo * ajusta_raiz(nodo * raiz);
nodo * merge_nodos(nodo * raiz, nodo * n, nodo * vizinho, int vizinho_index, int k_prime);
nodo * redistribuir_nodos(nodo * raiz, nodo * n, nodo * vizinho, int vizinho_index,
        int k_prime_index, int k_prime);
nodo * Remover_entrada( nodo * raiz, nodo * n, int Chave, void * pointer );
nodo * Remover( nodo * raiz, int Chave );
 
 
 
 
// FUNÇÕES
 
// Prints the bottom row of chaves of the tree (with their respective
// ponteiros, if the verbose_output flag is set.
void imprimir_level( nodo * raiz ) {
    int i;
    nodo * c = raiz;
    if (raiz == NULL) {
        printf("Árvore Vazia\n");
        return;
    }
    while (!c->folha)
        c = c->ponteiros[0];
    while (true) {
        for (i = 0; i < c->num_chaves; i++) {
            if (verbose_output)
                printf("%lx ", (unsigned long)c->ponteiros[i]);
            printf("%d ", c->chaves[i]);
        }
        if (verbose_output)
            printf("%lx ", (unsigned long)c->ponteiros[ordem - 1]);
        if (c->ponteiros[ordem - 1] != NULL) {
            printf(" | ");
            c = c->ponteiros[ordem - 1];
        }
        else
            break;
    }
    printf("\n");
}
 
 
// Função para retornar altura da árvore
int height( nodo * raiz ) {
    int h = 0;
    nodo * c = raiz;
    while (!c->folha) {
        c = c->ponteiros[0];
        h++;
    }
    return h;
}
 
 
// Função retorna o comprimento em Partes
int path_to_raiz( nodo * raiz, nodo * filho ) {
    int length = 0;
    nodo * c = filho;
    while (c != raiz) {
        c = c->pai;
        length++;
    }
    return length;
}
 
// A função de ajustamento para a impressão da árvore
void enqueue( nodo * nodovo_nodo ) {
    nodo * c;
    if (queue == NULL) {
        queue = nodovo_nodo;
        queue->proximo = NULL;
    }
    else {
        c = queue;
        while(c->proximo != NULL) {
            c = c->proximo;
        }
        c->proximo = nodovo_nodo;
        nodovo_nodo->proximo = NULL;
    }
}
 
// A função de ajustamento para a impressão da árvore
nodo * dequeue( void ) {
    nodo * n = queue;
    queue = queue->proximo;
    n->proximo = NULL;
    return n;
}
 
// Imprime a árvore na Ordem do nível de nodos. | | Símbolo é usado para separar os nodos
void display( nodo * raiz ) {
 
    nodo * n = NULL;
    int i = 0;
    int rank = 0;
    int nodovo_rank = 0;
 
    if (raiz == NULL) {
        printf("Árvore Vazia\n");
        return;
    }
    queue = NULL;
    enqueue(raiz);
    while( queue != NULL ) {
        n = dequeue();
        if (n->pai != NULL && n == n->pai->ponteiros[0]) {
            nodovo_rank = path_to_raiz( raiz, n );
            if (nodovo_rank != rank) {
                rank = nodovo_rank;
                printf("\n");
            }
        }
        if (verbose_output)
            printf("(%lx)", (unsigned long)n);
        for (i = 0; i < n->num_chaves; i++) {
            if (verbose_output)
                printf("%lx ", (unsigned long)n->ponteiros[i]);
            printf("%d ", n->chaves[i]);
        }
        if (!n->folha)
            for (i = 0; i <= n->num_chaves; i++)
                enqueue(n->ponteiros[i]);
        if (verbose_output) {
            if (n->folha)
                printf("%lx ", (unsigned long)n->ponteiros[ordem - 1]);
            else
                printf("%lx ", (unsigned long)n->ponteiros[n->num_chaves]);
        }
        printf("| ");
    }
    printf("\n");
}
 
 
// Encontra o Registro sob uma determinada chave e imprime uma Mensagem determinada
void encontrar_imprimir(nodo * raiz, int Chave, bool verbose) {
    registro * r = encontrar(raiz, Chave, verbose);
    if (r == NULL)
        printf("Registro da Chave Não Encontrado %d.\n", Chave);
    else
        printf("Registro em %lx -- Chave %d, valor %d.\n",
                (unsigned long)r, Chave, r->valor);
}
 
void encontrar_imprimir_range( nodo * raiz, int Chave_start, int Chave_end,
        bool verbose ) {
    int i;
    int array_size = Chave_end - Chave_start + 1;
    int returned_chaves[array_size];
    void * returned_ponteiros[array_size];
    int num_found = encontrar_range( raiz, Chave_start, Chave_end, verbose,
            returned_chaves, returned_ponteiros );
    if (!num_found)
        printf("Nenhum Encontrado\n");
    else {
        for (i = 0; i < num_found; i++)
            printf("Chave: %d   Localização: %lx  valor: %d\n",
                    returned_chaves[i],
                    (unsigned long)returned_ponteiros[i],
                    ((registro *)
                     returned_ponteiros[i])->valor);
    }
}
 
int encontrar_range( nodo * raiz, int Chave_start, int Chave_end, bool verbose,
        int returned_chaves[], void * returned_ponteiros[]) {
    int i, num_found;
    num_found = 0;
    nodo * n = encontrar_Folha( raiz, Chave_start, verbose );
    if (n == NULL) return 0;
    for (i = 0; i < n->num_chaves && n->chaves[i] < Chave_start; i++) ;
    if (i == n->num_chaves) return 0;
    while (n != NULL) {
        for ( ; i < n->num_chaves && n->chaves[i] <= Chave_end; i++) {
            returned_chaves[num_found] = n->chaves[i];
            returned_ponteiros[num_found] = n->ponteiros[i];
            num_found++;
        }
        n = n->ponteiros[ordem - 1];
        i = 0;
    }
    return num_found;
}
 
// Mostra informações sobre caminho da folha
nodo * encontrar_Folha( nodo * raiz, int Chave, bool verbose ) {
    int i = 0;
    nodo * c = raiz;
    if (c == NULL) {
        if (verbose)
            printf("Árvore Vazia\n");
        return c;
    }
    while (!c->folha) {
        if (verbose) {
            printf("[");
            for (i = 0; i < c->num_chaves - 1; i++)
                printf("%d ", c->chaves[i]);
            printf("%d] ", c->chaves[i]);
        }
        i = 0;
        while (i < c->num_chaves) {
            if (Chave >= c->chaves[i]) i++;
            else break;
        }
        if (verbose)
            printf("%d ->\n", i);
        c = (nodo *)c->ponteiros[i];
    }
    if (verbose) {
        printf("Folha [");
        for (i = 0; i < c->num_chaves - 1; i++)
            printf("%d ", c->chaves[i]);
        printf("%d] ->\n", c->chaves[i]);
    }
    return c;
}
 
 
// Encontra e retorna o Registro a que se refere a Chave
registro * encontrar( nodo * raiz, int Chave, bool verbose ) {
    int i = 0;
    nodo * c = encontrar_Folha( raiz, Chave, verbose );
    if (c == NULL) return NULL;
    for (i = 0; i < c->num_chaves; i++)
        if (c->chaves[i] == Chave) break;
    if (i == c->num_chaves)
        return NULL;
    else
        return (registro *)c->ponteiros[i];
}

bool Buscar(nodo * raiz, int Chave, bool verbose){
	if(encontrar(raiz,Chave,verbose)==NULL){
		return false;
	}else{
		return true;
	}
}		
 
// Encontra um local apropriado para dividir
int cut( int length ) {
    if (length % 2 == 0)
        return length/2;
    else
        return length/2 + 1;
}
 
 
// INSERÇÃO
 
// Cria um novo Registro para guardar o valor a que se refere a Chave.
registro * make_registro(int valor) {
    registro * new_registro = (registro *)malloc(sizeof(registro));
    if (new_registro == NULL) {
        perror("Registro Criado");
        exit(EXIT_FAILURE);
    }
    else {
        new_registro->valor = valor;
    }
    return new_registro;
}
 
 
//Cria um nodovo nó
nodo * make_nodo( void ) {
    nodo * nodovo_nodo;
    nodovo_nodo = malloc(sizeof(nodo));
    if (nodovo_nodo == NULL) {
        perror("Nodo Criado");
        exit(EXIT_FAILURE);
    }
    nodovo_nodo->chaves = malloc( (ordem - 1) * sizeof(int) );
    if (nodovo_nodo->chaves == NULL) {
        perror("Novo Nodo de chaves Ordenada");
        exit(EXIT_FAILURE);
    }
    nodovo_nodo->ponteiros = malloc( ordem * sizeof(void *) );
    if (nodovo_nodo->ponteiros == NULL) {
        perror("Novo Nodo de ponteiros Ordenados");
        exit(EXIT_FAILURE);
    }
    nodovo_nodo->folha = false;
    nodovo_nodo->num_chaves = 0;
    nodovo_nodo->pai = NULL;
    nodovo_nodo->proximo = NULL;
    return nodovo_nodo;
}
 
// Cria uma novo nodo Folha e depois adpta-o de forma adequada.
nodo * make_Folha( void ) {
    nodo * Folha = make_nodo();
    Folha->folha = true;
    return Folha;
}
 
 
// Função auxiliar usada em inserir_nodo_pai para encontrar o índice do ponteiro do pai para o nodo à esquerda da Chave para ser inserido
int get_left_index(nodo * pai, nodo * left) {
 
    int left_index = 0;
    while (left_index <= pai->num_chaves &&
            pai->ponteiros[left_index] != left)
        left_index++;
    return left_index;
}
 
// Insere um novo ponteiro para um Registro e sua correspondente Chave em uma Folha. Retorna a Folha alterada. 
nodo * inserir_into_Folha( nodo * Folha, int Chave, registro * pointer ) {
 
    int i, inseririon_point;
 
    inseririon_point = 0;
    while (inseririon_point < Folha->num_chaves && Folha->chaves[inseririon_point] < Chave)
        inseririon_point++;
 
    for (i = Folha->num_chaves; i > inseririon_point; i--) {
        Folha->chaves[i] = Folha->chaves[i - 1];
        Folha->ponteiros[i] = Folha->ponteiros[i - 1];
    }
    Folha->chaves[inseririon_point] = Chave;
    Folha->ponteiros[inseririon_point] = pointer;
    Folha->num_chaves++;
    return Folha;
}
 
 
/* Insere um novo ponteiro Chave e um novo Registro em uma Folha de forma a ultrapassar a Ordem da árvore, obrigando a Folha de ser dividido pela metade */
nodo * inserir_into_Folha_after_divisaoting(nodo * raiz, nodo * Folha, int Chave, registro * pointer) {
 
    nodo * new_Folha;
    int * temp_chaves;
    void ** temp_ponteiros;
    int inseririon_index, divisao, new_Chave, i, j;
 
    new_Folha = make_Folha();
 
    temp_chaves = malloc( ordem * sizeof(int) );
    if (temp_chaves == NULL) {
        perror("Chaves Temporarias Ordenadas");
        exit(EXIT_FAILURE);
    }
 
    temp_ponteiros = malloc( ordem * sizeof(void *) );
    if (temp_ponteiros == NULL) {
        perror("Ponteiros Temporarios Ordenados");
        exit(EXIT_FAILURE);
    }
 
    inseririon_index = 0;
    while (inseririon_index < ordem - 1 && Folha->chaves[inseririon_index] < Chave)
        inseririon_index++;
 
    for (i = 0, j = 0; i < Folha->num_chaves; i++, j++) {
        if (j == inseririon_index) j++;
        temp_chaves[j] = Folha->chaves[i];
        temp_ponteiros[j] = Folha->ponteiros[i];
    }
 
    temp_chaves[inseririon_index] = Chave;
    temp_ponteiros[inseririon_index] = pointer;
 
    Folha->num_chaves = 0;
 
    divisao = cut(ordem - 1);
 
    for (i = 0; i < divisao; i++) {
        Folha->ponteiros[i] = temp_ponteiros[i];
        Folha->chaves[i] = temp_chaves[i];
        Folha->num_chaves++;
    }
 
    for (i = divisao, j = 0; i < ordem; i++, j++) {
        new_Folha->ponteiros[j] = temp_ponteiros[i];
        new_Folha->chaves[j] = temp_chaves[i];
        new_Folha->num_chaves++;
    }
 
    free(temp_ponteiros);
    free(temp_chaves);
 
    new_Folha->ponteiros[ordem - 1] = Folha->ponteiros[ordem - 1];
    Folha->ponteiros[ordem - 1] = new_Folha;
 
    for (i = Folha->num_chaves; i < ordem - 1; i++)
        Folha->ponteiros[i] = NULL;
    for (i = new_Folha->num_chaves; i < ordem - 1; i++)
        new_Folha->ponteiros[i] = NULL;
 
    new_Folha->pai = Folha->pai;
    new_Chave = new_Folha->chaves[0];
 
    return inserir_nodo_pai(raiz, Folha, new_Chave, new_Folha);
}
 
// Insere um novo ponteiro Chave e um nodo em que estes podem caber Sem violar as propriedades árvore B +.
nodo * inserir_into_nodo(nodo * raiz, nodo * n,
        int left_index, int Chave, nodo * right) {
    int i;
 
    for (i = n->num_chaves; i > left_index; i--) {
        n->ponteiros[i + 1] = n->ponteiros[i];
        n->chaves[i] = n->chaves[i - 1];
    }
    n->ponteiros[left_index + 1] = right;
    n->chaves[left_index] = Chave;
    n->num_chaves++;
    return raiz;
}
 
 
// Insere um novo ponteiro Chave e um nodo, fazendo com que o tamanho do nodo possa ultrapassar A Ordem, e fazendo com que o nodo se divida em dois.
nodo * inserir_nodo_apos_divisao(nodo * raiz, nodo * old_nodo, int left_index,
        int Chave, nodo * right) {
 
    int i, j, divisao, k_prime;
    nodo * nodovo_nodo, * filho;
    int * temp_chaves;
    nodo ** temp_ponteiros;
  
    temp_ponteiros = malloc( (ordem + 1) * sizeof(nodo *) );
    if (temp_ponteiros == NULL) {
        perror("Ponteiros temporários para nodos de divisão");
        exit(EXIT_FAILURE);
    }
    temp_chaves = malloc( ordem * sizeof(int) );
    if (temp_chaves == NULL) {
        perror("Chaves temporárias para nodos de divisão");
        exit(EXIT_FAILURE);
    }
 
    for (i = 0, j = 0; i < old_nodo->num_chaves + 1; i++, j++) {
        if (j == left_index + 1) j++;
        temp_ponteiros[j] = old_nodo->ponteiros[i];
    }
 
    for (i = 0, j = 0; i < old_nodo->num_chaves; i++, j++) {
        if (j == left_index) j++;
        temp_chaves[j] = old_nodo->chaves[i];
    }
 
    temp_ponteiros[left_index + 1] = right;
    temp_chaves[left_index] = Chave;
 
  
    divisao = cut(ordem);
    nodovo_nodo = make_nodo();
    old_nodo->num_chaves = 0;
    for (i = 0; i < divisao - 1; i++) {
        old_nodo->ponteiros[i] = temp_ponteiros[i];
        old_nodo->chaves[i] = temp_chaves[i];
        old_nodo->num_chaves++;
    }
    old_nodo->ponteiros[i] = temp_ponteiros[i];
    k_prime = temp_chaves[divisao - 1];
    for (++i, j = 0; i < ordem; i++, j++) {
        nodovo_nodo->ponteiros[j] = temp_ponteiros[i];
        nodovo_nodo->chaves[j] = temp_chaves[i];
        nodovo_nodo->num_chaves++;
    }
    nodovo_nodo->ponteiros[j] = temp_ponteiros[i];
    free(temp_ponteiros);
    free(temp_chaves);
    nodovo_nodo->pai = old_nodo->pai;
    for (i = 0; i <= nodovo_nodo->num_chaves; i++) {
        filho = nodovo_nodo->ponteiros[i];
        filho->pai = nodovo_nodo;
    }
 
    return inserir_nodo_pai(raiz, old_nodo, k_prime, nodovo_nodo);
}
 
 
 
/* INSERIR um novo nodo (Folha ou nodo interno) na árvore B +.
  * Retorna a raiz da árvore após inseririon.
  */
nodo * inserir_nodo_pai(nodo * raiz, nodo * left, int Chave, nodo * right) {
 
    int left_index;
    nodo * pai;
 
    pai = left->pai;
    if (pai == NULL)
        return inserir_na_nova_raiz(left, Chave, right);
 
    left_index = get_left_index(pai, left);
 
    if (pai->num_chaves < ordem - 1)
        return inserir_into_nodo(raiz, pai, left_index, Chave, right);
    return inserir_nodo_apos_divisao(raiz, pai, left_index, Chave, right);
}
 
 
// Cria uma nova Raiz para duas sub-árvores, e insere a Chave apropriada na nova Raiz.
nodo * inserir_na_nova_raiz(nodo * left, int Chave, nodo * right) {
 
    nodo * raiz = make_nodo();
    raiz->chaves[0] = Chave;
    raiz->ponteiros[0] = left;
    raiz->ponteiros[1] = right;
    raiz->num_chaves++;
    raiz->pai = NULL;
    left->pai = raiz;
    right->pai = raiz;
    return raiz;
}
 
 
 
// Primeiro inserçao: Iniciar uma nova árvore.
nodo * iniciar_nova_arvore(int Chave, registro * pointer) {
 
    nodo * raiz = make_Folha();
    raiz->chaves[0] = Chave;
    raiz->ponteiros[0] = pointer;
    raiz->ponteiros[ordem - 1] = NULL;
    raiz->pai = NULL;
    raiz->num_chaves++;
    return raiz;
}
 
 
 
//Função Principal de inserção
nodo * inserir(nodo *raiz, int Chave, int valor) {
 
    registro * pointer;
    nodo * Folha;
 
    if (encontrar(raiz, Chave, false) != NULL)
        return raiz;

    pointer = make_registro(valor);
 
    if (raiz == NULL)
        return iniciar_nova_arvore(Chave, pointer);
 
    Folha = encontrar_Folha(raiz, Chave, false);
  
    if (Folha->num_chaves < ordem - 1) {
        Folha = inserir_into_Folha(Folha, Chave, pointer);
        return raiz;
    }
 
    return inserir_into_Folha_after_divisaoting(raiz, Folha, Chave, pointer);
}
 
 //REMOVER
 
int obter_indice_vizinho( nodo * n ) {
 
    int i;
    for (i = 0; i <= n->pai->num_chaves; i++)
        if (n->pai->ponteiros[i] == n)
            return i - 1;
    printf("Procura ponteiro inexistente para Nodo do pai\n");
    printf("Nodo:  %#lx\n", (unsigned long)n);
    exit(EXIT_FAILURE);
}
 

nodo *remover_entrada_para_nodo(nodo * n, int Chave, nodo * pointer) { 
    int i, num_ponteiros;
 
    i = 0;
    while (n->chaves[i] != Chave)
        i++;
    for (++i; i < n->num_chaves; i++)
        n->chaves[i - 1] = n->chaves[i];
    num_ponteiros = n->folha ? n->num_chaves : n->num_chaves + 1;
    i = 0;
    while (n->ponteiros[i] != pointer)
        i++;
    for (++i; i < num_ponteiros; i++)
        n->ponteiros[i - 1] = n->ponteiros[i];

    n->num_chaves--;
    if (n->folha)
        for (i = n->num_chaves; i < ordem - 1; i++)
            n->ponteiros[i] = NULL;
    else
        for (i = n->num_chaves + 1; i < ordem; i++)
            n->ponteiros[i] = NULL;
 
    return n;
}
 
 
nodo *ajusta_raiz(nodo * raiz) {
 
    nodo * new_raiz;
 
    if (raiz->num_chaves > 0)
        return raiz;
 
    if (!raiz->folha) {
        new_raiz = raiz->ponteiros[0];
        new_raiz->pai = NULL;
    }
    else
        new_raiz = NULL;
 
    free(raiz->chaves);
    free(raiz->ponteiros);
    free(raiz);
 
    return new_raiz;
}
 
 
//merge dos nodos
nodo * merge_nodos(nodo * raiz, nodo * n, nodo * vizinho, int vizinho_index, int k_prime) {
 
    int i, j, inserir_indice_vizinho, n_start, n_end, new_k_prime;
    nodo * tmp;
    bool divisao;
 
     // Troca Vizinho com nodo que está na Extrema esquerda e se Vizinho esta a direita
 
    if (vizinho_index == -1) {
        tmp = n;
        n = vizinho;
        vizinho = tmp;
    }
 
    inserir_indice_vizinho = vizinho->num_chaves;
    
    divisao = false;
 
    if (!n->folha) {
 
        vizinho->chaves[inserir_indice_vizinho] = k_prime;
        vizinho->num_chaves++;
        n_end = n->num_chaves;
 
        n_start = 0; 
        if (n->num_chaves + vizinho->num_chaves >= ordem) {
            divisao = true;
            n_end = cut(ordem) - 2;
        }
 
        for (i = inserir_indice_vizinho + 1, j = 0; j < n_end; i++, j++) {
            vizinho->chaves[i] = n->chaves[j];
            vizinho->ponteiros[i] = n->ponteiros[j];
            vizinho->num_chaves++;
            n->num_chaves--;
            n_start++;
        }

        vizinho->ponteiros[i] = n->ponteiros[j];
 
        if (divisao) {
            new_k_prime = n->chaves[n_start];
            for (i = 0, j = n_start + 1; i < n->num_chaves; i++, j++) {
                n->chaves[i] = n->chaves[j];
                n->ponteiros[i] = n->ponteiros[j];
            }
            n->ponteiros[i] = n->ponteiros[j];
            n->num_chaves--;
        }

        for (i = 0; i < vizinho->num_chaves + 1; i++) {
            tmp = (nodo *)vizinho->ponteiros[i];
            tmp->pai = vizinho;
        }
    }
 
    else {
        for (i = inserir_indice_vizinho, j = 0; j < n->num_chaves; i++, j++) {
            vizinho->chaves[i] = n->chaves[j];
            vizinho->ponteiros[i] = n->ponteiros[j];
            vizinho->num_chaves++;
        }
        vizinho->ponteiros[ordem - 1] = n->ponteiros[ordem - 1];
    }
 
    if (!divisao) {
        raiz = Remover_entrada(raiz, n->pai, k_prime, n);
        free(n->chaves);
        free(n->ponteiros);
        free(n);
    }
    else
        for (i = 0; i < n->pai->num_chaves; i++)
            if (n->pai->ponteiros[i + 1] == n) {
                n->pai->chaves[i] = new_k_prime;
                break;
            }
 
    return raiz;
 
}
 
 
/* Redistribui entradas entre dois nodos quando:
  * Um tornou-se menor após Remover nodos
  * Mas seu Vizinho é Maior para anexar a
  * Entradas do menor Nodo sem exceder o
  * máximo
  */
nodo * redistribuir_nodos(nodo * raiz, nodo * n, nodo * vizinho, int vizinho_index,
        int k_prime_index, int k_prime) {
 
    int i;
    nodo * tmp;
 
    if (vizinho_index != -1) {
        if (!n->folha)
            n->ponteiros[n->num_chaves + 1] = n->ponteiros[n->num_chaves];
        for (i = n->num_chaves; i > 0; i--) {
            n->chaves[i] = n->chaves[i - 1];
            n->ponteiros[i] = n->ponteiros[i - 1];
        }
        if (!n->folha) {
            n->ponteiros[0] = vizinho->ponteiros[vizinho->num_chaves];
            tmp = (nodo *)n->ponteiros[0];
            tmp->pai = n;
            vizinho->ponteiros[vizinho->num_chaves] = NULL;
            n->chaves[0] = k_prime;
            n->pai->chaves[k_prime_index] = vizinho->chaves[vizinho->num_chaves - 1];
        }
        else {
            n->ponteiros[0] = vizinho->ponteiros[vizinho->num_chaves - 1];
            vizinho->ponteiros[vizinho->num_chaves - 1] = NULL;
            n->chaves[0] = vizinho->chaves[vizinho->num_chaves - 1];
            n->pai->chaves[k_prime_index] = n->chaves[0];
        }
    }
 
    else {
        if (n->folha) {
            n->chaves[n->num_chaves] = vizinho->chaves[0];
            n->ponteiros[n->num_chaves] = vizinho->ponteiros[0];
            n->pai->chaves[k_prime_index] = vizinho->chaves[1];
        }
        else {
            n->chaves[n->num_chaves] = k_prime;
            n->ponteiros[n->num_chaves + 1] = vizinho->ponteiros[0];
            tmp = (nodo *)n->ponteiros[n->num_chaves + 1];
            tmp->pai = n;
            n->pai->chaves[k_prime_index] = vizinho->chaves[0];
        }
        for (i = 0; i < vizinho->num_chaves; i++) {
            vizinho->chaves[i] = vizinho->chaves[i + 1];
            vizinho->ponteiros[i] = vizinho->ponteiros[i + 1];
        }
        if (!n->folha)
            vizinho->ponteiros[i] = vizinho->ponteiros[i + 1];
    }
    n->num_chaves++;
    vizinho->num_chaves--;
 
    return raiz;
}
 
 
// Remover uma entrada da árvore B +..
 nodo * Remover_entrada( nodo * raiz, nodo * n, int Chave, void * pointer ) {
 
    int min_chaves;
    nodo * vizinho;
    int vizinho_index;
    int k_prime_index, k_prime;
    int capacity;
 
    n = remover_entrada_para_nodo(n, Chave, pointer);
 
    if (n == raiz)
        return ajusta_raiz(raiz);
 
    min_chaves = n->folha ? cut(ordem - 1) : cut(ordem) - 1;
    
    if (n->num_chaves >= min_chaves)
        return raiz;
 
    vizinho_index = obter_indice_vizinho( n );
    k_prime_index = vizinho_index == -1 ? 0 : vizinho_index;
    k_prime = n->pai->chaves[k_prime_index];
    vizinho = vizinho_index == -1 ? n->pai->ponteiros[1] :
        n->pai->ponteiros[vizinho_index];
 
    capacity = n->folha ? ordem : ordem - 1;
 
    /* merge */
 
    if (vizinho->num_chaves + n->num_chaves < capacity)
        return merge_nodos(raiz, n, vizinho, vizinho_index, k_prime);
 
    /* Redistribuição */
 
    else
        return redistribuir_nodos(raiz, n, vizinho, vizinho_index, k_prime_index, k_prime);
}
 
 
 
//Função Remover Principal
nodo * Remover(nodo * raiz, int Chave) {
 
    nodo * Chave_Folha;
    registro * Chave_registro;
 
    Chave_registro = encontrar(raiz, Chave, false);
    Chave_Folha = encontrar_Folha(raiz, Chave, false);
    if (Chave_registro != NULL && Chave_Folha != NULL) {
        raiz = Remover_entrada(raiz, Chave_Folha, Chave, Chave_registro);
        free(Chave_registro);
    }
    return raiz;
}
 
 
void deletar_nodos_da_arvore(nodo * raiz) {
    int i;
    if (raiz->folha)
        for (i = 0; i < raiz->num_chaves; i++)
            free(raiz->ponteiros[i]);
    else
        for (i = 0; i < raiz->num_chaves + 1; i++)
            deletar_nodos_da_arvore(raiz->ponteiros[i]);
    free(raiz->ponteiros);
    free(raiz->chaves);
    free(raiz);
}
 
 
nodo *deletar_arvore(nodo * raiz) {
    deletar_nodos_da_arvore(raiz);
    return NULL;
}

void mensagem_1( void ) {
    system("clear");
    printf("Arvore B + de Ordem: %d.\n", ordem);
    
}
void mensagem_2( void ) {
    printf("\nENTRAR COM OS COMANDOS :\n\n");
    printf("\ti <Chave>  [ INSERIR <Chave> (inteiro) ];\n");
    printf("\tr <Chave>  [ REMOVER A CHAVE & SEUS VALORES ASSOCIADOS ];\n");
    printf("\tb <Chave>  [ BUSCAR A CHAVE ];\n");
    printf("\tf <Chave>  [ EXIBIR O VALOR DO ENDEREÇO DA CHAVE ];\n");
    printf("\tv <Chave1> <Chave2> [ IMPRIMIR AS CHAVES NO INVERVALO {<X>,<Y>} ];\n\n");
    printf("\tp => IMPRIMIR A ARVORE B+ ;\n");
    printf("\to => IMPRIMIR CHAVES DAS FOLHAS (EM ORDEM) ;\n");
    printf("\tx => REMOVER A ARVORE ;\n\n");
    printf("\t? => VOLTAR AO MENU.\n");
    printf("\tq => SAIR.\n");
  
}
 
void mensagem_3( void ) {
    printf("Mensagem: ./arvorebp [<ordem>]\n");
    printf("\tDe %d <= ordem <= %d .\n", MIN_ORDEM, MAX_ORDEM);
}
 
 
int main( int argc, char ** argv ) {
 
    char * input_file;
    FILE * fp;
    nodo * raiz;
    int input, range2;
    char instruction;
 
    raiz = NULL;
    verbose_output = false;
 
    if (argc > 1) {
        ordem = atoi(argv[1]);
        if (ordem < MIN_ORDEM || ordem > MAX_ORDEM) {
            fprintf(stderr, "Ordem Invalida: %d .\n\n", ordem);
            mensagem_3();
            exit(EXIT_FAILURE);
        }
    }
    
    mensagem_1();  
    mensagem_2();

    if (argc > 2) {
        input_file = argv[3];
        fp = fopen(input_file, "r");
        if (fp == NULL) {
            perror("Falha ao Abrir o Arquivo de Entrada");
            exit(EXIT_FAILURE);
        }
        while (!feof(fp)) {
            fscanf(fp, "%d\n", &input);
            raiz = inserir(raiz, input, input);
        }
        fclose(fp);
        display(raiz);
    }
 
    printf("> ");
    while (scanf("%c", &instruction) != EOF) {
        switch (instruction) {
        case 'r':
            scanf("%d", &input);
            raiz = Remover(raiz, input);
            break;
        case 'i':
            scanf("%d", &input);
            raiz = inserir(raiz, input, input);
            printf("Chave %d Inserida\n",input);
            break;
        case 'f':
            scanf("%d", &input);
            encontrar_imprimir(raiz, input, instruction == 'p');
            break;
        case 'v':
            scanf("%d %d", &input, &range2);
            if (input > range2) {
                int tmp = range2;
                range2 = input;
                input = tmp;
            }
            encontrar_imprimir_range(raiz, input,range2, instruction == 'p');
            break;
	 case 'b':
	    scanf("%d", &input);
            if(Buscar(raiz, input, false)==true){
		printf("Chave Cadastrada na Arvore \n");
	    }else{
		printf("Chave Não Encontrada \n");
	    }
            break;
        case 'o':
            imprimir_level(raiz);
            break;
        case 'q':
            while (getchar() != (int)'\n');
            return EXIT_SUCCESS;
        case 'p':
            display(raiz);
            break;
        case 'x':
            if (raiz)
                raiz = deletar_arvore(raiz);
            display(raiz);
            break;
        default:
	    system("clear");
            mensagem_2();
            break;
        }
        while (getchar() != (int)'\n');
        printf("> ");
    }
    printf("\n");
 
    return EXIT_SUCCESS;
}
