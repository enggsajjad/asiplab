; simple interrupt handler
; written by Hirofumi IWATO
; All Rights Reserved 2008. ASIP Solutions, Inc.

	.section	.rodata
	.section	.data
	.section	.htext
	.align 2
	.globl	__ih_reset
	.type	__ih_reset, @function
__ih_reset:
	xor	r16, r16, r16
	jpr	r16		; goto 0x000000000

