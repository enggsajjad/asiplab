;
; startup routine for brownie testbench
; written by Hirofumi IWATO 
; All Rights Reserved 2008. ASIP Solutions, Inc.
;

#define SP r5

	.section	.rodata
_startup_consts:
	.long	_sp_data
	.section	.data
	.section	.text
	.align 2
	.globl	_start
	.type	_start, @function
_start:
	addi	r16, r0,  %hi(_startup_consts)
	lsoi	r16, r16, %lo(_startup_consts)
	lw	r5,  0(r16)			; load stack pointer
	addi	r16, r0,  %hi(_main)
	lsoi	r16, r16, %lo(_main)

	subi	r5, r5, #4			; push link reg
	sw	(r5), r3

	ori	r1, r1, #0x00000300		; enable interrupt

	jprl	r16

	lw	r3, (r5)			; pop link reg
	addi	r5, r5, #4

	trap	0

