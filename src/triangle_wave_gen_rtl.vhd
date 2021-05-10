LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity triangle_wave_gen is 
    port(
        phase_i : in std_ulogic_vector(15 downto 0);
        sig_o   : out std_ulogic_vector(15 downto 0));
end entity; 

architecture rtl of triangle_wave_gen is 
  signal phase_32 : std_ulogic_vector(31 downto 0);

begin 

  --assing phase to 32 bit integer
  phase_32(31 downto 16)  <= (others => '0'); 
  phase_32(15 downto 0)   <= phase_i; 

  phase_map_p : process(phase_32)
    variable inter_result : signed(31 downto 0);
  begin
    inter_result := signed(phase_32) - 32768;
    inter_result := abs(inter_result) - 16384;
    --multiply by almost 2 
    inter_result := signed(inter_result(31) & inter_result(25 downto 0) & "00000") - inter_result;
    inter_result := signed(inter_result(31) & "0000" & inter_result(30 downto 4));
    sig_o <= std_ulogic_vector(inter_result(31) & inter_result(14 downto 0));
  end process;
end architecture;
