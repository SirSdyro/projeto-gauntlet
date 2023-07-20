##########
CHAR_UP:
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	li t5,320			
	li t6,-1			
	mul t3,t6,t5		
	add t4,t4,t3			# Subtrai-se -1*320 para checar qual a cor do pixel logo acima das coordenadas do jogador
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,up_aux1
	j GAME_LOOP
up_aux1:
	li t5,0x0000001f
	bne t4,t5,up_aux2
	j CHECK_KEY
up_aux2:
retorna1:	
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	bne t4,t5,up_aux3
	j NEXTLEVEL
up_aux3:	
	li t5,0x00000007
	beq t4,t5,DANO_2
	li t5,0x00000005
	beq t4,t5,DANO_2
	li t5,0xffffffcd
	beq t4,t5,DANO_2
	li t5,0x00000004
	beq t4,t5,DANO_2
	
	addi t1,t1,-16			# decrementa 16 pixeis
	sh t1,2(t0)			# salva

#selecionando a sprite
	la t0,CHAR_SELECT
	lw t1,0(t0)
	
  	li t0,'1'
  	beq t1,t0,psngm_1_up
 
  	li t0,'2'
  	beq t1,t0,psngm_2_up
  	 	
  	li t0,'3'
  	beq t1,t0,psngm_3_up
  	
  	li t0,'4'
  	beq t1,t0,psngm_4_up	
	

psngm_1_up:
 	la s3,lamar_cima		# Primeiro sprite do personagem(futuras alterações serão feitas para permitir a seleção de personagem com base no S9)	
	j up_1
psngm_2_up:
	la s3,ada_cima
	j up_1	
psngm_3_up:
	la s3,babbage_cima
	j up_1	
psngm_4_up:
	la s3,turing_cima
	j up_1			
	
up_1:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	
	mv a0,s3			# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite

##########
#CHECA_CHAVE:
#O posicionamento desse processo é crucial, pois checa qual a posição do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para então fazer o processo desejado, no caso
#a obtenção da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)			
	li t5,0x00000037
	bne t4,t5,rin
	j CHAVE
rin:	li t5, 0x00000018
	bne t4, t5, rin2
	j UPLIFE
rin2:	li t5, 0x0000003d
	bne t4, t5, rin3
	j UPSCORE
rin3:		
##########

	la a0,tile_hitbox_char
	li a3,1
	call print			# imprime o sprite
	
	la t0,OLD_CHAR_POS		# carrega em t0 o endereco de OLD_CHAR_POS
	
	la a0,tile			# carrega o endereco do sprite 'tile' em a0
	lh a1,0(t0)			# carrega a posicao x antiga do personagem em a1
	lh a2,2(t0)			# carrega a posicao y antiga do personagem em a2
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print			# imprime o sprite
	
	j GAME_LOOP
##########
##########
CHAR_DOWN:
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	li t5,320
	li t6,16
	mul t3,t6,t5
	add t4,t4,t3
	lb t4,0(t4)
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,down_aux1
	j GAME_LOOP
down_aux1:
	li t5,0x0000001f
	bne t4,t5,down_aux2
	j CHECK_KEY
down_aux2:
retorna2:	
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	bne t4,t5,down_aux3
	j NEXTLEVEL
down_aux3:
	li t5,0x00000007
	beq t4,t5,DANO_2
	li t5,0x00000005
	beq t4,t5,DANO_2
	li t5,0xffffffcd
	beq t4,t5,DANO_2
	li t5,0x00000004
	beq t4,t5,DANO_2	
	
	la t0,CHAR_POS
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16			# incrementa 16 pixeis
	sh t1,2(t0)			# salva

#selecionando a sprite
	la t0,CHAR_SELECT
	lw t1,0(t0)
	
  	li t0,'1'
  	beq t1,t0,psngm_1_down
 
  	li t0,'2'
  	beq t1,t0,psngm_2_down
  	 	
  	li t0,'3'
  	beq t1,t0,psngm_3_down
  	
  	li t0,'4'
  	beq t1,t0,psngm_4_down	
	

psngm_1_down:
 	la s3,lamar_baixo		# Primeiro sprite do personagem(futuras alterações serão feitas para permitir a seleção de personagem com base no S9)	
	j down_1
psngm_2_down:
	la s3,ada_baixo
	j down_1
psngm_3_down:
	la s3,babbage_baixo
	j down_1
psngm_4_down:
	la s3,turing_baixo
	j down_1				
		
down_1:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	
	mv a0,s3			# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite

##########
#CHECA_CHAVE:
#O posicionamento desse processo é crucial, pois checa qual a posição do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para então fazer o processo desejado, no caso
#a obtenção da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)
	li t5,0x00000037
	bne t4,t5,ren
	j CHAVE
ren:	li t5, 0x00000018
	bne t4, t5, ren2
	j UPLIFE
ren2:	li t5, 0x0000003d
	bne t4, t5, ren3
	j UPSCORE
ren3:		
##########
		
	la a0,tile_hitbox_char
	li a3,1
	call print			# imprime o sprite
			
	la t0,OLD_CHAR_POS		# carrega em t0 o endereco de OLD_CHAR_POS
	
	la a0,tile			# carrega o endereco do sprite 'tile' em a0
	lh a1,0(t0)			# carrega a posicao x antiga do personagem em a1
	lh a2,2(t0)			# carrega a posicao y antiga do personagem em a2
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print			# imprime o sprite
	
	j GAME_LOOP
##########
##########
CHAR_LEFT:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	mv t3,t6
	addi t3,t3,-1
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,-1
	lb t4,0(t4)
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,left_aux1
	j GAME_LOOP
left_aux1:
	li t5,0x0000001f
	bne t4,t5,left_aux2
	j CHECK_KEY
left_aux2:
retorna3:	
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	bne t4,t5,left_aux3
	j NEXTLEVEL
left_aux3:
	li t5,0x00000007
	beq t4,t5,DANO_2
	li t5,0x00000005
	beq t4,t5,DANO_2
	li t5,0xffffffcd
	beq t4,t5,DANO_2
	li t5,0x00000004
	beq t4,t5,DANO_2
		
	lh t1,0(t0)			# carrega o x atual do personagem
	addi t1,t1,-16			# decrementa 16 pixeis
	sh t1,0(t0)			# salva
	
#selecionando a sprite
	la t0,CHAR_SELECT
	lw t1,0(t0)
	
  	li t0,'1'
  	beq t1,t0,psngm_1_left
 
  	li t0,'2'
  	beq t1,t0,psngm_2_left
  	 	
  	li t0,'3'
  	beq t1,t0,psngm_3_left
  	
  	li t0,'4'
  	beq t1,t0,psngm_4_left	
	

psngm_1_left:
 	la s3,lamar_esquerda		# Primeiro sprite do personagem(futuras alterações serão feitas para permitir a seleção de personagem com base no S9)	
	j left_1
psngm_2_left:
	la s3,ada_esquerda
	j left_1
psngm_3_left:
	la s3,babbage_esquerda
	j left_1
psngm_4_left:
	la s3,turing_esquerda
	j left_1				
		
left_1:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	
	mv a0,s3			# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	
##########
#CHECA_CHAVE:
#O posicionamento desse processo é crucial, pois checa qual a posição do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para então fazer o processo desejado, no caso
#a obtenção da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)
	li t5,0x00000037
	bne t4,t5,ran
	j CHAVE
ran:	li t5, 0x00000018
	bne t4, t5, ran2
	j UPLIFE
ran2:	li t5, 0x0000003d
	bne t4, t5, ran3
	j UPSCORE
ran3:	
##########
		
	la a0,tile_hitbox_char
	li a3,1
	call print			# imprime o sprite
			
	la t0,OLD_CHAR_POS		# carrega em t0 o endereco de OLD_CHAR_POS
	
	la a0,tile			# carrega o endereco do sprite 'tile' em a0
	lh a1,0(t0)			# carrega a posicao x antiga do personagem em a1
	lh a2,2(t0)			# carrega a posicao y antiga do personagem em a2
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print			# imprime o sprite
	
	j GAME_LOOP
##########
##########
CHAR_RIGHT:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	la t1,OLD_CHAR_POS		# carrega em t1 o endereco de OLD_CHAR_POS
	lw t2,0(t0)
	sw t2,0(t1)			# salva a posicao atual do personagem em OLD_CHAR_POS
	
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
		
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	addi t4,t4,16
	lb t4,0(t4)
	li t5,0xffffffC8		# Checa para ver se é azul/parede
	bne t4,t5,right_aux1
	j GAME_LOOP
right_aux1:
	li t5,0x0000001f
	bne t4,t5,right_aux2
	j CHECK_KEY
right_aux2:
retorna4:	
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	bne t4,t5,right_aux3
	j NEXTLEVEL
right_aux3:
	li t5,0x00000007
	beq t4,t5,DANO_2
	li t5,0x00000005
	beq t4,t5,DANO_2
	li t5,0xffffffcd
	beq t4,t5,DANO_2
	li t5,0x00000004
	beq t4,t5,DANO_2
		
	lh t1,0(t0)			# carrega o x atual do personagem
	addi t1,t1,16			# incrementa 16 pixeis
	sh t1,0(t0)			# salva

#selecionando a sprite
	la t0,CHAR_SELECT
	lw t1,0(t0)
	
  	li t0,'1'
  	beq t1,t0,psngm_1_right
 
  	li t0,'2'
  	beq t1,t0,psngm_2_right
  	 	
  	li t0,'3'
  	beq t1,t0,psngm_3_right
  	
  	li t0,'4'
  	beq t1,t0,psngm_4_right	
	
psngm_1_right:
 	la s3,lamar_direita		# Primeiro sprite do personagem(futuras alterações serão feitas para permitir a seleção de personagem com base no S9)	
	j right_1
psngm_2_right:
	la s3,ada_direita
	j right_1	
psngm_3_right:
	la s3,babbage_direita
	j right_1			
psngm_4_right:
	la s3,turing_direita
	j right_1
			
right_1:	
	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	
	mv a0,s3			# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite

##########
#CHECA_CHAVE:
#O posicionamento desse processo é crucial, pois checa qual a posição do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para então fazer o processo desejado, no caso
#a obtenção da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endereço base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 é o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endereço base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endereço base
	
	lb t4,0(t4)
	li t5,0x00000037
	bne t4,t5,ron
	j CHAVE
ron:	li t5, 0x00000018
	bne t4, t5, ron2
	j UPLIFE
ron2:	li t5, 0x0000003d
	bne t4, t5, ron3
	j UPSCORE
ron3:	
##########
		
	la a0,tile_hitbox_char
	li a3,1
	call print			# imprime o sprite
			
	la t0,OLD_CHAR_POS		# carrega em t0 o endereco de OLD_CHAR_POS
	
	la a0,tile			# carrega o endereco do sprite 'tile' em a0
	lh a1,0(t0)			# carrega a posicao x antiga do personagem em a1
	lh a2,2(t0)			# carrega a posicao y antiga do personagem em a2
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print			# imprime o sprite
	
	j GAME_LOOP