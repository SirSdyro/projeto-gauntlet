setup:
#Seleciona-se o mapa com base no valor de S10
	beq s10,zero,map1	
	li t0,1
	beq s10,t0,map2
	li t0,2
	beq s10,t0,map3

map1:	la a0,designfase1
	j setup1
map2:	la a0,designfase2
	j setup1
map3:	la a0,designfase3
	j setup1
#Printa o mapa selecionado no frame 0
setup1:	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite	
#Seleciona-se a hitbox correspondente com base no S10
	beq s10,zero,hitbox1
	li t0,1
	beq s10,t0,hitbox2
	li t0,2
	beq s10,t0,hitbox3	
	
hitbox1:
	la a0,hitboxfase1
	j setup2
hitbox2:
	la a0,hitboxfase2
	j setup2
hitbox3:
	la a0,hitboxfase3
	j setup2	
#Printa a hitbox selecionada no frame 1		
setup2:	li a1,0				# x = 0
	li a2,0				# y = 0	
	li a3,1				# frame = 1
	call print			# imprime o sprite
	
#selecionando a sprite
	la t0,CHAR_SELECT
	lw t1,0(t0)
	
  	li t0,'1'
  	beq t1,t0,psngm_1
 
  	li t0,'2'
  	beq t1,t0,psngm_2
  	 	
  	li t0,'3'
  	beq t1,t0,psngm_3
  	
  	li t0,'4'
  	beq t1,t0,psngm_4	
		
psngm_1:
 	la s3,lamar_baixo		# Primeiro sprite do personagem(futuras alterações serão feitas para permitir a seleção de personagem com base no S9)	
	j setup3
psngm_2:
	la s3,ada_baixo
	j setup3
psngm_3:
	la s3,babbage_baixo
	j setup3
psngm_4:
	la s3,turing_baixo
	j setup3		
setup3:		
 	la t0,CHAR_POS			# carrega em t0 o endereco de CHAR_POS
	
	mv a0,s3			# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_char		# Carrega o endereço da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite
	
	la t0,TEMPO
	lb t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,108
	li a3,0x5b38
	ecall
	
	la t0,SCORE
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,132
	li a3,0x5bFF
	ecall
	
	la t0, LEVEL
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,86
	li a3,0x5bff
	ecall
	
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,157
	li a3,0x5bff
	ecall
									
#printando o inimigo e sua hitbox
	la t0,ENEMY_1_SWITCH
	lw t0,0(t0)
	beq t0,zero,enemy_2_setup
	la t0,ENEMY_1_POS	
	la a0,capacitor_parasita
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy		# Carrega o endereço da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite
#definindo a posição de ataque do capacitor parasita
	la t0,CHAR_POS
	lw t1,0(t0)
	la t0,ENEMY_1_ATK
	sw t1,0(t0)
########
enemy_2_setup:
	la t0,ENEMY_2_SWITCH
	lw t0,0(t0)
	beq t0,zero,enemy_2_setup_2
	
	la t0,ENEMY_2_POS	
	la a0,moto_cima
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy2		# Carrega o endereço da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite
	
enemy_2_setup_2:
	la t0,ENEMY_2_SWITCH_2
	lw t0,0(t0)
	beq t0,zero,enemy_3_setup
	
	la t0,ENEMY_2_POS_2	
	la a0,moto_cima
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy2_2		# Carrega o endereço da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite		
	
enemy_3_setup:
	la t0,ENEMY_3_SWITCH
	lw t0,0(t0)
	beq t0,zero,setup4
	
	la t0,ENEMY_3_POS	
	la a0,projetor
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy3		# Carrega o endereço da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite	
	
setup4:	
 	li s11,0			# Define o valor inicial do registrador da chave
 	
 	li a7,32
 	li a0,70
 	ecall
 	 
 	j GAME_LOOP
