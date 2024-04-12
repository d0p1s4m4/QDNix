# ez80 {#ez80}

## Registers

| 16Bits | High | Low | Usage             |
|--------|------|-----|-------------------|
| PC     |      |     | Program counter   |
| SP     |      |     | Stack pointer     |
| IX     | XH   | XL  |                   |
| IY     | YH   | YL  |                   |
| AF     | A    | F   | `A` 8bit accumulator, `F` flags registers |
| BC     | B    | C   |                   |
| DE     | D    | E   |                   |
| HL     | H    | L   |                   |
| AF'    | A'   | F'  |                   |
| BC'    | B'   | C'  |                   |
| DE'    | D'   | E'  |                   |
| HL'    | H'   | L'  |                   |
|        | I    | R   |                   |

#### F 

| 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0 |
|---|---|---|---|---|---|---|---|
| S | Z | y | H | x | V | N | C |

## Memory Management

## Calling Conventions

@cite krause2022efficient
@cite zeal8bit
