# Keyboard Input Using MARS Memory-Mapped I/O

## Setting up MARS MMIO
1. Open the MARS Tools menu and select Memory-Mapped I/O
2. Click `Connect to MIPS`

The bottem windown is the window used for keyboard inputs. You type there and MARS updates the registers. Just make sure it is open and connected to MIPS before compilying the main file. 
## Check If Key is Pressed

To check if a key is pressed, we want to look at the ready bit. To do this we can perform a bitwise AND between the control register and 1. Fortunately, MIPS has the `andi` instruction for this. However, we want to preserve the address of the Receiver Control register, so we use a temporary register. Since we only need the LSB, we mask it with 1, and other bits will be ignored.



```asm
# Load word from $t0 into $t1
lw $t1, 0($t0)

# Mask ready bit with 1
andi $t1, $t1, 1

# If the result of the AND is 0, no key is pressed then jump to no_key label
beq $t1, $zero, no_key
```

Taking a closer look at the AND operation:
```txt
if ($t1 == 0) no key pressed
   0000 0000 0000 0000 0000 0000 0000 0000
 & 0000 0000 0000 0000 0000 0000 0000 0001
 -----------------------------------------
                                         0

if ($t1 != 0) key pressed
   0000 0000 0000 0000 0000 0000 0000 0001
 & 0000 0000 0000 0000 0000 0000 0000 0001
 -----------------------------------------
                                         1

```

Next we have to read the key from the data register if a key is pressed. Since the address for the `Data Receiver` is 0xFFFF0004, and this is offset 4 from the control register, we can load the word at offset 4 from $t0.

```asm
lw $t2, 4($t0)
```
## If jump key is pressed
Now we can access the `Receiver Data` register to get the key pressed. And, since we are looking for the jump key, which has a hex code of 0x20 and that is equivalent to 32(decimal), we can compare $t2 with 32 by loading an immediate to a temp register. 

```asm
li $t3, 32 #  load the decimal ascii value for the SPACE key
beq $t2, $t3, setBillyJumping # jump if space key is pressed set billy in jumping state
```

```asm
#Function: setBillyJumping()
#Purpose: Sets the values of Billy's velocity, gracity, and set billyJumping to TRUE
setBillyJumping:
	# Set register $t0 to point to variable address holding JUMP_VELOCITY
	li $t0, JUMP_VELOCITY
	sw $t0, billyYVel # update Billy's Y velocity to -5 pixes/frame
	
	# Set isBillyJumping = 1
	li $t0, 1
	sw $t0, isBillyJumping
	
	j keyboardDone

```
And finally, we can end the keyboard check function with a label `keyboardDone` which jumps register to the return address.
```asm
keyboardDone:
    jr $ra
```
