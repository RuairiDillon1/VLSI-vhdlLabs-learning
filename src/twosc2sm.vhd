

LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY twosc2sm IS
	PORT (
	operand_i : IN std_ulogic_vector(3 DOWNTO 0);
	operand_u : OUT std_ulogic_vector(3 DOWNTO 0)
);

END ENTITY;

ARCHITECTURE rtl OF twosc2sm IS

	SIGNAl inter : std_ulogic_vector(2 DOWNTO 0);
	

BEGIN 

 --Twos complement conversion
 inter <= std_ulogic_vector(unsigned(NOT operand_i(2 DOWNTO 0))+1 );

 operand_u(3) <= operand_i(3);
 operand_u(2 downto 0) <= operand_i(2 downto 0) WHEN operand_i(3) = '0' ELSE inter;

END rtl;

