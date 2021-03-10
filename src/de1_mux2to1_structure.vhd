-------------------------------------------------------------------------------
-- Module     : de1_mux2to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module add1 on a DE1 prototype board
--              connecting device under test (DUT) add1
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_mux2to1 IS
  PORT (
    SW   : IN  std_ulogic_vector(2 DOWNTO 0);  -- Toggle Switch[2:0]
    LEDR : OUT std_ulogic   -- LED Red[0]  
    );
END de1_mux2to1;

ARCHITECTURE structure OF de1_mux2to1 IS

  COMPONENT mux2to1
    PORT (
      a_i   : IN  std_ulogic;
      b_i   : IN  std_ulogic;
      sel_i : IN  std_ulogic;
      y_o   : OUT std_ulogic);
  END COMPONENT;

BEGIN

  -- connecting device under test with peripheral elements
  DUT : mux2to1
    PORT MAP (
      a_i   => SW(0),
      b_i   => SW(1),
      sel_i => SW(2),
      y_o   => LEDR);
  
END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
