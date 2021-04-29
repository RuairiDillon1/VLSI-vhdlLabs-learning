LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity triangle_wave_gen is 
    port(
        clk_i   : in std_ulogic; 
        rst_n   : in std_ulogic; 
        phase_i : in std_ulogic_vector(16 downto 0);
        sig_o   : out std_ulogic_vector(15 downto 0));
end entity; 

architecture rtl of triangle_wave_gen is 
begin 

    signal_p : process(phase_i)
    begin 
        if phase_i(16) = '0' then 
            sig_o <= phase_i(15 downto 0);
        else
            sig_o <= not phase_i(15 downto 0);
        end if;
    end process;

end architecture;
