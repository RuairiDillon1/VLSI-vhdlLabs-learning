-------------------------------------------------------------------------------
-- Module     : mux2to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-to-1 multiplexer
--              function modelled by boolean equation
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

ARCHITECTURE equation OF mux2to1 IS

BEGIN

  y_o <= (sel_i AND a_i) OR (NOT sel_i AND b_i);

END equation;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

