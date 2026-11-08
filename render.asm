# Group 4 - Billy Run player code
# File: render.asm
# Contributors: 
# Last Modified: 11/07/2026
# Purpose: 

.eqv SCREEN_WIDTH 64 # Display width divided by size of pixel unit width (512/8 = 64) 

.data

#colors in hex = 0x00RRGGBB
green: .word 0x0000FF00
black: .word 0x00000000
#frameBuffer: .space 8192 # Bitmap framebuffer: 64 x 32 x 4 bytes
heapBase: .word 0x10040000 # base address of heap for the display

.text

# Function drawBilly()
# Purpose: draw player at billyX, billyY in green

drawBilly:
    lw $a0, billyX
    lw $a1, billyY
    lw $a2, green

    j drawPixel


# Function eraseBilly()
# Purpose: draw black pixel at billyX, billyY
eraseBilly:
    lw $a0, billyX
    lw $a1, billyY
    lw $a2, black

    j drawPixel



#Function:drawPixel(x, y, color)
# Purpose: draw pixel at (x, y) with color
# Inputs: $a0=x, $a1=y, $a2=color
drawPixel:
    # Calculate address for pixel using formula:
    # Address = Base + bytes * (y * width + x)
    #         = frameBuffer + 4 * (y * width + x)

    # set $t0 to point to screen width
    li $t0, SCREEN_WIDTH

    # Calculate y * width
    mul $t1, $a1, $t0

    # Add x to it
    add $t1, $t1, $a0

    # Convert pixel index to byte offset; 4 bytes per pixel
    li $t0, 4
    mul $t1, $t1, $t0

    # Get heap base address
    lw $t2, heapBase

    # Add the calculated offset to framebuffer base address
    add $t2, $t2, $t1

    # Write pixel color in the calculated address
    sw $a2, 0($t2)

    jr $ra
