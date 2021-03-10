-------------------------------------------------------------------------------
-- Module     : dreg
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: D-Type Register
--              including a low-active asynchronous reset input rst_ni
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY dreg IS
  PORT (clk_i  : IN  std_ulogic;
        rst_ni : IN  std_ulogic;
        d_i    : IN  std_ulogic_vector(3 DOWNTO 0);
        q_o    : OUT std_ulogic_vector(3 DOWNTO 0)
        );
END dreg;

ARCHITECTURE structure OF dreg IS

  COMPONENT d_ff
    PORT (
      clk_i  : IN  std_ulogic;
      rst_ni : IN  std_ulogic;
      d_i    : IN  std_ulogic;
      q_o    : OUT std_ulogic);
  END COMPONENT;
  
BEGIN

  d_ff_0 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => d_i(0),
      q_o    => q_o(0));

  d_ff_1 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => d_i(1),
      q_o    => q_o(1));

  d_ff_2 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => d_i(2),
      q_o    => q_o(2));

  d_ff_3 : d_ff
    PORT MAP (
      clk_i  => clk_i,
      rst_ni => rst_ni,
      d_i    => d_i(3),
      q_o    => q_o(3));

END structure;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

