.data
.include "hitbox_mapateste2.data"
COORD_P1: .half 8,8
.text
	la t0,COORD_P1
	lh t1,0(t0)		# t1 = x
	lh t2,2(t0)		# t2 = y
	#addi t2,t2,16	# olha o pixel acima dele

	la t3,hitbox_mapateste2		# endereco da hitbox do mapa atual
	addi t3,t3,8 	# primeiro 8 pixels depois das informacoes de nlin ncol
	mv a2,t3		# copia endereco do mapa da hitbox

	#li t5,240
	#sub a0,t5,t2	# y = 240 - y
	
	li t5,320
	mul a1,t2,t5	# y * 320
	add a1,a1,t1	# a1 += x
	add a2,a1,a2

	#add t3,t3,a1	# parte da esquerda do sprite

	#addi a1,a1,-1
	#add a2,a2,a1	# parte da direita do sprite

	lw t4,0(a2)
	#lb t6,0(a2)

