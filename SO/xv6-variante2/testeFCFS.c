#include "types.h"
#include "param.h"
#include "stat.h"
#include "user.h"


#define MAX 9999999
#define MIN 100
#define N  20

void loop(int n){
	int x,y;
	
	if(n) y=MAX;  
	else  y=MIN;
	
	for(x=0; x<y; x++)
		for(x=0; x<y; x++)
			for(x=0; x<y; x++){}
}

int main(){
	int n,pid[N],op;

	for(n=0;n<N;n++){
		pid[n] = fork();
		if (pid[n] == 0){
			op = (n%2);  // operação 0 ou 1
			loop(op);
			exit();
		}
	}
	for(n=0;n<N;n++)
		wait();
	exit();
  return 0;
}
