.data
	.globl printboard
	Row : .asciiz "-----------------------------\n"
	Emptyrow: .asciiz "|      |      |      |      |\n"
	Front: .asciiz "|"
	Back: .asciiz " |"
	Space1: .asciiz " "
	Newline: "\n"
#
#a0 Address of the first field of the board
#
#	-----------------------------
#	|      |      |      |      |
#	| 2048 |  128 |    8 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	| 1024 |   64 |    4 |    8 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  512 |   32 |  512 |  128 |
#	|      |      |      |      |
#	-----------------------------
#	|      |      |      |      |
#	|  256 |   16 | 2048 | 1024 |
#	|      |      |      |      |
#	-----------------------------
#
.text
printboard:
#Reference
#t0 has address of the first field
#t1 has rowline
#t2 has empty rowline
#t3 has newline
#t4 has space1
#t5 has Front
#t6 has Back
#t9 checks if end of row
#s2 has 4 stored
#s1 points if all rows covered
#t7 stores current value at the index
#t8 is used to compare
#s3 just
	move $t0 $a0 
	addiu $sp $sp -16
	sw $ra 0($sp)
	la $t1 Row
	la $t2 Emptyrow
	la $t3 Newline
	la $t4 Space1
	la $t5 Front
	la $t6 Back

	jal printonerow
	sw $s1 4($sp)
	sw $s2 8($sp)
	sw $s2 12($sp)
	li $s2 4
	li $t9 0
	li $s1 0
looprow:
	
	jal printsecond
	move $a0 $t5 #printing '|' at the beginning
	syscall
	li $t9 0
	jal printrow
	move $a0 $t3 #printing a new line
	syscall
	jal printsecond
	jal printonerow
	addi $s1 $s1 1 
	bne $s1 $s2 looprow #checking if all the rows are done

end:
	lw $ra 0($sp)
	lw $s1 4($sp)
	lw $s2 8($sp)
	lw $s3 16($sp)
	addi $sp $sp 16
    	jr $ra
  	li $v0 10
	syscall	
printrow:
	li $t8 999
	lh $t7 ($t0)
one_space:
	move $a0 $t4 #printing first space
	syscall
	bge $t8 $t7 two_space #checking if number greater than 999
	j print_number
two_space:
	syscall #printing second space
	li $t8 99
	bge $t8 $t7 three_space #checking if number greater than 99
	j print_number
three_space:
	syscall
	li $t8 9
	bge $t8 $t7 four_space #checking if number greater than 9
	j print_number
four_space:
	syscall
print_number:
	li $v0 1
	move $a0 $t7
	syscall
	li $v0 4	
numberprinted:
	move $a0 $t6 #printing " |" at the end
	syscall
	addi $t9 $t9 1 
	addi $t0 $t0 2 #points to next number in array
	bne $t9 $s2 printrow #checking if all numbers of row are done	
	jr $ra	
printonerow:
	li $v0 4
	move $a0 $t1
	syscall
	jr $ra
printsecond:
	li $v0 4
	move $a0 $t2
	syscall
	jr $ra
	

