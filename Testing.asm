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
billyX: .word 20	#Billy's X value MUST be a multiple of 4
billyY: .word 41	#rooted at top left corner

#colors
.eqv COLOR $t7
.eqv SKY 0x90D5FF

.eqv OUTLINE 0x6A462E
.eqv FUR 0x736249
.eqv SHADOW 0x3C2C25
.eqv HAIR 0x000000

#Draw the frames by creating a matrix which stores the ID of colors
# 0 --> transparent (skip pixel)
# 1 --> outline 	brown
# 2 --> fur		light brown
# 3 --> leg shadows	dark brown
# 4 --> mane/tail/eye	black
billyF1:	#15 x 13
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 4, 4, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 2, 2, 1, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 4, 4, 2, 2, 4, 2, 1
	.word 0, 0, 4, 4, 4, 0, 1, 1, 1, 1, 2, 2, 2, 2, 1
	.word 0, 4, 4, 4, 4, 1, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 4, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 0, 0, 0, 0, 1, 2, 2, 1, 1, 1, 2, 2, 3, 3, 0
	.word 0, 0, 0, 0, 1, 2, 2, 3, 0, 0, 1, 1, 1, 3, 0
	.word 0, 0, 0, 0, 1, 1, 0, 3, 0, 0, 3, 3, 1, 0, 0
	.word 0, 0, 0, 0, 0, 1, 1, 0, 3, 0, 0, 0, 1, 1, 0
	.word 0, 0, 0, 0, 0, 0, 1, 0, 3, 0, 0, 0, 0, 1, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 1

billyF2:	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 4, 4, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 2, 2, 1, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 4, 4, 2, 2, 4, 2, 1, 0
	.word 0, 4, 4, 4, 0, 1, 1, 1, 1, 2, 2, 2, 2, 1, 0
	.word 4, 4, 4, 0, 1, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0
	.word 4, 0, 0, 0, 1, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0
	.word 0, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 3, 0, 0, 0
	.word 0, 0, 0, 0, 1, 2, 2, 1, 1, 1, 1, 3, 0, 0, 0
	.word 0, 0, 0, 0, 3, 1, 2, 1, 0, 0, 1, 3, 3, 0, 0
	.word 0, 0, 0, 3, 3, 3, 1, 1, 0, 0, 1, 0, 3, 0, 0
	.word 0, 0, 0, 3, 0, 0, 0, 1, 1, 0, 1, 0, 0, 3, 0
	.word 0, 0, 0, 0, 3, 0, 0, 0, 0, 1, 0, 1, 0, 0, 3
	
billyF3:	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 4, 4, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 2, 2, 1, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 4, 4, 2, 2, 4, 2, 1, 0
	.word 4, 4, 4, 0, 0, 1, 1, 1, 1, 2, 2, 2, 2, 1, 0
	.word 4, 4, 0, 1, 1, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0
	.word 4, 0, 0, 1, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0, 0
	.word 0, 0, 0, 1, 2, 2, 2, 1, 1, 2, 3, 0, 0, 0, 0
	.word 0, 0, 0, 1, 2, 2, 1, 1, 0, 1, 1, 3, 0, 0, 0
	.word 0, 0, 3, 3, 1, 2, 1, 0, 0, 0, 1, 3, 0, 0, 0
	.word 0, 0, 3, 0, 3, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0
	.word 0, 3, 3, 0, 0, 1, 1, 0, 0, 0, 3, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 3, 0, 0, 0
	
billyF4:	
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 4, 4, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 4, 1, 2, 2, 1, 0
	.word 0, 4, 4, 4, 0, 0, 0, 0, 4, 4, 2, 2, 4, 2, 1
	.word 4, 4, 4, 4, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 1
	.word 4, 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 1, 0, 0, 0
	.word 0, 0, 0, 1, 2, 2, 2, 2, 1, 1, 1, 1, 1, 0, 0
	.word 0, 0, 0, 1, 2, 2, 1, 1, 0, 3, 3, 1, 1, 0, 0
	.word 0, 0, 1, 1, 1, 1, 3, 3, 0, 1, 1, 1, 0, 0, 0
	.word 0, 1, 1, 0, 0, 3, 3, 0, 0, 0, 3, 0, 0, 0, 0
	.word 1, 1, 0, 0, 0, 0, 3, 3, 0, 3, 3, 0, 0, 0, 0
	.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

	
.text
.globl main	#gloably accessable
main:
	lw $a1, billyX
	lw $a2, billyY
##DRAW BACKGROUND##
	la $s0, display		#this will load the starting address of the reserved space (display) into s0
				##s0 = base address##
	la $s1, billyF1		#store start address of our array in s1???		
	li $t4, SKY		#load light blue color
	li $t3, 6912		#COUNTER. 128x54 (size of the canvas when using 4 by 4 units. )
bgLoop:
	sw $t4, 0($s0)		
	
	#increment
	addi $s0, $s0, 4	#move to next pixel in display
	addi $t3, $t3, -1	#decrement number of pixels
	bnez $t3, bgLoop	#repeat while number of pixels is not 0
	
	la $s0, display		#after the background is printed, the address is past the frame. Reset address to beginning	

#################################
#  DRAW THE BILLY BRONCO IMAGE  #
#	    (4 fps)		 #
#################################	
	#to get y starting position, we need to have S0 start at offset 512(length of screen)*Yposition
	li $t5, 512
	mul $t7, $a2, $t5	#t7 = yPos*512
	add $s0, $s0, $t7	#make the starting address lower so billy is on the ground
				#s0 is now = yPos*512
	add $s0, $s0, $a1	
	move $a3, $s0		#save the value of starting pos in a3

##dont actually need this next commented out bit
#	la $t8, nextIndex
#	li $t9, 1	#counter for which frame we're on
#outer loop moves through the rows, inner loop moves through cols
#	li $t1, 0	#counter for outer loop
drawLoop:
#	li $t2, 0	#counter for inner loop
#	innerDrawLoop:
#		lw $t5, 0($s1)
		
#		beq $t5, 0, transpPixel
#		beq $t5, 1, brown
#		beq $t5, 2, liBrown
#		beq $t5, 3, drBrown
#		beq $t5, 4, black
#		#blt $t2, 21, innerLoop
	
#	nextIndex:
#		#increment
#		addi $t2, $t2, 1
#		addi $s0, $s0, 4
#		addi $s1, $s1, 4
#		blt $t2, 15, innerDrawLoop	#loop till reaching end of array row
	
#		addi $s0, $s0, 452	#update offset
#		addi $t1, $t1, 1	
#		blt $t1, 13, drawLoop
#		end of loop
#		addi $t9, $t9, 1	# add for the next frame
#		la $s0, display		#reset display 
	
#TODO: 
# 1. set a sleep function so that program pauses on F1
# 2. erase billy by filling the memory with sky color
# 3. reset address to starting postion (remember to account for x and y)
# 4. change the s1 to read from frame 2 (la $s1, billyF2)
	#set a sleep function so frame holds
#	li $v0, 32
#	la $a0, 1000	#1000milis/4sec = 250 milis (b/c animation is 4 fps)
#	syscall


	move $s0, $a3		#reset for erasing
	la $s1, billyF1 	#!!!! load frame 2
	
	li $t1, 0
frameCHGLoop:
	li $t2, 0
	innerFrameCHG:
		sw $t4, 0($s0)	#SKY
		
		addi $t2, $t2, 1
		addi $s0, $s0, 4		
		blt $t2, 15, innerFrameCHG	#go through row
		
	##!!!!move $s0, $a3		
	addi $s0, $s0, -60	#back to beginning of row
	li $t2, 0
	la $t8, colorNext
	loopColor:
		lw $t5, 0($s1)		
		beq $t5, 0, transpPixel
		beq $t5, 1, brown
		beq $t5, 2, liBrown
		beq $t5, 3, drBrown
		beq $t5, 4, black
		
		colorNext:
		#increment
		addi $t2, $t2, 1
		addi $s0, $s0, 4
		addi $s1, $s1, 4	#increment the frame
		blt $t2, 15, loopColor	#loop till reaching end of array row
		
		addi $t1, $t1, 1
		addi $s0, $s0, 452
		blt $t1, 13, frameCHGLoop
		
		addi $t9, $t9, 1	# add for the next frame
	li $v0, 32
	la $a0, 250	#1000milis/4sec = 250 milis (b/c animation is 4 fps)
	syscall
	
	move $s0, $a3		#reset for printing
	beq $t9, 1, frame1
	beq $t9, 2, frame2	
	beq $t9, 3, frame3
	beq $t9, 4, frame4
	
frame1:
	la $s1, billyF1
	li $t1, 0
	b frameCHGLoop	
frame2:
	la $s1, billyF2
	li $t1, 0
	b frameCHGLoop
frame3:
	la $s1, billyF3
	li $t1, 0
	b frameCHGLoop
frame4:
	la $s1, billyF4
	
	#reset counters outside of drawLoop
	li $t9, 0
	li $t1, 0
	b frameCHGLoop


#depending on the ID found at the current index, 
#a different color will be assigned (these are kind of like if statements)
brown:
	bge $t1, 13, exit	#after loop is done, it drops off into the colors and keeps printing brown. 
				#exit oncec all rows are traversed
	la COLOR, OUTLINE
	sw COLOR, 0($s0)	#outline

	jr $t8
	
liBrown:
	la COLOR, FUR
	sw COLOR, 0($s0)
	
	jr $t8
drBrown:
	la COLOR, SHADOW
	sw COLOR, 0($s0)
	
	jr $t8
black:
	la COLOR, HAIR
	sw COLOR, 0($s0)
	
	jr $t8
	
transpPixel:
	jr $t8

	
exit:
	li $v0, 10
	syscall
	



















drawBilly:
#TODO: 
#1. load in the buffer before billy is printed
#2. jump to teh animation method

	addi $sp, $sp, -4	#save return address
    sw $ra, 0($sp)

	lw $s0, heapBase
	#to get y starting position, we need to have S0 start at offset 512(length of screen)*Yposition
	lw $t4, billyY
	li $t5, 512
	mul $t7, $t4, $t5	#t7 = yPos*512
	add $s0, $s0, $t7	#make the starting address lower so billy is on the ground
						#s0 is now = yPos*512
	
	lw $t4, billyX
	add $s0, $s0, $t4	
	move $a3, $s0		#save the value of starting pos in a3
	li $t4, SKY		#load light blue color
#TODO: 
# 1. set a sleep function so that program pauses on F1
# 2. erase billy by filling the memory with sky color
# 3. reset address to starting postion (remember to account for x and y)
# 4. change the s1 to read from frame 2 (la $s1, billyF2)

	#move $s0, $a3		#reset for erasing
	la $s1, billyF1 	#load frame 1
	
	li $t1, 0
frameCHGLoop:
	li $t2, 0
	innerFrameCHG:
		sw $t4, 0($s0)	#SKY
		
		addi $t2, $t2, 1
		addi $s0, $s0, 4		
		blt $t2, 15, innerFrameCHG	#go through row
			
	addi $s0, $s0, -60	#back to beginning of row
	li $t2, 0
	la $t8, colorNext
	loopColor:
		lw $t5, 0($s1)		
		beq $t5, 0, transpPixel	#this isnt being skipped properly
		beq $t5, 1, brown
		beq $t5, 2, liBrown
		beq $t5, 3, drBrown
		beq $t5, 4, black
		
		colorNext:
		#increment
		addi $t2, $t2, 1
		addi $s0, $s0, 4
		addi $s1, $s1, 4	#increment the frame
		blt $t2, 15, loopColor	#loop till reaching end of array row
		
		addi $t1, $t1, 1
		addi $s0, $s0, 452
		blt $t1, 13, frameCHGLoop
		
		addi $t9, $t9, 1	# add for the next frame

	lw $t0, isBillyJumping			#terminate running loop if billy jumping is true (1)
	beq $t0, 1, updateBillyPhysics	#if its true branch
	
	li $v0, 32
	la $a0, 250	#1000milis/4sec = 250 milis (b/c animation is 4 fps)
	syscall
	
	move $s0, $a3		#reset for printing
	beq $t9, 1, frame1
	beq $t9, 2, frame2	
	beq $t9, 3, frame3
	beq $t9, 4, frame4
	
frame1:
	la $s1, billyF1
	li $t1, 0
	b frameCHGLoop	
frame2:
	la $s1, billyF2
	li $t1, 0
	b frameCHGLoop
frame3:
	la $s1, billyF3
	li $t1, 0
	b frameCHGLoop
frame4:
	la $s1, billyF4
	
	#reset counters outside of drawLoop
	li $t9, 0
	li $t1, 0
	b frameCHGLoop


#depending on the ID found at the current index, 
#a different color will be assigned (these are kind of like if statements)
brown:
	#after loop is done, it drops off into the colors and keeps printing brown. 
				#exit oncec all rows are traversed
	la COLOR, OUTLINE
	sw COLOR, 0($s0)	#outline

	jr $t8
	
liBrown:
	la COLOR, FUR
	sw COLOR, 0($s0)
	
	jr $t8
drBrown:
	la COLOR, SHADOW
	sw COLOR, 0($s0)
	
	jr $t8
black:
	la COLOR, HAIR
	sw COLOR, 0($s0)
	
	jr $t8
	
transpPixel:
	jr $t8

   #jr $ra				#jump back to register from whence you came