-------------------------------------------------------------------------------
-- Module     : de1_add4
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module add4 on a DE1 prototype board
--              connecting device under test (DUT) add4
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_add4 IS
  PORT (
    SW   : IN  std_ulogic_vector(8 DOWNTO 0);  -- Toggle Switch[8:0]
    LEDR : OUT std_ulogic_vector(8 DOWNTO 0);  -- LED Red[8:0]
    LEDG : OUT std_ulogic_vector(4 DOWNTO 0);  -- LED Green[3:0]
    HEX0 : OUT std_ulogic_vector(6 DOWNTO 0);  -- Seven Segment Digit 0
    HEX1 : OUT std_ulogic_vector(6 DOWNTO 0);  -- Seven Segment Digit 1
    HEX2 : OUT std_ulogic_vector(6 DOWNTO 0);  -- Seven Segment Digit 2

    -- Ports for measurement of longest path through module
    CLOCK_50 : IN  std_ulogic;                    -- 50 MHz Clock
    GPO_1    : OUT std_ulogic_vector(1 DOWNTO 0)  -- Output Connector GPIO_1
                                                  -- GPO_1[0] = CLOCK_50
                                                  -- GPO_1[1] = co_o

    );
END de1_add4;

ARCHITECTURE structure OF de1_add4 IS

  COMPONENT binto7segment
    PORT (
      bin_i      : IN  std_ulogic_vector(3 DOWNTO 0);
      segments_o : OUT std_ulogic_vector(6 DOWNTO 0));
  END COMPONENT;

  COMPONENT add4
    PORT (
      a_i   : IN  std_ulogic_vector(3 DOWNTO 0);
      b_i   : IN  std_ulogic_vector(3 DOWNTO 0);
      ci_i  : IN  std_ulogic;
      sum_o : OUT std_ulogic_vector(3 DOWNTO 0);
      co_o  : OUT std_ulogic);
  END COMPONENT;

  SIGNAL a   : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL b   : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL ci  : std_ulogic;
  SIGNAL sum : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL co  : std_ulogic;

BEGIN

  -- Modifications for measurement of longest path through module
  GPO_1(0) <= CLOCK_50;
  GPO_1(1) <= co;
  -- use the following line for Tpd measurement
  -- ci <= CLOCK_50;                     -- tpd of add4 module only
  
  -- connecting switches to operands
  ci <= SW(0);                      -- use this line, if connected by SW(0)
  a <= SW(4 DOWNTO 1);
  b <= SW(8 DOWNTO 5);

  -- connecting operands to LEDs
  LEDR(0)          <= SW(0);
  LEDR(4 DOWNTO 1) <= SW(4 DOWNTO 1);
  LEDR(8 DOWNTO 5) <= SW(8 DOWNTO 5);

  -- connecting device under test with peripheral elements
  DUT : add4
    PORT MAP (
      a_i   => a,
      b_i   => b,
      ci_i  => ci,
      sum_o => sum,
      co_o  => co);

  -- connecting results to LEDs and HEX displays
  LEDG(3 DOWNTO 0) <= sum;
  LEDG(4)          <= co;

  operand_a : binto7segment
    PORT MAP (
      bin_i      => a,
      segments_o => HEX0);

  operand_b : binto7segment
    PORT MAP (
      bin_i      => b,
      segments_o => HEX1);
      
  operand_c : binto7segment
    PORT MAP (
      bin_i      => sum,
      segments_o => HEX2);

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
