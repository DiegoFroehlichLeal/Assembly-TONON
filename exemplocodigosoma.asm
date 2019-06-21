;______________________________________________________________
;o programa irá pedir ao usuário que digite dois valores, armazena os valores nos registro EAX e EBX, respectivamente,
;armazenaa o resultado em um local de memória 'res' e finalmente mostra o resultado.
;Alunos:
;Diego Froehlich Leal
;Marco Antônio Garcez
;
;INTRODUÇÃO À ORGANIZAÇÃO DE COMPUTADORES
;Professor - Marcos Tonon Alcantara
;______________________________________________________________
SYS_EXIT  equ 1
SYS_READ  equ 3
SYS_WRITE equ 4
STDIN     equ 0
STDOUT    equ 1

segment .data

   msg1 db "Digite um numero: ", 0xA,0xD
   len1 equ $- msg1

   msg2 db "Digite outro numero: ", 0xA,0xD
   len2 equ $- msg2

   msg3 db "A soma é "
   len3 equ $- msg3

segment .bss

  num1 resb 2
  num2 resb 2
  res resb 1
  ;______________________________________________________________
            ;resb reserva a memoria a ser usada, mas não necessariamente
            ;está sendo usada no momento, apenas alocada
            ;RESB  = Reserve Byte         -> reserva 1 byte
            ;RESW  = Reserve Word         -> reserva 2 bytes
            ;RESD  = Reserve Doubleword   -> reserva 4 bytes
            ;RESQ  = Reserve Quadword     -> reserva 8 bytes
            ;REST  = Reserve Ten          -> reserva 10 bytes
    ;______________________________________________________________

section	.text
   global _start

_start:             ;informa o inicio do programa
;______________________________________________________________
;Bloco de escrita e leitura do primeiro numero
;ax ->acumulador primário para entrada e saida e na maioria das instruções aritméticas
;bx ->acumulador de registro base pode ser usado em endereçamento indexado
;cx ->registro de contagem, pois os registradores ECX, CX armazenam a contagem de loop em operações iterativas
;dx ->usado em operações de entrada / saída. Ele também é usado com o registro AX junto com o DX para operações de multiplicação e divisão envolvendo grandes valores
;______________________________________________________________
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg1
   mov edx, len1
   int 0x80

   mov eax, SYS_READ
   mov ebx, STDIN
   mov ecx, num1
   mov edx, 2
   int 0x80 ; Informa ao Kernel que está acontecendo
;______________________________________________________________
;Bloco de escrita e leitura do segundo numero
;______________________________________________________________
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg2
   mov edx, len2
   int 0x80

   mov eax, SYS_READ
   mov ebx, STDIN
   mov ecx, num2
   mov edx, 2
   int 0x80
;______________________________________________________________
;Bloco de escrita da soma dos dois numeros
;______________________________________________________________
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, msg3
   mov edx, len3
   int 0x80
;______________________________________________________________
; movemos o primeiro numero para registro eax e o segundo para o ebx
; e subtraindo ascii '0' para convertê-lo em um número decimal
;______________________________________________________________
   mov eax, [num1]
   sub eax, '0'

   mov ebx, [num2]
   sub ebx, '0'
;______________________________________________________________
; somamos eax e ebx
; somamos com '0' para converter a soma de decimal para ASCII
;______________________________________________________________
   add eax, ebx
   add eax, '0'
;______________________________________________________________
; guarda a soma na memoria reservada (res)
;______________________________________________________________
   mov [res], eax
;______________________________________________________________
; mostramos o resultado
;______________________________________________________________
   mov eax, SYS_WRITE
   mov ebx, STDOUT
   mov ecx, res
   mov edx, 1
   int 0x80
exit:    ;informa o fim do programa

   mov eax, SYS_EXIT
   xor ebx, ebx ;muda o bit pra 0 indiferente se a entrada for 1 ou 0 para encerrar o programa
   int 0x80
