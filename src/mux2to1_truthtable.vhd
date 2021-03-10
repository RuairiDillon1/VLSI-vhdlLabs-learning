-------------------------------------------------------------------------------
-- Module     : mux2to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-to-1 multiplexer
--              function modelled by a truth table
--              sel = '1': a -> y
--              sel = '0': b -> y
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2to1 IS
  PORT (a_i   : IN  std_ulogic;       -- data input a
        b_i   : IN  std_ulogic;       -- data input b
        sel_i : IN  std_ulogic;       -- select which input is connected to y
                                      -- sel = '1': a -> y
                                      -- sel = '0': b -> y
        y_o   : OUT std_ulogic        -- data output y
        );
END mux2to1;

ARCHITECTURE truthtable OF mux2to1 IS

  SIGNAL inputs_s : std_ulogic_vector(2 DOWNTO 0);  -- temp input vector
  
BEGIN
  
  inputs_s <= (sel_i, b_i, a_i); -- concatenate single signals to a vector
  
  tt : WITH inputs_s SELECT      -- truthtable 
    y_o <=
    '0' WHEN "000",
    '0' WHEN "001",
    '1' WHEN "010",
    '1' WHEN "011",
    '0' WHEN "100",
    '1' WHEN "101",
    '0' WHEN "110",
    '1' WHEN "111",
    'X' WHEN OTHERS;

END truthtable;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

