.text
main:
	# 
	
	#preparing address
	addi $1, $0, 0xC000	
	sll $2, $1, 16	
	addi $2, $2, 0x110
	
	
	addi $5, $0, 10
	addi $5, $5, -2
	add $3, $0, $5
	sw $3, 0x0($2)
	
	addi $3, $3, -2
	sw $3, 0x0($0)
	lw $3, 0x0($0)
	sw $3, 0x0($2)
	
	
display:
	addi $1, $0, 0xC000	
	sll $2, $1, 16	
	addi $2, $2, 0x11C
	addi $3, $zero, 0x0
	addi $4, $0, 9
			
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	addi $3, $3, 0x1
	sw $3, 0x0($2)
	
	b display
	

	
