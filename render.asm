#===========================================
# Group 4 - Billy Run player code
# File: render.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Rendering functions for game
#===========================================

.data
heapBase: .word 0x10040000 	# base address of heap for the display
groundY: .word 59 			# ground y position (one below billy's feet)
currentFrame: .word 1		#what is the graphic frame we're on

dirt: 		.word 0x57463B
screenGray: .word 0x00C0C0C0

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
#===========================================
# Function drawBilly()
# Purpose: draw player at billyX, billyY
# Input: y position, what frame you're on
#===========================================
drawBilly:	
	lw $s0, heapBase	#get starting position

	#to get y starting position, we need to have S0 start at offset 512(length of screen)*Yposition
	lw $t4, billyY
	li $t5, SCREEN_WIDTH
	
	mul $t7, $t4, $t5	#t7 = yPos * 128

	lw $t4, billyX
	add $s1, $t4, $t7	#make the starting address lower so billy is on the ground (not at 0,0)
						#s1 is now = yPos*128 + xPos
	li $t4, 4
	mul $t4, $s1, $t4   # 4 * $s1; 4 is the byte offset

	add $s0, $s0, $t4	# s0 = base + 4(yPos*128 + xPos)

	move $a3, $s0		#save the value of starting pos in a3

	li $t4, SKY			#load light blue color

	#load what frame we're on (input) from currentFrame
	lw $t9, currentFrame	

	beq $t9, 1, frame1
	beq $t9, 2, frame1
	beq $t9, 3, frame1
	beq $t9, 4, frame2	
	beq $t9, 5, frame2	
	beq $t9, 6, frame2	
	beq $t9, 7, frame3
	beq $t9, 8, frame3
	beq $t9, 9, frame3
	beq $t9, 10, frame4
	beq $t9, 11, frame4
	beq $t9, 12, frame4

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
		bne $t9, 12 drawFrameFour
		li $t9, 0
drawFrameFour:
		li $t1, 0
		b frameCHGLoop
	
	li $t1, 0	#i think we can delete this
frameCHGLoop:
	li $t2, 0	#reset counter for the current line
	loopColor:
		#now fill the line we just erased with the next frame
		lw $t5, 0($s1)	#read the value at index in billy's frame

		#depending on the ID found at the current index, a different color will be assigned 
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
		
	#li $v0, 32
	#li $a0, FRAME_DELAY	#1000milis/4sec = 250 milis (b/c animation is 4 fps)
	#syscall
	
	move $s0, $a3		#reset for printing
	
returnDrawBilly:
	#go back to main
	addi $t9, $t9, 1	# add for the next frame
	sw $t9, currentFrame

	jr $ra	#jump back to register from whence you came


#(these are kind of like if statements)
brown:
	la COLOR, OUTLINE
	sw COLOR, 0($s0)	#outline

	j colorNext
	
liBrown:
	la COLOR, FUR
	sw COLOR, 0($s0)
	
	j colorNext
drBrown:
	la COLOR, SHADOW
	sw COLOR, 0($s0)
	
	j colorNext
black:
	la COLOR, HAIR
	sw COLOR, 0($s0)
	
	j colorNext
	
transpPixel:
	j colorNext

#   jr $ra
#	la $s1, billyF1

#	j drawBillyFrames

#	lw $ra, 0($sp)
#   addi $sp, $sp, 4
#   jr $ra				

#===========================================
# Function eraseBilly()
# Purpose: draw screenColor pixel at billyX, billyY
#===========================================
eraseBilly:
	lw $s0, heapBase	#get starting position

	lw $t4, billyY
	li $t5, SCREEN_WIDTH
	
	mul $t7, $t4, $t5	#t7 = yPos * 128

	lw $t4, billyX
	add $s1, $t4, $t7	#make the starting address lower so billy is on the ground (not at 0,0)
						#s1 is now = yPos*128 + xPos
	li $t4, 4
	mul $t4, $s1, $t4   # 4 * $s1; 4 is the byte offset

	add $s0, $s0, $t4	# s0 = base + 4(yPos*128 + xPos)

	li $t4, SKY			#load light blue color

	li $t1, 0
eraseFrame:
	li $t2, 0
	innerFrameCHG:
		#erase billy by filling the memory with sky color
		sw $t4, 0($s0)	#SKY
		
		addi $t2, $t2, 1
		addi $s0, $s0, 4		
		blt $t2, 15, innerFrameCHG	#go through row
			
		addi $t1, $t1, 1
		addi $s0, $s0, 452
		blt $t1, 13, eraseFrame

		addi $s0, $s0, -60	#back to beginning of row

	jr $ra

#===========================================
# Function: drawGround
# Purpose: draw a line depicting the ground
#===========================================
drawGround:
	# allocate space in stack pointer to store return address
	# this will allow us to return to the location where this function was called
	addi $sp, $sp, -8
	sw $ra, 4($sp)	#save ra on stack so its not overwritten
	
	#initilize counter and limit
	li $t5, 0
	li $t6, SCREEN_WIDTH 	#load x_max value (512/4 = 128)
	li $t7, GROUND_Y1		#Where to draw the ground (59)
	
loopDraw:
	# if ( x_i >= x_max) -> j returnDrawGround
	bge $t5, $t6, returnDrawGround
	
	move $a0, $t5 	# copy x_i to arg register 1
	move $a1, $t7 	# load y_ground to arg register 2
	lw $a2, dirt 	# load color value to arg register 3
	
	jal drawPixel 	#drawPixel(x_i, y_ground, while)
	
	addi $t5, $t5, 1 # x_i++
	
	j loopDraw

returnDrawGround:
	# retrieve the stashed return address from stack pointer and return
	lw $ra, 4($sp)
	addiu $sp, $sp, 8
	jr $ra

#===========================================
# Function: initScreen()
# Purpose: allocate screen buffer in heap
# Input: none
#===========================================
initScreen:
	addi $sp, $sp, -8
	sw $ra, 0($sp)		#i think this saves and updates the return address (so it comes back to main)
	
	# Reserved 512x256pixels in heap space
	li $v0, 9
	li $a0, 524288
	syscall

	sw $v0, heapBase	#v0 = The starting address defined in heapBase

	lw $ra, 0($sp)
	addi $sp, $sp, 8
	
	jr $ra
#===========================================
# Function: fillScreen(color)
# Purpose: fill screen with color
# Input: $a2=color
#MARGO CHANGE: input will be the eqv value of 'SKY'
#===========================================	
fillScreen:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0				# initial y value
	li $t1, GROUND_Y1 		# where the ground tarts (fill in sky till the ground line)
	
screenDrawLoop:
	
	# if (y_i >= y_max) return function
	bge $t0, $t1, returnDrawInitScrn	#once it goes past y max, return
										#why not jst start at base address and iterate till stop?
										#This is more dynamic (logic can be reused for other draw features)
	
	li $t2, 0				# initial x value
	li $t3, SCREEN_WIDTH 	# max x value (128)
	
	screenDrawInnerLoop:
		# if (x_i >= X_max) end inner loop (if initial x is greater or equal to the max, end loop)
		bge $t2, $t3, endScrnDrawInLoop
	
		move $a0, $t2 		# load x_i into arg0 of drawPixel()
		move $a1, $t0		# load y_in to arg1 of drawPixel()
		li $a2, SKY
		#move $a2, $a2		# load color vaue arg2 of drawPixel()
	
		jal drawPixel		# draw pixel at (x_i, y_i)

		addi $t2, $t2, 1 	#increment x_i++
	
		j screenDrawInnerLoop	
	
endScrnDrawInLoop:

	addi $t0, $t0, 1 	# increment y_i++
	j screenDrawLoop

returnDrawInitScrn:
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
#===========================================
# Function:drawPixel(x, y, color)
# Purpose: draw pixel at (x, y) with color
# Inputs: $a0=x, $a1=y, $a2=color
#===========================================
drawPixel:
    	# Calculate address for pixel using formula:
    	# Address = Base + bytes * (y * width + x)
    	#         = frameBuffer + 4 * (y * width + x)

    	# set $t0 to point to screen width
    	li $s0, SCREEN_WIDTH

    	# Calculate y * width
    	mul $s1, $a1, $s0

    	# Add x to it
    	add $s1, $s1, $a0

    	# Convert pixel index to byte offset; 4 bytes per pixel
   		li $s0, 4
    	mul $s1, $s1, $s0

    	# Get heap base address
    	lw $s2, heapBase	#s2 = base address

    	# Add the calculated offset to framebuffer base address
    	add $s2, $s2, $s1

    	# Write pixel color in the calculated address
    	sw $a2, 0($s2)

    	jr $ra

#===========================================
# Function:draw Billy graphic frame by frame
# Purpose: 
# Inputs: 
#===========================================

calculateAddress:
		addi $sp, $sp, -4
		sw $ra, 0($sp)

	    # set $t0 to point to screen width
    	li $s0, SCREEN_WIDTH

    	# Calculate y * width
    	mul $s1, $a1, $s0

    	# Add x to it
    	add $s1, $s1, $a0

    	# Convert pixel index to byte offset; 4 bytes per pixel
   		li $s0, 4
    	mul $s1, $s1, $s0

    	# Get heap base address
    	lw $s2, heapBase	#s2 = base address

    	# Add the calculated offset to framebuffer base address
    	add $s2, $s2, $s1

		move $v0, $s2

		lw $ra 0($sp)
		addi $sp, $sp, 4

		jr $ra


	
