#===== Efeitos sonoros Menu =====#
#===== Efeito sair menu
EFECT_sair_menu:	la s4,NUM_sair_menu
			lw s5,0(s4)		
			la s4,NOTAS_sair_menu		
			li s6,0			
			li a2,97		
			li a3,112
LOOP_sair_menu:		beq s6,s5, FIM_sair_menu
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j LOOP_sair_menu				
FIM_sair_menu:		j sair1

#===== Menu Controles
EFC_EFECT_controles:	la s4,NUM_controles
			lw s5,0(s4)		
			la s4,NOTAS_controles		
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_controles:	beq s6,s5, EFC_FIM_controles
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_controles				
EFC_FIM_controles:	j CONTROLES

#===== Menu Select
EFC_EFECT_select:	la s4,NUM_select
			lw s5,0(s4)		
			la s4,NOTAS_select		
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_select:	beq s6,s5, EFC_FIM_select
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_select				
EFC_FIM_select:		j SELECT

##===== Efeito tomar dano1 =====##
EFC_EFECT_tomar_dano1:	la s4,NUM_tomar_dano1
			lw s5,0(s4)		
			la s4,NOTAS_tomar_dano1	
			li s6,0			
			li a2,80		
			li a3,112
EFC_LOOP_tomar_dano1:	beq s6,s5, EFC_FIM_tomar_dano1
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_tomar_dano1				
EFC_FIM_tomar_dano1:	j continue_dano1

##===== Efeito tomar dano2 =====##
EFC_EFECT_tomar_dano2:	la s4,NUM_tomar_dano2
			lw s5,0(s4)		
			la s4,NOTAS_tomar_dano2
			li s6,0			
			li a2,80		
			li a3,112
EFC_LOOP_tomar_dano2:	beq s6,s5, EFC_FIM_tomar_dano2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_tomar_dano2				
EFC_FIM_tomar_dano2:	j continue_tomar_dano2

##====== Efeito pegar hd =====##
EFC_EFECT_pegar_hd:	la s4,NUM_pegar_hd
			lw s5,0(s4)		
			la s4,NOTAS_pegar_hd
			li s6,0			
			li a2,108		
			li a3,112
EFC_LOOP_pegar_hd:	beq s6,s5, EFC_FIM_pegar_hd
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_pegar_hd				
EFC_FIM_pegar_hd:	j continue_pegar_hd

#====== Efeito continuar da seleção de personagem =====#
EFC_EFECT_continuar:	la s4,NUM_continuar_instrucoes
			lw s5,0(s4)		
			la s4,NOTAS_continuar_instrucoes
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_continuar:	beq s6,s5, EFC_FIM_continuar
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_continuar				
EFC_FIM_continuar:	j continue_continuar

#===== Efeito pegar chave =====#
EFECT_pegar_chave: 	la s4,NUM_pegar_chave
			lw s5,0(s4)		
			la s4,NOTAS_pegar_chave
			li s6,0			
			li a2,112		
			li a3,112
EFC_LOOP_pegar_chave:	beq s6,s5, EFC_FIM_pegar_chave
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_pegar_chave				
EFC_FIM_pegar_chave:	j continue_pegar_chave

##===== Efeito pegar pen drive =====##
EFECT_pegar_pendrive:	la s4,NUM_pegar_pendrive
			lw s5,0(s4)		
			la s4,NOTAS_pegar_pendrive
			li s6,0			
			li a2,90		
			li a3,112
LOOP_pegar_pendrive:beq s6,s5, FIM_pegar_pendrive
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j LOOP_pegar_pendrive				
FIM_pegar_pendrive:	j continue_pegar_pendrive

##===== Efeito game over / tela game over =====##
EFC_EFECT_game_over: 	la s4,NUM_game_over
			lw s5,0(s4)		
			la s4,NOTAS_game_over		
			li s6,0			
			li a2,86		
			li a3,112
EFC_LOOP_game_over:	beq s6,s5, EFC_FIM_game_over
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_game_over				
EFC_FIM_game_over:	la a0, telagameover
			li a1,0				
			li a2,0				
			li a3,0				
			call print
			la t0,SCORE
			lw t1,0(t0)
			li a7,101			# Printa o numero do SCORE na tela
			mv a0,t1
			li a1,120
			li a2,115
			li a3,0xFF
			ecall
lp_game_over:		li t1,0xFF200000		# carrega o endereço de controle do KDMMIO
LOOP_game_over: 	lw t0,0(t1)			# Le bit de Controle Teclado
   			andi t0,t0,0x0001		# mascara o bit menos significativo
   			beq t0,zero,LOOP_game_over	# não tem tecla pressionada então volta ao loop
   			lw t2,4(t1)			# le o valor da tecla
  			sw t2,12(t1)
			
			li t0,'1'
  			beq t2,t0,EFECT_restart
  			
  			li t0,'0'
  			beq t2,t0,EFECT_sair_menu
  			
  			j lp_game_over
  			
EFECT_restart:		la s4,NUM_restart
			lw s5,0(s4)		
			la s4,NOTAS_restart
			li s6,0			
			li a2,86		
			li a3,112
LOOP_restart: 		beq s6,s5, FIM_restart
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j LOOP_restart				
FIM_restart:		j RESTART

 
#====== Dano DANO_ENEMY_2 moto
EFC_EFECT_DANO_ENEMY_2: la s4,NUM_dano_moto
			lw s5,0(s4)		
			la s4,NOTAS_dano_moto
			li s6,0			
			li a2,80		
			li a3,112
EFC_LOOP_DANO_ENEMY_2:	beq s6,s5, EFC_FIM_DANO_ENEMY_2
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_DANO_ENEMY_2				
EFC_FIM_DANO_ENEMY_2:	j continue_DANO_ENEMY_2

#====== Dano DANO_ENEMY_2_2 moto
EFC_EFECT_DANO_ENEMY_2_2:	la s4,NUM_dano_moto
				lw s5,0(s4)		
				la s4,NOTAS_dano_moto
				li s6,0			
				li a2,80		
				li a3,112
EFC_LOOP_DANO_ENEMY_2_2:	beq s6,s5, EFC_FIM_DANO_ENEMY_2_2
				lw a0,0(s4)		
				lw a1,4(s4)		
				li a7,31		
				ecall			
				mv a0,a1		
				li a7,32		
				ecall			
				addi s4,s4,8		
				addi s6,s6,1		
				j EFC_LOOP_DANO_ENEMY_2_2			
EFC_FIM_DANO_ENEMY_2_2:		j continue_DANO_ENEMY_2_2

#====== Dano projetor
EFC_EFECT_dano_projetor:la s4,NUM_dano_projetor
			lw s5,0(s4)		
			la s4,NOTAS_dano_projetor
			li s6,0			
			li a2,80		
			li a3,112
EFC_LOOP_dano_projetor:	beq s6,s5, EFC_FIM_dano_projetor
			lw a0,0(s4)		
			lw a1,4(s4)		
			li a7,31		
			ecall			
			mv a0,a1		
			li a7,32		
			ecall			
			addi s4,s4,8		
			addi s6,s6,1		
			j EFC_LOOP_dano_projetor				
EFC_FIM_dano_projetor:	j continue_dano_projetor
