-------------------------------------------------------------------------------
-- Module     : add1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 1-bit adder
--              function modelled as a truth table
--              using a selected signal assignment
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY add1 IS
  PORT (a_i   : IN  std_ulogic;         -- operand a
        b_i   : IN  std_ulogic;         -- operand b
        ci_i  : IN  std_ulogic;         -- carry in
        sum_o : OUT std_ulogic;         -- sum
        co_o  : OUT std_ulogic          -- carry out
        );
END add1;

ARCHITECTURE truthtable OF add1 IS

  SIGNAL inputs_s  : std_ulogic_vector(2 DOWNTO 0);  -- temp input signal
  SIGNAL outputs_s : std_ulogic_vector(1 DOWNTO 0);  -- temp output signal

BEGIN

  inputs_s <= (ci_i, b_i, a_i);  -- concatenate single signals to a vector

  tt : WITH inputs_s SELECT      -- truthtable
    outputs_s <=
    "00" WHEN "000",
    "10" WHEN "001",
    -- fill in the missing lines here
    -- ...
    "XX" WHEN OTHERS;

  sum_o <= outputs_s(1);         -- split vector elements ...
  co_o  <= outputs_s(0);         -- ... to individual signals

END truthtable;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

