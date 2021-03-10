-------------------------------------------------------------------------------
-- Module     : t_falling_edge_detector
-------------------------------------------------------------------------------
-- Author     :   <haf@fh-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2011   <haf@fh-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "falling_edge_detector"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-------------------------------------------------------------------------------

ENTITY t_falling_edge_detector IS
END t_falling_edge_detector;

-------------------------------------------------------------------------------

ARCHITECTURE tbench OF t_falling_edge_detector IS

  COMPONENT falling_edge_detector
    PORT (
      clk_i  : IN  std_ulogic;
      rst_ni : IN  std_ulogic;
      x_i    : IN  std_ulogic;
      fall_o : OUT std_ulogic);
  END COMPONENT;

  -- definition of a clock period
  CONSTANT period : time    := 10 ns;
  -- switch for clock generator
  SIGNAL clken_p  : boolean := true;

  -- component ports
  SIGNAL clk_i  : std_ulogic;
  SIGNAL rst_ni : std_ulogic;
  SIGNAL x_i    : std_ulogic;
  SIGNAL fall_o : std_ulogic;

BEGIN  -- tbench

  -- component instantiation
  MUV : falling_edge_detector
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      x_i    => x_i,
      fall_o => fall_o);

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
  reset : rst_ni <= '0', '1' AFTER period;


  stimuli_p : PROCESS
  BEGIN

    WAIT UNTIL rst_ni = '1';            -- wait until asynchronous reset ...
                                        -- ... is deactivated
    ---------------------------------------------------------------------------

    -- create a low-active pulse over a no. of clock periods
    ---------------------------------------------------------------------------
    x_i <= '1';                         -- assign a '1' to x_i
    WAIT FOR period;

    x_i <= '0';                         -- set input to '0' ...
    WAIT UNTIL rising_edge(clk_i);
    WAIT UNTIL falling_edge(clk_i);
    -- Observer: check, if fall_o is assigned to '1' for one clock period
    ASSERT fall_o = '1' REPORT "Error: Expected fall_o = '1' !" SEVERITY failure;
    WAIT UNTIL falling_edge(clk_i);
    ASSERT fall_o = '0' REPORT "Error: Expected fall_o = '0' !" SEVERITY failure;
    WAIT FOR 6 * period;                -- ... for a no. of periods

    x_i <= '1';                         -- assign a '1' to form a
    WAIT FOR 3 * period;                -- low active input pulse
    ---------------------------------------------------------------------------


    -- add another low-active input pulse here ...







    

    clken_p <= false;                   -- switch clock generator off

    WAIT;                               -- suspend proces
  END PROCESS;
  

END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
