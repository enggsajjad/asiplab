Brownie 用簡易テストベンチ
								All Rights Reserved 2008. ASIP Solutions, Inc.
																  2008/03/27



テストベンチ構成物 =============================================================

	[tb_browstd32.vhd]	テストベンチ回路（簡易タイマー割り込み付）
	[tb_im_mifu.vhd]	命令メモリ
	[tb_dm_mifu.vhd]	データメモリ



テストベンチ簡易仕様 ===========================================================

動作周波数：100MHz

・命令メモリ空間 ---------------------------------------------------------------
	命令メモリ（tb_im_mifu.vhd）はバイトアドレスで 
	0x0000 - 0xFFFF の領域を持っている．

　　実際のBrownieからのアクセスは次のようにマッピングされる

	Brownie					:	tb_im_mifu.vhd
	0x00000000 - 0x0000EFFF	:	0x0000 - 0xEFFF
	0x0FFE0000 - 0x0FFE0FFF	:	0xF000 - 0xFFFF

・データメモリ空間 -------------------------------------------------------------
	命令メモリ（tb_dm_mifu.vhd）はバイトアドレスで 
	0x10000 - 0x1FFFF の領域を持っている．

　　実際のBrownieからのアクセスは次のようにマッピングされる

	Brownie					:	tb_dm_mifu.vhd
	0x00010000 - 0x0001FFFF	:	0x0000 - 0xFFFF



・簡易タイマー割り込み ---------------------------------------------------------
	標準では200サイクルに1度 EXTINT_IN がアサートされる．
	タイマー割り込みはデフォルトで接続されていないので，
	タイマー割り込みをBrownieに接続したい場合は，テストベンチ中の記述


  EXTINT_IN <= '0';

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => open,
    catch_int => EXTCATCH_OUT);

　　を，

	
  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => EXTINT_IN,
    catch_int => EXTCATCH_OUT);


　　とすればよい．

以上．
