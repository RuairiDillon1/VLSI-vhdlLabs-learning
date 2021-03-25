-------------------------------------------------------------------------------
-- Module     : add4
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 4-bit adder
--              function modelled by cascading 1-bit adder modules
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ARCHITECTURE structure OF add4 IS

  COMPONENT add1
    PORT(a_i   : IN  std_ulogic;
         b_i   : IN  std_ulogic;
         ci_i  : IN  std_ulogic;
         sum_o : OUT std_ulogic;
         co_o  : OUT std_ulogic
         );
  END COMPONENT;

  SIGNAL carry0 : std_ulogic;
  SIGNAL carry1 : std_ulogic;
  SIGNAL carry2 : std_ulogic;


BEGIN

  inst0 : add1
    PORT MAP(a_i   => a_i(0),
             b_i   => b_i(0),
             ci_i  => ci_i,
             sum_o => sum_o(0),
             co_o  => carry0);

  inst1 : add1
    PORT MAP(a_i   => a_i(1),
             b_i   => b_i(1),
             ci_i  => carry0,
             sum_o => sum_o(1),
             co_o  => carry1);

  inst2 : add1
    PORT MAP(a_i   => a_i(2),
             b_i   => b_i(2),
             ci_i  => carry1,
             sum_o => sum_o(2),
             co_o  => carry2);

  inst3 : add1
    PORT MAP(a_i   => a_i(3),
             b_i   => b_i(3),
             ci_i  => carry2,
             sum_o => sum_o(3),
             co_o  => co_o);

END structure;
-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
