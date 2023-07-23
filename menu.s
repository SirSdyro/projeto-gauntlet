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
			la s4,NUM_volta_menu
			lw s5,0(s4)		
			la s4,NOTAS_volta_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_volta_menu:	beq s6,s5, EFC_FIM_volta_menu
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_volta_menu				
EFC_FIM_volta_menu:
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
			la s4,NUM_volta_menu
			lw s5,0(s4)		
			la s4,NOTAS_volta_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_volta_menu1:	beq s6,s5, EFC_FIM_volta_menu1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_volta_menu1				
EFC_FIM_volta_menu1:
	la a0, sobe_selecao1
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, sobe_selecao2
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, sobe_selecao3
	li a1,0				
	li a2,0				
	li a3,0				
	call print			
	li a3,1				
	call print
	li a7,32
	li a0,150
	ecall
	la a0, sobe_selecao4
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

cnt_selec:
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
  	  	
 	j KEY1_2
 	
cnt_selec_personagem:	
			la s4,NUM_volta_menu
			lw s5,0(s4)		
			la s4,NOTAS_volta_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_cnt_selec:	beq s6,s5, EFC_FIM_cnt_selec
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1
			j EFC_LOOP_cnt_selec	
EFC_FIM_cnt_selec:	la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
			j cnt_selec
			
##========= tela descrições =========#
#========== LAMAR
descricao_lamar:	
			la s4,NUM_avanca_menu
			lw s5,0(s4)		
			la s4,NOTAS_avanca_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_avanca_menu1:	beq s6,s5, EFC_FIM_avanca_menu1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_avanca_menu1				
EFC_FIM_avanca_menu1:
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
		li s7,1
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
descricao_ada:		
			la s4,NUM_avanca_menu
			lw s5,0(s4)		
			la s4,NOTAS_avanca_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_avanca_menu2:	beq s6,s5, EFC_FIM_avanca_menu2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_avanca_menu2			
EFC_FIM_avanca_menu2:
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
		li s7,2
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
descricao_babbage: 
			la s4,NUM_avanca_menu
			lw s5,0(s4)		
			la s4,NOTAS_avanca_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_avanca_menu3:	beq s6,s5, EFC_FIM_avanca_menu3
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_avanca_menu3			
EFC_FIM_avanca_menu3:
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
		li s7,3
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
descricao_alan: 
			la s4,NUM_avanca_menu
			lw s5,0(s4)		
			la s4,NOTAS_avanca_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_avanca_menu4:	beq s6,s5, EFC_FIM_avanca_menu4
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_avanca_menu4		
EFC_FIM_avanca_menu4:
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
		li s7,4
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
			la s4,NUM_entra_instrucoes
			lw s5,0(s4)		
			la s4,NOTAS_entra_instrucoes
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_instrucoes_gameplay:	
			beq s6,s5, EFC_FIM_instrucoes_gameplay
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_instrucoes_gameplay				
EFC_FIM_instrucoes_gameplay:
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
	 	la a0,instrucoes_menu
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
		li a7,32
		li a0,100
		ecall
loop_INSTRUCOES: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_instrucoes:	
		lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_instrucoes	# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,efc_instrucoes2
  		
  		j loop_instrucoes
  		
efc_instrucoes2:	la s4,NUM_avanca_menu
			lw s5,0(s4)		
			la s4,NOTAS_avanca_menu
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_avanca_menu5:	beq s6,s5, EFC_FIM_avanca_menu5
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_avanca_menu5	
EFC_FIM_avanca_menu5:
instrucoes2:	
			la a0, monitorchiado5
			li a1,0				
			li a2,0				
			li a3,0				
			call print			
			li a3,1				
			call print
			li a7,32
			li a0,400
			ecall
	 	la a0,instrucoes_menu2
		li a1,0				
		li a2,0				
		li a3,0				
		call print			
		li a3,1				
		call print
loop_INSTRUCOES2: 	
		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
loop_instrucoes2:	
		lw t0,0(t1)			# Le bit de Controle Teclado
   		andi t0,t0,0x0001		# mascara o bit menos significativo
   		beq t0,zero,loop_instrucoes2	# não tem tecla pressionada então volta ao loop
   		lw t2,4(t1)			# le o valor da tecla
  		sw t2,12(t1)  			# escreve a tecla pressionada no display
  	
  		li t0,'1'
  		beq t2,t0,cnt_instrucoes
  		
  		j loop_instrucoes
#vai para o CHAR de acordo com o valor em s7
cnt_instrucoes:	
		j EFC_EFECT_continuar
		continue_continuar:
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

