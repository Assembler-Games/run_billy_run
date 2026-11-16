#Margaret Oh
#CS2640 Final Project- Billy Bronco Graphics
#
################################################################
###			BITMAP SETTINGS				###
###								###
###	Unit Width (px): 4					###
###	Unit Width (px): 4					###
###	Display Width (px): 512				###
###	Display Height (px): 256				###
###	Base Address for display 0x10010000 (static data)	###
###								###
################################################################

.data
display: .space 524288	#This reserves 524,288 bytes of space (1px = 4 bytes [32-bit word])
xPosbilly:
yPosbilly:
#Draw the frames by creating a matrix which stores the ID of colors
# 0 --> transparent (skip pixel)
# 1 --> outline 	brown
# 2 --> fur		light brown
# 3 --> leg shadows	dark brown
# 4 --> mane/tail/eye	black
billyF1:
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1, 4, 4, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1, 2, 2, 1, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1, 2, 4, 2, 1, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 1, 2, 2, 2, 2, 2, 1
	.word 0, 0, 0, 0, 4, 0, 0, 0, 1, 1, 1, 1, 1, 1, 2, 2, 2, 1, 2, 2, 1
	.word 0, 0, 0, 4, 4, 4, 4, 0, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 1, 1, 0
	.word 0, 0, 4, 4, 4, 4, 4, 1, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0
	.word 0, 4, 4, 4, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 4, 0, 0, 4, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 1, 2, 2, 2, 1, 1, 1, 1, 1, 2, 2, 1, 3, 0, 0
	.word 0, 0, 0, 0, 0, 0, 1, 2, 2, 1, 3, 3, 0, 0, 0, 1, 1, 1, 3, 0, 0
	.word 0, 0, 0, 0, 0, 0, 1, 2, 1, 3, 3, 3, 0, 0, 0, 0, 1, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 3, 3, 0, 0, 0, 3, 3, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 3, 3, 0, 0, 0, 0, 1, 1, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 3, 3, 0, 0, 0, 0, 0, 1, 1, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 1
	
.text
.globl main	#gloably accessable
main:
##DRAW BACKGROUND##
	la $s0, display		#this will load the starting address of the reserved space (display) into s0
				#s0 = base address		
	li $t3, 7168		#128x64 (size of the canvas when using 4 by 4 units. )
	li $t4, 0x90D5FF	#load light blue color
loop1:
	sw $t4, 0($s0)		
	addi $s0, $s0, 4	#move to next pixel in display
	addi $t3, $t3, -1	#decrement number of pixels
	bnez $t3, loop1		#repeat while number of pixels is not 0
	
	la $s0, display		#after the background is printed, the address is past the frame. Reset address to beginning
	li $t1, 0		#declare counter	
			
#################################
#  DRAW THE BILLY BRONCO IMAGE  #
#################################

	li $t1, 0	#counter for outer loop
outerLoop:
	#move through cols of img array
	li $t2, 0	#counter for inner loop
innerLoop:
	#move through rows of img array
	#access element in array --> index = (row * width) + col
	li $t8, 21
	mul $t5, $t2, $t8	
	add $t6, $t5, $t1	#t6 = index
	li $t8, 4
	mul $t7, $t6, $t8	#offset(every entry takes up 4 bytes [4 by 4 units])
	
	la $s1, billyF1		#load base address of array
	add $t9, $s1, $t7	#add the offset to the load address of array
	lw $s2, 0($t9)		#value at a specific index of array
	
	#depending on the ID found at the current index, a different color will be assigned (these are kind of like if statements)
	beq $t9, 0, transpPixel
	
#TODO: add the colored branches (x4)
transpPixel:
	#increment
	addi $t2, $t2, 1
	blt $t2, 19, innerLoop	#if less than 5, loop again
	
	##Inner loop ends##
	addi $t1, $t1, 1
	blt $t1, 21, outerLoop	

exit:
	li $v0, 10
	syscall

