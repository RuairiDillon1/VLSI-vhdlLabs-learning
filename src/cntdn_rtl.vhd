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


BEGIN

  incrementer : 

  state_register : 

  counter_output : 

  terminal_output : 

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

