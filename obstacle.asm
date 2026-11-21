#Group 4 - run Billy run
#Contributors-Lim Lee
#Last motified-11/13/2026
#purpose:
# Multiple obstacles for MARS Bitmap Display
# One logical pixel per obstacle; maximum five simultaneous obstacles.
.data
obstacleX:      .word -1, -1, -1, -1, -1
obstacleColor:  .word 0x00FF0000
spawnTimer:     .word 0
moveTimer:      .word 0

.text
# Initialize random generator and slots.
initObstacle:
    la $t4, obstacleX
    li $t5, 5
    li $t6, -1
initObstacleLoop:
    sw $t6, 0($t4)
    addiu $t4, $t4, 4
    addiu $t5, $t5, -1
    bgtz $t5, initObstacleLoop
    sw $zero, moveTimer

    li $v0, 30                 # system time, low 32 bits in $a0
    syscall
    move $a1, $a0             # seed
    li $a0, 1                 # random stream ID
    li $v0, 40
    syscall
    j randomSpawnTime         # tail call, keeps caller's $ra

# Random wait of 20..60 frames (approximately 1..3 seconds).
randomSpawnTime:
    li $v0, 42
    li $a0, 1                 # same random stream
    li $a1, 41                # returns 0..40 in $a0
    syscall
    addiu $t3, $a0, 20
    sw $t3, spawnTimer
    jr $ra

# Call exactly once per 50ms game frame.
updateObstacle:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)

    lw $t3, spawnTimer
    addiu $t3, $t3, -1
    sw $t3, spawnTimer
    bgtz $t3, obstacleMovementTimer
    jal spawnObstacle
    jal randomSpawnTime       # independent of existing obstacles

obstacleMovementTimer:
    lw $t3, moveTimer
    addiu $t3, $t3, 1
    sw $t3, moveTimer
    slti $t7, $t3, 2
    bnez $t7, obstacleUpdateDone
    sw $zero, moveTimer

    jal eraseObstacles
    la $t4, obstacleX
    li $t5, 5
obstacleMoveLoop:
    lw $t6, 0($t4)
    bltz $t6, obstacleMoveNext
    addiu $t6, $t6, -1
    sw $t6, 0($t4)            # -1 marks reusable slot
obstacleMoveNext:
    addiu $t4, $t4, 4
    addiu $t5, $t5, -1
    bgtz $t5, obstacleMoveLoop
    jal drawObstacles

obstacleUpdateDone:
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

# Fill first free slot; if full, skip this spawn attempt.
spawnObstacle:
    la $t4, obstacleX
    li $t5, 5
obstacleFindSlot:
    lw $t6, 0($t4)
    bltz $t6, obstacleSlotFound
    addiu $t4, $t4, 4
    addiu $t5, $t5, -1
    bgtz $t5, obstacleFindSlot
    jr $ra
obstacleSlotFound:
    li $t6, 63
    sw $t6, 0($t4)
    jr $ra

# Repaint active obstacles black (prior positions).
eraseObstacles:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    la $t4, obstacleX
    li $t5, 5
obstacleEraseLoop:
    lw $t6, 0($t4)
    bltz $t6, obstacleEraseNext
    move $a0, $t6
    li $a1, 26
    lw $a2, black
    jal drawPixel
obstacleEraseNext:
    addiu $t4, $t4, 4
    addiu $t5, $t5, -1
    bgtz $t5, obstacleEraseLoop
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra

# Paint all active obstacles red.
drawObstacles:
    addiu $sp, $sp, -4
    sw $ra, 0($sp)
    la $t4, obstacleX
    li $t5, 5
obstacleDrawLoop:
    lw $t6, 0($t4)
    bltz $t6, obstacleDrawNext
    move $a0, $t6
    li $a1, 26
    lw $a2, obstacleColor
    jal drawPixel
obstacleDrawNext:
    addiu $t4, $t4, 4
    addiu $t5, $t5, -1
    bgtz $t5, obstacleDrawLoop
    lw $ra, 0($sp)
    addiu $sp, $sp, 4
    jr $ra
