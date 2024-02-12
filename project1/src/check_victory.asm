
.text
	.globl check_victory


#
#	$a0 board address
#	$a1 board length
#
#	$v0 == 1 iff 2048 found
#

check_victory:
    li $v0 0
    	li $t0 0
loop:

	lh $t1 0($a0)
	beq $t1, 2048, found
	add $a0, $a0, 2
	addi $t0, $t0, 1
	bne $t0, $a1, loop
	j notfound
found:
	li $v0, 1

notfound:
	jr $ra
