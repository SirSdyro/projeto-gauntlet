.include "MACROSv21.s"

.data
#descrição personagens
.include "ada_descricao.data"
.include "babbage_descricao.data"
.include "turing_descricao.data"
.include "lamar_descricao.data"

#tela instruções de gameplay
.include "telaINSTRUCOES.data"

#tela game over
.include "telagameover.data"
#menu:
.include "menu10.data"
.include "menu_gauntlet.data"
.include "menu_gauntlet_2.data"
.include "selecao_personagens.data"

#monitor_chiado
.include "monitorchiado1.data"
.include "monitorchiado2.data"
.include "monitorchiado3.data"
.include "monitorchiado4.data"
.include "monitorchiado5.data"

#controles
.include "controles1.data"
.include "controles2.data"
.include "controles3.data"
.include "controles4.data"
.include "controles5.data"

#teladesce
.include "teladesce1.data"
.include "teladesce2.data"
.include "teladesce3.data"
.include "teladesce4.data"
.include "teladesce5.data"

mapa_e_hitbox:
.include "mapa1_teste.data"
.include "hitbox_mapateste2.data"
.include "hitboxfase1.data"
.include "hitboxfase2.data"
.include "hitboxfase3.data"
.include "GauntletRoom001MapBG.data"
.include "escotilha_aberta.data"
.include "tile.data"
.include "tile1.data"
.include "tile2.data"
.include "tile_hitbox_char.data"
.include "tile_hitbox_enemy.data"
.include "tile_hitbox_enemy2.data"
.include "tile_hitbox_enemy2_2.data"
.include "tile_hitbox_enemy3.data"
.include "tile_hitbox_enemy3_2.data"
.include "tile_hitbox_enemy3proj.data"
.include "tile_hitbox_enemy3proj_2.data"
.include "tile_hitbox_item1.data"
.include "hd.data"
.include "tile_hitbox_item2.data"
.include "pendrive.data"
##########
##########
#PERSONAGENS#
Lamar:
.include "lamar_cima.data"
.include "lamar_baixo.data"
.include "lamar_direita.data"
.include "lamar_esquerda.data"
.include "memoria_ram_cima.data"
.include "memoria_ram_baixo.data"
.include "memoria_ram_left.data"
.include "memoria_ram_right.data"
Ada:
.include "ada_cima.data"
.include "ada_baixo.data"
.include "ada_direita.data"
.include "ada_esquerda.data"
.include "papel_perfurado_cima.data"
.include "papel_perfurado_baixo.data"
.include "papel_perfurado_left.data"
.include "papel_perfurado_right.data"
Babbage:
.include "babbage_cima.data"
.include "babbage_baixo.data"
.include "babbage_direita.data"
.include "babbage_esquerda.data"
.include "maquina_babbage.data"
Turing:
.include "turing_cima.data"
.include "turing_baixo.data"
.include "turing_direita.data"
.include "turing_esquerda.data"
.include "bits_cima.data"
.include "bits_down.data"
.include "bits_left.data"
.include "bits_right.data"
##########
##########
#INIMIGOS#
CapacitorParasita:
.include "capacitor_parasita.data"
.include "descarga_capacitor.data"
Moto:
.include "moto_cima.data"
.include "moto_baixo.data"
.include "moto_esquerda.data"
.include "moto_direita.data"
Projetor:
.include "projetor.data"
.include "projetor_tiro.data"

CHAR_SELECT:	.word 0				# define o personagem selecionado
CHAR_POS:	.half 216,8			# x, y
OLD_CHAR_POS:	.half 216,8			# x, y
SAIDA_POS: 	.half 8,216			# x, y
TEMPO: 		.word 60
TEMPO_COOLDOWN: .word 0
TEMPO_ATK: 	.word 1				# tempo até o ataque do inimigo
ENEMY_1_POS:    .half 216,216			# x, y
ENEMY_1_OLD_POS:.half 216,216			# x, y
ENEMY_1_ATK:	.half 0,0			# x, y
ENEMY_1_SWITCH: .word 0				# permite a existência do inimigo 1 (no caso o capacitor parasita)
ENEMY_2_POS:    .half 136,8			# x, y
ENEMY_2_OLD_POS:.half 136,8			# x, y
ENEMY_2_DIRECT:	.word 1
ENEMY_2_SWITCH: .word 2				# permite a existência do inimigo 1 (no caso o capacitor parasita)
ENEMY_2_POS_2:    .half 8,8			# x, y
ENEMY_2_OLD_POS_2:.half 8,8			# x, y
ENEMY_2_DIRECT_2:.word 1
ENEMY_2_SWITCH_2:.word 2				# permite a existência do inimigo 1 (no caso o capacitor parasita)
ENEMY_3_POS:	.half 40,40			# x, y
ENEMY_3_OLD_POS:.half 40,40			# x, y
ENEMY_3_SWITCH:	.word 2
ENEMY_3_DIRECT: .word 1
ENEMY_3_PROJ:	.word 0
ENEMY_3_POSPROJ:.half 0,0
ENEMY_3_OLDPROJ:.half 0,0
DIRECAO_PROJ:   .word 0
ATK_PROJ: 	.word 0				# registra a existência do projétil do personagem
POS_PROJ:	.half 0,0			# x, y
OLD_POS_PROJ:   .half 0,0			# x, y
POS_MELEE:	.half 0,0			# x, y
SCORE:		.word 0
LEVEL:		.word 1

#EFEITOS SONOROS
NUM_sair_menu: .word 6
NOTAS_sair_menu: 74,100,74,100,71,100,67,100,64,100,60,1700

NUM_controles:.word 3
NOTAS_controles: 71,130,71,130,74,350

NUM_select: .word 6
NOTAS_select: 60,200,60,200,64,200,67,200,71,200,74,1100

NUM_game_over: .word 6
NOTAS_game_over: 74,200,74,200,71,200,67,200,64,200,60,2000

NUM_tomar_dano1: .word 3
NOTAS_tomar_dano1: 50,64,50,60,50,60

NUM_tomar_dano2: .word 3
NOTAS_tomar_dano2: 50,64,50,60,50,60

NUM_pegar_hd: .word 3
NOTAS_pegar_hd: 71,100,80,130

NUM_pegar_pendrive: .word 3
NOTAS_pegar_pendrive: 90,100,90,100

NUM_pegar_chave: .word 3
NOTAS_pegar_chave: 71,100,80,130

.text
#OBSERVAÇÕES:
#*No menu, a opção de ver as instruções ainda não está implementada, nada acontecerá se você pressionar 2
#*Recomenda-se o uso do paint.net com o arquivo da hitbox ou do mapa para obter as coordenadas precisas de onde você quer printar
#ou de qual pixel você quer checar
#*Cuidado com as coordenadas que utilizará, se não forem múltiplas de 4, muito provavelmente dará erro
#*Na seleção de mapas o mapa2 está igual o primeiro apenas como placeholder, a implementação de um mapa diferente é fácil
#*O tempo só funciona no FPGrars, já que a execução detro do rars normal é lento para dedéu e lá é extremamente rápida

##########
##########
j MENU
###===== EFEITOS SONOROS =====###

.include "efeitos_sonoros.s"

RESTART:
	mv s10,zero
	
	li t0,216
	li t1,8
	la t2,CHAR_POS
	sh t0,0(t2)
	sh t1,2(t2)
	la t2,OLD_CHAR_POS
	sh t0,0(t2)
	sh t1,2(t2)
	
	la t0,TEMPO
	li t1,60
	sw t1,0(t0)
	
	la t0,ENEMY_2_SWITCH
	li t1,1
	sw t1,0(t0)
	li t0,136
	li t1,8
	la t2,ENEMY_2_POS
	sh t0,0(t2)
	sh t1,2(t2)
	la t2,ENEMY_2_OLD_POS
	sh t0,0(t2)
	sh t1,2(t2)
	
	la t0,ENEMY_3_SWITCH
	li t1,1
	sw t1,0(t0)
	li t0,40
	li t1,40
	la t2,ENEMY_3_POS
	sh t0,0(t2)
	sh t1,2(t2)
	la t2,ENEMY_3_OLD_POS
	sh t0,0(t2)
	sh t1,2(t2)
	
	la t0,LEVEL
	li t1,1
	sw t1,0(t0)
	
	la t0,SCORE
	sw zero,0(t0)
	
	la t0,TEMPO_COOLDOWN
	sw zero,0(t0)	
MENU:
	call menu
	.include "menu.s"
##########
##########	
SETUP:	
	call setup
	.include "setup.s"
##########
##########
# Quando o registrador s9 atinge o valor estabelecido no game loop,
# é decrementado 1 do valor indicado pela label TEMPO, representando os segundos
#tempo_ataque:

segundo:		
	la t0,TEMPO			# Carregando o valor do tempo atual
	lb t1,0(t0)			
	addi t1,t1,-1			# Decrementa 1 para simbolizar o 1 segundo passado
	sb t1,0(t0)			# Atualiza o tempo
	lb t1,0(t0)			# Carrega o valor do tempo para printar
	mv s9,zero			# Reseta o contador
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,56
	li a3,0x37
	ecall
	bne t1,zero,babooey1
	j EFC_EFECT_game_over
babooey1:
	bge t1,zero,babooey2
	j EFC_EFECT_game_over
babooey2:	
#tempo_ataque_inimigo:
	la t0,TEMPO_ATK			# Carrega o valor do tempo de ataque do inimigo
	lw t1,0(t0)			
	addi t1,t1,-1			# Decrementa 1 para simbolizar o 1 segundo passado 
	sw t1,0(t0)			# Atualiza o tempo de ataque	
#tempo_cooldown
	la t0,TEMPO_COOLDOWN
	lw t1,0(t0)
	beq t1,zero,GAME_LOOP
	addi t1,t1,-1
	sw t1,0(t0)
	la t0,TEMPO_COOLDOWN
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,96
	li a3,0xff
	ecall
	j GAME_LOOP					
##########

##########		
##########
CHECK_KEY:
	bne s11,zero,key_aux
	j GAME_LOOP
key_aux:			
	li t2,'w'
	bne s8,t2,key_aux2		# se tecla pressionada for 'w', chama CHAR_CIMA
	j retorna1	
key_aux2:
	li t2,'a'
	bne s8,t2,key_aux3		# se tecla pressionada for 'a', chama CHAR_CIMA
	j retorna3
key_aux3:		
	li t2,'s'
	bne s8,t2,key_aux4		# se tecla pressionada for 's', chama CHAR_CIMA
	j retorna2	
key_aux4:
	li t2,'d'
	bne s8,t2,key_aux5		# se tecla pressionada for 'd', chama CHAR_CIMA
	j retorna4
key_aux5:

NEXTLEVEL:
	call next_level	
	.include "next_level.s"
UPLIFE:
	la t0,TEMPO			# Carregando o valor do tempo atual
	lb t1,0(t0)					
	addi t1,t1,10			# incrementa 10 para represemtar os 10 de vida recuperados
	sb t1,0(t0)			# Atualiza o tempo
	lb t1,0(t0)			# Carrega o valor do tempo para printar
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,56
	li a3,0x37
	ecall	
######
#Realiza o processo de atualização de sprites de uma forma meio grosseira a fim de permitir o reuso para todos as direções de movimento	
	la t0,CHAR_POS
	la a0,tile_hitbox_char
	lh a1,0(t0)
	lh a2,2(t0)		
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
	j EFC_EFECT_pegar_hd
continue_pegar_hd:	
##########	
UPSCORE:
	la t0,SCORE			# Carregando o valor do tempo atual
	lw t1,0(t0)		
	addi t1,t1,100			# incrementa 10 para represemtar os 100 de pontos a mais
	sw t1,0(t0)
	lw t1,0(t0)			# Carrega o valor do tempo para printar
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,76
	li a3,0xff
	ecall
######
#Realiza o processo de atualização de sprites de uma forma meio grosseira a fim de permitir o reuso para todos as direções de movimento	
	la t0,CHAR_POS
	la a0,tile_hitbox_char
	lh a1,0(t0)
	lh a2,2(t0)		
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
	call EFECT_pegar_pendrive
continue_pegar_pendrive:		
######	
	j GAME_LOOP	

CHAVE:			
	li s11,1			# Altera o valor do registrador da chave
######
#Realiza o processo de atualização de sprites de uma forma meio grosseira a fim de permitir o reuso para todos as direções de movimento	
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
	call EFECT_pegar_chave
continue_pegar_chave:
######	
	j GAME_LOOP

GAME_LOOP:
#Após as alterações feitas para acomodar a hitbox dinâmica, o game loop está vazio e , acredito eu, poderemos
#usá-lo para fazer o tempo, inimigos e outros processos que devem ocorrer sem o input do jogador

contador:
# Serve para definir quando passou aproximadamente 1 segundo
# este valor de 20 milhões foi escolhido devido a como os comandos são processados no assembly
# e ao fato que a execução no FPGrars é absurdamente rápida. Ele pode ser alterado para mudar
# o quão rápido o tempo é decrementado. Muito provavelmente será alterado quando o resto do jogo
# for programado
	addi s9,s9,1
	li t0,20000000   # Retire 3 zeros caso queira testar dentro do rars normal
	beq s9,t0,segundo

	la t0,CHAR_SELECT
	lw t1,0(t0)
	
	li t2,'2'
	beq t1,t2,projetil_1
	
	li t2,'4'
	beq t1,t2,projetil_2
	
	j inimigo_1
	
projetil_1:
	call proj
	.include "proj.s"
projetil_2:
	call proj2	
	.include "proj2.s"
												
inimigo_1:
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_1_SWITCH		
	lw t0,0(t0)
	ble t0,zero,inimigo_2
######
#Checa para ver se pode atacar	
	la t0,TEMPO_ATK
	lw t1,0(t0)
	bne t1,zero,inimigo_2
	call inimigo_1_rotina
	
inimigo_2:
	li t0,2500000
	rem t1,s9,t0
	bne t1,zero,inimigo_2_2
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_2_SWITCH		
	lw t0,0(t0)
	ble t0,zero,inimigo_2_2
	call inimigo_2_rotina
	
inimigo_2_2:
	li t0,2500000
	rem t1,s9,t0
	bne t1,zero,inimigo_3
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_2_SWITCH_2		
	lw t0,0(t0)
	ble t0,zero,inimigo_3
	call inimigo_2_rotina_2	
	
inimigo_3:
	la t0,ENEMY_3_PROJ
	lw t1,0(t0)
	bne t1,zero,PROJ_ENEMY_3
	
	li t0,2500000
	rem t1,s9,t0
	bne t1,zero,game_loop1
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_3_SWITCH		
	lw t0,0(t0)
	ble t0,zero,game_loop1
	
	call inimigo_3_rotina
		
PROJ_ENEMY_3:
	li t0,2000000
	rem t1,s9,t0
	bne t1,zero,game_loop1
	call enemy_proj
														
DANO_1:
		la t0,TEMPO			# Carrega o valor do tempo atual
		lb t1,0(t0)
		addi t1,t1,-10			# Decrementa 10 de dano
		j EFC_EFECT_tomar_dano1
continue_dano1: sb t1,0(t0)			# Atualiza o tempo
		la t0,TEMPO
		lb t1,0(t0)
		li a7,101			# Printa o numero do tempo na tela
		mv a0,t1
		li a1,248
		li a2,56
		li a3,0x37
		ecall	
######
#Printa a descarga para simbolizar o ataque bem efetuado
	la t0,ENEMY_1_ATK
	la a0,descarga_capacitor	
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	j inimigo1_1
######	
##########
DANO_2:
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
	j EFC_EFECT_tomar_dano2
continue_tomar_dano2:	
	j GAME_LOOP
##########
														
game_loop1:
#Essa label ficará aqui por possíveis conveniências futuras, mas muito provavelmente pode ser apagada, então dane-se
	call KEY2			# chama o procedimento de entrada do teclado
		
	j GAME_LOOP
##########
##########
### Apenas verifica se há tecla pressionada
KEY2:	li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
  	mv s8,t2
	
	li t0,'w'
	beq t2,t0,CHAR_UP		# se tecla pressionada for 'w', chama CHAR_CIMA
	
	li t0,'a'
	beq t2,t0,CHAR_LEFT		# se tecla pressionada for 'a', chama CHAR_CIMA
	
	li t0,'s'
	beq t2,t0,CHAR_DOWN		# se tecla pressionada for 's', chama CHAR_CIMA
	
	li t0,'d'
	beq t2,t0,CHAR_RIGHT		# se tecla pressionada for 'd', chama CHAR_CIMA
	
	li t0,' '
	beq t2,t0,selecATAQUE		# se tecla pressionada for 'd', chama CHAR_CIMA	
	
FIM:	ret				# retorna
##########
	.include "movimentos.s"
##########
selecATAQUE:
	la t0,TEMPO_COOLDOWN
	lw t1,0(t0)
	beq t1,zero,atk_aux0
	j GAME_LOOP
atk_aux0:
	la t0, CHAR_SELECT
	lw t0, 0(t0)			#pega a info de qual personagem está selecionado, as linhas de codigo abaizo selecionará qual o tipo de #dano
 
	li t1, '1'
	bne t0, t1, atk_aux1 
 	j SELECMELEE
atk_aux1:	
 	li t1, '2'
	bne t0, t1, atk_aux2 
	j SELECPROJ
atk_aux2:	
	li t1, '3'
	bne t0, t1, atk_aux3
	j SELECMELEE
atk_aux3:	
	li t1, '4'
	bne t0, t1, atk_aux4
	j SELECPROJ
atk_aux4:	
##########
sair:
	li a7,10
	ecall
	
.include "print.s"
.include "inimigo_1_rotina.s"
.include "ataqueproj.s"
.include "inimigo_2_rotina.s"
.include "inimigo_2_rotina_2.s"
.include "inimigo_3_rotina.s"
.include "enemy_proj.s"
.include "ataquemelee.s"	
.include "SYSTEMv21.s"
