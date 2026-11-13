.eqv SCORE_DIGITS           5       # number of digits shown (leading zeros)
.eqv SCORE_X                42      # x of left-most digit
.eqv SCORE_Y                1       # y of top row of digits
.eqv SCORE_DIGIT_W          3       # glyph width in pixels
.eqv SCORE_DIGIT_H          5       # glyph height in pixels
                                    # digit stride = 4 px (3 wide + 1 gap)
.eqv SCORE_AREA_W           20      # SCORE_DIGITS * 4

.data
score:             .word 0
highScore:         .word 0
scoreMultiplier:   .word 1
scoreFrameCounter: .word 0
scoreDirty:        .word 1          # 1 = score changed, needs redraw

scoreColor:        .word 0x00ff69b4 # pink digits
scoreBgColor:      .word 0x00000000 # black background
finalScoreMsg: .asciiz "Final score: "
highScoreMsg:  .asciiz "High score:  "
scoreNewline:  .asciiz "\n"

.text
initScore:
	sw $zero, score
	sw $zero, scoreFrameCounter

	li $t0, 1
	sw $t0, scoreMultiplier
	sw $t0, scoreDirty          # force first draw

	jr $ra

  updateScore:
	addi $sp, $sp, -8
	sw $ra, 4($sp)

	lw $t0, scoreFrameCounter
	addi $t0, $t0, 1

	li $t1, SCORE_FRAME_INTERVAL
	blt $t0, $t1, updateScoreSaveCounter

	sw $zero, scoreFrameCounter

	lw $t2, scoreMultiplier
	li $t3, SCORE_POINTS_PER_TICK
	mul $a0, $t2, $t3
	jal addScore
	j updateScoreExit

updateScoreSaveCounter:
	sw $t0, scoreFrameCounter
updateScoreExit:
	lw $ra, 4($sp)
	addi $sp, $sp, 8
	jr $ra
