Simplified Test Bench for Brownie
                                All Rights Reserved 2008. ASIP Solutions, Inc.
                                                                  2008/03/27



Test Bench Constructs/Components================================================

    [tb_browstd32.vhd]  Test bench circuit (Simple timer interrupt equipped)
    [tb_im_mifu.vhd]    Instruction memory
    [tb_dm_mifu.vhd]    data memory



Basic specification of Test bench ==============================================

operating frequency : 100MHz

  Instruction memory space------------------------------------------------------
    Instruction memory (tb_im_mifu.vhd¡Ëhas an area/ of 0x0000 - 0xFFFF
    in byte address. 

    Access from Brownie will be mapped as follows. 

    Brownie                 :   tb_im_mifu.vhd
    0x00000000 - 0x0000EFFF :   0x0000 - 0xEFFF
    0x0FFE0000 - 0x0FFE0FFF :   0xF000 - 0xFFFF

  Data Memory space-------------------------------------------------------------
    Data memory (tb_dm_mifu.vhd¡Ëhas an area of 0x10000 - 0x1FFFF 
    in byte address. 

    Access from Brownie will be mapped as follows. 

    Brownie                 :   tb_dm_mifu.vhd
    0x00010000 - 0x0001FFFF :   0x0000 - 0xFFFF



  Simple timer interrupt -------------------------------------------------------
    Normally EXTINT_IN is asserted once in 200 cycles. 
    Timer interrupt is not connected by default. 
    To connect timer interrupt to Brownie, change the description in test bench 
    as follows.


  EXTINT_IN <= '0';

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => open,
    catch_int => EXTCATCH_OUT);

The above should be changed as below. 

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => EXTINT_IN,
    catch_int => EXTCATCH_OUT);

