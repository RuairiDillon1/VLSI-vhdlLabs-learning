LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity phase_gen is 
    generic(width : integer := 16);
    port(
            clk_i     : in std_ulogic;
            rst_n     : in std_ulogic;
            en_p      : in std_ulogic;
            phase_inc : in std_ulogic_vector(width-1 downto 0);
            phase_o   : out std_ulogic_vector(width-1 downto 0)
        );
end entity;  

architecture rtl of phase_gen is 
    signal c_val, n_val: unsigned(width-1 downto 0); 
begin 
    -- current value 
    c_val <= to_unsigned(0, width) when rst_n = '0' else n_val when rising_edge(clk_i) and en_p = '1';
    -- add increment value
    n_val <= c_val + unsigned(phase_inc);
    -- output 
    phase_o <= std_ulogic_vector(c_val); 
end architecture;
