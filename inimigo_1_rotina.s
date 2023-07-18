inimigo_1_rotina:
######
#Reseta o tempo de ataque	
	li t1,1
	sw t1,0(t0)
######
#Atualiza a antiga posição do capacitor		
	la t0,ENEMY_1_POS
	lw t1,0(t0)
	la t0,ENEMY_1_OLD_POS
	sw t1,0(t0)
######
#Atualiza a posição atual do capacitor		
	la t0,ENEMY_1_ATK
	lw t1,0(t0)
	la t0,ENEMY_1_POS
	sw t1,0(t0)
######
#Printa o capacitor na posição de ataque	
	la t0,ENEMY_1_ATK
	
	la a0,capacitor_parasita
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
######
#Checa para ver se o personagem foi atingido
	la t0,CHAR_POS
	lw t0,0(t0)
	la t1,ENEMY_1_ATK
	lw t1,0(t1)
	beq t0,t1,DANO_1
######
#Atualiza a hitbox do inimigo
inimigo1_1:	
	la a0,tile_hitbox_enemy
	li a3,1
	call print
######
#Atualiza a posição de ataque para o próximo ataque		
	la t0,CHAR_POS
	lh t1,0(t0)
	lh t2,2(t0)
	la t0,ENEMY_1_ATK
	sh t1,0(t0)
	sh t2,2(t0)
######
#Limpa o sprite do inimigo e sua hitbox na posição antiga no frame 0 e no frame 1	
	la t0,ENEMY_1_OLD_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	j game_loop1
######	