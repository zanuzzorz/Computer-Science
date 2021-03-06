#include <GL/glut.h>
#include <math.h>       															// Usado para Função Seno

float pontos[45][45][3];  															// Matriz para gravar os pontos da bandeira
int cont = 0; 																		// Contador para controlar a velocidade das tremulações

/* A função geral de inicialização OpenGL, define todos os parâmetros iniciais */
void InitGL(int Width, int Height){
    float x, y;

    glClearColor(0.5f, 0.5f, 0.5f, 0.0f);											// Especifica qual a cor de Fundo
    glMatrixMode(GL_PROJECTION);													// Inicializa o sistema de coordenadas
    glLoadIdentity();																// Reinicia a matriz de projeção

    gluPerspective(100.0f,(GLfloat)Width/(GLfloat)Height,0.1f,100.0f);	            // Calcula a taxa de proporção da Janela

    glMatrixMode(GL_MODELVIEW);

    for(x = 0.0f; x < 9.0f; x +=  0.2f )											// Loop através do plano X
		for(y = 0.0f; y < 9.0f; y += 0.2f){											// Loop através do plano Y

			 /* Aplica a tremulação na bandeira */
			 pontos[ (int) (x*5) ][ (int) (y*5) ][0] = x;					
			 pontos[ (int) (x*5) ][ (int) (y*5) ][1] = y - 4.4f;
			 pontos[ (int) (x*5) ][ (int) (y*5) ][2] = (float) (sin( ( (x*5*8)/360 ) * 3.14159 * 2 ));
		}
}

/* A função principal de desenho */
void Desenha(){
    int x, y;
    float fx, fy, fxb, fyb;

    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glLoadIdentity();
    glTranslatef(0.0f,0.0f,-12.0f);												//Ajuste do posicionamento da Bandeira

    glBegin(GL_QUADS);
		 for (x=0; x<44; x++) {
			for (y=0; y<44; y++) {
				fx  = (float) (x)/44;
				fy  = (float) (y)/44;
				fxb = (float) (x+1)/44;
				fyb = (float) (y+1)/44;

				/* Cores da Bandeira */
				if((fy > 0.35 && fy < 0.4) || (fy > 0.6 && fy < 0.65))	
					glColor3f(1, 1, 1);
				else if(fy > 0.4 && fy <= 0.6)
				 	glColor3f(0, 0, 0);
				else
				 	glColor3f(0, 0.7, 1);
				 
				 /* Desenha a Bandeira */
				 glVertex3f( pontos[x][y][0], pontos[x][y][1], pontos[x][y][2]);
				 glVertex3f( pontos[x][y+1][0], pontos[x][y+1][1], pontos[x][y+1][2] );
				 glVertex3f( pontos[x+1][y+1][0], pontos[x+1][y+1][1], pontos[x+1][y+1][2] );
				 glVertex3f( pontos[x+1][y][0], pontos[x+1][y][1], pontos[x+1][y][2] );

			}
		 }
    glEnd();

	/* Desenho do Mastro */
	glLineWidth(10); 
	glColor3f(0.7, 0.5, 0.3);
	glBegin(GL_LINES);
		glVertex3f(0, -39.0, 0.0);
		glVertex3f(0, 5.0, 0.0);
	glEnd();

	 /* Define a velocidade da tremulação com base no ciclo do seno */
    if (cont == 1) {
		 for(y = 0; y < 45; y++)
			 pontos[44][y][2] = pontos[0][y][2];

		 for( x = 0; x < 44; x++ ) 
			 for( y = 0; y < 45; y++)
				pontos[x][y][2] = pontos[x+1][y][2];

		 cont = 0;
    }    
    cont++;

	 /* Executa os comandos OpenGL (Substitui o glFlush) */
    glutSwapBuffers();
}

int main(int argc, char **argv) {  
    glutInit(&argc, argv);  
    glutInitDisplayMode(GLUT_RGBA | GLUT_DOUBLE | GLUT_ALPHA | GLUT_DEPTH);  
    glutInitWindowSize(600, 600);
    glutCreateWindow("Bandeira Tremulando");   
    glutIdleFunc(&Desenha);    					// Realiza operações e animações em segundo plano (Substitui o glutDisplayFunc)
    InitGL(600, 600);  							// Inicializa a Janela
    glutMainLoop();     							
    return 1;
}
