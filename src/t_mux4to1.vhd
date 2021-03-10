-------------------------------------------------------------------------------
-- Module     : t_mux4to1
-------------------------------------------------------------------------------
-- Author     :   <johann.faerber@hs-augsburg.de>
-- Company    : University of Applied Sciences Augsburg
-- Copyright (c) 2012   <johann.faerber@hs-augsburg.de>
-------------------------------------------------------------------------------
-- Description: Testbench for design "mux4to1"
-------------------------------------------------------------------------------
-- Revisions  : see end of file
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
-------------------------------------------------------------------------------

ENTITY t_mux4to1 IS
END t_mux4to1;

-------------------------------------------------------------------------------

ARCHITECTURE tbench OF t_mux4to1 IS

  COMPONENT mux4to1
    PORT (
      i0_i  : IN  std_ulogic;
      i1_i  : IN  std_ulogic;
      i2_i  : IN  std_ulogic;
      i3_i  : IN  std_ulogic;
      sel_i : IN  std_ulogic_vector(1 DOWNTO 0);
      y_o   : OUT std_ulogic);
  END COMPONENT;

  -- component ports
  SIGNAL i0_i  : std_ulogic;
  SIGNAL i1_i  : std_ulogic;
  SIGNAL i2_i  : std_ulogic;
  SIGNAL i3_i  : std_ulogic;
  SIGNAL sel_i : std_ulogic_vector(1 DOWNTO 0);
  SIGNAL y_o   : std_ulogic;
  SIGNAL y_ref : std_ulogic;


  -- definition of a clock period
  CONSTANT period : time := 10 ns;

BEGIN  -- tbench

  -- component instantiation
  MUV : mux4to1
    PORT MAP (
      i0_i  => i0_i,
      i1_i  => i1_i,
      i2_i  => i2_i,
      i3_i  => i3_i,
      sel_i => sel_i,
      y_o   => y_o);

  -- reference model
  REF : y_ref <= i0_i WHEN sel_i = "00" ELSE
                 i1_i WHEN sel_i = "01" ELSE
                 i2_i WHEN sel_i = "10" ELSE
                 i3_i WHEN sel_i = "11" ELSE
                 'X';

  -- process for stimuli generation
  stimuli_p : PROCESS

  BEGIN

    sel_i <= B"00";                     -- select i0
    i0_i  <= '0';                       -- assign a '0' to i0 -> observed at y?
    i1_i  <= '1';                       -- assign all other input values to '1'
    i2_i  <= '1';
    i3_i  <= '1';
    WAIT FOR period;                    -- actually, values are assigned here
    -- observer:
    ASSERT y_o = y_ref
      REPORT "Error: value of y_o incorrect !" SEVERITY error;
    ---------------------------------------------------------------------------

    sel_i <= B"00";                     -- select i0
    i0_i  <= '1';                       -- assign a '1' to i0 -> observed at y?
    i1_i  <= '0';                       -- assign all other input values to '0'
    i2_i  <= '0';
    i3_i  <= '0';
    WAIT FOR period;                    -- actually, values are assigned here
    -- observer:
    ASSERT y_o = y_ref
      REPORT "Error: value of y_o incorrect !" SEVERITY error;
    ---------------------------------------------------------------------------

    sel_i <= B"01";                     -- select input i1
    i0_i  <= '1';                       -- assign a '0' to i1 -> observed at y?
    i1_i  <= '0';                       -- assign all other input values to '1'
    i2_i  <= '1';
    i3_i  <= '1';
    WAIT FOR period;                    -- actually, values are assigned here
    -- observer:
    ASSERT y_o = y_ref
      REPORT "Error: value of y_o incorrect !" SEVERITY error;
    ---------------------------------------------------------------------------


    -- add the missing stimuli here ...

    


      WAIT;
    END PROCESS;

  END tbench;

-------------------------------------------------------------------------------
-- Revisions:
-- ----------
-- $Id:$
-------------------------------------------------------------------------------
