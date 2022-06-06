-- Copyright (C) 2008 ASIP Solutions, Inc. All rights reserved. 
--
-- Testbench for BrownieSTD32
--

library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;
use std.textio.all;
use WORK.all;


entity InterruptGenerator is
  generic (
  period : integer := 200000 -- if system is driven by 20MHz, 0.1s
    );
  port (
    CLK       : in  std_logic;
    reset     : in  std_logic;
    timer_int : out std_logic;
    catch_int : in  std_logic);
end InterruptGenerator;

architecture InterruptGenerator of InterruptGenerator is
  signal timer_counter : std_logic_vector(31 downto 0);
  signal timer_int_tmp : std_logic;
  signal detection : std_logic;
  
begin  -- InterruptGenerator

  -- purpose: timer counter
  -- type   : sequential
  -- inputs : CLK, reset
  -- outputs: 
  timer : process (CLK, reset)
  begin  -- process timer
  if reset = '1' then -- asynchronous reset (active high)
      timer_counter <= X"00000000";
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      timer_counter <= timer_counter + 1;
    end if;
  end process timer;

  -- purpose: latch ext int signal
  -- type   : sequential
  -- inputs : CLK, reset
  -- outputs: 
  latch: process (CLK, reset)
  begin  -- process latch
  if reset = '1' then -- asynchronous reset (active low)
      timer_int_tmp <= '0';
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if(catch_int = '1') then
        timer_int_tmp <= '0';
      elsif(detection = '1') then
        timer_int_tmp <= '1';
      else
        timer_int_tmp <= timer_int_tmp;
      end if;
    end if;
  end process latch;
  
  detection <= '1' when timer_counter = conv_std_logic_vector(period, 32) else
               '0';

  timer_int <= timer_int_tmp;
  
end InterruptGenerator;



library IEEE;
use IEEE.std_logic_1164.all;
use WORK.all;

entity tb_BrownieSTD32 is
end tb_BrownieSTD32;

architecture tb of tb_BrownieSTD32 is

  component BrownieSTD32
    port (
      clk:	in std_logic;
      RESET:	in std_logic;
      IMEM_ADDR_OUT:	out std_logic_vector(31 downto 0);
      IMEM_DATA_IN:	in std_logic_vector(31 downto 0);
      IMEM_ADDRERR_IN:	in std_logic;
      DMEM_ADDR_OUT:	out std_logic_vector(31 downto 0);
      DMEM_DATA_IN:	in std_logic_vector(31 downto 0);
      DMEM_DATA_OUT:	out std_logic_vector(31 downto 0);
      DMEM_REQ_OUT:	out std_logic;
      DMEM_ACK_IN:	in std_logic;
      DMEM_RW_OUT:	out std_logic;
      DMEM_WMODE_OUT:	out std_logic_vector(1 downto 0);
      DMEM_EMODE_OUT:	out std_logic;
      DMEM_ADDRERR_IN:	in std_logic;
      DMEM_CANCEL_OUT:	out std_logic;
      EXTINT_IN:	in std_logic;
      EXTCATCH_OUT:	out std_logic
    );
  end component;
  component tb_im_mifu
    generic (
      DATA_FILE_NAME: string := "TestData.IM";
      FLUSH_DELAY: time := 10 ns
    );
    port (
      CLK:	in std_logic;
      address:	in std_logic_vector(31 downto 0);
      data_out:	out std_logic_vector(31 downto 0);
      addr_err:	out std_logic;
      finish:	out std_logic
    );
  end component;
  component tb_dm_mifu
    generic (
      INIT_DATA_FILE_NAME: string := "TestData.DM";
      DUMP_DATA_FILE_NAME: string := "TestData.OUT"
    );
    port (
      CLK:	in std_logic;
      address:	in std_logic_vector(31 downto 0);
      data_out:	out std_logic_vector(31 downto 0);
      data_in:	in std_logic_vector(31 downto 0);
      req:	in std_logic;
      ack:	out std_logic;
      write_enb:	in std_logic;
      access_mode:	in std_logic_vector(1 downto 0);
      sign_ext:	in std_logic;
      addr_err:	out std_logic;
      cancel:	in std_logic;
      finish:	in std_logic
    );
  end component;

  component InterruptGenerator
    generic (
      period : integer := 200
    );
    port (
      CLK       : in  std_logic;
      reset     : in  std_logic;
      timer_int : out std_logic;
      catch_int : in  std_logic
    );
  end component;
  
  constant CLK_PERIOD : time := 10 ns;
  constant RESET_OFFSET : time := CLK_PERIOD / 10;

  signal clk:	std_logic;
  signal RESET:	std_logic;
  signal IMEM_ADDR_OUT:	std_logic_vector(31 downto 0);
  signal IMEM_DATA_IN:	std_logic_vector(31 downto 0);
  signal IMEM_ADDRERR_IN:	std_logic;
  signal DMEM_ADDR_OUT:	std_logic_vector(31 downto 0);
  signal DMEM_DATA_IN:	std_logic_vector(31 downto 0);
  signal DMEM_DATA_OUT:	std_logic_vector(31 downto 0);
  signal DMEM_REQ_OUT:	std_logic;
  signal DMEM_ACK_IN:	std_logic;
  signal DMEM_RW_OUT:	std_logic;
  signal DMEM_WMODE_OUT:	std_logic_vector(1 downto 0);
  signal DMEM_EMODE_OUT:	std_logic;
  signal DMEM_ADDRERR_IN:	std_logic;
  signal DMEM_CANCEL_OUT:	std_logic;
  signal EXTINT_IN:	std_logic;
  signal EXTCATCH_OUT:	std_logic;
  signal tb_finish:	std_logic;
  signal ig_reset:      std_logic;
  
begin  -- Architecture Body

  DUT: BrownieSTD32 port map (
      clk	 => clk,
      RESET	 => RESET,
      IMEM_ADDR_OUT	 => IMEM_ADDR_OUT,
      IMEM_DATA_IN	 => IMEM_DATA_IN,
      IMEM_ADDRERR_IN	 => IMEM_ADDRERR_IN,
      DMEM_ADDR_OUT	 => DMEM_ADDR_OUT,
      DMEM_DATA_IN	 => DMEM_DATA_IN,
      DMEM_DATA_OUT	 => DMEM_DATA_OUT,
      DMEM_REQ_OUT	 => DMEM_REQ_OUT,
      DMEM_ACK_IN	 => DMEM_ACK_IN,
      DMEM_RW_OUT	 => DMEM_RW_OUT,
      DMEM_WMODE_OUT	 => DMEM_WMODE_OUT,
      DMEM_EMODE_OUT	 => DMEM_EMODE_OUT,
      DMEM_ADDRERR_IN	 => DMEM_ADDRERR_IN,
      DMEM_CANCEL_OUT	 => DMEM_CANCEL_OUT,
      EXTINT_IN	 => EXTINT_IN,
      EXTCATCH_OUT	 => EXTCATCH_OUT
  );
  IMEM: tb_im_mifu
    generic map (FLUSH_DELAY => CLK_PERIOD * 8)
    port map (
      CLK	 => clk,
      address	 => IMEM_ADDR_OUT,
      data_out	 => IMEM_DATA_IN,
      addr_err	 => IMEM_ADDRERR_IN,
      finish	 => tb_finish
    );
  DMEM: tb_dm_mifu port map (
      CLK	 => clk,
      address	 => DMEM_ADDR_OUT,
      data_out	 => DMEM_DATA_IN,
      data_in	 => DMEM_DATA_OUT,
      req	 => DMEM_REQ_OUT,
      ack	 => DMEM_ACK_IN,
      write_enb	 => DMEM_RW_OUT,
      access_mode	 => DMEM_WMODE_OUT,
      sign_ext	 => DMEM_EMODE_OUT,
      addr_err	 => DMEM_ADDRERR_IN,
      cancel	 => DMEM_CANCEL_OUT,
      finish	 => tb_finish
  );

  -- Clock Signal
  process
  begin
    clk <= '1';
    wait for CLK_PERIOD/2;
    clk <= '0';
    wait for CLK_PERIOD/2;
  end process;

  -- Reset Signal
  RESET <= '1',
           '0' after CLK_PERIOD + RESET_OFFSET;

  ig_reset <= RESET or EXTCATCH_OUT;

  EXTINT_IN <= '0';

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => open,
    catch_int => EXTCATCH_OUT);
  
end tb;

configuration CFG of tb_BrownieSTD32 is
  for tb
  end for;
end;

-----------------------------------
-----------------------------------
