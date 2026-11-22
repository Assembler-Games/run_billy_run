#===========================================
# Group 4 - Billy Run player code
# File: render.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Rendering functions for game
#===========================================


.data

# Colors in hex = 0x00RRGGBB
green: 		.word 0x0000FF00
black: 		.word 0x00000000
white: 		.word 0x00FFFFFF
screenGray: .word 0x00C0C0C0


groundY: .word 59 # ground y position

heapBase: .word 0x10040000 # base address of heap for the display

.text

#===========================================
# Function drawBilly()
# Purpose: draw player at billyX, billyY in green
#===========================================

drawBilly:
    	lw $a0, billyX
    	lw $a1, billyY
    	lw $a2, green

    	j drawPixel

#===========================================
# Function eraseBilly()
# Purpose: draw screenColor pixel at billyX, billyY
#===========================================
eraseBilly:
    	lw $a0, billyX
    	lw $a1, billyY
    	lw $a2, screenGray

    	j drawPixel

#===========================================
# Function: drawGround
# Purpose: draw a line depicting the ground
#===========================================
drawGround:
	
	# allocate space in stack pointer to store return address
	# this will allow us to return to the location where this function was called
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	
	#initilize counter and limit
	li $t5, 0
	li $t6, SCREEN_WIDTH #load x_max value
	li $t7, GROUND_Y1
	
loopDraw:
		
	bge $t5, $t6, returnDrawGround # if ( x_i >= x_max) -> j returnDrawGround
	
	move $a0, $t5 # copy x_i to arg register 1
	move $a1, $t7 # load y_ground to arg register 2
	lw $a2, white # load color value to arg register 3
	
	jal drawPixel # drawPixel(x_i, y_ground, while)
	
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
	sw $ra, 8($sp)
	
	# Reserved 512x256pixels in heap space
	li $v0, 9
	li $a0, 524288
	syscall
	
	sw $v0, heapBase

	lw $ra, 8($sp)
	addi $sp, $sp, 8
	
	jr $ra
#===========================================
# Function: fillScreen(color)
# Purpose: fill screen with color
# Input: $a2=color
#===========================================	
fillScreen:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0		# init y_i
	li $t1, SCREEN_HEIGHT 	# max y value
	
screenDrawLoop:
	
	# if (y_i >= y_max) return function
	bge $t0, $t1, returnDrawInitScrn
	
	li $t2, 0		# init x_i
	li $t3, SCREEN_WIDTH 	# max x value

screenDrawInnerLoop:
	
	# if (x_i >= X_max) end inner loop
	bge $t2, $t3, endScrnDrawInLoop
	
	move $a0, $t2 		# load x_i into arg0 of drawPixel()
	move $a1, $t0		# load y_in to arg1 of drawPixel()
	move $a2, $a2		# load color vaue arg2 of drawPixel()
	
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
    	lw $s2, heapBase

    	# Add the calculated offset to framebuffer base address
    	add $s2, $s2, $s1

    	# Write pixel color in the calculated address
    	sw $a2, 0($s2)

    	jr $ra
