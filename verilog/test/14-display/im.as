.text
main:
	add $0, $0, $0
	
	#preparing address
	addi $1, $0, 0xC000	
	sll $2, $1, 16	
	addi $2, $2, 0x110
	
display:
	add $0, $0, $0
	addi $3, $zero, 0x1
	add $0, $0, $0
	sw $3, 0x0($2)
	add $0, $0, $0
	
	
	add $0, $0, $0
	addi $3, $zero, 0x2
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x3
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x4
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x5
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x6
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x7
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x8
	add $0, $0, $0
	sw $3, 0x0($2)
	
	add $0, $0, $0
	addi $3, $zero, 0x9
	add $0, $0, $0
	sw $3, 0x0($2)

	b display
