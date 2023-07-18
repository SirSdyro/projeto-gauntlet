SELECMELEE:
	li t1, '1'
	beq t0, t1, ATAQUE_LAMAR        #manda o programa para os checks do babbage

	li t1, '3'
	beq t0, t1, ATAQUE_BAB        #manda o programa para os checks do babbage
 
ATAQUE_LAMAR:
 
	la t1,lamar_cima
	beq t1,s3,CHECKCIMALAMAR
 
	la t1,lamar_baixo
	beq t1,s3,CHECKBAIXOLAMAR
	
	la t1,lamar_esquerda
	beq t1,s3,CHECKLEFTLAMAR
 
	la t1,lamar_direita
	beq t1,s3,CHECKRIGHTLAMAR
 
CHECKCIMALAMAR:

	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,-16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_MELEE
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
	bne t4,t5,aux1
	j GAME_LOOP
aux1:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########
continue_melee1:	
	la t0,POS_MELEE
	la a0,memoria_ram_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP
		
CHECKBAIXOLAMAR:
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux2
	j GAME_LOOP
aux2:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########
continue_melee2:	
	la t0,POS_MELEE
	la a0,memoria_ram_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP
		
CHECKLEFTLAMAR:

	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,-16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_MELEE
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
	bne t4,t5,aux3
	j GAME_LOOP
aux3:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########	
continue_melee3:	
	la t0,POS_MELEE
	la a0,memoria_ram_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP
 	
CHECKRIGHTLAMAR:
	
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux4
	j GAME_LOOP
aux4:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########	
continue_melee4:	
	la t0,POS_MELEE
	la a0,memoria_ram_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP
	
########
CPCTR_KILL_MELEE:
	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,200
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,76
	li a3,0xFF
	ecall

	la t0,ENEMY_1_SWITCH
	sw zero,0(t0)
	
	la t0,ENEMY_1_POS
	la a0,tile1
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,1
	call print
	
	la t0,lamar_cima
	beq t0,s3,continue_melee1

	la t0,lamar_baixo
	beq t0,s3,continue_melee2
	
	la t0,lamar_esquerda
	beq t0,s3,continue_melee3
	
	la t0,lamar_direita
	beq t0,s3,continue_melee4
	
	la t0,babbage_cima
	beq t0,s3,continue_melee5

	la t0,babbage_baixo
	beq t0,s3,continue_melee6
	
	la t0,babbage_esquerda
	beq t0,s3,continue_melee7
	
	la t0,babbage_direita
	beq t0,s3,continue_melee8
	
ATAQUE_BAB:
 
	la t1,babbage_cima
	beq t1,s3,CIMABAB
 
	la t1,babbage_baixo
	beq t1,s3,BAIXOBAB
	
	la t1,babbage_esquerda
	beq t1,s3,LEFTBAB
 
	la t1,babbage_direita
	beq t1,s3,RIGHTBAB
CIMABAB:
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,-16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	mv s8,t4
	
	li t5,320
	li t3,15
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux5
	j GAME_LOOP
aux5:	
	addi t4,s8,-1
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,-1
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########
continue_melee5:	
	la t0,POS_MELEE
	la a0,memoria_ram_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
 
	j GAME_LOOP
BAIXOBAB:
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,2(t2)
	addi t1,t1,16
	sh t1,2(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	mv s8,t4
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux6
	j GAME_LOOP
aux6:	
	addi t4,s8,-1
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,-1
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE			
########
continue_melee6:	
	la t0,POS_MELEE
	la a0,memoria_ram_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP
LEFTBAB:
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,-16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	mv s8,t4
	
	addi t4,t4,15
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux7
	j GAME_LOOP
aux7:	
	addi t4,s8,0
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,-16
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,-16
	li t5,320
	li t3,0
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,-16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE	

########	
continue_melee7:	
	la t0,POS_MELEE
	la a0,memoria_ram_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
 	j GAME_LOOP
RIGHTBAB:
	la t0,CHAR_POS
	lw t1,0(t0)
	la t2,POS_MELEE
	sw t1,0(t2)
	lh t1,0(t2)
	addi t1,t1,16
	sh t1,0(t2)
########	
#checa colisão
	la t0,POS_MELEE
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	mv s8,t4
	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,aux8
	j GAME_LOOP
aux8:	
	addi t4,s8,0
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	li t5,320
	li t3,0
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	
	addi t4,s8,16
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
########	
continue_melee8:	
	la t0,POS_MELEE
	la a0,memoria_ram_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,250
	ecall
	la a0,tile
	li a3,0
	call print
	
	j GAME_LOOP		
