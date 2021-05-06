LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity lsfr_fibonacci is
    port(
        clk_i       : in std_ulogic;
        en_pi       : in std_ulogic;
        rst_n       : in std_ulogic;
        lfsr_o      : out std_ulogic_vector(17 downto 0);
        noise_o     : out std_ulogic; 
        eoc_po      : out std_ulogic; 
        );
end entity; 

architecture rtl of lsfr_fibonacci is 
    signal c_state_register, n_state_register : std_ulogic_vector(17 downto 0);
    signal feedback : std_ulogic;
begin 

    --shift
    n_state_register <= feedback & c_state_register(17 downto 1);
    --change output
    --set seed
    c_state_register <= std_ulogic_vector(to_unsigned(1, c_state_register'length)) when rst_n = '0' 
                        else n_state_register when rising_edge(clk_i) and en_pi = '1';
    --feedback
    --exponents 18 and 11
    feedback <= c_state_register(0) xor c_state_register(7);

    lfsr_o <= c_state_register;
    noise_o <= c_state_register(0);
    eoc_po <= '1' when n_state_register = std_ulogic_vector(to_unsigned(1, n_state_register'length)));
end architecture;
