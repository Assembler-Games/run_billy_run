# run_billy_run
A Computer Organization and Assembly Programming course game project built in Assembly MIPS32 via MARS simulator.


## Setup
1. Open MARS
2. Open the Tools menu and select Memory-Mapped I/O
3. Connect to MIPS
4. Make sure the MMIO window is open
5. Open the Tools menu and select Bitmap Display
6. Set pixel width and height to 8
7. Set Display Width to 512
8. Set Display Height to 256
9. Set base address to `0x10040000(heap)`
10. Make sure everything is connected
11. Compile from the main file

## Controls
Use MARS MMIO to read keyboard inputs. Use the bottom window for typing.
- Space: Jump
- q: Quit