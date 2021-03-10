-------------------------------------------------------------------------------
-- Module     : t_cntupdn
-------------------------------------------------------------------------------
-- Author     : caeuser  <johann.faerber@hs-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2020 caeuser  <johann.faerber@hs-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "cntupdn"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY t_cntupdn IS
END ENTITY t_cntupdn;

ARCHITECTURE tbench OF t_cntupdn IS

  -- component ports
  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL mode_i  : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);


  -- definition of a clock period
  CONSTANT period : time    := 20 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

BEGIN  -- ARCHITECTURE tbench

  -- component instantiation
  MUV : ENTITY work.cntupdn
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
      mode_i  => mode_i,
      count_o => count_o);

  -- clock generation
  clock_p : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk_i <= '0'; WAIT FOR period/2;
      clk_i <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- initial reset, always necessary at the beginning OF a simulation
  reset : rst_ni <= '0', '1' AFTER period;

  -- process for stimuli generation
  stimuli_p : PROCESS

  BEGIN

    WAIT UNTIL rst_ni = '1';            -- wait until asynchronous reset ...
    -- ... is deactivated

    


    clken_p <= false;                   -- switch clock generator off

    WAIT;
  END PROCESS;



END ARCHITECTURE tbench;

-------------------------------------------------------------------------------
