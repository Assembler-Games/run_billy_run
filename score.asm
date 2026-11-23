#Group 4 - Billy Run score code
#File: score.asm
#Contributors: Muy Kheng Ly
#Last Modified: 11/13/2026
#Purpose: 	Calculate, store and display the score
#		  	Billy passes obstacle without collision → +1 point
#			Billy collides with obstacle → game over

.eqv SCORE_MAX 99999
.eqv FRAMES_PER_POINT 10   #0.5s per point at 50 ms/frame
.eqv JUMP_BONUS 5

.data
score:     .word 0
highScore: .word 0
frameCount: .word 0
wasJumping: .word 0

finalScoreMsg: .asciiz "\nGame Over!\nFinal score: "
highScoreMsg:  .asciiz "\nHigh score: "
restartMsg:   .asciiz "\nEnter 1 to restart or 0 to quit: "
invalidMsg:   .asciiz "\nInvalid input. Enter 1 or 0: "
goodbyeMsg:   .asciiz "\nThanks for playing!\n"
newline:      .asciiz "\n"

.text

.globl initScore
.globl addScore
.globl obstaclePassed
.globl printFinalScore
.globl askRestart

#Resets the current score for a new game.
#The high score is preserved.
initScore:
    sw $zero, score
    sw $zero, frameCount
    sw $zero, wasJumping
    jr $ra

#Adds points to the current score.
addScore:
    lw $t0, score
    add $t0, $t0, $a0

    #Do not allow score below 0
    bgez $t0, checkScoreMaximum
    li $t0, 0

checkScoreMaximum:
    #Do not allow score above SCORE_MAX
    li $t1, SCORE_MAX
    ble $t0, $t1, storeScore
    move $t0, $t1

storeScore:
    sw $t0, score

    #Update high score if current score is greater
    lw $t2, highScore
    ble $t0, $t2, addScoreDone

    sw $t0, highScore

addScoreDone:
    jr $ra

#Add 1 point when Billy passes an obstacle.
#Call this function only once for each obstacle.

obstaclePassed:
    li $a0, 1
    jal addScore
    jr $ra

.globl updateScore

updateScore:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)

    # 1 point every FRAMES_PER_POINT frames survived
    lw $t0, frameCount
    addiu $t0, $t0, 1
    li $t1, FRAMES_PER_POINT
    blt $t0, $t1, storeFrames
    sw $zero, frameCount
    li $a0, 1
    jal addScore
    j checkLanding
storeFrames:
    sw $t0, frameCount

checkLanding:
    # Bonus when a jump finishes (was jumping, now on the ground)
    lw $t0, isBillyJumping
    lw $t1, wasJumping
    sw $t0, wasJumping
    beqz $t1, updateScoreDone    # wasn't jumping last frame
    bnez $t0, updateScoreDone    # still in the air
    li $a0, JUMP_BONUS
    jal addScore

updateScoreDone:
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

#Prints the final score and high score.
printFinalScore:
    # Print "Game Over"
    li $v0, 4
    la $a0, finalScoreMsg
    syscall

    # Print current score
    li $v0, 1
    lw $a0, score
    syscall

    # Print high score message
    li $v0, 4
    la $a0, highScoreMsg
    syscall

    # Print high score
    li $v0, 1
    lw $a0, highScore
    syscall

    # Print newline
    li $v0, 4
    la $a0, newline
    syscall

    jr $ra

#Asks the player if they to restart or quit.
#$v0 = 1 if player chooses restart
#$v0 = 0 if player chooses quit

askRestart:

askAgain:
    li $v0, 4
    la $a0, restartMsg
    syscall

    #Read player input
    li $v0, 5
    syscall

    #If input is 1, restart
    li $t0, 1
    beq $v0, $t0, chooseRestart

    #If input is 0, quit
    beq $v0, $zero, chooseQuit

    #Otherwise, input is invalid
    li $v0, 4
    la $a0, invalidMsg
    syscall

    j askAgain

chooseRestart:
    li $v0, 1
    jr $ra

chooseQuit:
    li $v0, 0
    jr $ra

quitSelected:
    li $v0, 0
    jr $ra
