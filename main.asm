# Group 4 - Billy Run player code
# Group Members: Gudimella Lahari, Lim Lee, Muy Kheng Ly, Jose Salas, Margaret Oh
# File: main.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: 

.include "macros.asm"

.data
continue: .word 1 #variable use to check if continue
exitMsg: .asciiz "Exiting game...Have a great day!\n"

.text

.globl main

main: 
startNewGame:
	#reset score for the new game
	jal initScore

	#Reset the continue variable
    	li $t0, 1
    	sw $t0, continue

	#initialize billy
	jal initBilly
	
	#initialize obstacle timer
	jal initObstacle
	
	# Draw Billy
	jal drawBilly
	
	# Draw Ground
	jal drawGround

gameLoop:
	
	# Erase billy from the bitmap display by drawing black pixel at his position	
	jal eraseBilly
	
	# Check keyboard input for SPACE key
	jal checkKeyboard
	
	#calculate and update billy's position if billy is jumping
	jal updateBillyPhysics

	# update obstacle -> move original obstacle leftwards
	jal updateObstacle
	
	#check collision first
	lw $t2, collision

	bnez $t2, gameOver

	# draw billy
	jal drawBilly
	
	jal addScore
	
	#Check if the player wants to quit

    	lw $t1, continue
    	
    	#when collision happened, game over
	beq $t1, $zero, gameOver
    	
    	# delay between frames
    	li $v0, 32
	li $a0, 50
	syscall
	
	j gameLoop


gameOver:
	#Print the final score after collision
    	jal printFinalScore

	#Ask if the player wants to restart
    	jal askRestart

	#restart the game when $v0==1
	li $t0, 1
	
    	beq $v0, $t0, startNewGame
	#quit the game
	j quitGame

quitGame:
	li $v0, 4
    	la $a0, exitMsg
    	syscall

	li $v0, 10
    	syscall

# This are placed at the bottom because
.include "billy.asm"
.include "keyboard_input.asm"
.include "render.asm"
.include "score.asm"
.include "obstacle.asm"

