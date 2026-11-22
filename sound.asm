#===========================================
# Group 4 - Billy Run player code
# Group Members: Gudimella Lahari, Lim Lee, Muy Kheng Ly, Jose Salas, Margaret Oh
# File: sound.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Sound functions for game
#===========================================

.eqv duration 	 30
.eqv instrument1 81
.eqv volume 	100

.data 
pitch1: 	.word 90
pitch1end:	.word 50


.text


#=================================
# Function: playNote()
# Plays a note with given pitch and duration

#=================================

playNote1:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	lw $s3, pitch1
	lw $s4, pitch1end
sound_loop:

	li $v0, 31
	move $a0, $s3
	li $a1, duration
	li $a2, instrument1
	li $a3, volume
	syscall
	
	li $v0, 32
	li $a0, 20
	syscall
	
	addi $s3, $s3, -4
	bgt $s3, $s4, sound_loop
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
