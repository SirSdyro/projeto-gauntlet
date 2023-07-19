enemy_proj:
	la t0,ENEMY_3_POSPROJ			# carrega em t0 o endereco de CHAR_POS
	la t1,ENEMY_3_OLDPROJ		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,ENEMY_3_POSPROJ
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
	beq t4,t5,ENEMY_CLEAN
	li t5,0x0000001f
	beq t4,t5,ENEMY_CLEAN
	li t5,0xfffffff8		# Checa para ver se é azul/parede
	beq t4,t5,ENEMY_CLEAN_DANO
		
#######	
	la t0,ENEMY_3_POSPROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16
	sh t1,2(t0)		
	
	la t0,ENEMY_3_POSPROJ
	la a0,projetor_tiro
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy3proj
	li a3,1
	call print
		
	la t0,ENEMY_3_OLDPROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
		
	j game_loop1

ENEMY_CLEAN:
	la t0,ENEMY_3_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_3_OLDPROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,ENEMY_3_POSPROJ
	sw zero,0(t0)
	la t0,ENEMY_3_OLDPROJ
	sw zero,0(t0)
	
	j GAME_LOOP	
ENEMY_CLEAN_DANO:
	la t0,TEMPO			# Carrega o valor do tempo atual
	lb t1,0(t0)
	addi t1,t1,-10			# Decrementa 10 de dano
	sb t1,0(t0)			# Atualiza o valor do tempo
	
	la t0,TEMPO
	lb t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,56
	li a3,0x37
	ecall
	
	la t0,ENEMY_3_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_3_OLDPROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,ENEMY_3_POSPROJ
	sw zero,0(t0)
	la t0,ENEMY_3_OLDPROJ
	sw zero,0(t0)
	
	j GAME_LOOP				
