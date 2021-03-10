-------------------------------------------------------------------------------
-- Module     : add4
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-bit adder
--              function modelled by '+'-operator
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ARCHITECTURE rtl OF add4 IS

  SIGNAL temp_sum : unsigned(4 DOWNTO 0);

BEGIN

  -- VHDL-2008 standard allows this elegant one line solution:
  -----------------------------------------------------------------------------
  -- Quartus version 13.0 is not able to synthesise it :-(
  -- (co_o,sum_o) <= ('0' & unsigned(a_i)) + unsigned(b_i) + unsigned'(0 => ci_i);

  
  -- This version can be used with most simulators and synthesisers:
  -----------------------------------------------------------------------------
  temp_sum <= ('0' & unsigned(a_i)) + unsigned(b_i) + unsigned'(0 => ci_i);

  sum_o <= std_ulogic_vector(temp_sum(3 DOWNTO 0));

  co_o <= temp_sum(4);

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

