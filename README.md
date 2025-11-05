# ARC 6502

> If you know, you know. Playing around with 6502 assembly with a pretend board.



## Getting started

You need clang installed

### Ubuntu

- `make setup`
- `make`

### macOS

- `make setup_mac`
- `make`
- `make run`

## Notes

- $ is base 16

`a2 0f a0 0f a9 ff 20 0f 80` is draw a pixel.

- a2, a0 = column and row (LDX, LDY)
- 0f, 0f = 15,15 position
- a9, ff = set color to white (LDA)
- 20 03 80 = jump to draw pixel sub routine (subject to change if moved)

- 4c 18 80 = jump back to loop label (subject to change if moved)

### Example

![output](./assets/output.png)

```
00000000  4c 18 80 86 02 84 03 85  04 a2 00 a5 03 69 20 85   L............i .
00000010  03 a0 00 a5 04 91 02 60  a2 0f a0 0f a9 ff 20 03   .......`...... .
00000020  80 a2 00 a0 00 a9 ff 20  03 80 a2 1f a0 00 a9 ff   ....... ........
00000030  20 03 80 a2 00 a0 1f a9  ff 20 03 80 a2 1f a0 1f    ........ ......
00000040  a9 ff 20 03 80 4c 18 80  00 00 00 00 00 00 00 00   .. ..L..........
```

## Resources

- https://www.masswerk.at/6502/6502_instruction_set.html
- https://en.wikipedia.org/wiki/MOS_Technology_6502
- https://cc65.github.io/
- http://6502.org/tutorials/6502opcodes.html
- https://www.youtube.com/watch?v=PxZGoiWvA4A

