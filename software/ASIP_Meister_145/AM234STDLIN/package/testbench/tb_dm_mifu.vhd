--
-- Copyright (C) 2008 ASIP Solutions, Inc. All rights reserved. 
--
-- Module	 : Data memory for a test bench with MIFU interface
-- Author	 : ASIP Solutions, Inc.
-- Version	 : 1.0

-- Functionality : behavior level
--  port
--    clk              : clock
--    finish           : signal to notify end of simulation
--    req              : memory access request from cpu
--    ack              : memory access ack to cpu
--    cancel           : cancel signal from cpu
--    write_enb        : write enable
--    data_in          : data output from cpu
--    access_mode      : access mode from cpu
--                       11 => 32 bits access
--                       10 => 24 bits access
--                       01 => 16 bits access
--                       00 => 8 bits access
--    sign_ext         : extention mode from cpu
--                       0 => zero extention
--                       1 => sign extention
--    address          : address
--    data_out         : data output
--    addr_err         : address error

library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;

entity tb_dm_mifu is
    generic (
      INIT_DATA_FILE_NAME: string := "TestData.DM";
      DUMP_DATA_FILE_NAME: string := "TestData.OUT"
    );
    port (
      clk        : in  std_logic;
      finish     : in  std_logic;
      req        : in  std_logic;
      ack        : out std_logic;
      cancel     : in  std_logic;
      write_enb  : in  std_logic;
      data_in    : in  std_logic_vector(31 downto 0);
      access_mode: in  std_logic_vector(1 downto 0);
      sign_ext   : in  std_logic;
      address    : in  std_logic_vector(31 downto 0);
      data_out   : out std_logic_vector(31 downto 0);
      addr_err   : out std_logic
    );
end tb_dm_mifu;

architecture behavior of tb_dm_mifu is
  subtype Dtype is std_logic_vector(31 downto 0);
  type MEMtype is array (0 to 16383) of Dtype;

  file DMin: text open read_mode is INIT_DATA_FILE_NAME;
  file Tout: text open write_mode is DUMP_DATA_FILE_NAME;

  signal ack_out: std_logic;

begin  -- Architecture Body

  ack <= ack_out and not req;

  DMem : process
    variable addr : std_logic_vector(31 downto 0);
    variable datum : std_logic_vector(7 downto 0);
    variable data : Dtype;
    variable data_tmp : Dtype;
    variable access_mode_num : integer;
    variable lbuf : line;
    variable DM : MEMType;
    variable Tbuf : line;

    variable base_addr : integer;
    variable offset : integer;

    type state is (st0, st1, st2);
    variable dm_s : state := st0;

  begin
    for A in DM'range loop
      DM(A) := (others => '0');
    end loop;
    addr := (others => '0');
    while (not(endfile(DMin))) loop
      for i in 0 to 4 - 1 loop
        if(endfile(DMin)) then
          exit;
        end if;
        readline(DMin, lbuf);
        hread(lbuf, addr); -- 1st column in file is address
        hread(lbuf, datum); -- 2nd column in file is data
        data(32 - 8 * i - 1 downto 32 - 8 * (i + 1)) := datum;
      end loop;
      DM(conv_integer(addr(15 downto 2))) := data;
          -- byte address to word address
    end loop;

    addr_err <= '0';
    ack_out <= '0';
    loop
      wait on clk, finish;
      if clk'event and clk = '1' then
        case dm_s is
          when st0 =>
            ack_out <= not req;
            if req = '1' then
              dm_s := st1;
            end if;
  
          when st1 =>
            if cancel = '1' then
	      dm_s := st0;
            elsif req = '0' then
              ack_out <= '0';
  
              base_addr := conv_integer(address(15 downto 2));
              offset := conv_integer(address(2 - 1 downto 0));
              data := DM(base_addr);
              access_mode_num := conv_integer(access_mode);

              if(access_mode = "00") then 
                  data_tmp(31 downto 24) := data(7 downto 0);
                  data_tmp(23 downto 16) := data(15 downto 8);
                  data_tmp(15 downto 8) := data(23 downto 16);
                  data_tmp(7 downto 0) := data(31 downto 24);
              elsif(access_mode = "01") then
                  data_tmp(31 downto 16) := data(15 downto 0);
                  data_tmp(15 downto 0) := data(31 downto 16);
              elsif(access_mode = "10") then                   -- because it is not used by browstd32, not implemented correctly
                  data_tmp := data;
              elsif(access_mode = "11") then
                  data_tmp := data;
              end if;

              if conv_integer(access_mode) + conv_integer(address(2 - 1 downto 0)) >= 4 then
                addr_err <= '1';
                data_out <= (others => 'X');
              else
                addr_err <= '0';
                if write_enb = '0' then
                  for i in 4 - 1 downto 0 loop
                    if i > access_mode then
                      data_out((i + 1) * 8 - 1 downto i * 8)
                        <= (others => sign_ext and data_tmp(7 + offset * 8));
                    else
                      data_out((i + 1) * 8 - 1 downto i * 8)
                        <= data_tmp((i + 1 + offset) * 8 - 1 
                                 downto (i + offset) * 8);
                    end if;
                  end loop;
                else
                  data_out <= data_in;
                  for i in 4 - 1 downto 0 loop
                    if i <= access_mode then
                      data((i + 1 + (3-access_mode_num) - offset) * 8 - 1 downto (i + (3-access_mode_num) - offset) * 8)
                        := data_in((i + 1) * 8 - 1 downto i * 8);
                    end if;
                  end loop;

                  DM(base_addr) := data;
                end if;
              end if;

              dm_s := st2;
            end if;

          when st2 =>
            ack_out <= '1';
            if req = '0' then
              dm_s := st0;
            else
              dm_s := st1;
            end if;
        end case;
      end if;
  
      if finish'event and finish = '1' then
        for A in DM'range loop
--          if addr <= 0 or A * 4 <= addr then
            data := DM(A);
--            for i in 0 to 4 - 1 loop
              hwrite(Tbuf, conv_std_logic_vector(A * 4, 32), 
                           RIGHT, 8);
              hwrite(Tbuf, data, 
                           RIGHT, 9);
              writeline(Tout, Tbuf);
--            end loop;
--          end if;
        end loop;
        assert false report "Simulation End." severity failure; 
      end if;
    end loop;
  end process DMem;
end behavior;
