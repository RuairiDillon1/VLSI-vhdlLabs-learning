-------------------------------------------------------------------------------
-- Module     : de1_cntdnmodm
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: test the module cntdnmodm on a DE1 prototype board
--              connecting device under test (DUT) cntdnmodm
--              to input/output signals of the DE1 prototype board
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY de1_cntdnmodm IS
  PORT (
    CLOCK_50 : IN  std_ulogic;                     -- 50 MHz Clock
    KEY      : IN  std_ulogic_vector(1 DOWNTO 0);  -- KEY[1:0]
                                                   -- KEY[0] = rst_ni
                                                   -- KEY[1] = en_pi
    GPO_1    : OUT std_ulogic_vector(7 DOWNTO 0)   -- Output Connector GPIO_1
                                                   -- GPO_1[3:0] = count_o
                                                   -- GPO_1[4] = tc_o
                                                   -- GPO_1[5] = clk_i
                                                   -- GPO_1[6] = tc_mod6_o
                                                   -- GPO_1[7] = tc_100hz_o
    );
END de1_cntdnmodm;

ARCHITECTURE structure OF de1_cntdnmodm IS

  COMPONENT cntdn
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(3 DOWNTO 0);
      tc_o    : OUT std_ulogic);
  END COMPONENT;

  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL tc_o    : std_ulogic;

  SIGNAL tc_mod6_o    : std_ulogic;
  SIGNAL tc_100hz_o    : std_ulogic;

BEGIN

  -- connecting clock generator master clock of synchronous system
  clk_i    <= CLOCK_50;
  GPO_1(5) <= clk_i;                    -- to measure clk signal

  -- connecting asynchronous system reset to digital system
  rst_ni <= KEY(0);

  -- count enable input is high-active, KEY(1) ist low-aktive, therefore ...
  -- ... if KEY1 is released, high signal is produced
  en_pi <= KEY(1);


  -- connecting device under test with peripheral elements
  DUT : ENTITY work.cntdnmodm
    GENERIC MAP (
      n => 4,
      m => 10)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => count_o,
      tc_o    => tc_o);
  
  -- 3-bit modulo-6 down counter
  mod6_count : ENTITY work.cntdnmodm
    GENERIC MAP (
      n => 3,
      m => 6)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => OPEN,
      tc_o    => tc_mod6_o);
  
  -- instantiate and parameterise the generics to
  -- create a frequency of 100 Hz at its output signal tc_100hz_o
  -- declare the necessary signals count_modxxx_o and  tc_100hz_o
  -----------------------------------------------------------------------------
    prescaler : entity work.cntdnmodm
    GENERIC MAP (
     n => 19,
     m => 500e3)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => open,
      tc_o    => tc_100hz_o);
  -----------------------------------------------------------------------------
  
  -- connecting count value to GPIO1
  GPO_1(3 DOWNTO 0) <= count_o;
  GPO_1(4)          <= tc_o;
  GPO_1(6)          <= tc_mod6_o;
  GPO_1(7)          <= tc_100hz_o;
  
END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
