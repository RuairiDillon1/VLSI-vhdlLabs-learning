-------------------------------------------------------------------------------
-- Module     : t_cntupen
-------------------------------------------------------------------------------
-- Author     :   <haf@fh-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2011   <haf@fh-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "cntupen"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY t_cntupen IS
END t_cntupen;

ARCHITECTURE tbench OF t_cntupen IS

  COMPONENT cntupen
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(3 DOWNTO 0));
  END COMPONENT;

  -- definition of a clock period
  CONSTANT period : time    := 10 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

  -- component ports
  SIGNAL clk_i   : std_ulogic;
  SIGNAL rst_ni  : std_ulogic;
  SIGNAL en_pi   : std_ulogic;
  SIGNAL count_o : std_ulogic_vector(3 DOWNTO 0);

BEGIN  -- tbench

  -- component instantiation
  MUV : ENTITY work.cntupen(rtl)
    PORT MAP (
      clk_i   => clk_i,
      rst_ni  => rst_ni,
      en_pi   => en_pi,
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

  -- initial reset, always necessary at the beginning of a simulation
  -----------------------------------------------------------------------------
  -- Following a verification plan:
  -- ------------------------------
  -- 1. t = 0 ns: activate asynchronous reset
  -- 2. t = 10 ns: deactivate asynchronous reset
  -----------------------------------------------------------------------------
  reset : rst_ni <= '0', '1' AFTER period;

  stimuli_p : PROCESS

  BEGIN

    ---------------------------------------------------------------------------
    -- ... continuing with the verification plan:
    ---------------------------------------------------------------------------
    WAIT UNTIL rst_ni = '1';            -- wait until asynchronous reset ...
                                        -- ... is deactivated
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------
    -- 2. activate enable
    -- 3. Wait for a full counting cycle
    ---------------------------------------------------------------------------
    en_pi <= '1';                       -- activate enable input en_pi
    WAIT FOR 15 * period;               -- wait for at least one count cycle
    ASSERT count_o = X"F" REPORT "Error: Expected count_o = F !" SEVERITY failure;
    ---------------------------------------------------------------------------

                                        -- wait for a no. of count values
                                        -- then ...
    ---------------------------------------------------------------------------

    
    ---------------------------------------------------------------------------
    -- 4. After another five periods: Deactivate Enable
    ---------------------------------------------------------------------------
                                        -- .... deactivate enable input en_pi
    
    ---------------------------------------------------------------------------

    
    ---------------------------------------------------------------------------
    -- 5. After another three periods: Activate Enable
    -- 6. Simulate another complete counting cycle
    ---------------------------------------------------------------------------
                                        -- activate enable input en_pi
                                        -- wait for at least one count cycle
--    ASSERT count_o = ??? REPORT "Error: Expected count_o = ??? !" SEVERITY failure;


    ---------------------------------------------------------------------------
    -- 7. Switch off the clock generator
    ---------------------------------------------------------------------------
    clken_p <= false;                   -- switch clock generator off

    WAIT;                               -- suspend proces
  END PROCESS;
  
END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
