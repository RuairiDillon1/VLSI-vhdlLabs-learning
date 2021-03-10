-------------------------------------------------------------------------------
-- Module     : de1_mux4to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module mux4to1 on a DE1 prototype board
--              connecting device under test (DUT) mux4to1
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_mux4to1 IS
  PORT (
    SW   : IN  std_ulogic_vector(5 DOWNTO 0);  -- Toggle Switch[5:0]
    LEDR : OUT std_ulogic                      -- LED Red[0]  
    );
END de1_mux4to1;

ARCHITECTURE structure OF de1_mux4to1 IS

  -- component under test
  COMPONENT mux4to1 IS
    PORT (
      i0_i  : IN  std_ulogic;
      i1_i  : IN  std_ulogic;
      i2_i  : IN  std_ulogic;
      i3_i  : IN  std_ulogic;
      sel_i : IN  std_ulogic_vector(1 DOWNTO 0);
      y_o   : OUT std_ulogic);
  END COMPONENT mux4to1;
  
  -- wires connecting the module
  SIGNAL i0_i  : std_ulogic;
  SIGNAL i1_i  : std_ulogic;
  SIGNAL i2_i  : std_ulogic;
  SIGNAL i3_i  : std_ulogic;
  SIGNAL sel_i : std_ulogic_vector(1 DOWNTO 0);
  SIGNAL y_o   : std_ulogic;
  
BEGIN

  -- connecting switches to inputs
  i0_i  <= SW(0);
  i1_i  <= SW(1);
  i2_i  <= SW(2);
  i3_i  <= SW(3);
  sel_i <= SW(5 DOWNTO 4);
  
  -- connecting device under test with peripheral elements
  DUT : ENTITY work.mux4to1
      PORT MAP (
        i0_i  => i0_i,
        i1_i  => i1_i,
        i2_i  => i2_i,
        i3_i  => i3_i,
        sel_i => sel_i,
        y_o   => y_o);
  
  -- connecting results to LEDs
  LEDR <= y_o;

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
