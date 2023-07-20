.include "MACROSv21.s"

.data
menu:
.include "menu_gauntlet.data"
.include "menu_gauntlet_2.data"
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
.include "tile_hitbox_enemy3.data"
.include "tile_hitbox_enemy3proj.data"
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
Turing:
.include "turing_cima.data"
.include "turing_baixo.data"
.include "turing_direita.data"
.include "turing_esquerda.data"
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
TEMPO_ATK: 	.word 1				# tempo até o ataque do inimigo
ENEMY_1_POS:    .half 216,216			# x, y
ENEMY_1_OLD_POS:.half 216,216			# x, y
ENEMY_1_ATK:	.half 0,0			# x, y
ENEMY_1_SWITCH: .word 0				# permite a existência do inimigo 1 (no caso o capacitor parasita)
ENEMY_2_POS:    .half 136,8			# x, y
ENEMY_2_OLD_POS:.half 136,8			# x, y
ENEMY_2_DIRECT:	.word 1
ENEMY_2_SWITCH: .word 1				# permite a existência do inimigo 1 (no caso o capacitor parasita)
ENEMY_3_POS:	.half 40,40			# x, y
ENEMY_3_OLD_POS:.half 40,40			# x, y
ENEMY_3_SWITCH:	.word 1
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
MENU:
	la a0, menu_gauntlet		# Carrega o endereço do menu para printá-lo apenas no frame 0
	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite
	
	call KEY1
	
KEY1: 	
	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  	li t0,'1'
  	beq t2,t0,SELECT
  	
  	li t0,'3'
  	beq t2,t0,sair1
  	j test
sair1: 	
	j sair
  	
test: 	j KEY1				# retorna
##########
########## 	
SELECT:
	la a0, menu_gauntlet_2		# Carrega o endereço do menu de seleção de personagem para printar apenas no frame 0
	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite
	
	call KEY1_2
KEY1_2: 	
	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP_2: lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP_2		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  	li t0,'1'
  	beq t2,t0,CHAR_1
 
  	li t0,'2'
  	beq t2,t0,CHAR_2
  	 	
  	li t0,'3'
  	beq t2,t0,CHAR_3
  	
  	li t0,'4'
  	beq t2,t0,CHAR_4
  	  	
 	ret				# retorna
# Os processos seguintes alteram o valor CHAR_SELECT para definir qual personagem deve ter seus sprites printados 	  	 
CHAR_1:
	li t0,'1'
	la t1,CHAR_SELECT
	sw t0,0(t1)
	j SETUP
CHAR_2:
	li t0,'2'
	la t1,CHAR_SELECT
	sw t0,0(t1)
	j SETUP	
CHAR_3:
	li t0,'3'
	la t1,CHAR_SELECT
	sw t0,0(t1)
	j SETUP	
CHAR_4:
	li t0,'4'
	la t1,CHAR_SELECT
	sw t0,0(t1)
	j SETUP	
##########
##########	
SETUP:	
#Seleciona-se o mapa com base no valor de S10
	beq s10,zero,map1	
	li t0,1
	beq s10,t0,map2
	li t0,2
	beq s10,t0,map3

map1:	la a0,hitboxfase1
	j setup1
map2:	la a0,hitboxfase2
	j setup1
map3:	la a0,hitboxfase3
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
	li a2,56
	li a3,0x37
	ecall
	
	la t0,SCORE
	lw t1,0(t0)
	li a7,101			# Printa o numero do tempo na tela
	mv a0,t1
	li a1,248
	li a2,76
	li a3,0xFF
	ecall
	
	la t0, LEVEL
	lw t1, 0(t0)
	li a7,101			# Printa o numero do level na tela
	mv a0,t1
	li a1,248
	li a2,36
	li a3,0xff
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
	beq t0,zero,enemy_3_setup
	
	la t0,ENEMY_2_POS	
	la a0,moto_cima
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy2		# Carrega o endereço da hitbox do personagem
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
	j RESTART
babooey1:
	bge t1,zero,babooey2
	j RESTART
babooey2:	
#tempo_ataque_inimigo:
	la t0,TEMPO_ATK			# Carrega o valor do tempo de ataque do inimigo
	lw t1,0(t0)			
	addi t1,t1,-1			# Decrementa 1 para simbolizar o 1 segundo passado 
	sw t1,0(t0)			# Atualiza o tempo de ataque	
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
	li t3,1
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
	li t3,1
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
	li t3,1
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
	li t3,1
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
	li t3,1
	j nxt_level_ene_2

nxt_level_ene_2:	
	la t0,ENEMY_2_SWITCH
	mv t1,t3
	sw t1,0(t0)
	la t0,ENEMY_2_DIRECT
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
	li t3,1
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
	li t3,1
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
	li t3,1
	j nxt_level_ene_3

nxt_level_ene_3:	
	la t0,ENEMY_3_SWITCH
	li t1,1
	sw t1,0(t0)
	la t0,ENEMY_3_DIRECT
	li t1,1
	sw t1,0(t0)
		 			 		
	j SETUP
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
######	
	j GAME_LOOP	
##########	
UPSCORE:
	la t0,SCORE			# Carregando o valor do tempo atual
	lw t1,0(t0)			
	addi t1,t1,100			# incrementa 10 para represemtar os 10 de vida recuperados
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
	beq t1,t2,projetil
	
	li t2,'4'
	beq t1,t2,projetil
	
	j inimigo_1
	
projetil:
	la t0,ATK_PROJ
	lw t1,0(t0)
	beq t1,zero,inimigo_1
	
	la t0,DIRECAO_PROJ
	lw t1,0(t0)
			
	li t2,1
	beq t2,t1,MOV_CIMA
 
	li t2,2
	beq t2,t1,MOV_BAIXO
	
	li t2,3
	beq t2,t1,MOV_LEFT
 
	li t2,4
	beq t2,t1,MOV_RIGHT
	
MOV_CIMA:
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
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x0000001f
	beq t4,t5,CLEAN	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL
	li t5,0x00000005
	beq t4,t5,MOTO_KILL
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL		
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,-16
	sh t1,2(t0)

	la t0,POS_PROJ
	la a0,papel_perfurado_cima
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
	
MOV_BAIXO:
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
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x0000001f
	beq t4,t5,CLEAN	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL
	li t5,0x00000005
	beq t4,t5,MOTO_KILL
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL		
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t1,t1,16
	sh t1,2(t0)		
	
	la t0,POS_PROJ
	la a0,papel_perfurado_baixo
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
	
MOV_LEFT:
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
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x0000001f
	beq t4,t5,CLEAN	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL
	li t5,0x00000005
	beq t4,t5,MOTO_KILL
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL	
#######	
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	addi t6,t6,-16
	sh t6,0(t0)
			
	la t0,POS_PROJ
	la a0,papel_perfurado_left
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

MOV_RIGHT:
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
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se é verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x0000001f
	beq t4,t5,CLEAN	
	li t5,0x00000007		# Checa para ver se é vermelho/capacitor
	beq t4,t5,CPCTR_KILL
	li t5,0x00000005
	beq t4,t5,MOTO_KILL
	li t5,0xffffffcd
	beq t4,t5,PROJETOR_KILL
	li t5,0xffffffe6
	beq t4,t5,PROJETOR_PROJ_KILL		
#######
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			
	addi t6,t6,16
	sh t6,0(t0)
	
	la t0,POS_PROJ
	la a0,papel_perfurado_right
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
CLEAN:
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	j GAME_LOOP
	
CPCTR_KILL:
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
	
	la t0,ENEMY_1_SWITCH
	sw zero,0(t0)
	
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_1_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
MOTO_KILL:
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
	
	la t0,ENEMY_2_SWITCH
	sw zero,0(t0)
	
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_2_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
	
PROJETOR_KILL:
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
	
	la t0,ENEMY_3_SWITCH
	sw zero,0(t0)
	
	la t0,ATK_PROJ
	sw zero,0(t0)
	
	la t0,ENEMY_3_POS
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	la a0,tile1
	li a3,1
	call print
	
	la t0,OLD_POS_PROJ
	la a0,tile
	lh a1,0(t0)
	lh a2,2(t0)
	li a3,0
	call print
	
	j inimigo_1
	
PROJETOR_PROJ_KILL:
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
													
inimigo_1:
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_1_SWITCH		
	lw t0,0(t0)
	beq t0,zero,inimigo_2
######
#Checa para ver se pode atacar	
	la t0,TEMPO_ATK
	lw t1,0(t0)
	bne t1,zero,inimigo_2
	call inimigo_1_rotina
	
inimigo_2:
	li t0,2500000
	rem t1,s9,t0
	bne t1,zero,inimigo_3
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_2_SWITCH		
	lw t0,0(t0)
	beq t0,zero,inimigo_3
	call inimigo_2_rotina
	
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
	beq t0,zero,game_loop1
	
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
	sb t1,0(t0)			# Atualiza o tempo
	
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
##########
selecATAQUE:
	la t0, CHAR_SELECT
	lw t0, 0(t0)			#pega a info de qual personagem está selecionado, as linhas de codigo abaizo selecionará qual o tipo de #dano
 
	li t1, '1'
	beq t0, t1, SELECMELEE 
 
 	li t1, '2'
	beq t0, t1, SELECPROJ 
	
	li t1, '3'
	beq t0, t1, SELECMELEE
	
	li t1, '4'
	beq t0, t1, SELECPROJ
##########
sair:
	li a7,10
	ecall
	
.include "print.s"
.include "inimigo_1_rotina.s"
.include "ataqueproj.s"
.include "inimigo_2_rotina.s"
.include "inimigo_3_rotina.s"
.include "enemy_proj.s"
.include "ataquemelee.s"	
.include "SYSTEMv21.s"
