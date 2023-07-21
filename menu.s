menu:
	la a0, menu10			# Carrega o endereço do menu para printá-lo apenas no frame 0
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
  	beq t2,t0,EFC_EFECT_select
  	
  	li t0,'2'
  	beq t2,t0,EFC_EFECT_controles
  	
  	li t0,'3'
  	beq t2,t0,EFECT_sair_menu
  	j KEY1


CONTROLES:
	la a0, monitorchiado1
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, monitorchiado2
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, monitorchiado3
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, monitorchiado4
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, monitorchiado5
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, controles1
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print

	
			li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP_CONTROLES: 	lw t0,0(t1)			# Le bit de Controle Teclado
   			andi t0,t0,0x0001		# mascara o bit menos significativo
   			beq t0,zero,LOOP_CONTROLES	# não tem tecla pressionada então volta ao loop
   			lw t2,4(t1)			# le o valor da tecla
  			sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  			li t0,'0'
  			beq t2,t0,sair_controles
  			
  			j LOOP_CONTROLES
sair_controles:
	la a0, controles2
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, controles3
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, controles4
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	la a0, controles5
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,200
	ecall
	j MENU     
sair1: 	
	li a7,10
	ecall
		
########## 	
sair_select:
	la a0, controles2
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, controles3
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, controles4
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, controles5
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	j MENU	
SELECT:
	la a0, monitorchiado1		# Carrega o endereço do menu de seleção de personagem para printar apenas no frame 0
	li a1,0				# x = 0
	li a2,0				# y = 0
	li a3,0				# frame = 0
	call print			# imprime o sprite
	li a7,32
	li a0,150
	ecall
	la a0, monitorchiado2
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, monitorchiado3
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, monitorchiado4
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, monitorchiado5
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
cnt_selec_personagem:
	la a0, selecao_personagens
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	
	call KEY1_2
	
KEY1_2: 	
	li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP_2: lw t0,0(t1)			# Le bit de Controle Teclado
   	andi t0,t0,0x0001		# mascara o bit menos significativo
   	beq t0,zero,LOOP_2		# não tem tecla pressionada então volta ao loop
   	lw t2,4(t1)			# le o valor da tecla
  	sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  	li t0,'0'
  	beq t2,t0,sair_select
  	
  	li t0,'1'
  	beq t2,t0,descricao_lamar
 
  	li t0,'2'
  	beq t2,t0,descricao_ada
  	 	
  	li t0,'3'
  	beq t2,t0,descricao_babbage
  	
  	li t0,'4'
  	beq t2,t0,descricao_alan
  	  	
 	ret				# retorna

##========= tela descrições =========#
#========== LAMAR
descricao_lamar:li s7,1
		la a0, lamar_descricao
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_selec_LAMAR: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_LAMAR:	lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_LAMAR		# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,instrucoes_gameplay
 
  		li t0,'0'
  		beq t2,t0,cnt_selec_personagem
  		
  		j loop_selec_LAMAR
#========== ADA
descricao_ada:	li s7,2
		la a0, ada_descricao
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_selec_ADA: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_ADA:	lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_ADA		# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,instrucoes_gameplay
 
  		li t0,'0'
  		beq t2,t0,cnt_selec_personagem
  		
  		j loop_selec_ADA

#========== BABBAGE
descricao_babbage: li s7,3
		la a0, babbage_descricao
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_selec_BABBAGE: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_BABBAGE:	lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_BABBAGE	# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,instrucoes_gameplay
 
  		li t0,'0'
  		beq t2,t0,cnt_selec_personagem
  		
  		j loop_selec_BABBAGE

#========== BABBAGE
descricao_alan: li s7,4
		la a0, turing_descricao
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_selec_ALAN: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_ALAN:	lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_ALAN	# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,instrucoes_gameplay
 
  		li t0,'0'
  		beq t2,t0,cnt_selec_personagem
  		
  		j loop_selec_ALAN
  
# Os processos seguintes alteram o valor CHAR_SELECT para definir qual personagem deve ter seus sprites printados
instrucoes_gameplay:
	 	la a0, telaINSTRUCOES
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_INSTRUCOES: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_instrucoes:	
		lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_instrucoes	# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,cnt_instrucoes
  		
  		j loop_instrucoes 
#vai para o CHAR de acordo com o valor em s7
cnt_instrucoes:
		li t0,1
		beq t0,s7,CHAR_1
		li t0,2
		beq t0,s7,CHAR_2
		li t0,3
		beq t0,s7,CHAR_3
		li t0,4
		beq t0,s7,CHAR_4
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
