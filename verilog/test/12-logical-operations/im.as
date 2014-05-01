.text
main:
	addi $1, $0, 0xA	
	sll $2, $1, 15
	srl $3, $2, 5
	and $4, $2, $3
	or $5, $2, $3
	xor $6, $2, $3
	
	
