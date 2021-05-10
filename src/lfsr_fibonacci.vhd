LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity lfsr_fibonacci is 
    port(
        clk_i       : in std_ulogic;
        en_pi       : in std_ulogic;
        rst_n       : in std_ulogic;
        lfsr_o      : out std_ulogic_vector(3 downto 0);
        noise_o     : out std_ulogic; 
        eoc_po      : out std_ulogic 
        );
end entity; 

architecture rtl of lfsr_fibonacci is 
    signal c_state_register, n_state_register : std_ulogic_vector(3 downto 0);
begin 

    --shift
    n_state_register <=  (c_state_register(1) xor c_state_register(0)) & c_state_register(3 downto 1);

    --change output
    c_state_register <= "0001" when rst_n = '0' else n_state_register 
                                when rising_edge(clk_i) and en_pi = '1';

    lfsr_o <= c_state_register;
    noise_o <= c_state_register(0);
    eoc_po <= '1' when c_state_register = "0011";
end architecture;
