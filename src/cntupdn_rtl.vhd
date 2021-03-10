-------------------------------------------------------------------------------
-- Module     : cntupdn
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Up/Down-Counter
--              including a low-active asynchronous reset input rst_ni
--              a high-active enable input en_pi
--              mode_i = 0 -> count down
--              mode_i = 1 -> count up
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cntupdn IS
  PORT (clk_i   : IN  std_ulogic;
        rst_ni  : IN  std_ulogic;
        en_pi   : IN  std_ulogic;
        mode_i  : IN  std_ulogic; -- mode_i = 0 -> count down
                                  -- mode_i = 1 -> count up
        count_o : OUT std_ulogic_vector(3 DOWNTO 0)
        );
END cntupdn;

ARCHITECTURE rtl OF cntupdn IS


BEGIN

  de_incrementer :

  state_register : 

  counter_output : 

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

