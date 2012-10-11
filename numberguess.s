.globl main
.data
  greet: .asciiz  "Welcome to the Number Guessing Game!\n"
  lower: .asciiz  "Lower!\n"
 higher: .asciiz  "Higher!\n"
 prompt: .asciiz  "Enter value [0,1000]: "
 winner: .asciiz  "Congratulations, you won!"

  bound: .word    1001

.text
main:
	li $v0, 4       #set system call code to print string
	la $a0, greet   #load prompt1 string in to a0
	syscall         #print a0
	j pickrandom

pickrandom:
	li $v0, 42      #set syscall to number generator
	li $a0, 1337    #set generator id
	lw $a1, bound   #set upper bound to the bound
	syscall
	move $t0, $a0   #store goal number in t0
	j promptuser

promptuser:
	li $v0, 4
	la $a0, prompt
	syscall         #print prompt
	li $v0, 5
	syscall         #get guess from user
	move $t1, $v0   #store guess in t1
	j check

check:
	blt $t1, $t0, sayhigher
	bgt $t1, $t0, saylower
	beq $t1, $t0, saywin
	
saylower:
	li $v0, 4
	la $a0, lower
	syscall
	j promptuser

sayhigher:
	li $v0, 4
	la $a0, higher
	syscall
	j promptuser

saywin:
	li $v0, 4
	la $a0, winner
	syscall
	j exit

exit:
	li $v0, 10      #set syscall to exit
	syscall         #exit
