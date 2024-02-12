.text
	.globl move_left
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|	
#	|  0 |  2 |  0 |  4 |	=> 	|  2 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|	
#
	
move_left:
	addi $sp $sp -8
	sw $ra 4($sp)
	sw $a0 ($sp)
loop:
	jal move_one
	lw $a0 ($sp)
	bnez $v0 loop
	lw $ra 4($sp)
	addi $sp $sp 8
    jr $ra