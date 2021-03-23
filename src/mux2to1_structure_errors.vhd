-------------------------------------------------------------------------------
-- Module     : mux2to1
-------------------------------------------------------------------------------
-- Author     : Johann Faerber
-- Company    : University of Applied Sciences Augsburg
-------------------------------------------------------------------------------
-- Description: 2-to-1 multiplexer
--              function modelled as structure of basic logic gates
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

ENTITY mux2to1 IS
  PORT (a_i   : IN  std_ulogic;
        b_i   : IN  std_ulogic;
        sel_i : IN  std_ulogic;
--        y_o   : OUT std_ulogic; -- kein ; nach letztem Signal
        y_o   : OUT std_ulogic
        );
-- END mux21;
END mux2to1; --wrong label


ARCHITECTURE structure OF mux2to1 IS

  COMPONENT invgate
    PORT (
      a_i : IN  std_ulogic;
      y_o : OUT std_ulogic);
  END COMPONENT;

  COMPONENT or2gate
    PORT (
      a_i : IN  std_ulogic;
      b_i : IN  std_ulogic;
--      y_o : std_ulogic); missing OUT
      y_o : OUT std_ulogic);
  END COMPONENT;

  --missing component declaration
  COMPONENT and2gate
  PORT (a_i : IN  std_ulogic;           -- data input a
        b_i : IN  std_ulogic;           -- data input b
        y_o : OUT std_ulogic            -- data output y
        );
  END COMPONENT;

  --missing signal p0
  SIGNAL p0 : std_ulogic;
  SIGNAL p1  : std_ulogic;
  SIGNAL p2 : std_ulogic;
  SIGNAL p3 : std_ulogic;
  
BEGIN

  inv_gate_1 : invgate
    PORT MAP (
      a_i => sel_i,
      --y_o <= p2);
      y_o => p2);  --Arrow in the wrong direction


  and2_gate_1 : and2gate
    PORT MAP (
      a_i => a_i,
      --b_i => p2 --missing comma
      b_i => p2,
      y_o => p0);

  and2_gate_2 : and2gate
    PORT MAP (
      a_i => b_i,
      b_i => sel_i,
      y_o => p1);

  or2_gate_1 : or2gate
    PORT MAP (
      a_i => p0,
      b_i => p1,
      y_o => p3);

  --missing assignment of output signal
  y_o <= p3; 


--END struct
END ARCHITECTURE; 

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------

