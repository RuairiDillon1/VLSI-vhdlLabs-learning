-------------------------------------------------------------------------------
-- Module     : or2gate
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-input OR Gate
--              function modelled by logic equation
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

--empty file 

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY or2gate IS
  PORT (a_i : IN  std_ulogic;           -- data input a
        b_i : IN  std_ulogic;           -- data input b
        y_o : OUT std_ulogic            -- data output y
        );
END or2gate;

ARCHITECTURE equation OF or2gate IS

BEGIN

  y_o <= a_i or b_i;

END equation;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
