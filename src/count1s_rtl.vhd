library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity count1s is
port ( clk    : in      std_ulogic;
       rst_n  : in      std_ulogic;
       onesec_o : out     std_ulogic);
end entity;

architecture rtl of count1s is
 signal count_val, next_count_val : unsigned(32 downto 0); 
 -- count 1s (value for implementation)
 constant loading_val : integer := 50000000;  
 -- count 1us (value for simulation) 
 --constant loading_val : integer := 50;  
begin
  count_val <= to_unsigned(loading_val - 1, count_val'length) when rst_n = '0' 
               else next_count_val when rising_edge(clk);
  next_count_val <= to_unsigned(loading_val -1, count_val'length) when count_val = 0 
                    else (count_val - 1);
  onesec_o <= '1' when count_val = to_unsigned(0, count_val'length) else '0'; 
end architecture rtl;
