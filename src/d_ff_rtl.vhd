-------------------------------------------------------------------------------
-- Module     : d_ff
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: D-Type Flip-Flop
--              including a low-active asynchronous reset input rst_ni
--              and a high-active enable input en_pi
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY d_ff IS
  PORT (
    clk_i  : IN  std_ulogic;
    rst_ni : IN  std_ulogic;
    d_i    : IN  std_ulogic;
    q_o    : OUT std_ulogic
    );
END d_ff;

ARCHITECTURE rtl OF d_ff IS

BEGIN

  dflipflop_p : q_o <= '0' WHEN (rst_ni = '0') ELSE
                       d_i WHEN rising_edge(clk_i);

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

