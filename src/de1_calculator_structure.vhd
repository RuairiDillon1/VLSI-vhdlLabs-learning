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
    LEDR : OUT std_ulogic_vector(8 DOWNTO 0);  -- LED Red[7:0]
    HEX0 : OUT std_ulogic_vector(6 DOWNTO 0)   -- Seven Segment Digit 0
    );
END de1_calculator;

ARCHITECTURE structure OF de1_calculator IS

  COMPONENT binto7segment
    PORT (
      bin_i      : IN  std_ulogic_vector(3 DOWNTO 0);
      segments_o : OUT std_ulogic_vector(6 DOWNTO 0));
  END COMPONENT;

  COMPONENT twosc2sm
 
   PORT (
   operand_i : IN std_ulogic_vector(3 DOWNTO 0);
   operand_u : OUT std_ulogic_vector(3 DOWNTO 0));

  END COMPONENT;

  SIGNAL a    : signed(3 DOWNTO 0);
  SIGNAL b    : signed(3 DOWNTO 0);
  SIGNAL sum  : signed(3 DOWNTO 0);
  SIGNAL disp : std_ulogic_vector(3 DOWNTO 0);

BEGIN

  -- connecting switches to operands
  -- ...

  -- add the operands

  -- ...

  -- connecting operands to LEDs
  LEDR(3 DOWNTO 0) <= SW(3 DOWNTO 0);
  -- LEDR(3)          <= '0';
  LEDR(7 DOWNTO 4) <= SW(7 DOWNTO 4);
  -- LEDR(7)          <= '0';
  LEDR(8) <= disp(3);

  a <= signed(SW(3 DOWNTO 0));
  b <= signed(SW(7 DOWNTO 4));

  sum <= a + b;


  conversion_1 : twosc2sm
    PORT MAP (

   operand_i => std_ulogic_vector(sum),
   operand_u => disp

	);
  -- display result on HEX0
  result_sum : binto7segment
    PORT MAP (
      bin_i      => std_ulogic_vector('0' & disp(2 downto 0)),
      --bin_i     => std_ulogic_vector(sum),
      segments_o => HEX0);

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
