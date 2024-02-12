.text
	.globl place
	
# 	$a0 board address
# 	$a1 board length
#	$a2 field number to place into
#	$a3 number to place
#
#	$v0 == 0 iff place succesfull else 1
#

place:
	li $v0 1
	mul $t0 $a2 2
	add $t2 $a0 $t0
	lh $t1 0($t2)
	bne $t1 $zero end
	sh $a3 0($t2)
	li $v0 0
end:	
    jr $ra
