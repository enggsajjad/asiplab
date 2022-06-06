Brownie v.1.1 �ѥå�����
								All Rights Reserved 2008. ASIP Solutions, Inc.
																  2008/07/22


����Brownie v.1.1 �� ASIP Meister Std v.2.3 ��������ǽ�Ǥ���


�ѥå���������ʪ ===============================================================

[package/]	+ README.txt
			+ ReleaseNotes.txt
			+ BrownieSTD32_Spec.pdf
			+ browstd32.pdb
			+ [fhm/]
			|	+ browregfile.fhm
			|	+ dummy_register.fhm
			+ [util/]
			|	+ gccout2img
			|	+ pasout2img
			|	+ img2mem
			|	+�ʤ���¾���������ץȡ�
			+ [testbench/]
			|	+ README.txt
			|	+ tb_*.vhd
			|	+ wave_*.do
			+ [src/]
				+ t001.asm
				+ browtb.x
				+ startup.s
				+ handler.s

	README.txt				�ܥե�����
	ReleaseNotes.txt		��꡼���Ρ��ȡ����ΤΥХ�
	BrownieSTD32_Spec.pdf	Brownie �λ��ͽ�
	browstd32.pdb			Brownie ��PDB�ե�����
	[fhm/]					Brownie�� FHM
	[util/]					Brownie�� �桼�ƥ���ƥ���������ץȥ���ץ�
	[testbench/]			Brownie�� �ʰץƥ��ȥ٥���ե�����
	[src/]					Brownie�� �ʰץƥ��ȥ�������


�����ʹߡ�
����ASIP Meister �� [/usr/local/ASIPmeister] �˥��󥹥ȡ��뤵��Ƥ���Ȥ��롥



Brownie ��������ˡ =============================================================

����FHM �Υ��󥹥ȡ���

	�� ASIP Meister Std 2.3 �ˤ� Brownie �Ѥ�FHM�����󥹥ȡ��뤵��Ƥ���Τǡ�
	�� �ܹ��� FHM�Υ��󥹥ȡ��� �ϥ����åײ�ǽ�Ǥ���

	�ѥå������� [fhm/] �ǥ��쥯�ȥ�ʲ��� 
	[browregfile.fhm] ����� [dummy_register.fhm] ��

/usr/local/ASIPmeister/share/fhmdb/workdb/FHM_work

	�˥��ԡ�����

	[/usr/local/ASIPmeister/share/fhmdb/fhmdbstruct] �ե��������
	<class name="FHM_work"> ���Ф��Ƥ��ܥѥå�������°�� [fhm/fhmdbstruct] 
	�򻲹ͤˡ��ʲ��Τ褦�����Ƥ�񤭲ä��롥

		<class name="FHM_work">
				:
				:
			<model>dummy_register</model>
			<model>browregfile</model>

�������κ�ȸ塤 ASIPmeister ��ư����browstd32.pdb �򳫤����Ȥǡ�
����Brownie�Υǡ������ɤ߹��ޤ�롥���λ�����������ǽ�ʾ��֤ˤʤ롥


����������֥�������ˤ� Assembler Generation��
����HDL�������ˤ� HDL Generation �Υܥ���򲡤���
�����������줿�ե�����������ǥ��쥯�ȥ� [meister/] �ʲ����֤���롥


��������ѥ���������ˤ� Compiler Generation �ܥ���򲡤���
�����������줿����ѥ������ [meister/browstd32.swgen/] �ʲ���Ÿ�������Τǡ�
�������Ѥ���ݤ� [meister/browstd32.swgen/bin/] �˥ѥ����̤����ȡ�



�ʰץƥ��� =====================================================================

VHDL �С������Υƥ�����ˡ ----------------------------------------------------

	�ʰץƥ��ȥ٥���Υ���ޥå����ˤĤ��Ƥ� [testbench/README.txt] �򻲾ȡ�

	testbench �ǥ��쥯�ȥ���� t001.asm �� pas ��Ȥäƥ�����֥뤹��

% pas -des browstd32.des -src t001.asm > t001.out

	pas �� [/usr/local/ASIPmeister/bin] �ˤ��롥
	�ޤ���brownie32.des ��GUI��[Assenbler Generation]������������Τǡ�
	�����ǥ��쥯�ȥ� [meister/] �ʲ��ˤ��롥

	���ˡ�������֥��� .out �ե������ [util/] �ǥ��쥯�ȥ겼�ˤ��� 
	pasout2img ��Ȥä�

TestData.IM
TestData.DM

	���Ѵ����롥
	ξ�Ԥ�VHDL�ѥƥ��ȥ٥�� tb_browstd32.vhd �����Ȥ�����ꥤ�᡼���Ǥ��롥
	�Ѵ����뤿��Υ��ޥ�ɤϡ��ʲ����̤�Ǥ��롥

% pasout2img t001.out

	��������[util/] �ǥ��쥯�ȥ���Υġ�������Ѥ���ݤˤ� [util/] �ǥ��쥯�ȥ��
	�ѥ����̤��Ƥ������ȡ��ޤ��ϡ��ѥ����̤ä����˥��ԡ��������Ѥ��뤳�ȡ�

	���ꥤ�᡼��������ϡ��ʲ��Υե������Ʊ��ǥ��쥯�ȥ������뤳�Ȥǡ�
	ModelSim���ǥ��ߥ�졼�����Ǥ��롥

���������� HDL [meister/browstd32.VHDL.syn/*.vhd] 
���ƥ��ȥ٥�� [testbench/tb_browstd32.vhd]
               [testbench/tb_im_mifu.vhd]
               [testbench/tb_dm_mifu.vhd]
����Ǻ��������ץ����Υ��᡼�� TestData.IM �� TestData.DM

	���ԡ������ǥ��쥯�ȥ�ˤơ�

% vlib work
% vcom *.vhd
% vsim work.cfg

	��¹ԡ�
	ModelSim�� do�ե����� [testbench/wave_vhdl.do] ����������Ƥ���Τǡ�
	�ȷ���¬���ˤ�ɬ�פ˱����� ModelSim �Υ��󥽡����ǰʲ��Τ褦�����Ѳ�ǽ�Ǥ��롥

VSIM 1 > do wave_vhdl.do



Verilog �С������Υƥ�����ˡ -------------------------------------------------

	�ʰץƥ��ȥ٥���Υ���ޥå����ˤĤ��Ƥ� [testbench/README.txt] �򻲾ȡ�

	testbench �ǥ��쥯�ȥ���� t001.asm �� pas ��Ȥäƥ�����֥뤹��

% pas -des browstd32.des -src t001.asm > t001.out

	pas �� [/usr/local/ASIPmeister/bin] �ˤ��롥
	�ޤ���brownie32.des ��GUI��[Assenbler Generation]������������Τǡ�
	�����ǥ��쥯�ȥ� [meister/] �ʲ��ˤ��롥

	���ˡ�������֥��� .out �ե������ [util/] �ǥ��쥯�ȥ겼�ˤ��� 
	pasout2img ��Ȥä�

TestData.IM
TestData.DM

	���Ѵ����롥
	ξ�Ԥ�VHDL�ѥƥ��ȥ٥�� tb_browstd32.vhd �����Ȥ�����ꥤ�᡼���Ǥ��롥
	�Ѵ����뤿��Υ��ޥ�ɤϡ��ʲ����̤�Ǥ��롥

% pasout2img t001.out

	��������[util/] �ǥ��쥯�ȥ���Υġ�������Ѥ���ݤˤ� [util/] �ǥ��쥯�ȥ��
	�ѥ����̤��Ƥ������ȡ��ޤ��ϡ��ѥ����̤ä����˥��ԡ��������Ѥ��뤳�ȡ�

	���ꥤ�᡼��������ϡ��ʲ��Υե������Ʊ��ǥ��쥯�ȥ������뤳�Ȥǡ�
	ModelSim���ǥ��ߥ�졼�����Ǥ��롥���������ƥ��ȥ٥����VHDL����Ѥ���
	ModelSim�ˤ�뺮�祷�ߥ�졼������Ԥ���ΤȤ��롥

���������� HDL [meister/browstd32.Verilog.syn/*.v] 
���ƥ��ȥ٥�� [testbench/tb_browstd32.vhd]
               [testbench/tb_im_mifu.vhd]
               [testbench/tb_dm_mifu.vhd]
����Ǻ��������ץ����Υ��᡼�� TestData.IM �� TestData.DM

	���ԡ������ǥ��쥯�ȥ�ˤơ�

% vlib work
% vlog *.v
% vcom *.vhd
% vsim -novopt work.cfg

	��¹ԡ�
	ModelSim��do�ե����� [testbench/wave_vlog.do] ����������Ƥ���Τǡ�
	ɬ�פ˱��������Ѳ�ǽ�Ǥ��롥

VSIM 1 > do wave_vlog.do

	�ʤ�������ѥ����Υ��֥������ȥե������Verilog�ѥ��������.mem�ˤ�
	�Ѵ��Ǥ��롥pasout2img���ˤ�äƽ��Ϥ��줿 TestData.?? �ե������
	Ʊ���ǥ��쥯�ȥ�� img2mem ����Ѥ��롥

% pasout2img main
% img2mem

	img2mem �� TestData.IM ����� TestData.DM ���顤
	.mem �����Υե����� TestData.IM.mem �� TestData.DM.mem ����Ϥ��롥



����ѥ�������� ===============================================================

	
	gcc�ν��ϤǤ���elf�������顢���ꥤ�᡼������Ф��뤿��Υ桼�ƥ���ƥ���
	������ץȤΥ���ץ��gccout2img��img2mem �Ȥ����ܥѥå������� [util/] ��
	ź�դ��Ƥ��롥
	�ʤ����ܥѥå�������°�Υ桼�ƥ���ƥ������Ѥ��뤿��ˤ� [util/]��
	�ѥ����̤��Ƥ���ɬ�פ����롥

	�Ϥ���ˡ�BrownieSTD32 �Ѥ�GCC���åȤ��������롥
	Ÿ����� [meister/browstd32.swgen/bin] �˥ѥ����̤��Ƥ�����


�̾�Υ���ѥ���ˡ -------------------------------------------------------------

% brownie32-elf-gcc -S main.c -o main.s
% brownie32-elf-as -o startup.o startup.s
% brownie32-elf-as -o handler.o handler.s
% brownie32-elf-as -o main.o main.s
% brownie32-elf-ld -o test -T browtb.x main.o startup.o handler.o

	�ʾ�Υ��ޥ�ɤ������Ϥ��뤳�Ȥǡ�
	�ץ��å��Υ��֥������ȥ����� test ����������롥
	startup.s��handler.s�ϥ������ȥ��åץ롼����ȡ�
	�����ߥϥ�ɥ�롼����Ǥ��ꡤ��󥫥�����ץ� browtb.x
	�ˤ������äƥ�󥯤���롥
	startup.s, handler.s, browtb.x�ϡ��桼�����Ķ��ˤ��碌�ƽ���
	����ɬ�פ����롥


����ѥ����Υ��֥������ȥե������ʰץƥ��ȥ٥���Υ��ꥤ�᡼�����Ѵ� -----
	���̾�Υ���ѥ���ˡ�פˤ�����줿 elf �����Υե�������Ф���
	gccout2img �����Ѥ��롥

% gccout2img test

	gccout2img �� TestData.IM �� TestData.DM ����Ϥ���Τǡ�
	������Ѥ��ƴʰץƥ��Ȥ������ǥ��ߥ�졼������ǽ�Ǥ��롥



����ѥ����Υ��֥������ȥե������Verilog�ѥ��������.mem�ˤ��Ѵ� ----------
	gccout2img���ޤ��� pasout2img �ˤ�äƽ��Ϥ��줿 TestData.?? �ե������
	Ʊ���ǥ��쥯�ȥ�� img2mem ����Ѥ��롥

% gccout2img test
% img2mem

	img2mem �� TestData.IM ����� TestData.DM ���顤
	.mem �����Υե����� TestData.IM.mem �� TestData.DM.mem ����Ϥ��롥


�ʾ塥
