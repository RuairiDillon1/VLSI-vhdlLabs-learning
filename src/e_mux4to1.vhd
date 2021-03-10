-------------------------------------------------------------------------------
-- Module     : mux4to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-to-1 multiplexer
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux4to1 IS
  PORT (i0_i  : IN  std_ulogic;         -- data input 0
        i1_i  : IN  std_ulogic;         -- data input 1
        i2_i  : IN  std_ulogic;         -- data input 2
        i3_i  : IN  std_ulogic;         -- data input 3
        sel_i : IN  std_ulogic_vector(1 DOWNTO 0);
        -- select which input is connected to y:
        -- sel = "00": i0 -> y
        -- sel = "01": i1 -> y
        -- sel = "10": i2 -> y
        -- sel = "11": i3 -> y
        y_o   : OUT std_ulogic          -- data output y
        );
END mux4to1;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

