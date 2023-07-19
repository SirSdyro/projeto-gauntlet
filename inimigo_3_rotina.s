inimigo_3_rotina:
	#checa colisão
	la t0,ENEMY_3_POS
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
	beq t5,t4,CHECK_MOV
	
	la t0,ENEMY_3_PROJ
	li t1,1
	sw t1,0(t0)

	la t0,ENEMY_3_POS
	lw t1,0(t0)
	la t2,ENEMY_3_POSPROJ
	sw t1,0(t2)
	
	la t0,ENEMY_3_POSPROJ
	lh t1,2(t0)
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
	
	
CHECK_MOV:
	la t0,ENEMY_3_DIRECT
	lw t1,0(t0)
	li t2,1
	beq t1,t2,CHECK_LEFT
	li t2,2
	beq t1,t2,CHECK_RIGHT	

CHECK_LEFT:
	la t0,ENEMY_3_POS
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
	beq t5,t4,CHECK_RIGHT
	
	la t0,ENEMY_3_DIRECT
	li t1,1
	sw t1,0(t0)
	
	la t0,ENEMY_3_POS
	lw t2,0(t0)
	la t1,ENEMY_3_OLD_POS
	sw t2,0(t1)
	
	lh t1,0(t0)
	addi t1,t1,-16
	sh t1,0(t0)
	
	la t0,ENEMY_3_POS
	la a0,projetor
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy3
	li a3,1
	call print
	
	la t0,ENEMY_3_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	j game_loop1
	
CHECK_RIGHT:
	la t0,ENEMY_3_POS
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
	beq t5,t4,CHECK_LEFT
	
	la t0,ENEMY_3_DIRECT
	li t1,2
	sw t1,0(t0)
	
	la t0,ENEMY_3_POS
	lw t2,0(t0)
	la t1,ENEMY_3_OLD_POS
	sw t2,0(t1)
	
	lh t1,0(t0)
	addi t1,t1,16
	sh t1,0(t0)
	
	la t0,ENEMY_3_POS
	la a0,projetor
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile_hitbox_enemy3
	li a3,1
	call print
	
	la t0,ENEMY_3_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	j game_loop1
	
