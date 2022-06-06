--
-- Copyright (C) 2008 ASIP Solutions, Inc. All rights reserved. 
--
-- Module	 : Instruction memory for a test bench with MIFU interface
-- Author	 : ASIP Solutions, Inc.
-- Version	 : 1.0

-- Functionality : behavior level
--  port
--    clk              : clock
--    finish           : signal to notify end of simulation
--    address          : address
--    data_out         : data output
--    addr_err         : address error

library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;

entity tb_im_mifu is
    generic (
      DATA_FILE_NAME: string := "TestData.IM";
      FLUSH_DELAY: time := 10 ns
    );
    port (
      clk        : in  std_logic;
      finish     : out std_logic;  
      address    : in  std_logic_vector(31 downto 0);
      data_out   : out std_logic_vector(31 downto 0);
      addr_err   : out std_logic
    );
end tb_im_mifu;

architecture behavior of tb_im_mifu is
  subtype Dtype is std_logic_vector(31 downto 0);
  type MEMtype is array (0 to 16383) of Dtype;
  file IMin: text open read_mode is DATA_FILE_NAME;
  
begin  -- Architecture Body
  IMem: process
    variable addr : std_logic_vector(31 downto 0);
    variable mapped_intr_addr : std_logic_vector(31 downto 0);
    variable datum : std_logic_vector(7 downto 0);
    variable data : Dtype;
    variable lbuf : line;
    variable IM   : MEMtype;

    variable base_addr : integer;
    variable offset : integer;
  begin
    for A in IM'range loop
      IM(A) := (others => '0');
    end loop;
    while (not(endfile(IMin))) loop
      for i in 0 to 4 - 1 loop
        readline(IMin, lbuf);
        hread(lbuf, addr); -- 1st column in file is address
        hread(lbuf, datum); -- 2nd column in file is data
        data(32 - 8 * i - 1 downto 32 - 8 * (i + 1)) := datum;
      end loop;
      
      if(X"00000000" <= addr and addr <= X"0000EFFF") then 
        IM(conv_integer(addr(31 downto 2))) := data;
      elsif(X"0FFE0000" <= addr and addr <= X"0FFE0FFF") then 
        mapped_intr_addr := (X"0000F" & addr(11 downto 0));
        IM(conv_integer(mapped_intr_addr(31 downto 2))) := data;
      else
        assert false;
      end if;
          -- byte address to word address
    end loop;

    addr_err <= '0';
    finish <= '0';
    loop
      wait until address'event;
              if address > addr then
                wait for FLUSH_DELAY;
                finish <= '1';
                wait;
              end if;
              
--              base_addr := conv_integer(address(31 downto 2));
              
              if(X"00000000" <= address and address <= X"0000EFFF") then 
                base_addr := conv_integer(address(31 downto 2));
              elsif(X"0FFE0000" <= addr and addr <= X"0FFE0FFF") then 
                base_addr := conv_integer((X"0000F" & address(11 downto 2)));
              else
                assert false;
              end if;
              
              offset := conv_integer(address(2 - 1 downto 0));
              data := IM(base_addr);

              if conv_integer(address(2 - 1 downto 0)) >= 4 then
                addr_err <= '1';
                data_out <= (others => 'X');
              else
                addr_err <= '0';
                  for i in 4 - 1 downto 0 loop
                      data_out((i + 1) * 8 - 1 downto i * 8)
                        <= data((i + 1 + offset) * 8 - 1 
                                 downto (i + offset) * 8);
                  end loop;
              end if;
    end loop;
  end process IMem;
end behavior;
