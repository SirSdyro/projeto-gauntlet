next_level:
#passando para a próxima fase
	la t0,SAIDA_POS
	la a0,escotilha_aberta		# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print
	
	la t0, LEVEL                    #Soma-se um ao valor que representa o level onde o player se encontra
	lw t1, 0(t0)
	addi t1, t1, 1                  #isso aqui fico logo embaixo do incrementador do mapa
	sw t1, 0(t0)
		
	addi s10,s10,1			# Soma-se 1 ao registrador de selecionar o mapa para indicar que o próxima mapa com sua hitbox deve ser selecionado
	li t4, 3
	beq s10, t4, repetefase
	j aux0
repetefase: 
	mv s10, zero
#reseta a posição do personagem	
aux0:
	beq s10,zero,mapa1
	li t0,1
	beq s10,t0,mapa2
	li t0,2
	beq s10,t0,mapa3
mapa1:	
	li t1,216
	li t2,8
	j nxt_level_char				
mapa2:
	li t1,8
	li t2,200
	j nxt_level_char
mapa3:
	li t1,216
	li t2,120
	j nxt_level_char	
	
nxt_level_char:
	la t0,CHAR_POS			# Carrega a posição do personagem 
	sh t1,0(t0)			# Atualiza o x
	sh t2,2(t0)			# Atualiza o y
	la t0,OLD_CHAR_POS		# Carrega a posição antiga do personagem
	sh t1,0(t0)			# Atualiza o x
	sh t2,2(t0)			# Atualiza o y
#reseta o tempo	
	la t0,TEMPO
	li t1,60
	sw t1,0(t0)
#reseta o cooldown
	la t0,TEMPO_COOLDOWN
	sw zero,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,96
	li a3,0xff
	ecall
#inimigos
	beq s10,zero,mapa1_ene_1
	li t0,1
	beq s10,t0,mapa2_ene_1
	li t0,2
	beq s10,t0,mapa3_ene_1
mapa1_ene_1:
	mv t3,zero
	j nxt_level_ene_1
mapa2_ene_1:
	la t0,ENEMY_1_POS
	li t1,184
	li t2,200
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_1_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,3
	j nxt_level_ene_1
mapa3_ene_1:
	la t0,ENEMY_1_POS
	li t1,56
	li t2,216
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_1_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,3
	j nxt_level_ene_1
			
nxt_level_ene_1:			
	la t0,ENEMY_1_SWITCH
	mv t1,t3
	sw t1,0(t0)
	la t0,TEMPO_ATK
	li t1,1
	sw t1,0(t0)
	la t0,ENEMY_1_ATK
	sh zero,0(t0)
	sh zero,2(t0)
#######
	beq s10,zero,mapa1_ene_2
	li t0,1
	beq s10,t0,mapa2_ene_2
	li t0,2
	beq s10,t0,mapa3_ene_2
mapa1_ene_2:
	la t0,ENEMY_2_POS
	li t1,136
	li t2,8
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_2
mapa2_ene_2:
	la t0,ENEMY_2_POS
	li t1,168
	li t2,184
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_2
mapa3_ene_2:
	la t0,ENEMY_2_POS
	li t1,136
	li t2,120
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_2

nxt_level_ene_2:	
	la t0,ENEMY_2_SWITCH
	mv t1,t3
	sw t1,0(t0)
	la t0,ENEMY_2_DIRECT
	li t1,1
	sw t1,0(t0)
#######
	beq s10,zero,mapa1_ene_2_2
	li t0,1
	beq s10,t0,mapa2_ene_2_2
	li t0,2
	beq s10,t0,mapa3_ene_2_2
mapa1_ene_2_2:
	la t0,ENEMY_2_POS_2
	li t1,8
	li t2,8
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS_2
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_2_2
mapa2_ene_2_2:
	la t0,ENEMY_2_POS_2
	li t1,168
	li t2,184
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS_2
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,0
	j nxt_level_ene_2_2
mapa3_ene_2_2:
	la t0,ENEMY_2_POS_2
	li t1,136
	li t2,8
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_2_OLD_POS_2
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_2_2

nxt_level_ene_2_2:	
	la t0,ENEMY_2_SWITCH_2
	mv t1,t3
	sw t1,0(t0)
	la t0,ENEMY_2_DIRECT_2
	li t1,1
	sw t1,0(t0)
#######	
	beq s10,zero,mapa1_ene_3
	li t0,1
	beq s10,t0,mapa2_ene_3
	li t0,2
	beq s10,t0,mapa3_ene_3
mapa1_ene_3:
	la t0,ENEMY_3_POS
	li t1,40
	li t2,40
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_3_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_3
mapa2_ene_3:
	la t0,ENEMY_3_POS
	li t1,8
	li t2,56
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_3_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_3
mapa3_ene_3:
	la t0,ENEMY_3_POS
	li t1,8
	li t2,8
	sh t1,0(t0)
	sh t2,2(t0) 
	la t0,ENEMY_3_OLD_POS
	sh t1,0(t0)
	sh t2,2(t0) 
	li t3,2
	j nxt_level_ene_3

nxt_level_ene_3:	
	la t0,ENEMY_3_SWITCH
	mv t1,t3
	sw t1,0(t0)
	la t0,ENEMY_3_DIRECT
	li t1,1
	sw t1,0(t0)
		 			 		
	j SETUP
