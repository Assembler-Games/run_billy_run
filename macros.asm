#===========================================
# Group 4 - Billy Run player code
# File: macros.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: Define useful macros 
#===========================================

# Macros for printing strings and integers
# Usage: printString "Hello" or printInt 5
.macro printString(%str)
	li $v0, 4
	la $a0, %str
	syscall
.end_macro

# Macro to print a string
# Input: %str
.macro printInt(%int)
	li $v0, 1
	move $a0, %int
	syscall
.end_macro