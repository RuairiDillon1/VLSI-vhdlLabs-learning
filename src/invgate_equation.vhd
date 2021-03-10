-------------------------------------------------------------------------------
-- Module     : invgate
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: Inverter Gate
--              function modelled by logic equation
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY invgate IS
  PORT (a_i : IN  std_ulogic;           -- data input a
        y_o : OUT std_ulogic            -- data output y
        );
END invgate;

ARCHITECTURE equation OF invgate IS

BEGIN

  y_o <= NOT a_i;

END equation;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

