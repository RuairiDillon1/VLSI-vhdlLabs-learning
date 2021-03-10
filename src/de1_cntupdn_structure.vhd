-------------------------------------------------------------------------------
-- Module     : de1_cntupdn
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module cntupdn on a DE1 prototype board
--              connecting device under test (DUT) cntupdn
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_cntupdn IS
  PORT (
    CLOCK_50 : IN  std_ulogic;                     -- 50 MHz Clock
    KEY      : IN  std_ulogic_vector(2 DOWNTO 0);  -- KEY[1:0]
                                                   -- KEY[0] = rst_ni
                                                   -- KEY[1] = en_pi
                                                   -- KEY[1] = mode_i
    GPO_1    : OUT std_ulogic_vector(5 DOWNTO 0)   -- Output Connector GPIO_1
                                                   -- GPO_1[3:0] = count_o
                                                   -- GPO_1[4] = mode_i
                                                   -- GPO_1[5] = clk_i
    );
END de1_cntupdn;

ARCHITECTURE structure OF de1_cntupdn IS

  COMPONENT cntupdn IS
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      mode_i  : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(3 DOWNTO 0));
  END COMPONENT cntupdn;
  
  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL mode_i  : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);
  
BEGIN

  -- connecting clock generator master clock of synchronous system

  
  -- connecting asynchronous system reset to digital system

  
  -- count enable input is high-active, KEY(1) ist low-aktive, therefore ...


  -- count direction controller by mode_i, connected to KEY(2)


  -- connecting device under test with peripheral elements

  
  -- connecting count value to GPIO1


  
END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
