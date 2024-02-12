.text
	.globl complete_move

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  4 |  0 |  0 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 


complete_move:
	addi $sp $sp -16
	sw $a0 ($sp)
	sw $ra 4($sp)
	jal move_left
	lw $a0 ($sp)
	jal merge
	lw $a0 ($sp)
	sw $v1 8($sp)
	sw $v0 12($sp)
	jal move_left
	lw $a0 ($sp)
	lw $ra 4($sp)
	lw $v1 8($sp)
	lw $v0 12($sp)
	addi $sp $sp 16
    jr $ra
