-------------------------------------------------------------------------------
-- Module     : and2gate
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-input AND Gate
--              function modelled by logic equation
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY and2gate IS
  PORT (a_i : IN  std_ulogic;           -- data input a
        b_i : IN  std_ulogic;           -- data input b
        y_o : OUT std_ulogic            -- data output y
        );
END and2gate;

ARCHITECTURE equation OF and2gate IS

BEGIN

  y_o <= a_i AND b_i;

END equation;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

