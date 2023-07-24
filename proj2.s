proj2:
	la t0,ATK_PROJ
	lw t1,0(t0)
	bne t1,zero,projac2
	j inimigo_1
projac2:	
	la t0,DIRECAO_PROJ
	lw t1,0(t0)
			
	li t2,1
	beq t2,t1,MOV_CIMA2
 
	li t2,2
	beq t2,t1,MOV_BAIXO2
	
	li t2,3
	beq t2,t1,MOV_LEFT2
 
	li t2,4
	beq t2,t1,MOV_RIGHT2
	
MOV_CIMA2:
	la t0,POS_PROJ			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_POS_PROJ		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
		
#######		
#checa colisão
	la t0,POS_PROJ
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
	beq t4,t5,CLEAN2
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN2
	li t5,0x0000001f
	beq t4,t5,CLEAN2	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL2
	li t5,0x00000005
	beq t4,t5,MOTO_KILL2
	li t5,0x00000004
	beq t4,t5,MOTO_KILL2_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL2
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL2		
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,-16
	sh t1,2(t0)

	la t0,POS_PROJ
	la a0,bits_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,POS_PROJ
	sh a1,0(t0)
	sh a2,2(t0)
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
	
	j inimigo_1
	
MOV_BAIXO2:
	la t0,POS_PROJ			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_POS_PROJ		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
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
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	beq t4,t5,CLEAN2
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN2
	li t5,0x0000001f
	beq t4,t5,CLEAN2	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL2
	li t5,0x00000005
	beq t4,t5,MOTO_KILL2
	li t5,0x00000004
	beq t4,t5,MOTO_KILL2_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL2
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL2		
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16
	sh t1,2(t0)		
	
	la t0,POS_PROJ
	la a0,bits_down
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
		
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
		
	j inimigo_1
	
MOV_LEFT2:
	la t0,POS_PROJ			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_POS_PROJ		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######	
#checa colisão
	la t0,POS_PROJ
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
	beq t4,t5,CLEAN2
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN2
	li t5,0x0000001f
	beq t4,t5,CLEAN2	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL2
	li t5,0x00000005
	beq t4,t5,MOTO_KILL2
	li t5,0x00000004
	beq t4,t5,MOTO_KILL2_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL2
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL2	
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t6,t6,-16
	sh t6,0(t0)
			
	la t0,POS_PROJ
	la a0,bits_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
		
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
		
	j inimigo_1

MOV_RIGHT2:
	la t0,POS_PROJ			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_POS_PROJ		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
#######		
#checa colisão
	la t0,POS_PROJ
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
	beq t4,t5,CLEAN2
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN2
	li t5,0x0000001f
	beq t4,t5,CLEAN2	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL2
	li t5,0x00000005
	beq t4,t5,MOTO_KILL2
	li t5,0x00000004
	beq t4,t5,MOTO_KILL2_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL2
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL2		
#######
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			
	addi t6,t6,16
	sh t6,0(t0)
	
	la t0,POS_PROJ
	la a0,bits_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
		
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,50
	ecall
		
	j inimigo_1
CLEAN2:
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	j GAME_LOOP
	
CPCTR_KILL2:
	la t0,ATK_PROJ
	sw zero,0(t0)

	la t0,ENEMY_1_SWITCH
	lw t1,0(t0)
	addi t1,t1,-2
	sw t1,0(t0)
	
	la t0,ENEMY_1_SWITCH
	lw t1,0(t0)
	bgt t1,zero,ck_aux2
	
	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,300
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,132
	li a3,0x5bFF
	ecall
	
	la t0,ENEMY_1_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
ck_aux2:	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
MOTO_KILL2:
	la t0,ATK_PROJ
	sw zero,0(t0)

	la t0,ENEMY_2_SWITCH
	lw t1,0(t0)
	addi t1,t1,-2
	sw t1,0(t0)
	
	la t0,ENEMY_2_SWITCH
	lw t1,0(t0)
	bgt t1,zero,mk_aux2

	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,200
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,132
	li a3,0x5bFF
	ecall
		
	la t0,ENEMY_2_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
mk_aux2:	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
	
MOTO_KILL2_2:
	la t0,ATK_PROJ
	sw zero,0(t0)

	la t0,ENEMY_2_SWITCH_2
	lw t1,0(t0)
	addi t1,t1,-2
	sw t1,0(t0)
	
	la t0,ENEMY_2_SWITCH_2
	lw t1,0(t0)
	bgt t1,zero,mk_aux2_2

	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,200
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,132
	li a3,0x5bFF
	ecall
		
	la t0,ENEMY_2_POS_2
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
mk_aux2_2:	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1	
	
PROJETOR_KILL2:
	la t0,ATK_PROJ
	sw zero,0(t0)

	la t0,ENEMY_3_SWITCH
	lw t1,0(t0)
	addi t1,t1,-2
	sw t1,0(t0)
	
	la t0,ENEMY_3_SWITCH
	lw t1,0(t0)
	bgt t1,zero,pk_aux2

	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,150
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,132
	li a3,0x5bFF
	ecall
	
	la t0,ENEMY_3_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
pk_aux2:	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
	
PROJETOR_PROJ_KILL2:
	la t0,ENEMY_3_PROJ
	sw zero,0(t0)
	
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_3_POSPROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,ENEMY_3_OLDPROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1		
