.include "MACROSv21.s"

.data
menu:
.include "menu_gauntlet.data"
.include "menu_gauntlet_2.data"
mapa_e_hitbox:
.include "mapa1_teste.data"
.include "hitbox_mapateste2.data"
.include "GauntletRoom001MapBG.data"
.include "escotilha_aberta.data"
.include "tile.data"
.include "tile1.data"
.include "tile2.data"
.include "tile_hitbox_char.data"
.include "tile_hitbox_enemy.data"
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

CHAR_SELECT:	.word 0				# define o personagem selecionado
CHAR_POS:	.half 8,8			# x, y
OLD_CHAR_POS:	.half 8,8			# x, y
SAIDA_POS: 	.half 8,216			# x, y
TEMPO: 		.word 60
TEMPO_ATK: 	.word 1				# tempo at� o ataque do inimigo
ENEMY_1_POS:    .half 216,216			# x, y
ENEMY_1_OLD_POS:.half 216,216			# x, y
ENEMY_1_ATK:	.half 0,0			# x, y
ENEMY_1_SWITCH: .word 0				# permite a exist�ncia do inimigo 1 (no caso o capacitor parasita)
DIRECAO_PROJ:   .word 0
ATK_PROJ: 	.word 0				# registra a exist�ncia do proj�til do personagem
POS_PROJ:	.half 0,0			# x, y
OLD_POS_PROJ:   .half 0,0			# x, y
POS_MELEE:	.half 0,0			# x, y

.text
#OBSERVA��ES:
#*No menu, a op��o de ver as instru��es ainda n�o est� implementada, nada acontecer� se voc� pressionar 2
#*Recomenda-se o uso do paint.net com o arquivo da hitbox ou do mapa para obter as coordenadas precisas de onde voc� quer printar
#ou de qual pixel voc� quer checar
#*Cuidado com as coordenadas que utilizar�, se n�o forem m�ltiplas de 4, muito provavelmente dar� erro
#*Na sele��o de mapas o mapa2 est� igual o primeiro apenas como placeholder, a implementa��o de um mapa diferente � f�cil
#*O tempo s� funciona no FPGrars, j� que a execu��o detro do rars normal � lento para ded�u e l� � extremamente r�pida

##########
##########
MENU:
	la a0, menu_gauntlet		# Carrega o endere�o do menu para print�-lo apenas no frame 0
	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite
	
	call KEY1
	
KEY1: 	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
LOOP: 	lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP		# n�o tem tecla pressionada ent�o volta ao loop
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
	la a0, menu_gauntlet_2		# Carrega o endere�o do menu de sele��o de personagem para printar apenas no frame 0
	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite
	
	call KEY1_2
KEY1_2: 	
	li t1,0xFF200000		# carrega o endere�o de controle do KDMMIO
LOOP_2: lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP_2		# n�o tem tecla pressionada ent�o volta ao loop
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

map1:	la a0,mapa1_teste
	j setup1
map2:	la a0,hitbox_mapateste2
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
	
hitbox1:
	la a0,hitbox_mapateste2
	j setup2
hitbox2:
	la a0,hitbox_mapateste2
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
 	la s3,lamar_baixo		# Primeiro sprite do personagem(futuras altera��es ser�o feitas para permitir a sele��o de personagem com base no S9)	
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
	la a0,tile_hitbox_char		# Carrega o endere�o da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite
		
#printando o inimigo e sua hitbox
	la t0,ENEMY_1_SWITCH
	lw t0,0(t0)
	beq t0,zero,setup4
	la t0,ENEMY_1_POS	
	la a0,capacitor_parasita
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	li a3,0				# carrega o valor do frame em a3
	call print			# imprime o sprite
	la a0,tile_hitbox_enemy		# Carrega o endere�o da hitbox do personagem
	li a3,1				# Seleciona o frame 1
	call print			# imprime o sprite
#definindo a posi��o de ataque do capacitor parasita
	la t0,CHAR_POS
	lw t1,0(t0)
	la t0,ENEMY_1_ATK
	sw t1,0(t0)
	
setup4:	
 	li s11,0			# Define o valor inicial do registrador da chave
 	j GAME_LOOP
##########
##########
# Quando o registrador s9 atinge o valor estabelecido no game loop,
# � decrementado 1 do valor indicado pela label TEMPO, representando os segundos
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
	beq t1,zero,sair
	blt t1,zero,sair
#tempo_ataque_inimigo:
	la t0,TEMPO_ATK			# Carrega o valor do tempo de ataque do inimigo
	lw t1,0(t0)			
	addi t1,t1,-1			# Decrementa 1 para simbolizar o 1 segundo passado 
	sw t1,0(t0)			# Atualiza o tempo de ataque	
	j GAME_LOOP				
##########

##########
DANO_2:
	la t0,TEMPO			# Carrega o valor do tempo atual
	lb t1,0(t0)
	addi t1,t1,-10			# Decrementa 10 de dano
	sb t1,0(t0)			# Atualiza o valor do tempo
	j GAME_LOOP
##########
##########
CHECK_KEY:
	beq s11,zero,GAME_LOOP
	la t0,SAIDA_POS
	la a0,escotilha_aberta		# carrega o endereco do sprite 'char' em a0
	lh a1,0(t0)			# carrega a posicao x do personagem em a1
	lh a2,2(t0)			# carrega a posicao y do personagem em a2
	mv a3,s0			# carrega o valor do frame em a3
	call print
#passando para a pr�xima fase	
	addi s10,s10,1			# Soma-se 1 ao registrador de selecionar o mapa para indicar que o pr�xima mapa com sua hitbox deve ser selecionado
#reseta a posi��o do personagem	
	li t1,8				# Soma-se 8 para resetar a posi��o inicial do personagem e sua hitbox(Sup�e-se que a posi��o inicial do personagem ser� nas coordenadas (8,8) em todos os mapas por via de simplicidade)
	la t0,CHAR_POS			# Carrega a posi��o do personagem 
	sh t1,0(t0)			# Atualiza o x
	sh t1,2(t0)			# Atualiza o y
	la t0,OLD_CHAR_POS		# Carrega a posi��o antiga do personagem
	sh t1,0(t0)			# Atualiza o x
	sh t1,2(t0)			# Atualiza o y
#reseta o tempo	
	la t0,TEMPO
	li t1,60
	sw t1,0(t0)
#inimigos
	la t0,ENEMY_1_SWITCH
	li t1,1
	sw t1,0(t0)
	la t0,TEMPO_ATK
	li t1,1
	sw t1,0(t0)
	la t0,ENEMY_1_POS
	li t1,216
	sh t1,0(t0)
	sh t1,2(t0) 
	la t0,ENEMY_1_OLD_POS
	sh t1,0(t0)
	sh t1,2(t0)
	la t0,ENEMY_1_ATK
	sh zero,0(t0)
	sh zero,2(t0)	 		
	j SETUP
CHAVE:
	li s11,1			# Altera o valor do registrador da chave
######
#Realiza o processo de atualiza��o de sprites de uma forma meio grosseira a fim de permitir o reuso para todos as dire��es de movimento	
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
#Ap�s as altera��es feitas para acomodar a hitbox din�mica, o game loop est� vazio e , acredito eu, poderemos
#us�-lo para fazer o tempo, inimigos e outros processos que devem ocorrer sem o input do jogador

contador:
# Serve para definir quando passou aproximadamente 1 segundo
# este valor de 20 milh�es foi escolhido devido a como os comandos s�o processados no assembly
# e ao fato que a execu��o no FPGrars � absurdamente r�pida. Ele pode ser alterado para mudar
# o qu�o r�pido o tempo � decrementado. Muito provavelmente ser� alterado quando o resto do jogo
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
#checa colis�o
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	addi t4,t4,-320	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se � azul/parede
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se � verde/porta/escotilha
	beq t4,t5,CLEAN	
	li t5,0x00000007		# Checa para ver se � vermelho/capacitor
	beq t4,t5,CPCTR_KILL	
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
#checa colis�o
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	li t5,320
	li t3,16
	mul t3,t5,t3
	add t4,t4,t3
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se � azul/parede
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se � verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x00000007		# Checa para ver se � vermelho/capacitor
	beq t4,t5,CPCTR_KILL		
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
#checa colis�o
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	addi t4,t4,-1	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se � azul/parede
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se � verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x00000007		# Checa para ver se � vermelho/capacitor
	beq t4,t5,CPCTR_KILL	
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
#checa colis�o
	la t0,POS_PROJ
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	addi t4,t4,16	
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se � azul/parede
	beq t4,t5,CLEAN
	li t5,0x00000038		# Checa para ver se � verde/porta/escotilha
	beq t4,t5,CLEAN
	li t5,0x00000007		# Checa para ver se � vermelho/capacitor
	beq t4,t5,CPCTR_KILL	
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
	
					
inimigo_1:
######
#Checa para ver se o inimigo pode existir
	la t0,ENEMY_1_SWITCH		
	lw t0,0(t0)
	beq t0,zero,game_loop1
######
#Checa para ver se pode atacar	
	la t0,TEMPO_ATK
	lw t1,0(t0)
	bne t1,zero,game_loop1
######
#Reseta o tempo de ataque	
	li t1,1
	sw t1,0(t0)
######
#Atualiza a antiga posi��o do capacitor		
	la t0,ENEMY_1_POS
	lw t1,0(t0)
	la t0,ENEMY_1_OLD_POS
	sw t1,0(t0)
######
#Atualiza a posi��o atual do capacitor		
	la t0,ENEMY_1_ATK
	lw t1,0(t0)
	la t0,ENEMY_1_POS
	sw t1,0(t0)
######
#Printa o capacitor na posi��o de ataque	
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
#Atualiza a posi��o de ataque para o pr�ximo ataque		
	la t0,CHAR_POS
	lh t1,0(t0)
	lh t2,2(t0)
	la t0,ENEMY_1_ATK
	sh t1,0(t0)
	sh t2,2(t0)
######
#Limpa o sprite do inimigo e sua hitbox na posi��o antiga no frame 0 e no frame 1	
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
DANO_1:
	la t0,TEMPO			# Carrega o valor do tempo atual
	lb t1,0(t0)
	addi t1,t1,-10			# Decrementa 10 de dano
	sb t1,0(t0)			# Atualiza o tempo
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
game_loop1:
#Essa label ficar� aqui por poss�veis conveni�ncias futuras, mas muito provavelmente pode ser apagada, ent�o dane-se
	call KEY2			# chama o procedimento de entrada do teclado
		
	j GAME_LOOP
##########
##########
### Apenas verifica se h� tecla pressionada
KEY2:	li t1,0xFF200000		# carrega o endereco de controle do KDMMIO
	lw t0,0(t1)			# Le bit de Controle Teclado
	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,FIM   	   	# Se nao ha tecla pressionada entao vai para FIM
  	lw t2,4(t1)  			# le o valor da tecla tecla
	
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
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	li t5,320			
	li t6,-1			
	mul t3,t6,t5		
	add t4,t4,t3			# Subtrai-se -1*320 para checar qual a cor do pixel logo acima das coordenadas do jogador
	lb t4,0(t4)			# Carrega um byte do para saber a cor do pixel
	li t5,0xffffffC8		# Checa para ver se � azul/parede
	beq t4,t5,GAME_LOOP
	li t5,0x00000038		# Checa para ver se � verde/porta/escotilha
	beq t4,t5,CHECK_KEY
	li t5,0x00000007
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
 	la s3,lamar_cima		# Primeiro sprite do personagem(futuras altera��es ser�o feitas para permitir a sele��o de personagem com base no S9)	
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
#O posicionamento desse processo � crucial, pois checa qual a posi��o do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para ent�o fazer o processo desejado, no caso
#a obten��o da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	lb t4,0(t4)			
	li t5,0x00000037
	beq t4,t5,CHAVE	
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
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	#la t4,hitbox_mapateste2
	li t5,320
	li t6,16
	mul t3,t6,t5
	add t4,t4,t3
	lb t4,0(t4)
	li t5,0xffffffC8
	beq t4,t5,GAME_LOOP
	li t5,0x00000038
	beq t4,t5,CHECK_KEY
	li t5,0x00000007
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
 	la s3,lamar_baixo		# Primeiro sprite do personagem(futuras altera��es ser�o feitas para permitir a sele��o de personagem com base no S9)	
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
#O posicionamento desse processo � crucial, pois checa qual a posi��o do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para ent�o fazer o processo desejado, no caso
#a obten��o da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	lb t4,0(t4)
	li t5,0x00000037
	beq t4,t5,CHAVE	
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
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	#la t4,hitbox_mapateste2
	addi t4,t4,-1
	lb t4,0(t4)
	li t5,0xffffffC8
	beq t4,t5,GAME_LOOP
	li t5,0x00000038
	beq t4,t5,CHECK_KEY
	li t5,0x00000007
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
 	la s3,lamar_esquerda		# Primeiro sprite do personagem(futuras altera��es ser�o feitas para permitir a sele��o de personagem com base no S9)	
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
#O posicionamento desse processo � crucial, pois checa qual a posi��o do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para ent�o fazer o processo desejado, no caso
#a obten��o da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	lb t4,0(t4)
	li t5,0x00000037
	beq t4,t5,CHAVE	
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
		
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	#la t4,hitbox_mapateste2
	addi t4,t4,16
	lb t4,0(t4)
	li t5,0xffffffC8
	beq t4,t5,GAME_LOOP
	li t5,0x00000038
	beq t4,t5,CHECK_KEY
	li t5,0x00000007
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
 	la s3,lamar_direita		# Primeiro sprite do personagem(futuras altera��es ser�o feitas para permitir a sele��o de personagem com base no S9)	
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
#O posicionamento desse processo � crucial, pois checa qual a posi��o do personagem na hitbox antes
#de atualizar a hitbox dele, permitindo saber qual a cor para ent�o fazer o processo desejado, no caso
#a obten��o da chave
	la t0,CHAR_POS
	lh t6,0(t0)
	lh t1,2(t0)			# carrega o y atual do personagem
	
	li t4,0xFF100000		# Carrega o endere�o base do frame que se quer printar, sendo FF1 = frame 1 e FF0 = frame 0 (o frame 0 � o que aparece ao jogador)
	li t5,320			
	mul t5,t1,t5	# y * 320	# Multiplica o y por 320
	add t4,t4,t5			# Soma-se o y ao endere�o base
	add t4,t4,t6	# a1 += x	# Soma-se o x ao endere�o base
	
	lb t4,0(t4)
	li t5,0x00000037
	beq t4,t5,CHAVE	
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
	lw t0, 0(t0)			#pega a info de qual personagem est� selecionado, as linhas de codigo abaizo selecionar� qual o tipo de #dano
 
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
.include "ataqueproj.s"
.include "ataquemelee.s"	
.include "SYSTEMv21.s"
