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
