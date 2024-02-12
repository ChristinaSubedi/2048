.text
	.globl merge

#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|		|----|----|----|----|
#	|  2 |  2 |  0 |  4 |  => 	|  4 |  0 |  0 |  4 |
#	|----|----|----|----|		|----|----|----|----|
#
#   BONUS: Return the number of merges in $v0 and the
#          total base score of the merges in $v1. 

merge:
	li $v0 0
	li $v1 0
	li $t0 1 #counter to check if buffer ended
	
loop:
	lw $t1 ($a0) #first index
	lh $t1 ($t1)
	lw $t2 4($a0) #second index
	lh $t2 ($t2)
	beqz $t1 bothzero
	beq $t1 $t2 mergefound #check if index are equal
bothzero:
	addi $t0 $t0 1 
	addi $a0 $a0 4
	bne $t0 $a1 loop
	j end
mergefound:
	add $v0 $v0 1
	add $t3 $t1 $t2 #adding equal content	
	add $v1 $v1 $t3
	lw $t4 ($a0)
	sh $t3 ($t4)
	lw $t4 4($a0)
	sh $zero ($t4)
	addi $a0 $a0 4 #checks for next index
	addi $t0 $t0 1
	bne $t0 $a1 loop
end:	
    jr $ra
