# Group 4 - Billy Run player code
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

	#move the obstacle
	jal moveObstacle

	#check collision first
	jal checkCollision

	#when collision happened, game over
	bne $v0, $zero, gameOver

	# draw billy
	jal drawBilly

	#Check if the player wants to quit
    li $t0, 0
    lw $t1, continue
    beq $t0, $t1, quitGame

	# delay between frames 
	li $v0, 32
	li $a0, 50
	syscall
	
	j gameLoop

exit:
	li $v0, 10
	syscall

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

