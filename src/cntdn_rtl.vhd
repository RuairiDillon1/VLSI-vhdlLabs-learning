-------------------------------------------------------------------------------
-- Module     : cntdn
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Down-Counter
--              including a low-active asynchronous reset input rst_ni
--              a high-active enable input en_pi
--              and a terminal count output: tc = 1 when count = 0
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cntdn IS
  PORT (clk_i   : IN  std_ulogic;
        rst_ni  : IN  std_ulogic;
        en_pi   : IN  std_ulogic;
        count_o : OUT std_ulogic_vector(3 DOWNTO 0);
        tc_o    : OUT std_ulogic
        );
END cntdn;

ARCHITECTURE rtl OF cntdn IS

    signal state_n, state_c : unsigned(3 downto 0);

BEGIN

  incrementer :  state_n <= state_c - 1;

  state_register : state_c <= "0000" when rst_ni = '0' else state_n when 
                      rising_edge(clk_i) and en_pi = '1';

  counter_output : count_o <= std_ulogic_vector(state_c);

  --terminal_output : tc_o <= '1' when state_c = "0000" else '0';
  terminal_output : tc_o <= not (state_c(3) or state_c(2) or state_c(1) or state_c(0));

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

