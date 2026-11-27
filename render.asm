#===========================================
# Group 4 - Billy Run player code
# File: render.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Rendering functions for game
#===========================================

.data
heapBase: .word 0x10040000 # base address of heap for the display
groundY: .word 59 # ground y position (one below billy's feet)

# Colors in hex = 0x00RRGGBB
green: 		.word 0x0000FF00
black: 		.word 0x00000000
white: 		.word 0x00FFFFFF
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
# Purpose: draw player at billyX, billyY in green
#===========================================
drawBilly:
    lw $a0, billyX
    lw $a1, billyY
    lw $a2, black

    j drawPixel
#TODO: 
#1. load in the buffer before billy is printed
#2. jump to teh animation method

#	addi $sp, $sp, -4
#   sw $ra, 0($sp)

#	lw $s0, heapBase
	#to get y starting position, we need to have S0 start at offset 512(length of screen)*Yposition
#	lw $t4, billyY
#	li $t5, 512
#	mul $t7, $t4, $t5	#t7 = yPos*512
#	add $s0, $s0, $t7	#make the starting address lower so billy is on the ground
						#s0 is now = yPos*512
	
#	lw $t4, billyX
#	add $s0, $s0, $t4	
#	move $a3, $s0		#save the value of starting pos in a3

#	la $s1, billyF1

#	j drawBillyFrames

#	lw $ra, 0($sp)
#   addi $sp, $sp, 4
#   jr $ra				#jump back to register from whence you came

#===========================================
# Function eraseBilly()
# Purpose: draw screenColor pixel at billyX, billyY
#===========================================
eraseBilly:
    	lw $a0, billyX
    	lw $a1, billyY
		li $a2, SKY
    	#lw $a2, screenGray

    	j drawPixel

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
	lw $a2, white 	# load color value to arg register 3
	
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
	sw $ra, 8($sp)		#i think this saves and updates the return address (so it comes back to main)
	
	# Reserved 512x256pixels in heap space
	li $v0, 9
	li $a0, 524288
	syscall

	sw $v0, heapBase	#v0 = The starting address defined in heapBase

	lw $ra, 8($sp)
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
	li $t1, SCREEN_HEIGHT 	# max y value (64)
	
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
drawBillyFrames:
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
	la $s1, billyF2 	#!!!! load frame 2
	
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
#black:
#	la COLOR, HAIR
#	sw COLOR, 0($s0)
	
#	jr $t8
	
transpPixel:
	jr $t8

	
