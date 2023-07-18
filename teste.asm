.include "MACROSv21.s"

.data
.include "hitbox_mapateste2.data"
COORD_P1: .half 8,8
tempo: .word 0
.text

loop:
	la t2,tempo
	lw t1,0(t2)
	addi t1,t1,1
	sw t1,0(t2)
	li a7,101
	mv a0,t1
	li a1,0
	li a2,20
	li a3,0x37
	ecall
	li t6,100
	beq t1,t6,reseta
	j pula
reseta:
	la t0,tempo
	sw zero,0(t0)
pula:	
	j loop	
	
	
	
.include "SYSTEMv21.s"	

