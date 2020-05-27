@Hamilton Nguyen

.global sumS32 /*int32_t */
.global sumU32_64 /*uint64_t */
.global countNegative /*unit32_t*/
.global leftStringFull /*void */
.global leftStringTrunc /*void */
.global countMatches /*unit32_t */
.global find2ndMatch /*int32_t */
.global sortDecendingInPlace /*void */
.global decimalStringToInt8 /*int8_t */
.global hexStringToUint32 /*unit32_t */
.global uint8ToBinaryString /*void */
.global findStreet /*int32_t */

.text

sumS32:

	MOV R2, R0
	MOV R0, #0
	CMN R1, #0
	CMP R1, #0
	sumS32_loop_1:
	BEQ sumS32_Return
	LDR R3, [R2], #4
	ADD R0, R0, R3 
	SUBS R1, R1, #1
	B sumS32_loop_1
	
	sumS32_Return:
	BX LR 

sumU32_64:
	
	PUSH {R4,R5,R6}
	MOV R5, R0
	MOV R6, R1
	MOV R0, #0
	MOV R1, #0
	sumU32_64_loop_1:
	LDR R4, [R5], #4
	ADDS R0, R0, R4
	ADC R1, R1, #0
	SUBS R6, R6, #1
	
	BNE sumU32_64_loop_1
	POP {R4,R5,R6}
	BX LR

countNegative:

	PUSH {R4,R5}
	MOV R4, R0
	MOV R0, #0
	CMP R1, #0
	countNegative_loop_1:
	BEQ countNegative_Return
	LDR R5, [R4], #4
	CMP R5, #0
	ADDLT R0, R0, #1
	ADDGE R0, R0, #0
	SUBS R1, R1, #1
	B countNegative_loop_1

	countNegative_Return:
	POP {R4,R5}
	BX LR

leftStringFull:

	PUSH {R4}
	CMP R2, #0
	BEQ leftStringFull_first_character
	MOV R4, #0
	MOV R0, #0
	leftStringFull_string_length:
	LDRB R4, [R1], #1 
	CMP R4, #0												
	BEQ leftStringFull_verify_length								
	ADD R0, R0, #1										
	B leftStringFull_string_length
	
	leftStringFull_verify_length:
	CMP R0, R2									
	BMI leftStringFull_exceed_length							
	MOV R4, #0
	MOV R0, #0
	leftStringFull_loop_1:
	STRB R1, [R4], #1 
	SUB R2, R2, #1
	BNE leftStringFull_loop_1
	MOV R0, R4
	POP {R4}
	BX LR
	
	leftStringFull_first_character:
	MOV R0, #0
	POP {R4}
	BX LR
	
	leftStringFull_exceed_length:
	MOV R0, #0xFFFFFFFF
	POP {R4}
	BX LR

leftStringTrunc:

	PUSH {R4}
	CMP R2, #0
	BEQ leftStringTrunc_none
	MOV R4, #0
	leftStringTrunc_loop_1:
	STRB R1, [R4], #1
	SUB R2, R2, #1
	BNE leftStringTrunc_loop_1
	MOV R0, R4
	POP {R4}
	BX LR
	
	leftStringTrunc_none:
	POP {R4}
	BX LR

countMatches:

	CMP R1, #0
	BEQ countMatches_none
	PUSH {R4,R5,R6}
	LDRSB R6, [R1], #1
	MOV R4, R6
	MOV R5, #0
	LDRSB R3, [R0], #1
	countMatches_scan_position:
	CMP R6,R3
	LDRSB R3, [R0], #1
	BNE countMatches_restart
	LDRSB R6, [R1], #1
	CMP R6, #0
	BEQ countMatches_level_increment 
	B countMatches_scan_position
	
	countMatches_restart:
	MOV R6, R4
	CMP R3, #0
	BEQ countMatches_findStreet_return
	B countMatches_scan_position
	countMatches_level_increment:
	ADD R5,R5, #1
	B countMatches_scan_position
	
	countMatches_findStreet_return:
	MOV R0, R5
	POP {R4, R5,R6}
	BX LR
	
	countMatches_none:
	MOV R0, #0XFFFFFFFF
	BX LR

find2ndMatch:
	
	PUSH {R0, R1,R4,R9}
	MOV R9, #0
	find2ndMatch_loop_1:
	LDRSB R2, [R0]
	LDRSB R4, [R1]
	CMP R4, #0
	BEQ find2ndMatch_match_findStreet_return_string
	CMP R9, #2
	BEQ find2ndMatch_return
	CMP R2, #0
	BEQ find2ndMatch_return_negative	
	CMP R2, R4
	BEQ find2ndMatch_hit
	CMP R2, R4
	BNE find2ndMatch_not_equal
	
	find2ndMatch_hit:
	ADD R0, R0, #1
	ADD R1, R1, #1
	B find2ndMatch_loop_1

	find2ndMatch_not_equal:
	POP {R1}
	PUSH {R1}
	ADD R0, R0, #1
	B find2ndMatch_loop_1
		
	find2ndMatch_match_findStreet_return_string:
	ADD R9, R9, #1
	POP {R1}
	PUSH {R1}
	B find2ndMatch_loop_1

	find2ndMatch_return_negative:
	MOV R0, #-1
	BX LR

	find2ndMatch_return:
	POP {R1,R4}
	SUB R0, R0, R1
	BX LR

sortDecendingInPlace:

	CMP R1, #0
	BEQ sortDecendingInPlace_position_zero
	PUSH {R4,R5,R6,R7,R8}
	MOV R5, #0
	sortDecendingInPlace_position_move:
	LDR R7, [R0], #4
	ADD R5, R5, #4
	MOV R6, R5
	SUB R1, R1, #1
	BEQ sortDecendingInPlace_return
	sortDecendingInPlace_highest_value:
	LDR R8, [R0], R6
	ADD R6, R6, #4
	CMP R7, R8
	CMN R7, R8
	BLT sortDecendingInPlace__switch_numbers
	CMP R8, #0
	BEQ sortDecendingInPlace_position_move
	B sortDecendingInPlace_highest_value
	sortDecendingInPlace__switch_numbers:
	MOV R4, R7
	MOV R7, R8
	B sortDecendingInPlace_highest_value
	
	sortDecendingInPlace_return:
	POP {R4,R5,R6,R7,R8}
	MOV R0, R7
	BX LR
	
	sortDecendingInPlace_position_zero:
	BX LR

decimalStringToInt8:

	PUSH {R4,R5,R6,R7,R8,R9,R10}
	MOV R4, R0            	
	MOV R1, R0            	
	MOV R6, #0         
	MOV R0, #0            
	MOV R7, #1            
	MOV R3, #10           	
	MOV R9, #0
	MOV R10, #0
	decimalStringToInt8_scan_bit_zero:
	LDRSB R5, [R4]
	CMP R5, #'-'
	SUBEQ R10, R10, #1
	LDREQSB R5, [R4], #1
	LDREQSB R2, [R1], #1
	ADDNE R10, R10, #1      	
	decimalStringToInt8_counter:
	LDRSB R5, [R4], #1    	
	CMP R5, #0            	
	BEQ decimalStringToInt8_register8           	
	ADD R6, R6, #1        	
	B decimalStringToInt8_counter	

	decimalStringToInt8_register8:
	MOV R8, R6                	
	SUB R8, #1                	
	B decimalStringToInt8_data_handle  	

	decimalStringToInt8_data_handle:
	SUB R8, R9                	
	LDRSB R2, [R1], #1    	
	CMP R2, #0                
	MULEQ R0, R0, R10

	BEQ decimalStringToInt8_data_return
	CMP R2, #65
	BLT decimalStringToInt8_numerical
	BGE decimalStringToInt8_alpha     
	B decimalStringToInt8_data_handle

	decimalStringToInt8_numerical:                     
	SUB R2, #48                
	MOV R7, #1                   
	B decimalStringToInt8_crossedproduct_loop_1  	

	decimalStringToInt8_alpha:                             
	SUB R2, #55                   	
	MOV R7, #1                      	
	B decimalStringToInt8_crossedproduct_loop_1  	

	decimalStringToInt8_crossedproduct_loop_1 :        	
	CMP R2, #0                    
	BLT decimalStringToInt8_return_zero           	
	CMP R2, #9                   	
	BGT decimalStringToInt8_return_zero          	
	CMP R8, #0                    
	BEQ decimalStringToInt8_crossproduct_register2 	
	MUL R7, R3, R7                	
	SUB R8, #1                  
	B decimalStringToInt8_crossedproduct_loop_1

	decimalStringToInt8_crossproduct_register2: 
	ADD R9, R9, #1        	
	MUL R7, R7, R2
	ADD R0, R0, R7        	
	B decimalStringToInt8_register8

	decimalStringToInt8_return_zero:
	MOV R0, #0
	B decimalStringToInt8_data_return

	decimalStringToInt8_data_return:
	POP {R4,R5,R6,R7,R8,R9,R10}
	BX LR

hexStringToUint32:

	PUSH {R4,R5,R6,R7,R8,R9}
	MOV R4, R0            	
	MOV R6, #0            	
	MOV R1, R0            	
	MOV R0, #0            	
	MOV R7, #1            	
	MOV R3, #16           
	MOV R9, #0
	hexStringToUint32_iteration_string_per_count:
	LDRSB R5, [R4], #1    		
	CMP R5, #0            			
	BEQ hexStringToUint32_register8_dataHandle           		
	ADD R6, R6, #1        			
	B hexStringToUint32_iteration_string_per_count	
                          			  
	hexStringToUint32_register8_dataHandle:
	MOV R8, R6            		
	SUB R8, #1            		
	B hexStringToUint32_function_1	

	hexStringToUint32_function_1:
	SUB R8, R9            		
	LDRSB R2, [R1], #1    	
	CMP R2, #0            		
	BEQ hexStringToUint32_return       	
	CMP R2, #65           		
	BLT hexStringToUint32_numerical
	BGE hexStringToUint32_hex_alpha      
	B hexStringToUint32_function_1	

	hexStringToUint32_numerical:             			
	SUB R2, #48           			
	MOV R7, #1            			
	B hexStringToUint32_crossedProduct_loop_1   	

	hexStringToUint32_hex_alpha:                   				
	SUB R2, #55           			
	MOV R7, #1            			
	B hexStringToUint32_crossedProduct_loop_1   	

	hexStringToUint32_crossedProduct_loop_1:    		
	CMP R2, #0            			
	BLT hexStringToUint32_return_zero       		
	CMP R2, #15           			
	BGT hexStringToUint32_return_zero       		
	CMP R8, #0            			
	BEQ hexStringToUint32_crossedProduct_R2_register  		
	MUL R7, R3, R7        			
	SUB R8, #1            			
	B hexStringToUint32_crossedProduct_loop_1   	

	hexStringToUint32_crossedProduct_R2_register:         	
	ADD R9, R9, #1        	
	MUL R7, R7, R2        	                     		
	ADD R0, R0, R7        	
	B hexStringToUint32_register8_dataHandle             	

	hexStringToUint32_return_zero:
	MOV R0, #0
	B hexStringToUint32_return

	hexStringToUint32_return:               	
	POP {R4,R5,R6,R7,R8,R9}
	BX LR

uint8ToBinaryString: 

	PUSH {R4}
	MOV R2, #0X80  
	hexStringToUint32_loop_1:
	TST R1, R2
	MOVNE R4, #'1'
	MOVEQ R4, #'0'
	STRB R4, [R0],#1
	MOVS R2, R2, LSR #1
	
	BNE hexStringToUint32_loop_1
	MOV R4, #0
	STRB R4, [R0]
	POP {R4}
	BX LR

findStreet:

	push {R4,R5,R6}
	MOV r6, #0			
	ADD r1, r1, #31 		
	mov r4, #0
				
	findStreet_equality_compare:
	CMP r1 , r0			
	beq findStreet_char_hit			
	bne findStreet_Finish_execution		
		
	findStreet_char_hit:
	add r4, #1			
	cmp r4, #3
	beq findStreet_Banner	
	
	findStreet_Banner:
	MOV R5, #1			
	B findStreet_proceed
	
	findStreet_proceed:
	ADD r1, r1, #1			
	ADD r0, r0, #1			
	b findStreet_equality_compare		
	findStreet_Finish_execution:
	CMP R5, #1			
	BNE findStreet_scan_index
	BEQ findStreet_query_found
	
	findStreet_query_found:
	MOV R0, R6			
	B findStreet_return
					
	findStreet_scan_index:
	CMP R6, R5			
	BEQ findStreet_query_not_found			
	ADD R4, R4, #120		
	ADD R6, R6, #1			
	B findStreet_equality_compare
	findStreet_query_not_found:
	MOV R0, #-1	
	B findStreet_return
	
	findStreet_return:
	POP {R4,R5,R6}
	BX LR
	  
