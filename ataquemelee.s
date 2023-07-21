.data

NUM_ataque_ram: .word 2
NOTAS_ataque_ram: 85,50,85,50

NUM_ataque_maquina: .word 2
NOTAS_ataque_maquina: 85,50,85,50

.text
SELECMELEE:
	li t1, '1'
	bne t0, t1, urubu1        #manda o programa para os checks do babbage
	j ATAQUE_LAMAR
urubu1:
	li t1, '3'
	bne t0, t1, urubu2        #manda o programa para os checks do babbage
 	j ATAQUE_BAB
urubu2:	
ATAQUE_LAMAR:
	la t0,TEMPO_COOLDOWN
	li t1,2
	sw t1,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,96
	li a3,0xff
	ecall
 
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
	bne t4,t5,urubu3
	j CPCTR_KILL_MELEE
urubu3:	li t5,0x00000005
	bne t4,t5,urubu4
	j MOTO_KILL_MELEE	
urubu4:	li t5,0x00000004
	bne t4,t5,urubu4_2
	j MOTO_KILL_MELEE_2	
urubu4_2:
	li t5,0xffffffcd
	bne t4,t5,urubu5
	j PROJETOR_KILL_MELEE
urubu5:	
########
continue_melee1:	
	la t0,POS_MELEE
	la a0,memoria_ram_cima
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_ram1:	la s4,NUM_ataque_ram
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ram		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_ram1:	beq s6,s5, FIM_ataque_ram1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_ram1:		
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
	bne t4,t5,urubu6
	j CPCTR_KILL_MELEE
urubu6:	li t5,0x00000005
	bne t4,t5,urubu7
	j MOTO_KILL_MELEE
urubu7:	li t5,0x00000004
	bne t4,t5,urubu7_2
	j MOTO_KILL_MELEE_2	
urubu7_2:	
	li t5,0xffffffcd
	bne t4,t5,urubu8
	j PROJETOR_KILL_MELEE
urubu8:	
########
continue_melee2:	
	la t0,POS_MELEE
	la a0,memoria_ram_baixo
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_ram2:	la s4,NUM_ataque_ram
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ram	
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_ram2:	beq s6,s5, FIM_ataque_ram2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_ram2:	
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
	bne t4,t5,urubu9
	j CPCTR_KILL_MELEE
urubu9:	li t5,0x00000005
	bne t4,t5,urubu10
	j MOTO_KILL_MELEE
urubu10:li t5,0x00000004
	bne t4,t5,urubu10_2
	j MOTO_KILL_MELEE_2	
urubu10_2:
	li t5,0xffffffcd
	bne t4,t5,urubu11
	j PROJETOR_KILL_MELEE
urubu11:	
########	
continue_melee3:	
	la t0,POS_MELEE
	la a0,memoria_ram_left
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_ram3:	la s4,NUM_ataque_ram
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ram
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_ram3:	beq s6,s5, FIM_ataque_ram3
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_ram3:	
	
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
	bne t4,t5,urubu12
	j CPCTR_KILL_MELEE
urubu12:li t5,0x00000005
	bne t4,t5,urubu13
	j MOTO_KILL_MELEE
urubu13:li t5,0x00000004
	bne t4,t5,urubu13_2
	j MOTO_KILL_MELEE_2	
urubu13_2:
	li t5,0xffffffcd
	bne t4,t5,urubu14
	j PROJETOR_KILL_MELEE
urubu14:	
########	
continue_melee4:	
	la t0,POS_MELEE
	la a0,memoria_ram_right
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_ram4:	la s4,NUM_ataque_ram
			lw s5,0(s4)		
			la s4,NOTAS_ataque_ram		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_ram4:	beq s6,s5, FIM_ataque_ram4
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_ram4:	
	j GAME_LOOP
	
########
CPCTR_KILL_MELEE:

	la t0,ENEMY_1_SWITCH
	lw t1,0(t0)
	
	la t2,CHAR_SELECT
	lw t3,0(t2)
	
	li t2,'1'
	beq t2,t3,dano_lamar1
	li t2,'3'
	beq t2,t3,dano_babbage1
	
dano_lamar1:	
	addi t1,t1,-1
	j ckm_aux2
dano_babbage1:	
	addi t1,t1,-2
	j ckm_aux2	
ckm_aux2:
	sw t1,0(t0)
	
	la t0,ENEMY_1_SWITCH
	lw t1,0(t0)
	bgt t1,zero,ckm_aux
	
	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,350
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,76
	li a3,0xFF
	ecall
	
	la t0,ENEMY_1_POS
	la a0,tile1
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,1
	call print
	la a0,tile
	li a3,0
	call print
	
ckm_aux:	
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
	
MOTO_KILL_MELEE:

	la t0,ENEMY_2_SWITCH
	lw t1,0(t0)
	
	la t2,CHAR_SELECT
	lw t3,0(t2)
	
	li t2,'1'
	beq t2,t3,dano_lamar2
	li t2,'3'
	beq t2,t3,dano_babbage2
	
dano_lamar2:	
	addi t1,t1,-1
	j mkm_aux2
dano_babbage2:	
	addi t1,t1,-2
	j mkm_aux2	
mkm_aux2:
	sw t1,0(t0)
	
	la t0,ENEMY_2_SWITCH
	lw t1,0(t0)
	bgt t1,zero,mkm_aux
	
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
	
	la t0,ENEMY_2_POS
	la a0,tile1
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,1
	call print
	la a0,tile
	li a3,0
	call print
	
mkm_aux:	
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

MOTO_KILL_MELEE_2:

	la t0,ENEMY_2_SWITCH_2
	lw t1,0(t0)
	
	la t2,CHAR_SELECT
	lw t3,0(t2)
	
	li t2,'1'
	beq t2,t3,dano_lamar2_2
	li t2,'3'
	beq t2,t3,dano_babbage2_2
	
dano_lamar2_2:	
	addi t1,t1,-1
	j mkm_aux2_2
dano_babbage2_2:	
	addi t1,t1,-2
	j mkm_aux2_2	
mkm_aux2_2:
	sw t1,0(t0)
	
	la t0,ENEMY_2_SWITCH_2
	lw t1,0(t0)
	bgt t1,zero,mkm_aux_2
	
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
	
	la t0,ENEMY_2_POS_2
	la a0,tile1
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,1
	call print
	la a0,tile
	li a3,0
	call print
	
mkm_aux_2:	
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
	
PROJETOR_KILL_MELEE:
	la t0,ENEMY_3_SWITCH
	lw t1,0(t0)
	
	la t2,CHAR_SELECT
	lw t3,0(t2)
	
	li t2,'1'
	beq t2,t3,dano_lamar3
	li t2,'3'
	beq t2,t3,dano_babbage3
	
dano_lamar3:	
	addi t1,t1,-1
	j pkm_aux2
dano_babbage3:	
	addi t1,t1,-2
	j pkm_aux2	
pkm_aux2:
	sw t1,0(t0)
	
	la t0,ENEMY_3_SWITCH
	lw t1,0(t0)
	bgt t1,zero,pkm_aux
	
	la t0,SCORE
	lw t1,0(t0)
	addi t1,t1,150
	sw t1,0(t0)
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,76
	li a3,0xFF
	ecall
	
	la t0,ENEMY_3_POS
	la a0,tile1
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,1
	call print
	la a0,tile
	li a3,0
	call print
pkm_aux:	
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
	la t0,TEMPO_COOLDOWN
	li t1,5
	sw t1,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,96
	li a3,0xff
	ecall
 
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
aux5:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	li t5,0x00000005
	beq t4,t5,MOTO_KILL_MELEE
	li t5,0x00000004
	beq t4,t5,MOTO_KILL_MELEE_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL_MELEE
	
	addi t4,s8,-1
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu15
	j CPCTR_KILL_MELEE
urubu15:li t5,0x00000005
	bne t4,t5,urubu16
	j MOTO_KILL_MELEE
urubu16:li t5,0x00000004
	bne t4,t5,urubu16_2
	j MOTO_KILL_MELEE_2	
urubu16_2:
	li t5,0xffffffcd
	bne t4,t5,urubu17
	j PROJETOR_KILL_MELEE
urubu17:
	addi t4,s8,16
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu18
	j CPCTR_KILL_MELEE
urubu18:li t5,0x00000005
	bne t4,t5,urubu19
	j MOTO_KILL_MELEE
urubu19:li t5,0x00000004
	bne t4,t5,urubu19_2
	j MOTO_KILL_MELEE_2	
urubu19_2:
	li t5,0xffffffcd
	bne t4,t5,urubu20
	j PROJETOR_KILL_MELEE
urubu20:
	addi t4,s8,-1
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu21
	j CPCTR_KILL_MELEE
urubu21:li t5,0x00000005
	bne t4,t5,urubu22
	j MOTO_KILL_MELEE
urubu22:li t5,0x00000004
	bne t4,t5,urubu22_2
	j MOTO_KILL_MELEE_2	
urubu22_2:
	li t5,0xffffffcd
	bne t4,t5,urubu23
	j PROJETOR_KILL_MELEE
urubu23:
	addi t4,s8,0
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu24
	j CPCTR_KILL_MELEE
urubu24:li t5,0x00000005
	bne t4,t5,urubu25
	j MOTO_KILL_MELEE
urubu25:li t5,0x00000004
	bne t4,t5,urubu25_2
	j MOTO_KILL_MELEE_2	
urubu25_2:
	li t5,0xffffffcd
	bne t4,t5,urubu26
	j PROJETOR_KILL_MELEE
urubu26:
	addi t4,s8,16
	li t5,320
	li t3,-16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu27
	j CPCTR_KILL_MELEE
urubu27:li t5,0x00000005
	bne t4,t5,urubu28
	j MOTO_KILL_MELEE
urubu28:li t5,0x00000004
	bne t4,t5,urubu28_2
	j MOTO_KILL_MELEE_2	
urubu28_2:
	li t5,0xffffffcd
	bne t4,t5,urubu29
	j PROJETOR_KILL_MELEE
urubu29:
########
continue_melee5:	
	la t0,POS_MELEE
	la a0,maquina_babbage
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_maquina1:	la s4,NUM_ataque_maquina
			lw s5,0(s4)		
			la s4,NOTAS_ataque_maquina		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_maquina1:	beq s6,s5, FIM_ataque_maquina1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_maquina1: 
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
aux6:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	li t5,0x00000005
	beq t4,t5,MOTO_KILL_MELEE
	li t5,0x00000004
	beq t4,t5,MOTO_KILL_MELEE_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL_MELEE
	
	addi t4,s8,-1
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu30
	j CPCTR_KILL_MELEE
urubu30:li t5,0x00000005
	bne t4,t5,urubu31
	j MOTO_KILL_MELEE
urubu31:li t5,0x00000004
	bne t4,t5,urubu31_2
	j MOTO_KILL_MELEE_2	
urubu31_2:
	li t5,0xffffffcd
	bne t4,t5,urubu32
	j PROJETOR_KILL_MELEE
urubu32:	
	addi t4,s8,16
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu33
	j CPCTR_KILL_MELEE
urubu33:li t5,0x00000005
	bne t4,t5,urubu34
	j MOTO_KILL_MELEE
urubu34:li t5,0x00000004
	bne t4,t5,urubu34_2
	j MOTO_KILL_MELEE_2	
urubu34_2:
	li t5,0xffffffcd
	bne t4,t5,urubu35
	j PROJETOR_KILL_MELEE
urubu35:
	
	addi t4,s8,-1
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu36
	j CPCTR_KILL_MELEE
urubu36:li t5,0x00000005
	bne t4,t5,urubu37
	j MOTO_KILL_MELEE
urubu37:li t5,0x00000004
	bne t4,t5,urubu37_2
	j MOTO_KILL_MELEE_2	
urubu37_2:
	li t5,0xffffffcd
	bne t4,t5,urubu38
	j PROJETOR_KILL_MELEE
urubu38:
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu39
	j CPCTR_KILL_MELEE
urubu39:li t5,0x00000005
	bne t4,t5,urubu40
	j MOTO_KILL_MELEE
urubu40:li t5,0x00000004
	bne t4,t5,urubu40_2
	j MOTO_KILL_MELEE_2	
urubu40_2:
	li t5,0xffffffcd
	bne t4,t5,urubu41
	j PROJETOR_KILL_MELEE
urubu41:
	
	addi t4,s8,16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu42
	j CPCTR_KILL_MELEE
urubu42:li t5,0x00000005
	bne t4,t5,urubu43
	j MOTO_KILL_MELEE
urubu43:li t5,0x00000004
	bne t4,t5,urubu43_2
	j MOTO_KILL_MELEE_2	
urubu43_2:
	li t5,0xffffffcd
	bne t4,t5,urubu44
	j PROJETOR_KILL_MELEE
urubu44:			
########
continue_melee6:	
	la t0,POS_MELEE
	la a0,maquina_babbage
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_maquina2:	la s4,NUM_ataque_maquina
			lw s5,0(s4)		
			la s4,NOTAS_ataque_maquina		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_maquina2:	beq s6,s5, FIM_ataque_maquina2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_maquina2:	
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
aux7:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	li t5,0x00000005
	beq t4,t5,MOTO_KILL_MELEE
	li t5,0x00000004
	beq t4,t5,MOTO_KILL_MELEE_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu45
	j CPCTR_KILL_MELEE
urubu45:li t5,0x00000005
	bne t4,t5,urubu46
	j MOTO_KILL_MELEE
urubu46:li t5,0x00000004
	bne t4,t5,urubu46_2
	j MOTO_KILL_MELEE_2	
urubu46_2:
	li t5,0xffffffcd
	bne t4,t5,urubu47
	j PROJETOR_KILL_MELEE
urubu47:
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu48
	j CPCTR_KILL_MELEE
urubu48:li t5,0x00000005
	bne t4,t5,urubu49
	j MOTO_KILL_MELEE
urubu49:li t5,0x00000004
	bne t4,t5,urubu49_2
	j MOTO_KILL_MELEE_2	
urubu49_2:
	li t5,0xffffffcd
	bne t4,t5,urubu50
	j PROJETOR_KILL_MELEE
urubu50:
	
	addi t4,s8,-16
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu51
	j CPCTR_KILL_MELEE
urubu51:li t5,0x00000005
	bne t4,t5,urubu52
	j MOTO_KILL_MELEE
urubu52:li t5,0x00000004
	bne t4,t5,urubu52_2
	j MOTO_KILL_MELEE_2	
urubu52_2:
	li t5,0xffffffcd
	bne t4,t5,urubu53
	j PROJETOR_KILL_MELEE
urubu53:
	
	addi t4,s8,-16
	li t5,320
	li t3,0
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu54
	j CPCTR_KILL_MELEE
urubu54:li t5,0x00000005
	bne t4,t5,urubu55
	j MOTO_KILL_MELEE
urubu55:li t5,0x00000004
	bne t4,t5,urubu55_2
	j MOTO_KILL_MELEE_2	
urubu55_2:
	li t5,0xffffffcd
	bne t4,t5,urubu56
	j PROJETOR_KILL_MELEE
urubu56:
	
	addi t4,s8,-16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu57
	j CPCTR_KILL_MELEE
urubu57:li t5,0x00000005
	bne t4,t5,urubu58
	j MOTO_KILL_MELEE
urubu58:li t5,0x00000004
	bne t4,t5,urubu58_2
	j MOTO_KILL_MELEE_2	
urubu58_2:
	li t5,0xffffffcd
	bne t4,t5,urubu59
	j PROJETOR_KILL_MELEE
urubu59:	

########	
continue_melee7:	
	la t0,POS_MELEE
	la a0,maquina_babbage
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_maquina3:	la s4,NUM_ataque_maquina
			lw s5,0(s4)		
			la s4,NOTAS_ataque_maquina		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_maquina3:	beq s6,s5, FIM_ataque_maquina3
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_maquina3:	
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
aux8:	li t5,0x00000007
	beq t4,t5,CPCTR_KILL_MELEE
	li t5,0x00000005
	beq t4,t5,MOTO_KILL_MELEE
	li t5,0x00000004
	beq t4,t5,MOTO_KILL_MELEE_2
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL_MELEE
	
	addi t4,s8,0
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu60
	j CPCTR_KILL_MELEE
urubu60:li t5,0x00000005
	bne t4,t5,urubu61
	j MOTO_KILL_MELEE
urubu61:li t5,0x00000004
	bne t4,t5,urubu61_2
	j MOTO_KILL_MELEE_2	
urubu61_2:
	li t5,0xffffffcd
	bne t4,t5,urubu62
	j PROJETOR_KILL_MELEE
urubu62:
	
	addi t4,s8,0
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu63
	j CPCTR_KILL_MELEE
urubu63:li t5,0x00000005
	bne t4,t5,urubu64
	j MOTO_KILL_MELEE
urubu64:li t5,0x00000004
	bne t4,t5,urubu64_2
	j MOTO_KILL_MELEE_2		
urubu64_2:
	li t5,0xffffffcd
	bne t4,t5,urubu65
	j PROJETOR_KILL_MELEE
urubu65:
	
	addi t4,s8,16
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu66
	j CPCTR_KILL_MELEE
urubu66:li t5,0x00000005
	bne t4,t5,urubu67
	j MOTO_KILL_MELEE
urubu67:li t5,0x00000004
	bne t4,t5,urubu67_2
	j MOTO_KILL_MELEE_2	
urubu67_2:
	li t5,0xffffffcd
	bne t4,t5,urubu68
	j PROJETOR_KILL_MELEE
urubu68:
	
	addi t4,s8,16
	li t5,320
	li t3,0
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu69
	j CPCTR_KILL_MELEE
urubu69:li t5,0x00000005
	bne t4,t5,urubu70
	j MOTO_KILL_MELEE
urubu70:li t5,0x00000004
	bne t4,t5,urubu70_2
	j MOTO_KILL_MELEE_2	
urubu70_2:
	li t5,0xffffffcd
	bne t4,t5,urubu71
	j PROJETOR_KILL_MELEE
urubu71:
	
	addi t4,s8,16
	li t5,320
	li t3,-1
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel	
	li t5,0x00000007
	bne t4,t5,urubu72
	j CPCTR_KILL_MELEE
urubu72:li t5,0x00000005
	bne t4,t5,urubu73
	j MOTO_KILL_MELEE
urubu73:li t5,0x00000004
	bne t4,t5,urubu73_2
	j MOTO_KILL_MELEE_2	
urubu73_2:
	li t5,0xffffffcd
	bne t4,t5,urubu74
	j PROJETOR_KILL_MELEE
urubu74:
########	
continue_melee8:	
	la t0,POS_MELEE
	la a0,maquina_babbage
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	li a7,32
	li a0,150
	ecall
	la a0,tile
	li a3,0
	call print
EFECT_ataque_maquina4:	la s4,NUM_ataque_maquina
			lw s5,0(s4)		
			la s4,NOTAS_ataque_maquina		
			li s6,0			
			li a2,80		
			li a3,112
LOOP_ataque_maquina4:	beq s6,s5, FIM_ataque_maquina4
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
FIM_ataque_maquina4:	
	j GAME_LOOP		
