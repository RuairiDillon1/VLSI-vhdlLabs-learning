-------------------------------------------------------------------------------
-- Module     : t_cnt4up
-------------------------------------------------------------------------------
-- Author     :   <haf@fh-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2011   <haf@fh-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "cnt4up"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY t_cnt4up IS
END t_cnt4up;

ARCHITECTURE tbench OF t_cnt4up IS

  COMPONENT cnt4up
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(3 DOWNTO 0));
  END COMPONENT;

  -- definition of a clock period
  CONSTANT period : time    := 10 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

  -- component ports
  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);

BEGIN  -- tbench

  -- component instantiation
  DUT : cnt4up
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
       count_o => count_o);

  -- clock generation
  clock_proc : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk_i <= '0'; WAIT FOR period/2;
      clk_i <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- initial reset, always necessary at the beginning of a simulation
  reset : rst_ni <= '0', '1' AFTER period;

  stimuli_p : PROCESS

  BEGIN

    WAIT UNTIL rst_ni = '1';            -- wait until asynchronous reset ...
                                        -- ... is deactivated
    ---------------------------------------------------------------------------

 
    WAIT FOR 15 * period;               -- wait for at least one count cycle
    ASSERT count_o = X"F" REPORT "Error: Expected count_o = F !" SEVERITY failure;
    ---------------------------------------------------------------------------


    -- add another count cycle here ...

    

                                        -- wait for another count cycle

    
 
    clken_p <= false;                   -- switch clock generator off

    WAIT;                               -- suspend proces
  END PROCESS;
  
END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
