-------------------------------------------------------------------------------
-- Module     : structure
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: detects a falling edge of input signal x_i
--              and produces a high-active signal for one clock period at
--              output fall_o
--              clk_i  __|--|__|--|__|--|__|--|__|--|__|--|__|--|__|--|__|--|
--                x_i  -----|___________________________________|-----------
--              fall_o ________|-----|______________________________________
--
--              structural model based on two flip flops with output logic
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ARCHITECTURE structure OF falling_edge_detector IS

  COMPONENT d_ff
    PORT (
      clk_i  : IN  std_ulogic;
      rst_ni : IN  std_ulogic;
      d_i    : IN  std_ulogic;
      q_o    : OUT std_ulogic);
  END COMPONENT;

  SIGNAL q0, q1 : std_ulogic;           -- D-Type Flip-Flop outputs
  
BEGIN

  dflipflop_0 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => x_i,
      q_o    => q0);

  dflipflop_1 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => q0,
      q_o    => q1);

  output_logic : fall_o <= ;            -- fill in the correct equation here

END structure;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

