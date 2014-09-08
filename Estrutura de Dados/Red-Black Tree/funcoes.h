/*
Universidade Federal da Fronteira Sul
Ciência da Computação - Estruturas de Dados II
@Autor: Ricardo Zanuzzo
*/

#define RED 1
#define BLACK 0

/*Strutcs usadas no Programa:
no (contem int para o valor,cor e level e ponteiros Esquerda,Direita e o Pai);
STree (contem a Raiz da Arvore);
*/
typedef struct no{
	int valor,cor,level;
	struct no *Esq;
	struct no *Dir;
	struct no *Pai;
}no;

typedef struct {
	no *Raiz;
}STree;

//Reset: Coloca a Raiz da Arvore NULL;
void Reset(STree *T);

//Inserir: Insere um Elemento da Arvore e chama as funções de Inserção;
void Inserir(STree *T,no *pN,int elemento);

//Inserir Caso 1 : O novo nó é agora o nó da raiz da árvore. Uma vez que o nó raiz deve ser preto, e alterando sua cor adiciona o mesmo número de nós pretos para cada caminho. Somente o nó raiz não tem pai,então podemos assumir a partir de agora que o nó tem um pai;
void InserirCaso1(STree *T, no *n);

//Inserir Caso 2 : O novo nó possui um pai preto. Todas as propriedades estão ainda satisfeitas e voltamos a função Inserir;
void InserirCaso2(STree *T, no *n);

//Inserir Caso 3 : O Tio do nó é vermelho. Toca a cor do pai e do tio para preto e vermelho para avós. No entanto , o nó avô vermelho agora pode violar as propriedades de árvores rubro-negra,etão recursivamente invoca este procedimento em que a partir do caso 1 para lidar com isso.
void InserirCaso3(STree *T, no *n);

/*Inserir Caso 4 : Neste caso , ha dois casos que são imagens de espelho um do outro :
    a) O novo nó é o filho a Direita de seu pai e o pai é o filho a esquerda do avô. Neste caso, Rotaciona para a esquerda sobre o pai.
    b )O novo nó é o filho a Esquerda de seu pai eo pai é o filho direito do avô. Neste caso, Rotaciona para a direita sobre o pai; */
void InserirCaso4(STree *T, no *n);

/*Inserir Caso 5 : Neste último caso , tambem tem dois casos que são imagens de espelho um do outro :

    a) O novo nó é o filho a esquerda de seu pai e o pai é o filho esquerdo do avô. Neste caso, rodar para a direita sobre o avô.
    b) O novo nó é o filho a direita de seu pai e o pai é o filho direito do avô. Neste caso, girar para a esquerda sobre o avô.*/
void InserirCaso5(STree *T, no *n);

//Rrotate: Rotaciona o No a Direita;
void Rrotate(STree *T, no *pN);

//Lrotate: Rotaciona o No a Direita;
void Lrotate(STree *T, no *pN);

//Buscar: Busca o Nó na arvore e Retorna True se Existir, caso contrario Retorna False;
bool Buscar(int K,STree *T);

//RetornaNo: Busca o Nó na arvore e o Retorna se Existir;
no *RetornaNo(STree *t, int key);

//MaiorNo: Função do Predecessor que retorna o Maior Nó da Esquerda;  
no *MaiorNo(no *n);

//Remover: Remove um Elemento da Arvore e chama as funções de Remoção;
void Remover(STree *t, int valor);

//Remover Caso 1 : Verifica-se se o Nó é Raiz; 
void RemoveCaso1(STree *t, no *n);

//Remover Caso 2 : Verifica-se se o Nó tem um irmão vermelho. Neste caso, troca as cores do pai e irmão, em seguida, faz um Rotate com o Pai no Nó;
void RemoveCaso2(STree *t, no *n);

//Remover Caso 3 : Neste caso, o Pai do Nó, o irmão, e os filhos do irmãos são negros. Então, troca a cor do irmão para vermelho. Agora todos os caminhos que passam pelo pai do N tem um nó negro a menos do que antes da exclusão, por isso tem que executar de forma recursiva este procedimento apartir do pai de N.
void RemoveCaso3(STree *t, no *n);

//Remover Caso 4: O irmão de N e os filhos de irmãos são negros, mas seu pai é o vermelho. Troca as cores do irmão e pai , o que restaura  as propriedades da árvore;
void RemoveCaso4(STree *t, no *n);

/*Remover Caso 5: Existem dois casos tratados aqui, que são imagens de espelho um do outro :
   a) N irmão de X é negro, filho esquerdo do X é vermelho, filho a direita do X é preto, e N é o filho a esquerda de seu pai. Troca as cores do X e seu irmão à esquerda e Rotacionar à direita na X;
   b) N irmão de X é negro, filho direito do X é vermelho, filho a esquerda do X é preto, e N é o filho a direita de seu pai. Troca as cores do X e seu irmão direita e Rotacionar para a esquerda em X;
*/
void RemoveCaso5(STree *t, no *n);

/*Remover Caso 6: Existem tambem dois casos tratados aqui, que são imagens de espelho um do outro:
    a) N irmão de X é negro, filho a direita do X é vermelho, e N é o filho a esquerda de seu pai. Troca as cores do pai e irmão de N, fazendo o filho a direita de X preto, em seguida, Rotaciona à esquerda do pai de N .
    b) N irmão de X é negro, filho a esquerda do X é vermelho, e N é o filho a direita de seu pai. Troca as cores do pai e irmão de N, fazendo filho a esquerda do X preto, em seguida, Rotaciona à direita no pai de N .
*/
void RemoveCaso6(STree *t, no *n);

//SubstituirNo: Usado na Remoçao, esta funçao troca o Nó Pai por seu filho,caso exista;
void SubstituirNo(STree *T, no *oldn, no *newn);

//Verificar Propriedades: Verifica se a Avore Satisfaz as 4 Propriedades da Arvore Rubro-Negra
bool Verificar_Propriedades(STree *t);

//Propriedade 1: Cada nó é vermelho ou preto;
bool Verificar_Propriedade_1(no *n);

//Propriedade 2: O nó raiz é negra;
bool Verificar_Propriedade_2(no *n);

//Propriedade 3: Cada nó vermelho tem dois filhos , e ambos são negros (ou equivalentemente, o pai de cada nó vermelho é preto);
bool Verificar_Propriedade_3(no *n);

//Propriedade 4: Todos os caminhos de qualquer nó para seus nós folha contêm o mesmo número de nós pretos. Ela faz o Nó percorrer a árvore, incrementando a contagem negro nó à medida que avançamos. A primeira vez que chegamos a uma folha,então salva a contagem. Quando , posteriormente, chegar a outras folhas, nós comparamos a contagem para essa contagem salvos;
bool Verificar_Propriedade_4(no *n);
bool Verificar_Propriedade_4_Salvar(no *n, int black_count, int* path_black_count);

//Listar: Imprime a Arvore Rubro-Negra, tentando visualizar sua Estrutura; 
void Listar(no *p, int nivel);

//PrintNivel: Imprime um Determinado Nivel da Arvore Rubro-Negra;
void PrintNivel(no *p, int nivel);

//EmOrdem: Imprime os Elementos da Arvore Rubro-Negra em Ordem;
void EmOrdem(no *raiz);

//AjustarLevel: Ajusta o Nivel dos Nodos, toda vez que é Inserido ou Removido um Nó.
void AjustarLevel(no *n);

