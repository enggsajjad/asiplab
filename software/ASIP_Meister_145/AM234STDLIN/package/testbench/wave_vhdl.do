# Copyright 2008 ASIP Solutions, Inc. All rights reserved.

onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic -label CLOCK -radix hexadecimal /tb_browniestd32/dut/clk
add wave -noupdate -format Logic -label RESET -radix hexadecimal /tb_browniestd32/dut/reset
add wave -noupdate -format Literal -label PC -radix hexadecimal /tb_browniestd32/dut/uf_pc/data_out
add wave -noupdate -format Literal -label IR -radix hexadecimal /tb_browniestd32/dut/uf_ir/data_out
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label IM_addr_out -radix hexadecimal /tb_browniestd32/dut/uf_imau/addr2mem
add wave -noupdate -format Literal -label IM_data_in -radix hexadecimal /tb_browniestd32/dut/uf_imau/data2cpu
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label DM_addr_out -radix hexadecimal /tb_browniestd32/dut/uf_dmau/addr_out
add wave -noupdate -format Literal -label DM_data_out -radix hexadecimal /tb_browniestd32/dut/uf_dmau/data2mem
add wave -noupdate -format Literal -label DM_data_in -radix hexadecimal /tb_browniestd32/dut/uf_dmau/data2cpu
add wave -noupdate -format Logic -label DM_req_out /tb_browniestd32/dut/uf_dmau/req_out
add wave -noupdate -format Logic -label DM_ack_in /tb_browniestd32/dut/uf_dmau/ack_in
add wave -noupdate -format Logic -label DM_rw -radix hexadecimal /tb_browniestd32/dut/uf_dmau/rw2mem
add wave -noupdate -format Literal -label DM_mode -radix binary /tb_browniestd32/dut/uf_dmau/mode_out
add wave -noupdate -format Logic -label DM_ext -radix hexadecimal /tb_browniestd32/dut/uf_dmau/ext_out
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic -label EXTINT_IN /tb_browniestd32/dut/extint_in
add wave -noupdate -format Logic -label EXTCATCH_OUT /tb_browniestd32/dut/extcatch_out
add wave -noupdate -format Logic -label int_handling -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/interrupt_handling
add wave -noupdate -color White -format Logic -label bran_acc_IF -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/branch_acc_if
add wave -noupdate -color White -format Logic -label bran_acc_ID -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/branch_acc_id
add wave -noupdate -color White -format Logic -label bran_acc_EXE -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/branch_acc_exe
add wave -noupdate -color White -format Logic -label bran_acc_WB -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/branch_acc_wb
add wave -noupdate -format Logic -label valid_IF -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/valid_stage_if
add wave -noupdate -format Logic -label valid_ID -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/valid_stage_id
add wave -noupdate -format Logic -label valid_EXE -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/valid_stage_exe
add wave -noupdate -format Logic -label valid_WB -radix hexadecimal /tb_browniestd32/dut/ua_ctrl/valid_stage_wb
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -label FLAG -radix hexadecimal /tb_browniestd32/dut/uf_gpr/flag_reg/data_out
add wave -noupdate -format Literal -label STATUS -radix hexadecimal /tb_browniestd32/dut/uf_gpr/streg/data_out
add wave -noupdate -format Literal -label GPR1 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/status_out
add wave -noupdate -color Gold -format Literal -label GPR2 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg2/data_out
add wave -noupdate -color Gold -format Literal -label GPR3 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg3/data_out
add wave -noupdate -color Gold -format Literal -label GPR4 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg4/data_out
add wave -noupdate -color Gold -format Literal -label GPR5 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg5/data_out
add wave -noupdate -color Gold -format Literal -label GPR6 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg6/data_out
add wave -noupdate -color Gold -format Literal -label GPR7 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg7/data_out
add wave -noupdate -color Gold -format Literal -label GPR8 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg8/data_out
add wave -noupdate -color Gold -format Literal -label GPR9 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg9/data_out
add wave -noupdate -format Literal -label GPR10 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg10/data_out
add wave -noupdate -format Literal -label GPR11 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg11/data_out
add wave -noupdate -format Literal -label GPR12 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg12/data_out
add wave -noupdate -format Literal -label GPR13 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg13/data_out
add wave -noupdate -format Literal -label GPR14 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg14/data_out
add wave -noupdate -format Literal -label GPR15 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg15/data_out
add wave -noupdate -format Literal -label GPR16 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg16/data_out
add wave -noupdate -format Literal -label GPR17 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg17/data_out
add wave -noupdate -format Literal -label GPR18 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg18/data_out
add wave -noupdate -format Literal -label GPR19 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg19/data_out
add wave -noupdate -color Gold -format Literal -label GPR20 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg20/data_out
add wave -noupdate -color Gold -format Literal -label GPR21 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg21/data_out
add wave -noupdate -color Gold -format Literal -label GPR22 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg22/data_out
add wave -noupdate -color Gold -format Literal -label GPR23 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg23/data_out
add wave -noupdate -color Gold -format Literal -label GPR24 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg24/data_out
add wave -noupdate -color Gold -format Literal -label GPR25 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg25/data_out
add wave -noupdate -color Gold -format Literal -label GPR26 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg26/data_out
add wave -noupdate -color Gold -format Literal -label GPR27 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg27/data_out
add wave -noupdate -color Gold -format Literal -label GPR28 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg28/data_out
add wave -noupdate -color Gold -format Literal -label GPR29 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg29/data_out
add wave -noupdate -format Literal -label GPR30 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg30/data_out
add wave -noupdate -format Literal -label GPR31 -radix hexadecimal /tb_browniestd32/dut/uf_gpr/reg31/data_out
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
