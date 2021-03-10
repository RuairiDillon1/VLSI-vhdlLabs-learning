-------------------------------------------------------------------------------
-- Module     : mux2to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-to-1 multiplexer
--              function modelled by a conditional signal assignment
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

ARCHITECTURE rtl OF mux2to1 IS

BEGIN

  y_o <= a_i WHEN sel_i = '1' ELSE
         b_i WHEN sel_i = '0' ELSE
         'X';

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

