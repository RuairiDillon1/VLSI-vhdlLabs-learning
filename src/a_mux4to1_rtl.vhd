-------------------------------------------------------------------------------
-- Module     : mux4to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-to-1 multiplexer
--              function modeled using a selected signal assignement
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ARCHITECTURE rtl OF mux4to1 IS

BEGIN

  mux4to1_selected : WITH sel_i SELECT
    y_o <=
    i0_i WHEN "00",
    i1_i WHEN "01",
    i2_i WHEN "10",
    i3_i WHEN "11",
    'X' WHEN OTHERS;

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

