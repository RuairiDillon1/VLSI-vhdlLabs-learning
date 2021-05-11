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
begin
  count_val <= to_unsigned(0, count_val'length) when rst_n = '0' else next_count_val when rising_edge(clk);
  next_count_val <= (count_val + 1) mod to_unsigned(50000000, count_val'length);
  onesec_o <= '1' when count_val = to_unsigned(0, count_val'length) else '0'; 
end architecture rtl;
