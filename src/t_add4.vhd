-------------------------------------------------------------------------------
-- Module     : t_add4
-------------------------------------------------------------------------------
-- Author     :   <haf@fh-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2011   <haf@fh-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "add4"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-------------------------------------------------------------------------------

ENTITY t_add4 IS
END t_add4;

-------------------------------------------------------------------------------

ARCHITECTURE tbench OF t_add4 IS

  COMPONENT add4
    PORT (
      a_i   : IN  std_ulogic_vector(3 DOWNTO 0);
      b_i   : IN  std_ulogic_vector(3 DOWNTO 0);
      ci_i  : IN  std_ulogic;
      sum_o : OUT std_ulogic_vector(3 DOWNTO 0);
      co_o  : OUT std_ulogic);
  END COMPONENT;

  -- definition of a clock period
  CONSTANT period : time := 10 ns;

  -- component ports
  SIGNAL a_i   : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL b_i   : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL ci_i  : std_ulogic;
  SIGNAL sum_o : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL co_o  : std_ulogic;
  SIGNAL sum_ref : std_ulogic_vector(3 DOWNTO 0);
  SIGNAL co_ref  : std_ulogic;

BEGIN  -- tbench

  -- component instantiation
  MUV : ENTITY work.add4(structure)
    PORT MAP (
      a_i   => a_i,
      b_i   => b_i,
      ci_i  => ci_i,
      sum_o => sum_o,
      co_o  => co_o);

  REF : ENTITY work.add4(rtl)
    PORT MAP (
      a_i   => a_i,
      b_i   => b_i,
      ci_i  => ci_i,
      sum_o => sum_ref,
      co_o  => co_ref);

  stimuli_p : PROCESS

    -- purpose: apply stimuli to input signals of module under test
    PROCEDURE apply_stimuli (
      CONSTANT ci_stim        : IN std_ulogic;
      CONSTANT b_stim, a_stim : IN std_ulogic_vector) IS
    BEGIN  -- apply_stimuli
      a_i  <= a_stim;
      b_i  <= b_stim;
      ci_i <= ci_stim;
      WAIT FOR period;
      ASSERT sum_o = sum_ref REPORT "Error: sum is not correct !" SEVERITY failure;
      ASSERT co_o = co_ref REPORT "Error: co is not correct !" SEVERITY failure;
    END PROCEDURE apply_stimuli;
  
  BEGIN
    a_i  <= X"0";            -- set a value to input a_i as hexadecimal value
    b_i  <= B"0000";         -- set a value to input b_i as binary vector value
    ci_i <= '0';             -- set a value to input ci_i as a 1-bit value
    WAIT FOR period;         -- values are assigned here
    ASSERT sum_o = X"0" REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: co is not correct !" SEVERITY failure;

                             -- prefix B is the default, hence not necessary to write
    a_i <= "1111";           -- change value of a_i as binary vector value
    WAIT FOR period;
    ASSERT sum_o = X"F" REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: co is not correct !" SEVERITY failure;

    a_i <= X"0";             -- change value of a_i
    b_i <= B"0101";             -- change value of b_i
    WAIT FOR period;
    ASSERT sum_o = X"5" REPORT "Error: sum is not correct !" SEVERITY failure;
    ASSERT co_o = '0' REPORT "Error: co is not correct !" SEVERITY failure;


    -- alternatively, a local procedure can be used to assign input values:
    -----------------------------------------------------------------------
    -- the following test cases are the same as above, hence commented here
--                  ci_i, b_i,    a_i
--    apply_stimuli('0', B"0000", X"0");
--    apply_stimuli('0', B"1111", X"0");
--    apply_stimuli('0', X"F",    B"0101");


    -- add your stimuli here ...
    ---------------------------------------------------------------------------
    

    apply_stimuli('0', X"A", X"2");
    apply_stimuli('1', X"A", X"2");
    apply_stimuli('1', X"F", X"F");
    

    WAIT;
  END PROCESS;

END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
