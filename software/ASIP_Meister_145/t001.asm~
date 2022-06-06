; Simple test program for brownie std 32 v.0.97c
;   Copyright 2008 ASIP Solutions, Inc. All rights reserved.

	.addr_space	32	; address space is 2^32
	.addressing	Byte	; byte addressing          (default)
	.bits_per_byte	8	; 1 byte consists of 8 bit (default)
	.endian		Big	; Big endian (default)
	.section	.data
	.align		4
data:
	.data.32	0x12345678
	.data.32	0x98765432
	.data.8		0xAA
	.data.8		0xFF
	.data.16	0x0000
data_dump_start:


	.section	.text
	.org	0x00000000
main:

	; relative jump testing

jp_t:
SW
jp0:	
	JP	$(jp1 - jp0 - 4)
	TRAP    $(trap_abort - trap_base)
jp2:	
	JP	$(jp3 - jp2 - 4)
	TRAP    $(trap_abort - trap_base)
jp1:	
	JP	$(jp2 - jp1 - 4)
	TRAP    $(trap_abort - trap_base)
jp3:	
	JP	$(jp4 - jp3 - 4)
	TRAP    $(trap_abort - trap_base)
jp4:	
	NOP
	; OK, go to the next test


	; absolute jump testing
jpr_t:
	LSOI	%GPR10,	%GPR10,	$(jpr1 / 0x10000)
	LSOI	%GPR10,	%GPR10,	$(jpr1 % 0x10000)
	LSOI	%GPR11,	%GPR11,	$(jpr2 / 0x10000)
	LSOI	%GPR11,	%GPR11,	$(jpr2 % 0x10000)
	LSOI	%GPR12,	%GPR12,	$(jpr3 / 0x10000)
	LSOI	%GPR12,	%GPR12,	$(jpr3 % 0x10000)
	LSOI	%GPR13,	%GPR13,	$(jpr4 / 0x10000)
	LSOI	%GPR13,	%GPR13,	$(jpr4 % 0x10000)
	JPR	%GPR10					; enter jpr maze
	TRAP    $(trap_abort - trap_base)

jpr2:	
	JPR		%GPR12
	TRAP    $(trap_abort - trap_base)
jpr1:	
	JPR		%GPR11
	TRAP    $(trap_abort - trap_base)
jpr3:	
	JPR		%GPR13
	TRAP    $(trap_abort - trap_base)
jpr4:	
	NOP						; clear
	; OK, go to the next test

	; relative branch testing
br_t:
br_pa:	
	JP		$(br0 - br_pa - 4)		; enter br maze
br_abt:	
	TRAP	$(trap_abort - trap_base)
br0:	
	LSOI	%GPR10,	%GPR10,	$(0x0000)
	LSOI	%GPR10,	%GPR10,	$(0x1111)
br1:	
	BRZ	%GPR0,	$(br2 - br1 - 4)
	TRAP	$(trap_abort - trap_base)
br2:	
	BRZ	%GPR10,	$(br_abt - br2 - 4)
br3:	
	BRNZ	%GPR0,	$(br_abt - br3 - 4)
br4:	
	BRNZ	%GPR10,	$(br5 - br4 - 4)
	TRAP	$(trap_abort - trap_base)
br5:	
	NOP						; clear
	; OK, go to the next test


	; relative jump with link testing
jpl_t:
	LSOI	%GPR10,	%GPR10,	$(jpl1 / 0x10000)
	LSOI	%GPR10,	%GPR10,	$(jpl1 % 0x10000)
	ADDI	%GPR10,	%GPR10,	$(4)
jpl1:	
	JPL	$(jpl2 - jpl1 - 4)
	TRAP	$(trap_abort - trap_base)
jpl2:	
	EEQ	%GPR11,	%GPR10,	%GPR3			; check saved value
jpl3:	
	BRNZ	%GPR11, $(jpl4 - jpl3 - 4)
	TRAP	$(trap_abort - trap_base)		; trapped
jpl4:	
	NOP						; clear
	; OK, go to the next test

	; absolute jump with link testing
jprl_t:
	LSOI	%GPR10, %GPR10,	$(jprl1 / 0x10000)
	LSOI	%GPR10, %GPR10,	$(jprl1 % 0x10000)
	ADDI	%GPR10, %GPR10,	$(4)
	LSOI	%GPR11, %GPR11,	$(jprl2 / 0x10000)
	LSOI	%GPR11, %GPR11,	$(jprl2 % 0x10000)
jprl1:	
	JPRL	%GPR11
	TRAP	$(trap_abort - trap_base)
jprl2:	
	EEQ	%GPR12, %GPR10, %GPR3			; check saved value
jprl3:	
	BRNZ	%GPR12, $(jprl4 - jprl3 - 4)
	TRAP	$(trap_abort - trap_base)		; trapped
jprl4:	
	NOP						; clear
	; OK, go to the next test

ri_t:
	ADDI	%GPR10, %GPR0,  $(0x0000)	; 
	LSOI	%GPR10, %GPR10, $(0x0001)	; r10 must be 0x00000001
	ADDI	%GPR11, %GPR0,  $(0xFFFF)	; 
	LSOI	%GPR11, %GPR11, $(0xFFFF)	; r11 must be 0xffffffff
	ANDI	%GPR12, %GPR10, $(0x0101)	; r12 must be 0x00000001
	ANDI	%GPR13, %GPR11, $(0x1010)	; r13 must be 0x00001010
	ORI		%GPR14, %GPR12, $(0x8888)	; r14 must be 0x00008889
	XORI	%GPR15, %GPR14, $(0xFFFF)	; r15 must be 0x00007776
	LLSI	%GPR16, %GPR11, $(0x0010)	; r16 must be 0xffff0000
	LRSI	%GPR17, %GPR11, $(0x0018)	; r17 must be 0x000000ff
	ARSI	%GPR18, %GPR16, $(0x0008)	; r18 must be 0xffffff00
	ARSI	%GPR19, %GPR13, $(0x0004)	; r19 must be 0x00000101
	ADDI	%GPR20, %GPR11, $(0x0001)	; r20 must be 0x00000000
	NOP
	ORI		%GPR21, %GPR1,  $(0x0000)	; zero and carry must be set
	SUBI	%GPR22, %GPR10, $(0x0001)	; r22 must be 0x00000000
	NOP
	ORI		%GPR23, %GPR1,  $(0x0000)	; zero and carry must be set
	SUBI	%GPR24, %GPR15, $(0x7776)	; r24 must be 0x00000000
	NOP
	ORI		%GPR25, %GPR1,  $(0x0000)	; zero and carry must be set

	ADDI	%GPR5,	%GPR0,	$(0x0001)	; set dump ID
	TRAP	$(trap_dump - trap_base)	; dump rfile

rr_t:
	ADDI	%GPR10, %GPR0,  $(0x0000)	; 
	LSOI	%GPR10, %GPR10, $(0x0010)	; r10 msut be 0x00000010
	ADDI	%GPR11, %GPR0,  $(0x1234)	; 
	LSOI	%GPR11, %GPR11, $(0x5678)	; r11 must be 0x12345678
	ADDI	%GPR12, %GPR0,  $(0xFFFF)	; 
	LSOI	%GPR12, %GPR12, $(0x0000)	; r12 must be 0xFFFF0000

	AND	%GPR13, %GPR11, %GPR12		; r13 must be 0x12340000
	OR	%GPR14, %GPR10, %GPR12		; r14 must be 0xFFFF0010
	XOR	%GPR15, %GPR11, %GPR12		; r15 must be 0xEDCB5678
	MUL	%GPR16, %GPR15, %GPR10		; r16 must be 0xDCB56780
	DIV	%GPR17, %GPR15, %GPR10		; r17 must be 0xFEDCB567 x div bug
	MOD	%GPR18, %GPR15, %GPR10		; r18 must be 0xFFFFFFF8

	LLS	%GPR19, %GPR14, %GPR10		; r19 must be 0x00100000
	LRS	%GPR20, %GPR12, %GPR10		; r20 must be 0x0000FFFF
	ARS	%GPR21, %GPR11, %GPR10		; r21 must be 0x00001234
	ARS	%GPR22, %GPR15, %GPR10		; r22 must be 0xFFFFEDCB

	ADDI	%GPR23, %GPR0,  $(0x8000)	;
	LSOI	%GPR23, %GPR23, $(0x0000)	; r23 must be 0x80000000
	ADD		%GPR24, %GPR10, %GPR18		; r24 msut be 0x00000008
	NOP
	OR		%GPR25, %GPR1,  %GPR0		; carry must be set
	ADD		%GPR26, %GPR23, %GPR23		; r26 msut be 0x00000000
	NOP
	OR		%GPR27, %GPR1,  %GPR0		; ovf, carry and zero must be set
	NOP
	SUB		%GPR28, %GPR22, %GPR22		; r28 must be 0x00000000
	NOP
	OR		%GPR29, %GPR1,  %GPR0		; carry(borrow) and zero must be set
	SUB		%GPR30, %GPR20, %GPR10		; r30 must be 0x0000FFEF
	NOP
	OR		%GPR31, %GPR1,  %GPR0		; carry(borrow) must be set

	ADDI	%GPR5,	%GPR0,	$(0x0002)	; set dump ID
	TRAP	$(trap_dump - trap_base)

eval_t:
	ADDI	%GPR10, %GPR0 , $(0x0000)
	LSOI	%GPR10, %GPR10, $(0x0001)
	ADDI	%GPR11, %GPR0 , $(0x0000)
	LSOI	%GPR11, %GPR11, $(0x0001)
	ADDI	%GPR12, %GPR0 , $(0x0000)
	LSOI	%GPR12, %GPR12, $(0x0010)
	ADDI	%GPR13, %GPR0 , $(0x0000)
	LSOI	%GPR13, %GPR13, $(0xFFFF)
	ADDI	%GPR14, %GPR0 , $(0xFFFF)
	LSOI	%GPR14, %GPR14, $(0xFFFF)
	ADDI	%GPR15, %GPR0 , $(0x8000)
	LSOI	%GPR15, %GPR15, $(0x0000)

	ELT	%GPR16, %GPR10, %GPR11		; r16 must be 0
	ELT	%GPR17, %GPR10, %GPR14		; r17 must be 0
	ELT	%GPR18, %GPR14, %GPR10		; r18 must be 1
	ELTU	%GPR19, %GPR10, %GPR11		; r19 must be 0
	ELTU	%GPR20, %GPR10, %GPR14		; r20 must be 1
	ELTU	%GPR21, %GPR14, %GPR10		; r21 must be 0
	EEQ	%GPR22, %GPR10, %GPR11		; r22 must be 1
	EEQ	%GPR23, %GPR10, %GPR12		; r23 must be 0
	ENEQ	%GPR24, %GPR10, %GPR11		; r24 must be 0
	ENEQ	%GPR25, %GPR10, %GPR12		; r25 must be 1

	ADDI	%GPR5,	%GPR0,	$(0x0003)	; set dump ID
	TRAP	$(trap_dump - trap_base)

ext_t:
	LSOI	%GPR10, %GPR10,	$(0x1234)
	LSOI	%GPR10, %GPR10,	$(0x5678)
	LSOI	%GPR11, %GPR11,	$(0x8888)
	LSOI	%GPR11, %GPR11,	$(0x8888)

	EXBW	%GPR12,	%GPR10
	EXBW	%GPR13, %GPR11
	EXHW	%GPR14,	%GPR10
	EXHW	%GPR15, %GPR11

	ADDI	%GPR5,	%GPR0,	$(0x0004)	; set dump ID
	TRAP	$(trap_dump - trap_base)

lsw_t:
	ADDI	%GPR10, %GPR0 , $(0x0000)
	LSOI	%GPR10, %GPR10, $(0x0400)
	ADDI	%GPR11, %GPR0 , $(0x0000)
	LSOI	%GPR11, %GPR11, $(0x0001)
	ADDI	%GPR12, %GPR0 , $(0x0000)
	LSOI	%GPR12, %GPR12, $(0x0010)
	ADDI	%GPR13, %GPR0 , $(0x0000)
	LSOI	%GPR13, %GPR13, $(0xFFFF)
	ADDI	%GPR14, %GPR0 , $(0xFFFF)
	LSOI	%GPR14, %GPR14, $(0xFFFF)
	ADDI	%GPR15, %GPR0 , $(0x8000)
	LSOI	%GPR15, %GPR15, $(0x0000)

	SW	-16(%GPR10),    %GPR11
	SW	-12(%GPR10),    %GPR12
	SW	-8(%GPR10),     %GPR13
	SW	-4(%GPR10),     %GPR14
	SW	0(%GPR10),      %GPR15
	SW	4(%GPR10),      %GPR14
	SW	8(%GPR10),      %GPR13
	SW	12(%GPR10),     %GPR12
	SW	16(%GPR10),     %GPR11

	LW	%GPR21, -16(%GPR10)
	LW	%GPR22, -12(%GPR10)
	LW	%GPR23, -8(%GPR10)
	LW	%GPR24, -4(%GPR10)
	LW	%GPR25, 0(%GPR10)
	LW	%GPR26, 4(%GPR10)
	LW	%GPR27, 8(%GPR10)
	LW	%GPR28, 12(%GPR10)
	LW	%GPR29, 16(%GPR10)

	ADDI	%GPR31, %GPR0,  $(0x0001)
	EEQ	%GPR30, %GPR21, %GPR11
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR22, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR23, %GPR13
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR24, %GPR14
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR25, %GPR15
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR26, %GPR14
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR27, %GPR13
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR28, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR29, %GPR11
	AND	%GPR31, %GPR31, %GPR30

ev1:	
		BRNZ	%GPR31, $(ev2 - ev1)
		TRAP	$(trap_abort - trap_base)
ev2:	NOP

	ADDI	%GPR10, %GPR0 , $(0x0000)
	LSOI	%GPR10, %GPR10, $(0x0450)
	ADDI	%GPR11, %GPR0 , $(0x0000)
	LSOI	%GPR11, %GPR11, $(0x0001)
	ADDI	%GPR12, %GPR0 , $(0x0000)
	LSOI	%GPR12, %GPR12, $(0x0010)
	ADDI	%GPR13, %GPR0 , $(0x0000)
	LSOI	%GPR13, %GPR13, $(0xFFFF)
	ADDI	%GPR14, %GPR0 , $(0x0000)
	LSOI	%GPR14, %GPR14, $(0xABCD)
	ADDI	%GPR15, %GPR0 , $(0x0000)
	LSOI	%GPR15, %GPR15, $(0x0000)

	SH	-16(%GPR10),    %GPR11
	SH	-12(%GPR10),    %GPR12
	SH	-8(%GPR10),     %GPR13
	SH	-4(%GPR10),     %GPR14
	SH	0(%GPR10),      %GPR15
	SH	4(%GPR10),      %GPR14
	SH	8(%GPR10),      %GPR13
	SH	12(%GPR10),     %GPR12
	SH	16(%GPR10),     %GPR11
	LH	%GPR21, -16(%GPR10)
	LH	%GPR22, -12(%GPR10)
	LH	%GPR23, -8(%GPR10)
	LH	%GPR24, -4(%GPR10)
	LH	%GPR25, 0(%GPR10)
	LH	%GPR26, 4(%GPR10)
	LH	%GPR27, 8(%GPR10)
	LH	%GPR28, 12(%GPR10)
	LH	%GPR29, 16(%GPR10)

	ADDI	%GPR31, %GPR0,  $(0x0001)
	EEQ	%GPR30, %GPR21, %GPR11
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR22, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR23, %GPR13			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR24, %GPR14			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR25, %GPR15
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR26, %GPR14			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR27, %GPR13			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR28, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR29, %GPR11
	AND	%GPR31, %GPR31, %GPR30

ev3:	
		BRNZ	%GPR31, $(ev4 - ev3 - 4)
		TRAP	$(trap_abort - trap_base)
ev4:	
	NOP

	ADDI	%GPR10, %GPR0 , $(0x0000)
	LSOI	%GPR10, %GPR10, $(0x0500)
	ADDI	%GPR11, %GPR0 , $(0x0000)
	LSOI	%GPR11, %GPR11, $(0x0001)
	ADDI	%GPR12, %GPR0 , $(0x0000)
	LSOI	%GPR12, %GPR12, $(0x0010)
	ADDI	%GPR13, %GPR0 , $(0x0000)
	LSOI	%GPR13, %GPR13, $(0x00FF)
	ADDI	%GPR14, %GPR0 , $(0x0000)
	LSOI	%GPR14, %GPR14, $(0x00AB)
	ADDI	%GPR15, %GPR0 , $(0x0000)
	LSOI	%GPR15, %GPR15, $(0x0000)

	SB	-16(%GPR10),    %GPR11
	SB	-12(%GPR10),    %GPR12
	SB	-8(%GPR10),     %GPR13
	SB	-4(%GPR10),     %GPR14
	SB	0(%GPR10),      %GPR15
	SB	4(%GPR10),      %GPR14
	SB	8(%GPR10),      %GPR13
	SB	12(%GPR10),     %GPR12
	SB	16(%GPR10),     %GPR11

	LB	%GPR21, -16(%GPR10)
	LB	%GPR22, -12(%GPR10)
	LB	%GPR23, -8(%GPR10)
	LB	%GPR24, -4(%GPR10)
	LB	%GPR25, 0(%GPR10)
	LB	%GPR26, 4(%GPR10)
	LB	%GPR27, 8(%GPR10)
	LB	%GPR28, 12(%GPR10)
	LB	%GPR29, 16(%GPR10)

	ADDI	%GPR31, %GPR0,  $(0x0001)
	EEQ	%GPR30, %GPR21, %GPR11
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR22, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR23, %GPR13			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR24, %GPR14			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR25, %GPR15
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR26, %GPR14			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	ENEQ	%GPR30, %GPR27, %GPR13			; not equal becase signed ext.
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR28, %GPR12
	AND	%GPR31, %GPR31, %GPR30
	EEQ	%GPR30, %GPR29, %GPR11
	AND	%GPR31, %GPR31, %GPR30

ev5:	
		BRNZ	%GPR31, $(ev6 - ev5 - 4)
		TRAP	$(trap_abort -  trap_base)
ev6:	
	NOP


load_static_data_t:
	LSOI	%GPR10,	%GPR10,	$(data / 0x10000)
	LSOI	%GPR10,	%GPR10,	$(data % 0x10000)

	LW	%GPR11,	0x0000(%GPR10)
	LW	%GPR12,	0x0004(%GPR10)
	LW	%GPR13,	0x0008(%GPR10)

	LH	%GPR14,	0x0000(%GPR10)
	LH	%GPR15,	0x0002(%GPR10)
	LH	%GPR16,	0x0004(%GPR10)
	LH	%GPR17,	0x0006(%GPR10)
	LH	%GPR18,	0x0008(%GPR10)
	LH	%GPR19,	0x000A(%GPR10)

	LB	%GPR20,	0x0000(%GPR10)
	LB	%GPR21,	0x0001(%GPR10)
	LB	%GPR22,	0x0002(%GPR10)
	LB	%GPR23,	0x0003(%GPR10)
	LB	%GPR24,	0x0004(%GPR10)
	LB	%GPR25,	0x0005(%GPR10)
	LB	%GPR26,	0x0006(%GPR10)
	LB	%GPR27,	0x0007(%GPR10)
	LB	%GPR28,	0x0008(%GPR10)
	LB	%GPR29,	0x0009(%GPR10)
	LB	%GPR30,	0x000A(%GPR10)
	LB	%GPR31,	0x000B(%GPR10)

	ADDI	%GPR5,	%GPR0,	$(0x0005)	; set dump ID
	TRAP	$(trap_dump - trap_base)


mode_check:
	; we are user mode now, so be prohibited to update the status register
	ORI	%GPR1,	%GPR1,	$(0xFFFF)

	LSOI	%GPR5,	%GPR5,	$(0x0000)	; set dump ID
	LSOI	%GPR5,	%GPR5,	$(0x0006)	; 
	SW	0x0000(%GPR6),	%GPR4		; 0xAAAAAAAA - separater for easy look up
	SW	0x0004(%GPR6),	%GPR5		; put ID
	SW	0x0008(%GPR6),	%GPR1		; status is dumped

	; increment dumping pointer
	ADDI	%GPR6,	%GPR6,	$(0x000C)

	TRAP	$(trap_mode_check - trap_base)
	
	; above trap_mode_check could break status register, 
	; we finish program immediately

finish_up_main:
	; finish
	LSOI	%GPR10,	%GPR10,	$(end / 0x10000)
	LSOI	%GPR10,	%GPR10,	$(end % 0x10000)
	JPR	%GPR10


	.org	0x0FFE0000
reset:	; reset interrupt handler
	; GPR6 is all 1 register
	LSOI	%GPR4,	%GPR4,	$(0xAAAA)
	LSOI	%GPR4,	%GPR4,	$(0xAAAA)

	; GPR5 is used as ID, in trap_dump
	; also, is used as a flag that stands for the program was aborted or not
	XOR	%GPR5,	%GPR5,	%GPR5

	; GPR6 is dumping pointer
	LSOI	%GPR6,	%GPR6,	$(data_dump_start / 0x10000)
	LSOI	%GPR6,	%GPR6,	$(data_dump_start % 0x10000)

	; GPR7 is reserved now 
	XOR	%GPR7,	%GPR7,	%GPR7

	; GPR8 is reserved now
	XOR	%GPR8,	%GPR8,	%GPR8

	; GPR9 is used by system
	XOR	%GPR9,	%GPR9,	%GPR9

	; goto main (interrupt will be permitted)
	LSOI	%GPR2,	%GPR2,	$(main / 0x10000)
	LSOI	%GPR2,	%GPR2,	$(main % 0x10000)
	RETI

	.org	0x0FFE0400
ext_interrupt:
	ADDI	%GPR7,	%GPR7,	$(0x0001)
	RETI

	.org	0x0FFE0800

trap_base:

trap_rf_clear:
	XOR	%GPR10,	%GPR10,	%GPR10
	XOR	%GPR11,	%GPR11,	%GPR11
	XOR	%GPR12,	%GPR12,	%GPR12
	XOR	%GPR13,	%GPR13,	%GPR13
	XOR	%GPR14,	%GPR14,	%GPR14
	XOR	%GPR15,	%GPR15,	%GPR15
	XOR	%GPR16,	%GPR16,	%GPR16
	XOR	%GPR17,	%GPR17,	%GPR17
	XOR	%GPR18,	%GPR18,	%GPR18
	XOR	%GPR19,	%GPR19,	%GPR19
	XOR	%GPR20,	%GPR20,	%GPR20
	XOR	%GPR21,	%GPR21,	%GPR21
	XOR	%GPR22,	%GPR22,	%GPR22
	XOR	%GPR23,	%GPR23,	%GPR23
	XOR	%GPR24,	%GPR24,	%GPR24
	XOR	%GPR25,	%GPR26,	%GPR25
	XOR	%GPR26,	%GPR27,	%GPR27
	XOR	%GPR27,	%GPR28,	%GPR28
	XOR	%GPR28,	%GPR28,	%GPR28
	XOR	%GPR29,	%GPR29,	%GPR29
	XOR	%GPR30,	%GPR30,	%GPR30
	XOR	%GPR31,	%GPR31,	%GPR31

	; increment interrupt return register to return correctly
	ADDI	%GPR2,	%GPR2,	$(0x0004)
	RETI

trap_dump:
	SW	0x0000(%GPR6),	%GPR4	; 0xAAAAAAAA - separater for easy look up
	SW	0x0004(%GPR6),	%GPR5	; put ID
	SW	0x0008(%GPR6),	%GPR1	; status register
	SW	0x000C(%GPR6),	%GPR2	; interrupt return register
	SW	0x0010(%GPR6),	%GPR3	; link register
	SW	0x0014(%GPR6),	%GPR10	; GPR10 - 31 are dumped
	SW	0x0018(%GPR6),	%GPR11
	SW	0x001C(%GPR6),	%GPR12
	SW	0x0020(%GPR6),	%GPR13
	SW	0x0024(%GPR6),	%GPR14
	SW	0x0028(%GPR6),	%GPR15
	SW	0x002C(%GPR6),	%GPR16
	SW	0x0030(%GPR6),	%GPR17
	SW	0x0034(%GPR6),	%GPR18
	SW	0x0038(%GPR6),	%GPR19
	SW	0x003C(%GPR6),	%GPR20
	SW	0x0040(%GPR6),	%GPR21
	SW	0x0044(%GPR6),	%GPR22
	SW	0x0048(%GPR6),	%GPR23
	SW	0x004C(%GPR6),	%GPR24
	SW	0x0050(%GPR6),	%GPR25
	SW	0x0054(%GPR6),	%GPR26
	SW	0x0058(%GPR6),	%GPR27
	SW	0x005C(%GPR6),	%GPR28
	SW	0x0060(%GPR6),	%GPR29
	SW	0x0064(%GPR6),	%GPR30
	SW	0x0068(%GPR6),	%GPR31

	; increment dumping pointer
	ADDI	%GPR6,	%GPR6,	$(0x006C)

	; increment interrupt return register to return correctly
	ADDI	%GPR2,	%GPR2,	$(0x0004)
	RETI

trap_abort:
	ADDI	%GPR5,	%GPR0,	$(0xFFFF)

	LSOI	%GPR10,	%GPR10,	$(end / 0x10000)
	LSOI	%GPR10,	%GPR10,	$(end % 0x10000)
	JPR	%GPR10

trap_mode_check:
	ORI	%GPR1,	%GPR1,	$(0xFFFF)
	
	LSOI	%GPR5,	%GPR5,	$(0x0000)	; set dump ID
	LSOI	%GPR5,	%GPR5,	$(0x0007)	; 
	SW	0x0000(%GPR6),	%GPR4		; 0xAAAAAAAA - separater for easy look up
	SW	0x0004(%GPR6),	%GPR5		; put ID
	SW	0x0008(%GPR6),	%GPR1		; status is dumped

	; increment dumping pointer
	ADDI	%GPR6,	%GPR6,	$(0x000C)

	; increment interrupt return register to return correctly
	; but this routine breaks status register, 
	; you need to abort or finish immediately
	ADDI	%GPR2,	%GPR2,	$(0x0004)
	RETI

	.org	0x0FFE0F00
end:
	NOP
	NOP
	NOP
	NOP
