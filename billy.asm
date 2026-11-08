# Group 4 - Billy Run player code
# Contributors: Jose Salas
# Last Modified: 11/07/2026
# Purpose: Establish billy's controls. Handles movement, gravity, and collisions with ground

.eqv SCREEN_WIDTH 64
.eqv GROUND_Y 26
.eqv JUMP_VELOCITY -5

.data
#Billy's initial position and velocity
billyX: .word 0
billyY: .word 0
billyYVel: .word 0
gravity: .word 0
isBillyJumping: .word 0 # values will be 0-1 (0 == not jumping, 1 == jumping)

.text

#Function: initBilly()

initBilly:
	# Store initial state in billy's position and gravity variables
	li $t0, 16
	sw $t0, billyX
	
	li $t1, GROUND_Y
	sw $t1, billyY
	
	li $t2, 1
	sw $t2, gravity
	
	# Set billy's velocity and isJumping to zero
	sw $zero, billyYVel
	sw $zero, isBillyJumping
	
	# Return to the caller after initializing
	jr $ra
	

	
#Function: updateBillyPhysics()
#Purpose: Calculate and update billy's y-coord position for each frame
updateBillyPhysics:

	#check if billy is jumping otherwise return
	lw $t0, isBillyJumping
	beq $t0, $zero, billyUpdatePhysComp
	
	# calculate new y value; y = y_old + billyVel + gravity
	
	# add billyVel + gravity
	lw $t1, billyYVel
	lw $t2, gravity
	
	add $t1, $t1, $t2
	
	# add billy's current y value with $t1, where $t1 = billyVel + gravity
	lw $t3, billyY
	
	add $t3, $t3, $t1
	
	# check if billy's collided with the ground or is still airborne
	li $t4, GROUND_Y
	ble $t3, $t4, saveBillyUpPhysics # if (y_new <= GROUND_Y) -> jump to save updated physics
	
	# if (y_new > GROUND_Y ) -> set y_new = GROUND_Y, billyVel = 0, and isBillyJumping = 0
	move $t3, $t4
	move $t1, $zero
	sw $zero, isBillyJumping
saveBillyUpPhysics:
	#store the billyVel
	sw $t1, billyYVel
	sw $t3, billyY
	
billyUpdatePhysComp:
	# return to caller
	jr $ra
