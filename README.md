# Welcome to ISA X
ISA X is a 16 bit instruction set architecture written in SystemVerilog.
SystemVerilog was chosen due to a slightly enhanced feature set over regular HDL.

# Design
Use this sheet to see the design and translation of assembly to machine code.

LW takes the value at memory address Rs and stores into register Rd.
SW takes stores the value of Rs into the memory address of Rd. Branch is left-shifted one position.
Jump is also shifted left one position. Move takes the value of the immediate and stores in the register Rd.

# What the program Looks like
```
Load [12], 10

Load [13], 8

Load [14], 2

Move RA, [12]

Move RB, [13]

Move RC, [14]

Loop: DEC RC

Add RA, RB

JNZ Loop

Store [14], RA
```

This got translated in the following table:
| Memory Address | Instruction | Opcode | Rd | Rs1/Immediate | Rs2 | Instruction from Announcment |
|----------------|-------------|--------|----|----------------|-----|------------------------------|
| 0x0002         | 0x8E0A      | MV     | R7 | d10            |     |                                |
| 0x0004         | 0x8D08      | MV     | R6 | d8             |     |                                |
| 0x0006         | 0x8C02      | MV     | R5 | d2             |     |                                |
| 0x0008         | 0x8020      | MV     | R0 | 0x20           |     |                                |
| 0x000A         | 0x8300      | MV     | R1 | 0x100          |     |                                |
| 0x000C         | 0x8402      | MV     | R2 | 0x002          |     |                                |
| 0x000E         | 0x8800      | MV     | R4 | 0x000          |     |                                |
| 0x0010         | 0x3001      | MUL    | R0 | R0             | R1  |                                |
| 0x0012         | 0xA038      | SW     | R0 | R7             |     | Load [12], 10                 |
| 0x0014         | 0x1002      | ADD    | R0 | R0             | R2  |                                |
| 0x0016         | 0xA028      | SW     | R0 | R6             |     | Load [13], 8                  |
| 0x0018         | 0x1002      | ADD    | R0 | R0             | R2  |                                |
| 0x001A         | 0xA026      | SW     | R0 | R5             |     | Load [14], 2                  |
| 0x001C         | 0x1604      | ADD    | R3 | R0             | R4  |                                |
| 0x001E         | 0x8201      | MV     | R1 | 0x001          |     |                                |
| 0x0020         |             |        |    |                |     | LOOP                           |
| 0x0022         | 0x2E39      | SUB    | R7 | R7             | R1  | DEC RC                         |
| 0x0024         | 0x1DE5      | ADD    | R6 | R6             | R5  | ADD RA RB                     |
| 0x0026         | 0xC1EE      | BNZ    | R7 | LOOP           |     | JNZ Loop                       |
| 0x0028         | 0x9D28      | LW     | R6 | R3             |     | SW [14], RA                    |

I had to translate the Load immediate into moving the value into a register and calculating the correct memory address froom there. This can be seen in the first several instructions. Since the memory is byte-addressable, the memory-address get's two added each time so that each value can be retrieved. This is a pretty common practice in ISAs I've seen like RISCV however they typically implement Load and store immediate opcodes as well as load-byte or store-byte, I don't have the space in the ISA to include such so I had to translate to the MV and store.

I don't have a decrement command so I moved d1 into a register and subtracted the counter register by it and stored the result in the counter register, this is effectively the same thing.

The LOOP label is a blank memory location because my ISA loads the PC with the label and before fetching the instruction adds 2 to the program counter thus the LOOP label must be -2 from the instructin I would like to fetch next.

# Process
I started by trying to implement a multi-cycle datapath like the ones I learned about in Computer Architecture. I ran into a lot of timing constraint issues. Something I realized is that it is really easy to understand these concepts on paper and to even trace the datapath but to try to create it at such a low level is monumental task.

You can see even in my single-cycle datapath implementation that I use blocking assignments as I do not pass the clock to my other modules and instead use the activity list to tell when to run, thus I always block the last assignment before changing the write-enable register or the opcode to ensure that the result is what I want and expect.

Interfaces were almost necessary to the success of this project. It made it a lot easier to organize my thoughts and how modules were going to interact. I think it also made testing easier.

The size of this design is massive, taking several minutes to run a synthesis.

# Future Work
If it hadn't taken so long to get this "working" I would like to have programmed a way to program the program memory from a file. I found some documentation on how to make this work but didn't have time to implement.
