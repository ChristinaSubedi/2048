.text 
	.globl move_one
	
#
#	$a0 buffer address
#	$a1 buffer length
#
#	|----|----|----|----|----|		|----|----|----|----|----|	
#	|  2 |  0 |  2 |  0 |  4 |	=> 	|  2 |  2 |  0 |  4 |  0 |
#	|----|----|----|----|----|		|----|----|----|----|----|
#
#	$v0 1 iff something changed else 0

move_one:
	li $v0 0
	li $t7 1 #t1 checks if buffer length exceeded
loop:
	lw $t1 ($a0) #first index of the buffer
	lh $t1 ($t1)
	beqz $t1 checknext #if zero then checks if next on the buffer is zero
nextiszero:
	addi $t7 $t7 1 
	addi $a0 $a0 4 # next buffer address
	bne $t7 $a1 loop #if buffer length not exceeded
	j end
checknext:
	lw $t2 4($a0) #if next index is 0 as well, no move for that one
	lh $t2 ($t2)
	beqz $t2 nextiszero
shift:	
	lw $t2 4($a0) #we got the address in t2
	lh $t3 ($t2)  #we got the value in t3
	lw $t4 ($a0)  #we got previous address in t4 
	sh $t3 ($t4)

	addi $t7 $t7 1 # next index of buffer size
	addi $a0 $a0 4 # next buffer address
	bne $t7 $a1 shift #checks if end of buffer reached
	lw $t3 ($a0) #we got the address in t2
	li $t2 0 #put the last value as 0
	sh $t2 ($t3) 
	li $v0 1
end:	
	jr $ra
