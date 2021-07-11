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

  component triangle_wave_gen is 
    port(
        phase_i : in std_ulogic_vector(15 downto 0);
        sig_o   : out std_ulogic_vector(15 downto 0));
  end component;

  component phase_gen is 
    generic(width : integer := 15);
    port(
            clk_i     : in std_ulogic;
            rst_n     : in std_ulogic;
            en_p      : in std_ulogic;
            phase_inc : in std_ulogic_vector(width-1 downto 0);
            phase_o   : out std_ulogic_vector(width-1 downto 0)
        );
  end component;

  signal phase : std_ulogic_vector(15 downto 0);
  
begin

  phase1 : phase_gen
    generic map(width => 16)
    port map(
             clk_i => clk, 
             rst_n => rst_n, 
             en_p => dv_i,
             phase_inc => std_ulogic_vector(switches_i & "000000"),
             phase_o => phase);

  sig_gen : triangle_wave_gen
  port map(
            phase_i => phase,
            sig_o => audio_o 
          );

end architecture rtl;
