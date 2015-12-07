Objetivo geral: desenvolver conhecimento e prática de implementação de um componente básico
(i.e., escalonador de processos) em um sistema operacional didático.

Objetivos específicos: 
a) estudar o código de uma implementação do Unix versão 6 para a plataforma Intel: xv6 (implementado no MIT para a disciplina de engenharia de sistemas operacionais); 
b) analisar e planejar a implementação de difererentes escalonadores de processos; 
c)implementar os escalonadores; 
d) validar os escalonadores através de experimentos; 


Plataforma:
xv6 → http://pdos.csail.mit.edu/6.828/2012/xv6.html

Descrição do problema: Implementar e testar/avaliar as seguintes variantes de escalonadores de
processos com políticas de decisão distintas:

◦ Variante 1: Round Robin FIFO

▪ Nesse escalonador, a política de decisão de quem é o próximo a executar segue a ordem de uma fila convencional (FIFO). Quando um processo é criado, quando ele finaliza a utilização de sua fatia (i.e., quantum) e quando retorna de um estado de bloqueio (e.g., quando finaliza a espera por uma operação de E/S), o processo é considerado o último a chegar e, naturalmente, é inserido ao final da fila de processos prontos (RUNNABLE).

◦ Variante 2: First Come First Served (não preemptivo!)

▪ Trata-se de uma política não-preemptiva. Aplica-se uma fila convencional (ordem FIFO), onde o processo que recebe a CPU devolve-a somente quando desejar (yield), quando finaliza ou quando é bloqueado (e.g., uma operação de E/S). Em caso de desbloqueio, o processo retorna ao final da fila.


◦ Variante 3: Multilevel Feedback Queue Scheduling

Nessa abordagem, há três filas de processos:

• A primeira fila contém os processos de mais alta prioridade;

• A segunda fila contém os processos de prioridade intermediária;

• A terceira fila contém os processos de mais baixa prioridade.

O escalonador atende as seguintes regras/propriedades:

1. Quando um processo é criado, ele é inserido na primeira fila;
2. A preferência, na execução, sempre é dos processos da primeira fila;
3. Caso não existam processos de alta prioridade (i.e., primeira fila), a
preferência de execução será dos processos na segunda fila;
4. Processos de baixa prioridade executam apenas quando as duas primeiras
filas estiverem vazias;
5. Caso o processo executando, voluntariamente, devolver o controle do
processador, o processo retorna ao final da mesma fila de onde saiu antes de
ser executado;
6. Caso o processo utilize toda a sua fatia de tempo (quantum), ele é retirado da
CPU e colocado ao final da fila de prioridade imediatamente inferior;
7. Quando um processo retorna do estado bloqueado (i.e., sleeping), ele é
promovido um nível, sendo o processo inserido ao final da final
imediatamente superior àquela que ele estava antes de ficar bloqueado;
8. Os processos das duas primeiras filas são escalonados na modalidade Round
Robin FIFO;
9. Na fila de mais baixa prioridade (terceira fila), os processos são escalonados
segundo a abordagem First Come First Served (não preemptiva).

