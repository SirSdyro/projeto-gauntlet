SELECPROJ:
	li t1, '2'
	beq t0, t1, ATAQUE_ADA        #manda o programa para os checks do babbage

#	li t1, '4'
#	beq t0, t1, ATAQUE_TURING        #manda o programa para os checks do babbage	
ATAQUE_ADA:
	j ATAQUE_PROJ 
	
ATAQUE_PROJ:
	la t0,ATK_PROJ
	lw t1,0(t0)
	li t2,1
	beq t1,t2,GAME_LOOP
	
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
########	
	
	la t0,POS_PROJ
	la a0,papel_perfurado_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
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
########	
	
	la t0,POS_PROJ
	la a0,papel_perfurado_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
		
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
########	
	
	la t0,POS_PROJ
	la a0,papel_perfurado_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
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
########	
	
	la t0,POS_PROJ
	la a0,papel_perfurado_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	j GAME_LOOP		
##########
PROJ_RESET:
	la t0,DIRECAO_PROJ
	sw zero,0(t0)
	la t0,ATK_PROJ
	sw zero,0(t0)
	j GAME_LOOP
##########		
