#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
typedef struct {
	char nome[30];
	int vida;
	int ouro;
	int casas[42];
}jogador_t;
int tela();
int dado();
int mapa(jogador_t j[4], int numjogadores,int posicao);
void acao(jogador_t j[4], int i, int posicao, int dados, int numjogadores);

void acao(jogador_t j[4], int i, int posicao, int dados, int numjogadores){
	int e,c;
	e=0;		
	switch(j[i].casas[posicao]){
		case 1:
			j[i].vida=j[i].vida-1; 						//Buraco
			printf("Buraco: %s, você perdeu uma Vida\n\n",j[i].nome);				
			break;
		case 2:
			j[i].ouro=j[i].ouro+20; 					//Sortudo
			printf("Sortudo: %s, você Ganhou 20 de Ouro\n\n",j[i].nome);			
			break;
		case 3:
			j[i].casas[posicao]=posicao+2;
			j[i].ouro=j[i].ouro+10; 					//Arcanjo
			printf("Arcanjo: %s, você avançara 2 casas e ganhara 10 de Ouro\n\n",j[i].nome);			
			break;
		case 4:
			j[i].ouro=j[i].ouro+(5*dados); 				//Duende
			printf("Duende: %s, você ganhara 5 de Ouro X o valor do dado\n\n",j[i].nome);			
			break;
		case 5:
			j[i].casas[posicao]=0; 						//Silada Bino
			printf("É uma silado Bino: %s, Você retornara para o inicio do jogo\n\n",j[i].nome);			
			break;
		case 6:
			printf("Diamante: %s, Jogue Novamente\n",j[i].nome);		//Diamente
				while(c!=1){
					printf("Precione 1 para Jogar o dado \n");
					scanf("%d",&c);
				}
				if(c==1){
					srand(time(NULL));
					dados=dado();
					printf("Valor que Apareceu no Dado: %d\n",dados);
				}
				j[i].casas[posicao]=j[i].casas[posicao]+dados;		
			break;							
		case 7:
			j[i].vida=j[i].vida-1;				
			j[i].casas[posicao]=j[i].casas[posicao]+5;			//Dinamite				
			printf("Dinamite: %s, você perdera 1 vida e avançara 5 casas\n\n",j[i].nome);			
			break;
		case 8:
			printf("Espere uma rodada para jogar"); 			//Cadeia
			break;	
		case 9:
			printf("Escolha um jogador para voltar 2 casas, e voce ganhara 10 de ouro: ");
			scanf("%d",&e);
			j[i].ouro=j[i].ouro+10;						//Sexta-feira 13
			j[e].casas[posicao]=j[e].casas[posicao]-2;	
			printf("Sexta-feira 13: %s, Voce Perdera 1 vida\n",j[e].nome);			
			printf("Sexta-feira 13: %s, Voce Recebeu 10 de Ouro\n\n",j[i].nome);			
			break;
		case 10:
			j[i].ouro=j[i].ouro+20; 					//Sortudo(2)
			printf("Sortudo: %s, você Ganhou 20 de Ouro\n\n",j[i].nome);			
			break;
		case 11:
			j[i].casas[posicao]=j[i].casas[posicao]+2;			//Explorador
			printf("Explorador: %s, você Avançara 2 Casas\n\n",j[i].nome);
			break;	
		case 12:
			j[i].casas[posicao]=j[i].casas[posicao]+dados;			//Benção
			printf("Bença: %s, você Avançara o valor do dado em casas \n\n",j[i].nome);			
			break;	
		case 13:
			j[i].ouro=j[i].ouro-10;						//Ladrão
			printf("Ladrao: %s, você Perdeu 10 de Ouro\n\n",j[i].nome);
			break;	
		case 14:
			printf("Escolha um jogador para perder uma Vida: ");
			scanf("%d",&e);							//Ceifador
			j[e].vida=j[e].vida-1;
			printf("Ceifador: %s, Voce Perdera 1 vida\n\n",j[e].nome);
			break;	
		case 15:
			printf("Escolha um jogador para voltar 5 casas: ");
			scanf("%d",&e);
			j[e].casas[posicao]=j[e].casas[posicao]-5;			//Magia Negra
			printf("Magia Negra: %s, Voce voltara 5 casas \n\n",j[e].nome);
			break;
		case 16:
			j[i].vida=j[i].vida+1;						//Cogumelo		
			printf("Cogumelo: %s, você Ganhou 1 vida Extra \n\n",j[i].nome);			
			break;	
		case 17:
			j[i].casas[posicao]=j[i].casas[posicao]-3; 			//Monstro
			printf("Mostro: %s, você Voltara 3 Casas \n\n",j[i].nome);
			break;
		case 18:
			j[i].ouro=j[i].ouro+30;						//Bau do Tesouro
			printf("Bau do Tesouro: %s, você Ganou 30 de Ouro\n\n",j[i].nome);
			break;	
		case 19:
			for(c=0;c<4;c++){
				j[c].ouro=j[c].ouro-10;					//Maldição
			}
			printf("Maldição: Todos Jogadores Perderam 10 de outro\n\n");
			break;	
		case 20:
			printf("Indique um Jogador pra ficar 1 Rodada sem Jogar: ");
			scanf("%d",&e);							//Paredão
			printf("Paredão: %s, você Fira uma rodada sem jogar\n\n",j[e].nome);			
			break;	
		case 21:
			printf("Escolha um jogador para perder uma Vida: ");
			scanf("%d",&e);
			j[e].vida=j[e].vida-1;						//Ceifador(2)
			printf("Ceifador: %s, Voce Perdera 1 vida\n\n",j[e].nome);			
			break;
		case 22:
			j[i].ouro=j[i].ouro+20;						//Atalho
			j[i].casas[posicao]=j[i].casas[posicao]+4;
			printf("Atalho: %s, Voce avançara 4 casas e ganhara 20 de ouro\n\n",j[i].nome);			
			break;					
		case 23:
			j[i].casas[posicao]=j[i].casas[posicao]-3; 			//Monstro(2)
			printf("Mostro: %s, você Voltara 3 Casas\n\n",j[i].nome);			
			break;	
		case 24:
			j[i].ouro=j[i].ouro+(5*dados); 					//Duende(2)	
			printf("Duende: %s, você ganhara 5 de Ouro X o valor do dado\n\n",j[i].nome);
			break;
		case 25:
			j[i].casas[posicao]=j[i].casas[posicao]+2;			//Explorador(2)
			printf("Explorador: %s, você Avançara 2 Casas\n\n",j[i].nome);			
			break;	
		case 26:
			j[i].ouro=j[i].ouro-10;						//Ladrão(2)
			printf("Ladrao: %s, você Perdeu 10 de Ouro\n\n",j[i].nome);			
			break;
		case 27:
			j[i].vida=j[i].vida-1; 						//Buraco(2)
			printf("Buraco: %s, você perdeu uma Vida\n\n",j[i].nome);				
			break;	
		case 28:
			j[i].vida=j[i].vida-1;				
			j[i].casas[posicao]=j[i].casas[posicao]+5;			//Dinamite(2)				
			printf("Buraco: %s, você perdeu uma Vida\n\n",j[i].nome);				
			break;	
		case 29:
			printf("Escolha um jogador para voltar 2 casas e ganhe 10 de ouro: ");
			scanf("%d",&e);
			j[i].ouro=j[i].ouro+10;						//Sexta-feira 13 (2)
			j[e].casas[posicao]=j[e].casas[posicao]-2;
			printf("Sexta-feira 13: %s, Voce Perdera 1 vida\n",j[e].nome);			
			printf("Sexta-feira 13: %s, Voce Recebeu 10 de Ouro\n\n",j[i].nome);
		case 30:
			j[i].casas[posicao]=j[i].casas[posicao]+dados;			//Benção(2)
			printf("Bença: %s, você Avançara o valor do dado em casas \n\n",j[i].nome);			
			break;
		case 31:
			for(c=0;c<4;c++){
				j[c].ouro=j[c].ouro-10;					//Maldição(2)
			}
			printf("Maldição: Todos Jogadores Perderam 10 de outro\n\n");
			break;
		case 32:
			j[i].ouro=j[i].ouro+30;						//Bau do Tesouro(2)
			printf("Bau do Tesouro: %s, você Ganou 30 de Ouro\n\n",j[i].nome);			
			break;
		case 33:
			j[i].casas[posicao]=j[i].casas[posicao]-3; 			//Monstro(3)
			printf("Mostro: %s, você Voltara 3 Casas\n\n",j[i].nome);			
			break;
		case 34:
			printf("Escolha um jogador para voltar 5 casas: ");
			scanf("%d",&e);
			j[e].casas[posicao]=j[e].casas[posicao]-5;			//Magia Negra(2)
			printf("Magia Negra: %s, Voce voltara 5 casas\n\n",j[e].nome);			
			break;
		case 35:
			j[i].ouro=j[i].ouro-10;						//Ladrão(3)
			printf("Ladrao: %s, você Perdeu 10 de Ouro\n\n",j[i].nome);			
			break;
		case 36:
			j[i].ouro=j[i].ouro+(5*dados); 					//Duende(3)
			printf("Duende: %s, você ganhara 5 de Ouro X o valor do dado\n\n",j[i].nome);			
			break;
		case 37:
			j[i].casas[posicao]=j[i].casas[posicao]+2;
			j[i].ouro=j[i].ouro+10; 					//Arcanjo(2)
			printf("Arcanjo: %s, você avançara 2 casas e ganhara 10 de Ouro\n\n",j[i].nome);			
			break;			
		case 38:
			printf("Escolha um jogador para perder uma Vida: ");
			scanf("%d",&e);
			j[e].vida=j[e].vida-1;						//Ceifador(3)
			printf("Ceifador: %s, Voce Perdera 1 vida\n\n",j[e].nome);			
			break;
		case 39:
			printf("Espere uma rodada para jogar"); 			//Cadeia(2)
			break;	
		case 40:
			j[i].vida=j[i].vida+1;						//Cogumelo(2)		
			printf("Cogumelo: %s, você Ganhou 1 vida Extra\n\n",j[i].nome);			
			break;				
	}
		
	
}

int tela(){
	int i,numjogadores,posicao,sobre,menu,inf;
	jogador_t j[4];
	menu=numjogadores=posicao=sobre=inf=0;
	printf ("\n");
	system("clear");
	printf ("		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n"
		"		@@                                            @@ \n"
		"		@@        ___    ___            ____          @@ \n"
		"		@@       |      |   |  |\\  /|  |              @@ \n"
		"		@@       |      |___|  | \\/ |  |---           @@ \n"
		"		@@       |___]  |   |  |    |  |____          @@ \n"
		"		@@                                            @@ \n"
		"		@@              ____    ____                  @@ \n"
		"		@@             |    |  |                      @@ \n"
		"		@@             |    |  |---                   @@ \n"
		"		@@             |____|  |                      @@ \n"
		"		@@                                            @@ \n"
		"		@@        |      -    ____   ____             @@ \n"
		"		@@        |      |   |      |                 @@ \n"
		"		@@        |      |   |---   |---              @@ \n"
		"		@@        |____  |   |      |____             @@ \n"
		"		@@                                            @@ \n"
		"		@@                                            @@ \n"
		"		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n"	
	
		"\n                        	|1| => Iniciar Jogo\n"	
		"				|2| => Instruções\n"	
		"				|3| => Sobre\n"
		"				|4| => Sair\n");			
	
	
	printf("\n Selecione uma das opções: ");
	scanf("%d",&menu);
	while(menu>4 || menu<=0){	
	printf("Opção Invalida! Selecione uma das opções: ");
	scanf("%d",&menu);
	}
	switch(menu){
		case 1:
			system("clear");
			while(numjogadores<=1 || numjogadores>4){
				printf("\nDigite o Numero de Jogadores Participantes: ");
				scanf("%d", & numjogadores);
				if(numjogadores<=1 || numjogadores>4){
					printf("\nOpção Invalida! Podem participar no Maximo 4 jogadores");
				}
			}
			for (i=0;i<numjogadores;i++){
				printf("Digite o nome do jogador: ");
				scanf("%s",j[i].nome);
			}
			for (i=0;i<numjogadores;i++){	
				j[i].vida=3;
				j[i].ouro=0;
				j[i].casas[posicao]=0;
			}
			system("clear");
			mapa(j,numjogadores,posicao);	
			
		break;
		case 2:
			system("clear");
			printf("			    		   |..| GAME OF LIFE |..|    \n\n"
			       "__________________________________________________________________________________________________\n\n"
				"REGRAS:\n\n"			       
			       "=> Ao Iniciar Informa-se o numero de Jogadores Participantes, Variando entre 2 e 4 Jogadores, em seguida cada jogador cadastra seu nome.\n\n"
			       "=> Na Ordem que cadastraram os nomes, cada jogador efetuara uma jogada. A jogada é composta de duas Etapas,Jogar o dado e Movimentção. O dado tera um valor variando de 1 a 6 e ele indica quantas casas o jogador deverá andar no Tabuleiro. Na Movimentação, a Peça do Jogador Move-se pelo Tabuleiro.\n\n"
				"=> Ao Parar numa casa do Tabuleiro, a peça do Jogador deve executar uma ação.\n\n"
				"=>Cada Jogador Possui 3 Vidas e uma Bolsa de Ouro. Os Jogadores Podem perder vidas e Ouro ao pararem nas casas dos Tabuleira e Ativando as Ações.\n\n"
				"Dois Jogadores nunca podem ocupar a mesma casa. Se isso acontecer, o jogador que chegou deve ser colocado na casa anterior.\n\n"
				"=> O Jogo Termina Quando Todos os Jogadores chegarem ao final do Tabuleiro (exceto aqueles que morreram durante o percurso).\n\n"
				"=>Vence o Jogador que tiver mais ouro ao Final. Além do valor acumulado na bolsa de ouro, cada vida extra vale 100 de Ouro.\n\n"
				"__________________________________________________________________________________________________\n\n");	
			while(inf!=2){
				printf("Precione 2 para Retornar ao Menu Principal\n");
				scanf("%d",&inf);
			}
			if(inf==2){
				sobre=tela();
			}
					
		break;
		case 3:
			system("clear");
			printf("			    		   |..| GAME OF LIFE |..|    \n\n"
			       "Desenvolvido por Ricardo Zanuzzo, Estudante de Ciência da Computação na UFFS!\n"
			       "__________________________________________________________________________________________________\n\n");	
			while(sobre!=3){
				printf("Precione 3 para Retornar ao Menu Principal\n");
				scanf("%d",&sobre);
			}
			if(sobre==3){
				sobre=tela();
			}
			
		break;
		case 4:
			printf("\n");
			system("clear");
			getchar();
				 
		}
		return menu;
}
int mapa(jogador_t j[4], int numjogadores,int posicao){
	int i,cont,dados,maior,menor,parar;
	char retornar;
	cont=dados=parar=maior=menor=0;
	
			printf("\n");
			printf ("				GAME OF LIFE                     \n"
				"		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n"
				"		@@ |INICIO|                                   @@ \n"
				"		@@ --------    				      @@ \n"
				"		@@   [1]    			              @@ \n"
				"		@@   [2]    			              @@ \n"
				"		@@   [3] 		   	              @@ \n"
				"		@@   [4][5][6][7][8][9][10][11][12][13]       @@ \n"
				"		@@             		           [14]       @@ \n"
				"		@@             		           [15]       @@ \n"
				"		@@             	       [19][18][17][16]       @@ \n"
				"		@@                     [20]                   @@ \n"
				"		@@                     [21]                   @@ \n"
				"		@@        	       [22]                   @@ \n"
				"		@@         [26][25][24][23]                   @@ \n"
				"		@@         [27]  	       [36][37][38]   @@ \n"
				"		@@         [28]  	       [35]    [39]   @@ \n"
				"		@@         [29][30][31][32][33][34]    [40]   @@ \n"
				"		@@                                   _______  @@ \n"
				"		@@                                  |  FIM  | @@ \n"
				"		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n\n");
	for (i=0;i<numjogadores;i++){
		printf("\njogador %d : ", i+1);
		printf("%s | ", j[i].nome);
		printf(" Vidas: %d", j[i].vida);
		printf(" | Ouro: %d", j[i].ouro);
		printf(" | Casa: %d\n\n", j[i].casas[posicao]);
	}
	for (i=0;i<numjogadores;i++){
		cont=0;
		printf("\n%s: Sua vez de Jogar \n",j[i].nome);
		while(cont!=1){
			printf("Precione 1 para Jogar o dado ");
			scanf("%d",&cont);
		}
		if(cont==1){
			srand(time(NULL));
			dados=dado();
			printf("Valor que Apareceu no Dado: %d\n",dados);
		}
		j[i].casas[posicao]=j[i].casas[posicao]+dados;
		acao(j,i,posicao,dados,numjogadores);
		j[i].casas[41]=41;
		if(j[i].casas[posicao]>j[i].casas[41]){
			j[i].casas[posicao]=41;
			parar++;
		}
		if(parar>=numjogadores){
			printf("\nTERMINOU!\n\n");
			for (i=0;i<numjogadores;i++){
				j[i].ouro=j[i].ouro+(j[i].vida*100);
				printf("%s : Voce Coletou %d de Ouro \n\n",j[i].nome,j[i].ouro);
				maior=j[i].ouro;
				menor=j[i].ouro;
				if(j[i].ouro>maior){
					maior=j[i].ouro;
				}else{
					menor=j[i].ouro;
				}
			printf("O Jogador que atingiu a Maior Quantidade de Ouro Foi: %s\n",j[i].nome);
			printf("Parabéns %s, Você é o Ganhador do Game of Life\n\n",j[i].nome);
			printf ("		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n"
				"		@@                                   		  @@ \n"
				"		@@ #################	  #	#            #    @@ \n"
				"		@@ #			  #	# #        # #    @@ \n"
				"		@@ #			  #	#  #      #  #    @@ \n"
				"		@@ #			  #	#   #    #   #    @@ \n"
				"		@@ #			  #	#    #  #    #    @@ \n"
				"		@@ ##############	  #	#     #      #    @@ \n"
				"		@@ #			  #	#            #    @@ \n"
				"		@@ #			  #	#            #    @@ \n"
				"		@@ #			  #	#            #    @@ \n"  
				"		@@ #			  #	#            #	  @@ \n"
				"		@@                                                @@ \n"
				"		@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n");
				
			printf("\nPrecione qualquer tecla para Retornar ao Menu Principal ");
			scanf("%s",&retornar);			
			tela();
			}		
		}
		if(j[i].vida==0){
			printf("Game Over para o Jogador: %s",j[i].nome);
			numjogadores--;
		}
		if(i==numjogadores-1){
			i=-1;
			mapa(j,numjogadores,posicao);	
		}
	}
	return 0;	
}

int dado(){
	int d;
	d=1 + (int) (6.0 * (rand()/ (RAND_MAX + 1.0)));
	return d;
}
int main(){
	tela();		
	return 0;
}
