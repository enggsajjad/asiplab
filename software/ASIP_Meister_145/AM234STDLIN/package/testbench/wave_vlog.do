# Copyright 2008 ASIP Solutions, Inc. All rights reserved.

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -label CLOCK -radix hexadecimal /tb_browniestd32/dut/CLK
add wave -noupdate -format Logic -label RESET -radix hexadecimal /tb_browniestd32/dut/RESET
add wave -noupdate -format Literal -label PC -radix hexadecimal /tb_browniestd32/dut/UF_PC/data_out
add wave -noupdate -format Literal -label IR -radix hexadecimal /tb_browniestd32/dut/UF_IR/data_out
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label IM_addr_out -radix hexadecimal /tb_browniestd32/dut/UF_IMAU/addr2mem
add wave -noupdate -format Literal -label IM_data_in -radix hexadecimal /tb_browniestd32/dut/UF_IMAU/data2cpu
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label DM_addr_out -radix hexadecimal /tb_browniestd32/dut/UF_DMAU/addr_out
add wave -noupdate -format Literal -label DM_data_out -radix hexadecimal /tb_browniestd32/dut/UF_DMAU/data2mem
add wave -noupdate -format Literal -label DM_data_in -radix hexadecimal /tb_browniestd32/dut/UF_DMAU/data2cpu
add wave -noupdate -format Logic -label DM_req_out /tb_browniestd32/dut/UF_DMAU/req_out
add wave -noupdate -format Logic -label DM_ack_in /tb_browniestd32/dut/UF_DMAU/ack_in
add wave -noupdate -format Logic -label DM_rw -radix hexadecimal /tb_browniestd32/dut/UF_DMAU/rw2mem
add wave -noupdate -format Literal -label DM_mode -radix binary /tb_browniestd32/dut/UF_DMAU/mode_out
add wave -noupdate -format Logic -label DM_ext -radix hexadecimal /tb_browniestd32/dut/UF_DMAU/ext_out
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic -label EXTINT_IN /tb_browniestd32/dut/EXTINT_IN
add wave -noupdate -format Logic -label EXTCATCH_OUT /tb_browniestd32/dut/EXTCATCH_OUT
add wave -noupdate -format Logic -label int_handling -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/interrupt_handling
add wave -noupdate -color White -format Logic -label bran_acc_IF -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/branch_acc_IF
add wave -noupdate -color White -format Logic -label bran_acc_ID -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/branch_acc_ID
add wave -noupdate -color White -format Logic -label bran_acc_EXE -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/branch_acc_EXE
add wave -noupdate -color White -format Logic -label bran_acc_WB -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/branch_acc_WB
add wave -noupdate -format Logic -label valid_IF -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/valid_stage_IF
add wave -noupdate -format Logic -label valid_ID -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/valid_stage_ID
add wave -noupdate -format Logic -label valid_EXE -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/valid_stage_EXE
add wave -noupdate -format Logic -label valid_WB -radix hexadecimal /tb_browniestd32/dut/UA_CTRL/valid_stage_WB
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label FLAG -radix hexadecimal /tb_browniestd32/dut/UF_GPR/FLAG_REG/data_out
add wave -noupdate -format Literal -label STATUS -radix hexadecimal /tb_browniestd32/dut/UF_GPR/STREG/data_out
add wave -noupdate -format Literal -label GPR1 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/status_out
add wave -noupdate -color Gold -format Literal -label GPR2 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG2/data_out
add wave -noupdate -color Gold -format Literal -label GPR3 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG3/data_out
add wave -noupdate -color Gold -format Literal -label GPR4 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG4/data_out
add wave -noupdate -color Gold -format Literal -label GPR5 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG5/data_out
add wave -noupdate -color Gold -format Literal -label GPR6 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG6/data_out
add wave -noupdate -color Gold -format Literal -label GPR7 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG7/data_out
add wave -noupdate -color Gold -format Literal -label GPR8 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG8/data_out
add wave -noupdate -color Gold -format Literal -label GPR9 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG9/data_out
add wave -noupdate -format Literal -label GPR10 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG10/data_out
add wave -noupdate -format Literal -label GPR11 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG11/data_out
add wave -noupdate -format Literal -label GPR12 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG12/data_out
add wave -noupdate -format Literal -label GPR13 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG13/data_out
add wave -noupdate -format Literal -label GPR14 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG14/data_out
add wave -noupdate -format Literal -label GPR15 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG15/data_out
add wave -noupdate -format Literal -label GPR16 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG16/data_out
add wave -noupdate -format Literal -label GPR17 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG17/data_out
add wave -noupdate -format Literal -label GPR18 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG18/data_out
add wave -noupdate -format Literal -label GPR19 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG19/data_out
add wave -noupdate -color Gold -format Literal -label GPR20 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG20/data_out
add wave -noupdate -color Gold -format Literal -label GPR21 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG21/data_out
add wave -noupdate -color Gold -format Literal -label GPR22 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG22/data_out
add wave -noupdate -color Gold -format Literal -label GPR23 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG23/data_out
add wave -noupdate -color Gold -format Literal -label GPR24 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG24/data_out
add wave -noupdate -color Gold -format Literal -label GPR25 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG25/data_out
add wave -noupdate -color Gold -format Literal -label GPR26 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG26/data_out
add wave -noupdate -color Gold -format Literal -label GPR27 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG27/data_out
add wave -noupdate -color Gold -format Literal -label GPR28 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG28/data_out
add wave -noupdate -color Gold -format Literal -label GPR29 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG29/data_out
add wave -noupdate -format Literal -label GPR30 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG30/data_out
add wave -noupdate -format Literal -label GPR31 -radix hexadecimal /tb_browniestd32/dut/UF_GPR/REG31/data_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {13551 ns} 0}
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {0 ns} {256 ns}
