-------------------------------------------------------------------------------
-- Module     : cntdnmodm
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Modulo-m n-Bit Down-Counter
--              including a low-active asynchronous reset input rst_ni
--              and a high-active enable input en_pi
--              additionally, a high_active output signal tc_o is produced,
--              when the counter reaches it's minimum value
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cntdnmodm IS
  GENERIC (
    n : natural := 4;                   -- counter width
    m : natural := 10);                 -- modulo value
  PORT (clk_i   : IN  std_ulogic;
        rst_ni  : IN  std_ulogic;
        en_pi   : IN  std_ulogic;
        count_o : OUT std_ulogic_vector(n-1 DOWNTO 0);
        tc_o    : OUT std_ulogic
        );
END cntdnmodm;

ARCHITECTURE rtl OF cntdnmodm IS

  SIGNAL next_state, current_state : unsigned(n-1 DOWNTO 0);

BEGIN

  -- includes decrementer and modulo logic
  next_state_logic : next_state <= to_unsigned(m-1, n) WHEN current_state = 0 ELSE
                                        current_state - 1;
                                        
  state_register : current_state <= to_unsigned(m-1, n) when rst_ni = '0' else
                        next_state when rising_edge(clk_i) and en_pi = '1';

  counter_output : count_o <= std_ulogic_vector(current_state); 

  terminal_count : tc_o <= '1' when current_state = to_unsigned(0, n) else '0';

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

