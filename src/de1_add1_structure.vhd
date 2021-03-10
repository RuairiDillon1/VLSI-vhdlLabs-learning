-------------------------------------------------------------------------------
-- Module     : de1_add1
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

ENTITY de1_add1 IS
  PORT (
    SW   : IN  std_ulogic_vector(2 DOWNTO 0);  -- Toggle Switch[2:0]
    LEDR : OUT std_ulogic_vector(1 DOWNTO 0)   -- LED Red[1:0]  
    );
END de1_add1;

ARCHITECTURE structure OF de1_add1 IS

  COMPONENT add1
    PORT (
      a_i   : IN  std_ulogic;
      b_i   : IN  std_ulogic;
      ci_i  : IN  std_ulogic;
      sum_o : OUT std_ulogic;
      co_o  : OUT std_ulogic);
  END COMPONENT;

BEGIN

  -- connecting device under test with peripheral elements
  DUT : add1
    PORT MAP (
      a_i   => SW(0),
      b_i   => SW(1),
      ci_i  => SW(2),
      sum_o => LEDR(0),
      co_o  => LEDR(1)
      );

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
