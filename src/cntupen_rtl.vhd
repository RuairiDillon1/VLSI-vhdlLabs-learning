-------------------------------------------------------------------------------
-- Module     : cntupen
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Up-Counter
--              including a low-active asynchronous reset input rst_ni
--              and a high-active enable input en_pi
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY cntupen IS
  PORT (clk_i   : IN  std_ulogic;
        rst_ni  : IN  std_ulogic;
        en_pi   : IN  std_ulogic;
        count_o : OUT std_ulogic_vector(3 DOWNTO 0)
        );
END cntupen;

ARCHITECTURE rtl OF cntupen IS

  -- datatype unsigned is defined in package numeric_std
  SIGNAL next_state, current_state : unsigned(3 DOWNTO 0);

BEGIN

  -- package numeric_std overloads operator '+'
  -- for arguments of different types, here: unsigned and integer
  incrementer : next_state <= current_state + 1;


  -- synthesisable construct of a d-type register with synchronrous enable
  state_register : current_state <= "0000" WHEN rst_ni = '0' ELSE
                                    next_state WHEN rising_edge(clk_i) AND (en_pi = '1');


  -- type conversion from unsignd to std_ulogic_vector necessary
  counter_output : count_o <= std_ulogic_vector(current_state);

END rtl;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

