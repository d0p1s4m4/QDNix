/*
 * BSD 3-Clause License
 *
 * Copyright (c) 2022, d0p1
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef _SYS_DEV_SERIAL_8250_H
# define _SYS_DEV_SERIAL_8250_H 1

/* UART 8250 , 16750 */

# define UART8250_RBR        0x0 /* RX */
# define UART8250_THR        0x0 /* TX */

# define UART8250_IER        0x1
# define UART8250_IER_RDA    0x1
# define UART8250_IER_THRE   0x2
# define UART8250_IER_RLSRC  0x4
# define UART8250_IER_MSRC   0x8

/* 16750 only */
# define UART16750_IER_SLEEP 0x10
# define UART16750_IER_LPM   0x20

# define UART8250_IIR        0x2

# define UART8250_FCR        0x2
# define UART8250_FCR_EN     0x1
# define UART8250_FCR_CLSR   0x2
# define UART8250_FCR_CLST   0x4
# define UART8250_FCR_DMA    0x8

/* 16750 only */
# define UART16750_FCR_64EN  0x20

# define UART8250_LCR        0x3

# define UART8250_MCR        0x4

# define UART8250_LSR        0x5

# define UART8250_MSR        0x6

# define UART8250_SCR        0x7

/* DLAB == 1 */
# define UART8250_DLL        0x0

# define UART8250_DLH        0x1

#endif /* !_SYS_DEV_SERIAL_8250_H */
