-------------------------------------------------------------------------------
-- Module     : de1_calculator
-------------------------------------------------------------------------------
-- Author     : Matthias Kamuf
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Basic calculator for a DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY de1_calculator IS
  PORT (
    SW   : IN  std_ulogic_vector(7 DOWNTO 0);  -- Toggle Switch[7:0]
    LEDR : OUT std_ulogic_vector(7 DOWNTO 0);  -- LED Red[7:0]
    HEX0 : OUT std_ulogic_vector(6 DOWNTO 0)   -- Seven Segment Digit 0
    );
END de1_calculator;

ARCHITECTURE structure OF de1_calculator IS

  COMPONENT binto7segment
    PORT (
      bin_i      : IN  std_ulogic_vector(3 DOWNTO 0);
      segments_o : OUT std_ulogic_vector(6 DOWNTO 0));
  END COMPONENT;

  SIGNAL a   : unsigned(2 DOWNTO 0);
  SIGNAL b   : unsigned(2 DOWNTO 0);
  SIGNAL sum : unsigned(3 DOWNTO 0);

BEGIN

  -- connecting switches to operands
  -- ...

  -- add the operands
  -- ...

  -- connecting operands to LEDs
  LEDR(2 DOWNTO 0) <= SW(2 DOWNTO 0);
  LEDR(3)          <= '0';
  LEDR(6 DOWNTO 4) <= SW(6 DOWNTO 4);
  LEDR(7)          <= '0';

  a <= unsigned(SW(2 DOWNTO 0));
  b <= unsigned(SW(6 DOWNTO 4));

  sum <= (a + b);
  -- display result on HEX0
  result_sum : binto7segment
    PORT MAP (
      bin_i      => std_ulogic_vector(sum),
      segments_o => HEX0);

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
