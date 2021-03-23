-------------------------------------------------------------------------------
-- Module     : t_add1
-------------------------------------------------------------------------------
-- Author     :   <haf@fh-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2011   <haf@fh-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "add1"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-------------------------------------------------------------------------------

ENTITY t_add1 IS
END t_add1;

-------------------------------------------------------------------------------

ARCHITECTURE tbench OF t_add1 IS

  COMPONENT add1
    PORT (
      a_i   : IN  std_ulogic;
      b_i   : IN  std_ulogic;
      ci_i  : IN  std_ulogic;
      sum_o : OUT std_ulogic;
      co_o  : OUT std_ulogic);
  END COMPONENT;

  -- definition of a clock period
  CONSTANT period : time := 10 ns;


  -- component ports
  SIGNAL a_i   : std_ulogic;
  SIGNAL b_i   : std_ulogic;
  SIGNAL ci_i  : std_ulogic;
  SIGNAL sum_o : std_ulogic;
  SIGNAL co_o  : std_ulogic;

BEGIN  -- tbench

  -- component instantiation
  MUV : add1
    PORT MAP (
      a_i   => a_i,
      b_i   => b_i,
      ci_i  => ci_i,
      sum_o => sum_o,
      co_o  => co_o);

  
  stimuli_p : PROCESS
 
  BEGIN
    -- Test case: 000
    ci_i <= '0';                        -- set a value to input ci_i 
    b_i  <= '0';                        -- set a value to input b_i 
    a_i  <= '0';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- Test case: 001
    a_i <= '1';                         -- change value of a_i
    WAIT FOR period;
    -- Observer:
    ASSERT sum_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: co is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- Test case: 010
    b_i <= '1';                         -- change value of b_i
    a_i <= '0';                         -- change value of a_i
    WAIT FOR period;
    -- Observer:
    ASSERT sum_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: co is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- fill in the missing stimuli here
    -- ...
    -- Test case: 011

    a_i  <= '1';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- Test case: 100
    ci_i <= '1';                        -- set a value to input ci_i 
    b_i  <= '0';                        -- set a value to input b_i 
    a_i  <= '0';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- Test case: 101

    a_i  <= '1';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------
   
 -- Test case: 110

    b_i  <= '1';                        -- set a value to input b_i 
    a_i  <= '0';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '0' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------

    -- Test case: 111 
    a_i  <= '1';                        -- set a value to input a_i 
    WAIT FOR period;                    -- values are assigned here
    -- Observer:
    ASSERT sum_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '1' REPORT "Error: sum is not correct !" SEVERITY failure;
    ---------------------------------------------------------------------------


    WAIT;
  END PROCESS;

END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
