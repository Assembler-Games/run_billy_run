# Using MARS Bitmap Display

We can use MARS to draw pixels on the screen using the bitmap display. The concept is simple. All we have to do is set the pixel color information to the right memory location. Each pixel has an address and a color value. We can think of it as a grid where each cell is a pixel. Since, we are using the resolutioon 512x256, this means we have 512 columns and 256 rows of pixels. Next, we considered the unit size of each pixel. MARS Bitmap allows us to define our pixel unit size. For our program we will use 8x8 pixels.

## Setting up the display
1. Open the MARS Tools menu and select Bitmap Display
2. Set the resolution to 512x256 and pixel size to 8x8
3. Select the base address `0x10040000(heap)`
4. Click `Connect to MIPS`
5. The display should now be ready for drawing pixels

### Using heap memory
MARS uses the base address for the entire program at the static data segment (usually `0x10010000`). In order to avoid conflicts, we use heap memory. This way we can safely draw pixels. If we used the static memory address `0x10010000`, it might overwrite other data.

## Calculating pixel address
To find the address of a pixel given a set of coordinates, we can use the formula: 

$$
Address_{pixel} = Address_{base} + bytes(y * Width + x)
$$  

where `x` and `y` are the pixel coordinates, `bytes` is size of each pixel, and `Width` is the screen width divided by the unit size. In our case, 512/8 = 64.

## Drawing a pixel
To draw a pixel on the screen we need to calculate its address using the formula above and then set the color value at that address.

For example, to draw a pixel at (2, 3) 
1. Pass the coordinates and color to $a0, $a1, $a2
2. Call drawPixel

```asm

#Function:drawPixel(x, y, color)
# Purpose: draw pixel at (x, y) with color
# Inputs: $a0=x, $a1=y, $a2=color
drawPixel:
    # Calculate address for pixel using formula:
    # Address = Base + bytes * (y * width + x)
    #         = frameBuffer + 4 * (y * width + x)

    # set $t0 to point to screen width
    li $t0, SCREEN_WIDTH 

    # Calculate y * width = 3 * 64 = 192
    mul $t1, $a1, $t0 

    # Add x to it = 192 + 2 = 194
    add $t1, $t1, $a0

    # Convert pixel index to byte offset; 4 bytes per pixel
    li $t0, 4
    mul $t1, $t1, $t0 # 194 * 4 = 776

    # Get heap base address
    lw $t2, heapBase # 0x10040000

    # Add the calculated offset to framebuffer base address
    add $t2, $t2, $t1 # 0x10040000 + 776(decimal) = 0x1004000 + 0x308 = 0x10040308

    # Write pixel color in the calculated address (0x10040308)
    sw $a2, 0($t2) 

    jr $ra
```
