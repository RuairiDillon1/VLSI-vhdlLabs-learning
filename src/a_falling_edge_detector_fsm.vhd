library IEEE;
use IEEE.std_logic_1164.all;

architecture fsm of falling_edge_detector is
  signal q0,q1 : std_ulogic;
begin

  q0 <= '1' when rst_ni = '0' else x_i when rising_edge(clk_i);
  q1 <= '1' when rst_ni = '0' else q0 when rising_edge(clk_i);
  fall_o <= '1' when q1 = '1' and q0 = '0' else '0';

end architecture;
