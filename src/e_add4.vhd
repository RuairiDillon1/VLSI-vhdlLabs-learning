-------------------------------------------------------------------------------
-- Module     : add4
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-bit adder
--              entity declaration
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY add4 IS
  PORT (a_i   : IN  std_ulogic_vector(3 DOWNTO 0);  -- operand a
        b_i   : IN  std_ulogic_vector(3 DOWNTO 0);  -- operand b
        ci_i  : IN  std_ulogic;                     -- carry in
        sum_o : OUT std_ulogic_vector(3 DOWNTO 0);  -- sum
        co_o  : OUT std_ulogic                      -- carry out
        );
END add4;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
