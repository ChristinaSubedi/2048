.text
	.globl move_check
#
#	$a0 buffer address
#	$a1 buffer length
#
#   $v0 == 1 iff left move possible and would change something
#            else 0
#

move_check:
	li $v0 0
	li $t7 1
loop:
	lw $t3 ($a0) #address of first index
	lh $t3 ($t3)#content of first index
	lw $t4 4($a0)
	lh $t4 ($t4)
	beqz $t3 checkifnext0 #if current index zero, check if there's something in next index
        beq $t3 $t4 end # if equal then move possible 
        
back:        #next index was zero too
	addi $t7 $t7 1 #increase the index to check if buffer is done
	addi $a0 $a0 4
	bne $t7 $a1 loop #check if buffer size reached
	j notfound
checkifnext0:
	beqz $t4 back
end:
	li $v0 1
notfound:
	jr $ra
