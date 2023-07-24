.data
NUM_ataque_ada: .word 2
NOTAS_ataque_ada: 71,100,78,100

NUM_ataque_alan: .word 4
NOTAS_ataque_alan: 71,50,65,50,71,50,65,50

.text
SELECPROJ:
	li t1, '2'
	beq t0, t1, ATAQUE_ADA        #manda o programa para os checks do babbage

	li t1, '4'
	beq t0, t1, ATAQUE_TURING        #manda o programa para os checks do babbage
		
ATAQUE_ADA:
	la t0,TEMPO_COOLDOWN
	li t1,2
	sw t1,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,157
	li a3,0x5bff
	ecall

	la t0,ATK_PROJ
	lw t1,0(t0)
	li t2,1
	bne t1,t2,gaviao
	j GAME_LOOP
gaviao:	
 	la t0,ATK_PROJ
	li t1,1
	sw t1,0(t0)
	
	la t1,ada_cima
	beq t1,s3,CIMA
 
	la t1,ada_baixo
	beq t1,s3,BAIXO
	
	la t1,ada_esquerda
	beq t1,s3,LEFT
 
	la t1,ada_direita
	beq t1,s3,RIGHT
CIMA:
	li t1,1
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,-16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	li t5,320
	li t3,15
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,ada_atk_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,papel_perfurado_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_ada1:	la s4,NUM_ataque_ada
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ada		
			li s6,0			
			li a2,83		
			li a3,112
LOOP_ataque_ada1:	beq s6,s5, FIM_ataque_ada1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_ada1		
FIM_ataque_ada1:	
	j GAME_LOOP
BAIXO:
	li t1,2
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,ada_atk_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,papel_perfurado_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_ada2:	la s4,NUM_ataque_ada
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ada		
			li s6,0			
			li a2,83		
			li a3,112
LOOP_ataque_ada2:	beq s6,s5, FIM_ataque_ada2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_ada1		
FIM_ataque_ada2:		
	j GAME_LOOP
LEFT:
	li t1,3
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,-16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,15
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,ada_atk_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,papel_perfurado_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_ada3:	la s4,NUM_ataque_ada
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ada		
			li s6,0			
			li a2,83		
			li a3,112
LOOP_ataque_ada3:	beq s6,s5, FIM_ataque_ada3
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_ada3		
FIM_ataque_ada3:	
	j GAME_LOOP	
RIGHT:
	li t1,4
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	
	lh t1,0(t2)
	addi t1,t1,16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,ada_atk_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,papel_perfurado_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_ada4:	la s4,NUM_ataque_ada
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ada		
			li s6,0			
			li a2,83		
			li a3,112
LOOP_ataque_ada4:	beq s6,s5, FIM_ataque_ada4
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_ada4		
FIM_ataque_ada4:	
	j GAME_LOOP		
##########
PROJ_RESET:
	la t0,DIRECAO_PROJ
	sw zero,0(t0)
	la t0,ATK_PROJ
	sw zero,0(t0)
	j GAME_LOOP
##########

ATAQUE_TURING:
	la t0,TEMPO_COOLDOWN
	li t1,4
	sw t1,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,157
	li a3,0x5bff
	ecall

	la t0,ATK_PROJ
	lw t1,0(t0)
	li t2,1
	bne t1,t2,gaviao2
	j GAME_LOOP
gaviao2:	
 	la t0,ATK_PROJ
	li t1,1
	sw t1,0(t0)
	
	la t1,turing_cima
	beq t1,s3,CIMA2
 
	la t1,turing_baixo
	beq t1,s3,BAIXO2
	
	la t1,turing_esquerda
	beq t1,s3,LEFT2
 
	la t1,turing_direita
	beq t1,s3,RIGHT2
CIMA2:
	li t1,1
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,-16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	li t5,320
	li t3,15
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,turing_atk_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,bits_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_alan1:	la s4,NUM_ataque_alan
			lw s5,0(s4)		
			la s4,NOTAS_ataque_alan		
			li s6,0			
			li a2,124		
			li a3,112
LOOP_ataque_alan1:	beq s6,s5, FIM_ataque_alan1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_alan1		
FIM_ataque_alan1:	
	j GAME_LOOP
BAIXO2:
	li t1,2
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,turing_atk_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,bits_down
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_alan2:	la s4,NUM_ataque_alan
			lw s5,0(s4)		
			la s4,NOTAS_ataque_alan		
			li s6,0			
			li a2,124		
			li a3,112
LOOP_ataque_alan2:	beq s6,s5, FIM_ataque_alan2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_alan2		
FIM_ataque_alan2:		
	j GAME_LOOP
LEFT2:
	li t1,3
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,-16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,15
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,turing_atk_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,bits_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_alan3:	la s4,NUM_ataque_alan
			lw s5,0(s4)		
			la s4,NOTAS_ataque_alan		
			li s6,0			
			li a2,124		
			li a3,112
LOOP_ataque_alan3:	beq s6,s5, FIM_ataque_alan3
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_alan3		
FIM_ataque_alan3:	
	j GAME_LOOP	
RIGHT2:
	li t1,4
	la t0,DIRECAO_PROJ
	sw t1,0(t0)
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_PROJ
	sw t1,0(t2)
	
	lh t1,0(t2)
	addi t1,t1,16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,PROJ_RESET
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,PROJ_RESET
	li t5,0x00000007
	beq t4,t5,PROJ_RESET
	li t5,0x00000005
	beq t4,t5,PROJ_RESET
	li t5,0xffffffcd
	beq t4,t5,PROJ_RESET
########	
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	la a0,turing_atk_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	la a0,bits_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	la t0,CHAR_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la t0,CHAR_POS
	mv a0,s3
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
EFECT_ataque_alan4:	la s4,NUM_ataque_alan
			lw s5,0(s4)		
			la s4,NOTAS_ataque_alan		
			li s6,0			
			li a2,124		
			li a3,112
LOOP_ataque_alan4:	beq s6,s5, FIM_ataque_alan4
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j LOOP_ataque_alan4		
FIM_ataque_alan4:	
	j GAME_LOOP			
