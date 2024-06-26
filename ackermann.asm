
.data
    entrada: .asciiz "Programa de Ackermann \n"
    entrada2: .asciiz "Insira o valor de m: "
    entrada3: .asciiz "Insira o valor de n: "
    negativo: .asciiz "Valor negativo não aceito"
    m: .word 0
    n: .word 0
    result: .word 0
    printResult1: .asciiz "A("
    printResult2: .asciiz ", "
    printResult3: .asciiz ") = "

.text 
.globl main

main:
    la $a0, entrada  # pega o endereço da mensagem
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    syscall         # chama o sistema operacional para imprimir a mensagem

    la $a0, entrada2 # pega o endereço da mensagem
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    syscall         # chama o sistema operacional para imprimir a mensagem

    li $v0, 5        # passo o valor 5 para o v0 que significa leitura de inteiro
    syscall         # chama o sistema operacional para ler o valor de m
    move $t0, $v0     # move o valor de m para o registrador t0
    beq $t0, $zero, continuaM # compara se m for igual a 0, se for, continua
    blez $t0, encerra # se m for negativo, encerra o programa
continuaM:
    la $t3, m        # pega o endereço da variável m
    sw $t0, 0($t3)   # salva o valor de m na variável m
    la $a0, entrada3 # pega o endereço da mensagem
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    syscall         # chama o sistema operacional para imprimir a mensagem

    li $v0, 5        # passo o valor 5 para o v0 que significa leitura de inteiro
    syscall         # chama o sistema operacional para ler o valor de n
    move $t1, $v0     # move o valor de n para o registrador t1
    beq $t1, $zero, continuaN # se n for igual a 0, continua
    blez $t1, encerra # se n for negativo, encerra o programa
continuaN:
    la $t3, n        # pega o endereço da variável n
    sw $t1, 0($t3)   # salva o valor de n na variável n
    addi $sp, $sp, -12 # aloca espaço para os parâmetros e para o retorno
    sw $t0, 8($sp)   # salva o valor de m na pilha
    sw $t1, 4($sp)   # salva o valor de n na pilha
    sw $ra, 0($sp)   # salva o valor de retorno na pilha
    jal Ackermann   # chama a função Ackermann
    lw $ra, 0($sp)   # recupera o valor de estado da pilha
    lw $t0, 8($sp)   # recupera o valor de retorno na pilha
    addi $sp, $sp, 12 # desaloca espaço para os parâmetros e para o retorno
    la $t1, result  # pega o endereço da variável result
    sw $t0, 0($t1)  # salva o valor de retorno na variável result
    j fim           # vai terminar o programa

encerra:
    la $a0, negativo
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    syscall
    li $v0, 10       # passo o valor 10 para o v0 que significa encerrar o programa
    syscall

fim:    
    la $t5, result   # pega o endereço da variável result
    lw $t5, 0($t5)   # pega o valor da variável result
    la $t6 , m      # pega o endereço da variável m
    lw $t6, 0($t6)   # pega o valor da variável m
    la $t7 , n      # pega o endereço da variável n
    lw $t7, 0($t7)   # pega o valor da variável n
    la $t4, printResult1 # pega o endereço da string printResult1
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    move $a0, $t4    # passo o endereço da string printResult1 para o a0
    syscall
    li $v0, 1        # passo o valor 1 para o v0 que significa impressão de inteiro
    move $a0, $t6   # passo o valor de m para o a0
    syscall
    la $t4, printResult2 # pega o endereço da string printResult2
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    move $a0, $t4    # passo o endereço da string printResult2 para o a0
    syscall
    li $v0, 1        # passo o valor 1 para o v0 que significa impressão de inteiro
    move $a0, $t7   # passo o valor de n para o a0
    syscall
    la $t4, printResult3 # pega o endereço da string printResult3
    li $v0, 4        # passo o valor 4 para o v0 que significa impressão de string
    move $a0, $t4    # passo o endereço da string printResult3 para o a0
    syscall
    li $v0, 1        # passo o valor 1 para o v0 que significa impressão de inteiro
    move $a0, $t5   # passo o valor de result para o a0
    syscall
    li $v0, 11      # passo o valor 11 para o v0 que significa impressão de caractere
    li $a0, '\n'   # passo o valor de \n para o a0
    syscall

    li $v0, 10       # passo o valor 10 para o v0 que significa encerrar o programa
    syscall

### Função de Ackermann ###
# public static int Ackermann(int m, int n){
#         if(m == 0){
#             return n + 1;
#         }else if(n == 0){
#             return Ackermann(m - 1, 1);
#         }else{
#             return Ackermann(m - 1, Ackermann(m, n - 1));
#         }
#     }
Ackermann:
    lw $t0, 8($sp)   # recupera o valor de m da pilha
    lw $t1, 4($sp)   # recupera o valor de n da pilha
    beqz $t0, else1  # se m for igual a 0, vai para o else1
    beqz $t1, else2  # se n for igual a 0, vai para o else2
    addi $t1, $t1, -1 # decrementa o valor de n
    addi $sp, $sp, -16 # aloca espaço para os parâmetros e para o retorno
    sw $t0, 12($sp)  # salva o valor de m na pilha
    sw $t0, 8($sp)   # salva o valor de m na pilha
    sw $t1, 4($sp)   # salva o valor de n na pilha
    sw $ra, 0($sp)   # salva o valor de retorno na pilha
    jal Ackermann   # chama a função Ackermann para A(m, n - 1)
    lw $ra, 0($sp)   # recupera o valor de estado da pilha
    lw $t1, 8($sp)   # recupera o valor que deu na chamada recursiva
    lw $t0, 12($sp)   # recupera o valor de m da pilha
    addi $sp, $sp, 16 # desaloca espaço para os parâmetros e para o retorno
    addi $t0, $t0, -1 # decrementa o valor de m
    addi $sp, $sp, -12 # aloca espaço para os parâmetros e para o retorno
    sw $t0, 8($sp)   # salva o valor de m - 1 na pilha
    sw $t1, 4($sp)   # salva o valor de retorna da chamada recursiva A(m, n - 1) na pilha
    sw $ra, 0($sp)   # salva o valor de retorno na pilha
    jal Ackermann   # chama a função Ackermann para A(m - 1, A(m, n - 1))
    lw $ra, 0($sp)   # recupera o valor de retorno da pilha
    lw $t0, 8($sp)   # recupera o valor de retorna da chamada recursiva A(m - 1, A(m, n - 1)) na pilha
    addi $sp, $sp, 12 # desaloca espaço para os parâmetros e para o retorno
    sw $t0, 8($sp)   # salva o valor de retorna da chamada recursiva A(m - 1, A(m, n - 1)) na pilha
    jr $ra           # retorna para o endereço de retorno

else1:
    addi $t1, $t1, 1  # incrementa o valor de n
    sw $t1, 8($sp)   # salva o valor de n na pilha
    jr $ra           # retorna para o endereço de retorno

else2:
    addi $t0, $t0, -1 # decrementa o valor de m
    li $t4, 1        # coloca o valor 1 em n
    addi $sp, $sp, -16 # aloca espaço para os parâmetros e para o retorno
    sw $t1, 12($sp)   # salva o valor de n na pilha
    sw $t0, 8($sp)   # salva o valor de m - 1 na pilha
    sw $t4, 4($sp)   # salva o valor de 1 na pilha
    sw $ra, 0($sp)   # salva o valor de estado na pilha
    jal Ackermann   # chama a função Ackermann para A(m - 1, 1)
    lw $ra, 0($sp)   # recupera o valor de estado da pilha
    lw $t0, 8($sp)   # recupera o valor de retorna da chamada recursiva A(m - 1, 1) na pilha
    lw $t1, 12($sp)   # recupera o valor de n na pilha
    addi $sp, $sp, 16 # desaloca espaço para os parâmetros e para o retorno
    sw $t0, 8($sp)   # salva o valor de retorna da chamada recursiva A(m - 1, 1) na pilha
    jr $ra           # retorna para o endereço de retorno

    