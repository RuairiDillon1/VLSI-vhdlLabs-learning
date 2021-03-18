-------------------------------------------------------------------------------
-- Module     : de1_binto7segment
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module binto7segment on a DE1 prototype board
--              connecting device under test (DUT) binto7segment
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_binto7segment IS
  PORT (
    SW        : IN    std_ulogic_vector(3 DOWNTO 0);  -- Toggle Switch[3:0]
    LEDR      : OUT   std_ulogic_vector(3 DOWNTO 0);  -- LED Red[3:0]  
    HEX0      : OUT   std_ulogic_vector(6 DOWNTO 0)   -- Seven Segment Digit 0 
    );
END de1_binto7segment;

ARCHITECTURE structure OF de1_binto7segment IS
  
  COMPONENT binto7segment
    PORT (
      bin_i      : IN  std_ulogic_vector(3 DOWNTO 0);
      segments_o : OUT std_ulogic_vector(6 DOWNTO 0));
  END COMPONENT;

BEGIN

  -- connecting device under test with peripheral elements
  DUT : binto7segment
    PORT MAP (
      bin_i      => SW,
      segments_o => HEX0);

  -- connect switches to red LEDs
  LEDR <= SW;

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
