-------------------------------------------------------------------------------
-- Module     : mux4to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-to-1 multiplexer
--              function modelled as structure of basic logic gates
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ARCHITECTURE structure OF mux4to1 IS

  COMPONENT mux2to1
    PORT (
      a_i   : IN  std_ulogic;
      b_i   : IN  std_ulogic;
      sel_i : IN  std_ulogic;
      y_o   : OUT std_ulogic);
  END COMPONENT;

  SIGNAL wire0, wire1 : std_ulogic;
  
BEGIN

  mux2to1_0 : mux2to1
    PORT MAP (

  mux2to1_1 : mux2to1

  
  mux2to1_2 :

  
END structure;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

