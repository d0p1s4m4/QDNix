# PDP-11 {#pdp11}

## Registers

| Name | Alt Name | Usage                  |
|------|----------|------------------------|
| r0   |          | Temporary accumulators |
| r1   |          | Temporary accumulators |
| r2   |          |                        |
| r3   |          |                        |
| r4   |          |                        |
| r5   |          | Environment pointer    |
| r6   | sp       | Stack Pointer          |
| r7   | pc       | Program counter        |

## Memory Management

Page size: 128K (64 bytes)

### Registers

| Name  | Address | Usage                                                   |
|-------|---------|---------------------------------------------------------|
| MMR0  | 0177572 | Memory Management Register #0                           |
| MMR1  | 0177574 | Memory Management Register #1 (⚠️ PDP-11/44 and 11/70) |
| MMR2  | 0177576 | Fault virtual address                                   |
| MMR3  |         | Memory Management Register #3 (⚠️ PDP-11/44 and 11/70) |

##### MMR0

| Bits  | Usage |
|-------|-------|
| 15    | Abort-Non Resident
| 14    | Abort-Page / Length Error
| 13    | Abort-Read Only / Access Violation
| 12    | Trap-Memory Management (⚠️ PDP-11/70 only)
| 11-10 | Reserved
| 9     | Enable Memory Management Traps (⚠️ PDP-11/70 only)
| 8     | Maintenance Mode (⚠️ Not used by PDP-11/24)
| 7     | Instruction Completed (⚠️ PDP-11/70 only)
| 6-5   | Page Mode
| 4     | Page Address Space I/D (⚠️ PDP-11/44 and 11/70)
| 3-1   | Page Number
| 0     | Enable Relocation

##### MMR1

| Bits  | Usage |
|-------|-------|
| 15-11 | Amount changed
| 10-8  | Register Number
| 7-3   | Amount Changed
| 2-0   | Register Number

##### MMR3

| Bits | Usage |
|------|-------|
| 15-6 | Reserved
| 5    | Enable Unibus Map
| 4    | Enable 22bit Mapping
| 3    | Reserved
| 2-0  | Mode 

| Value | Mode       |
|-------|------------|
| 0b100 | Kernel     |
| 0b010 | Supervisor |
| 0b001 | User       |
