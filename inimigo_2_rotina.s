inimigo_2_rotina:
	la t0,ENEMY_2_DIRECT
	lw t1,0(t0)
			
	li t2,1
	beq t2,t1,ENE_2_UP
 
	li t2,2
	beq t2,t1,ENE_2_DOWN
	
	li t2,3
	beq t2,t1,ENE_2_LEFT
 
	li t2,4
	beq t2,t1,ENE_2_RIGHT
	
ENE_2_UP:
	la t0,ENEMY_2_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
#######		
#checa colisão
	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,-320	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2
	
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN		
#######	
aux9:	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,-16
	sh t1,2(t0)

	la t0,ENEMY_2_POS
	la a0,babbage_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
#	li a7,32
#	li a0,50
#	ecall
	
	j game_loop1
	
		
ENE_2_DOWN:
	la t0,ENEMY_2_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######	
aux10:	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16
	sh t1,2(t0)		
	
	la t0,ENEMY_2_POS
	la a0,babbage_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
#	li a7,32
#	li a0,50
#	ecall
		
	j game_loop1
	
ENE_2_LEFT:
	la t0,ENEMY_2_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######	
#checa colisão
	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,-1	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######	
aux11:	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t6,t6,-16
	sh t6,0(t0)
			
	la t0,ENEMY_2_POS
	la a0,babbage_esquerda
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
#	li a7,32
#	li a0,50
#	ecall
		
	j game_loop1

ENE_2_RIGHT:
	la t0,ENEMY_2_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,16	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2
	
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######
aux12:
	la t0,ENEMY_2_POS
	lh t6,0(t0)
	lh t1,2(t0)			
	addi t6,t6,16
	sh t6,0(t0)
	
	la t0,ENEMY_2_POS
	la a0,babbage_direita
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2
	li a3,1
	call print
		
	la t0,ENEMY_2_POS
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
#	li a7,32
#	li a0,50
#	ecall
		
	j game_loop1
	
VIRA_DIREITA:

	la t0,ENEMY_2_DIRECT
	lw t1,0(t0)
	
	li t0,1
	beq t1,t0,vira1
	j cont1
vira1:
	la t0,ENEMY_2_DIRECT
	li t1,4
	sw t1,0(t0)
	j game_loop1
		
cont1:
	li t0,2
	beq t1,t0,vira2
	j cont2
vira2:
	la t0,ENEMY_2_DIRECT
	li t1,3
	sw t1,0(t0)
	j game_loop1
	
cont2:	
	li t0,3
	beq t1,t0,vira3
	j cont3
vira3:
	la t0,ENEMY_2_DIRECT
	li t1,1
	sw t1,0(t0)
	j game_loop1
	
cont3:	
	li t0,4
	beq t1,t0,vira4
vira4:
	la t0,ENEMY_2_DIRECT
	li t1,2
	sw t1,0(t0)
	j game_loop1
DANO_ENEMY_2:
	la t0,TEMPO			# Carrega o valor do tempo atual
	lb t1,0(t0)
	addi t1,t1,-10			# Decrementa 10 de dano
	sb t1,0(t0)			# Atualiza o tempo
	
	la t0,TEMPO
	lb t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,56
	li a3,0x37
	ecall
	
	la t0,ENEMY_2_DIRECT
	lw t1,0(t0)
	
	li t2,1
	beq t1,t2,aux9
	
	li t2,2
	beq t1,t2,aux10
	
	li t2,3
	beq t1,t2,aux11
	
	li t2,4
	beq t1,t2,aux12

#########	
									
			