# Group 4 - Billy Run player code
# File: macros.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: 


.macro printString(%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro