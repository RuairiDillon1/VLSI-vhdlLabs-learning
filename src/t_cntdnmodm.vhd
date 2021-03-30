-------------------------------------------------------------------------------
-- Module     : t_cntdnmodm
-------------------------------------------------------------------------------
-- Author     :   <johann.faerber@hs-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2013   <johann.faerber@hs-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "cntdnmodm"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY t_cntdnmodm IS
END t_cntdnmodm;

ARCHITECTURE tbench OF t_cntdnmodm IS

  COMPONENT cntdnmodm
    GENERIC (
      n : natural;
      m : natural);
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(n-1 DOWNTO 0);
      tc_o    : OUT std_ulogic);
  END COMPONENT;

  -- component generics
  CONSTANT n : natural := 4;
  CONSTANT m : natural := 10;

  -- component ports
  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(n-1 DOWNTO 0);
  SIGNAL tc_o    : std_ulogic;

  SIGNAL count_mod6_o : std_ulogic_vector(2 DOWNTO 0);
  SIGNAL tc_mod6_o    : std_ulogic;

  SIGNAL count_mod500e3_o : std_ulogic_vector(18 DOWNTO 0);
  SIGNAL tc_100hz_o    : std_ulogic;


  -- definition of a clock period
  CONSTANT period : time    := 20 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

BEGIN  -- tbench

  -- component instantiation
  MUV : cntdnmodm
    GENERIC MAP (
      n => n,
      m => m)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => count_o,
      tc_o    => tc_o);

  mod6_count : cntdnmodm
    GENERIC MAP (
      n => 3,
      m => 6)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => count_mod6_o,
      tc_o    => tc_mod6_o);

  -- instantiate and parameterise the generics to
  -- create a frequency of 100 Hz at its output signal tc_100hz_o
  -- declare the necessary signals count_modxxx_o and  tc_100hz_o
  -----------------------------------------------------------------------------
    prescaler : cntdnmodm
    GENERIC MAP (
     n => 19,
     m => 500e3)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      count_o => count_mod500e3_o,
      tc_o    => tc_100hz_o);

  -----------------------------------------------------------------------------


  -- clock generation
  clock_p : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk_i <= '0'; WAIT FOR period/2;
      clk_i <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- initial reset
  reset : rst_ni <= '1', '0' AFTER period,
                    '1' AFTER 2 * period;

  -- process for stimuli generation
  stimuli_p : PROCESS

  BEGIN

    WAIT UNTIL rising_edge(rst_ni);     -- wait for reset

    en_pi <= '1';                       -- activate counter


    -- wait for a period of tc_o ----------------------------------------------
    WAIT UNTIL rising_edge(tc_o);
    WAIT UNTIL falling_edge(tc_o);

    WAIT UNTIL count_o = X"5";

    en_pi <= '0';                       -- stop counter ...
    WAIT FOR 3* period;                 -- ... for 3 periods

    en_pi <= '1';                       -- activate counter

    -- wait for a period of tc_mod6_o -----------------------------------------
    WAIT UNTIL rising_edge(tc_mod6_o);
    WAIT UNTIL falling_edge(tc_mod6_o);
    ---------------------------------------------------------------------------

    
    -- wait for a period of tc_100hz_o ----------------------------------------
    wait until rising_edge(tc_100hz_o);
    wait until falling_edge(tc_100hz_o);

    ---------------------------------------------------------------------------


    -- wait for a period of tc_100hz_o ----------------------------------------
    wait until rising_edge(tc_100hz_o);
    wait until falling_edge(tc_100hz_o);

    ---------------------------------------------------------------------------
    

    clken_p <= false;                   -- switch clock generator off

    WAIT;
  END PROCESS;



END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
