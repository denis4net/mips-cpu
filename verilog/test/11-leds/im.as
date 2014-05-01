.text
main:
	add $0, $0, $0

	#preparing address
	addi $1, $0, 0xC000	

	
	sll $2, $1, 16 		#in $2 no 0xC0000000	
	addi $2, $2, 0x8C	#in $2 now 0xC000008C - addres of LEDs control register
	
leds:
	add $0, $0, $0
	addi $3, $zero, 0x1
	sll $4, $3, 31
	add $0, $0, $0
	sw $4, 0x0($2)
	

	#off first led
	add $0, $0, $0
	addi $4, $4, 1
	add $0, $0, $0
	sw $4, 0x0($2)
	
	#on second led
	add $0, $0, $0
	addi $4, $4, 2
	add $0, $0, $0
	sw $4, 0x0($2)
	
	#on third led
	add $0, $0, $0
	addi $4, $4, 4
	add $0, $0, $0
	sw $4, 0x0($2)
	
	add $0, $0, $0
	addi $4, $4, 8
	add $0, $0, $0
	sw $4, 0x0($2)
	
	add $0, $0, $0
	addi $4, $4, 16
	add $0, $0, $0
	sw $4, 0x0($2)
	
	add $0, $0, $0
	addi $4, $4, 32
	add $0, $0, $0
	sw $4, 0x0($2)

	add $0, $0, $0
	addi $4, $4, 64
	add $0, $0, $0
	sw $4, 0x0($2)
	
	add $0, $0, $0
	addi $4, $4, 128
	add $0, $0, $0
	sw $4, 0x0($2)
	add $0, $0, $0
	
	b leds
