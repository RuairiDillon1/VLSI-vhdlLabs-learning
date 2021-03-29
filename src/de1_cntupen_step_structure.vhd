-------------------------------------------------------------------------------
-- Module     : de1_cntupen_step
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module cntupen on a DE1 prototype board
--              connecting device under test (DUT) cntupen
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_cntupen_step IS
  PORT (
    CLOCK_50 : IN  std_ulogic;                     -- 50 MHz Clock
    KEY      : IN  std_ulogic_vector(1 DOWNTO 0);  -- KEY[1:0]
    HEX0     : OUT std_ulogic_vector(6 DOWNTO 0)   -- Seven Segment Digit 0
    );
END de1_cntupen_step;

ARCHITECTURE structure OF de1_cntupen_step IS

  COMPONENT binto7segment
    PORT (
      bin_i      : IN  std_ulogic_vector(3 DOWNTO 0);
      segments_o : OUT std_ulogic_vector(6 DOWNTO 0));
  END COMPONENT;

  COMPONENT falling_edge_detector
    PORT (
      clk_i  : IN  std_ulogic;
      rst_ni : IN  std_ulogic;
      x_i    : IN  std_ulogic;
      fall_o : OUT std_ulogic);
  END COMPONENT;

  COMPONENT cntupen
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(3 DOWNTO 0));
  END COMPONENT;

  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);

  SIGNAL long_pulse : std_ulogic;

BEGIN

  -- connecting clock generator master clock of synchronous system
  clk_i <= CLOCK_50;

  -- connecting asynchronous system reset to digital system
  rst_ni <= KEY(0);

  -- KEY(1) ist low-active
  long_pulse <= KEY(1);

  -- enable signal en_pi has to be connected via a falling edge detector
  single_pulse_generator : ENTITY work.falling_edge_detector(rtl)
    PORT MAP (
        clk_i  => clk_i,
        rst_ni => rst_ni,
        x_i    => long_pulse,
        fall_o => en_pi 
    );
      
  -- connecting device under test with peripheral elements
  DUT : ENTITY work.cntupen(rtl)
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni, 
      en_pi  => en_pi, 
      count_o => count_o 
    );
      
  -- connecting count value to HEX display
  count_value : ENTITY work.binto7segment(truthtable)
    PORT MAP (
      bin_i      => count_o, 
      segments_o => HEX0
    );
      
END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
