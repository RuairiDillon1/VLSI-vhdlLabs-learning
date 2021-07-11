LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity triangle_wave_gen is 
    port(
        --phase
        phase_i : in std_ulogic_vector(15 downto 0);
        --triangle signal
        sig_o   : out std_ulogic_vector(15 downto 0));
end entity; 

architecture rtl of triangle_wave_gen is 
begin 

  --assing phase to 32 bit integer

  phase_map_p : process(phase_i)
    variable inter_result : signed(20 downto 0);
  begin
    --subtract 2^15
    inter_result := signed("00000" & phase_i) - shift_left(to_signed(1, 21), 15);
    --take absolute value and subtract 2^14
    inter_result := abs(inter_result) - shift_left(to_signed(1, 21), 14);
    --multiply by almost 2 
    --multiply by 32 and subtract x to get x*32
    inter_result := shift_left(inter_result, 5) - inter_result;
    --divide by 16
    inter_result := shift_right(inter_result, 4);
    --take 16 bit signed integer as result
    sig_o <= std_ulogic_vector(inter_result(20) & inter_result(14 downto 0));
  end process;
end architecture;
