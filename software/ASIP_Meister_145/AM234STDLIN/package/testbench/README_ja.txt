Brownie �Ѵʰץƥ��ȥ٥��
								All Rights Reserved 2008. ASIP Solutions, Inc.
																  2008/03/27



�ƥ��ȥ٥������ʪ =============================================================

	[tb_browstd32.vhd]	�ƥ��ȥ٥����ϩ�ʴʰץ����ޡ��������ա�
	[tb_im_mifu.vhd]	̿�����
	[tb_dm_mifu.vhd]	�ǡ�������



�ƥ��ȥ٥���ʰ׻��� ===========================================================

ư����ȿ���100MHz

��̿�������� ---------------------------------------------------------------
	̿������tb_im_mifu.vhd�ˤϥХ��ȥ��ɥ쥹�� 
	0x0000 - 0xFFFF ���ΰ����äƤ��롥

�����ºݤ�Brownie����Υ��������ϼ��Τ褦�˥ޥåԥ󥰤����

	Brownie					:	tb_im_mifu.vhd
	0x00000000 - 0x0000EFFF	:	0x0000 - 0xEFFF
	0x0FFE0000 - 0x0FFE0FFF	:	0xF000 - 0xFFFF

���ǡ���������� -------------------------------------------------------------
	̿������tb_dm_mifu.vhd�ˤϥХ��ȥ��ɥ쥹�� 
	0x10000 - 0x1FFFF ���ΰ����äƤ��롥

�����ºݤ�Brownie����Υ��������ϼ��Τ褦�˥ޥåԥ󥰤����

	Brownie					:	tb_dm_mifu.vhd
	0x00010000 - 0x0001FFFF	:	0x0000 - 0xFFFF



���ʰץ����ޡ������� ---------------------------------------------------------
	ɸ��Ǥ�200���������1�� EXTINT_IN ���������Ȥ���롥
	�����ޡ������ߤϥǥե���Ȥ���³����Ƥ��ʤ��Τǡ�
	�����ޡ������ߤ�Brownie����³���������ϡ��ƥ��ȥ٥����ε���


  EXTINT_IN <= '0';

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => open,
    catch_int => EXTCATCH_OUT);

������

	
  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => EXTINT_IN,
    catch_int => EXTCATCH_OUT);


�����Ȥ���Ф褤��

�ʾ塥
