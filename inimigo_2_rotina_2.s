inimigo_2_rotina_2:
	la t0,ENEMY_2_DIRECT_2
	lw t1,0(t0)
			
	li t2,1
	beq t2,t1,ENE_2_UP_2
 
	li t2,2
	beq t2,t1,ENE_2_DOWN_2
	
	li t2,3
	beq t2,t1,ENE_2_LEFT_2
 
	li t2,4
	beq t2,t1,ENE_2_RIGHT_2
	
ENE_2_UP_2:
	la t0,ENEMY_2_POS_2			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS_2		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
#######		
#checa colisão
	la t0,ENEMY_2_POS_2
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
	beq t4,t5,VIRA_DIREITA_2
	li t5,0x00000037		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA_2	
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2_2
	
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN		
#######	
aux9_2:	la t0,ENEMY_2_POS_2
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,-16
	sh t1,2(t0)

	la t0,ENEMY_2_POS_2
	la a0,moto_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2_2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS_2
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS_2
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
	
	j inimigo_3
	
		
ENE_2_DOWN_2:
	la t0,ENEMY_2_POS_2			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS_2		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,ENEMY_2_POS_2
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
	beq t4,t5,VIRA_DIREITA_2
	li t5,0x00000037		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA_2
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2_2
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######	
aux10_2:	la t0,ENEMY_2_POS_2
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16
	sh t1,2(t0)		
	
	la t0,ENEMY_2_POS_2
	la a0,moto_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2_2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS_2
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS_2
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
		
	j inimigo_3
	
ENE_2_LEFT_2:
	la t0,ENEMY_2_POS_2			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS_2		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######	
#checa colisão
	la t0,ENEMY_2_POS_2
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
	beq t4,t5,VIRA_DIREITA_2
	li t5,0x00000037		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA_2
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2_2
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######	
aux11_2:	la t0,ENEMY_2_POS_2
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t6,t6,-16
	sh t6,0(t0)
			
	la t0,ENEMY_2_POS_2
	la a0,moto_esquerda
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2_2
	li a3,1
	call print
	
	la t0,ENEMY_2_POS_2
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS_2
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
		
	j inimigo_3

ENE_2_RIGHT_2:
	la t0,ENEMY_2_POS_2			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_2_OLD_POS_2		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,ENEMY_2_POS_2
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
	beq t4,t5,VIRA_DIREITA_2
	li t5,0x00000037		# Checa para ver se é azul/parede
	beq t4,t5,VIRA_DIREITA_2
	li t5,0xfffffff8
	beq t4,t5,DANO_ENEMY_2_2
	
#	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
#	beq t4,t5,CLEAN	
#######
aux12_2:
	la t0,ENEMY_2_POS_2
	lh t6,0(t0)
	lh t1,2(t0)			
	addi t6,t6,16
	sh t6,0(t0)
	
	la t0,ENEMY_2_POS_2
	la a0,moto_direita
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy2_2
	li a3,1
	call print
		
	la t0,ENEMY_2_POS_2
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,ENEMY_2_OLD_POS_2
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
		
	j inimigo_3
	
VIRA_DIREITA_2:

	la t0,ENEMY_2_DIRECT_2
	lw t1,0(t0)
	
	li t0,1
	beq t1,t0,vira1_2
	j cont1_2
vira1_2:
	la t0,ENEMY_2_DIRECT_2
	li t1,4
	sw t1,0(t0)
	j inimigo_3
		
cont1_2:
	li t0,2
	beq t1,t0,vira2_2
	j cont2_2
vira2_2:
	la t0,ENEMY_2_DIRECT_2
	li t1,3
	sw t1,0(t0)
	j inimigo_3
	
cont2_2:	
	li t0,3
	beq t1,t0,vira3_2
	j cont3_2
vira3_2:
	la t0,ENEMY_2_DIRECT_2
	li t1,1
	sw t1,0(t0)
	
	j inimigo_3
	
cont3_2:	
	li t0,4
	beq t1,t0,vira4_2
vira4_2:
	la t0,ENEMY_2_DIRECT_2
	li t1,2
	sw t1,0(t0)
	
	j inimigo_3
DANO_ENEMY_2_2:
	la t0,TEMPO			# Carrega o valor do tempo atual
	lb t1,0(t0)
	addi t1,t1,-10			# Decrementa 10 de dano
	j EFC_EFECT_DANO_ENEMY_2_2
	continue_DANO_ENEMY_2_2:
	sb t1,0(t0)			# Atualiza o tempo
	
	la t0,TEMPO
	lb t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,108
	li a3,0x0737
	ecall
	
	la t0,ENEMY_2_DIRECT_2
	lw t1,0(t0)
	
	li t2,1
	beq t1,t2,aux9_2
	
	li t2,2
	beq t1,t2,aux10_2
	
	li t2,3
	beq t1,t2,aux11_2
	
	li t2,4
	beq t1,t2,aux12_2

#########
