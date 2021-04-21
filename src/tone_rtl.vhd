library ieee;
use ieee.std_logic_1164.all;

entity tone is
  port (clk        : in  std_ulogic;
        rst_n      : in  std_ulogic;
        switches_i : in  std_ulogic_vector(9 downto 0);
        dv_i       : in  std_ulogic;
        audio_i    : in  std_ulogic_vector(15 downto 0);
        audio_o    : out std_ulogic_vector(15 downto 0));
end entity;

architecture rtl of tone is
  
begin

audio_o <= audio_i when rising_edge(clk) and dv_i = '1';

end architecture rtl;
