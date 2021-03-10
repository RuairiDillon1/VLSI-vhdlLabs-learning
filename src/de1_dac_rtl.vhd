library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_dac is 
  port ( CLOCK_50 : in  std_ulogic;         
         SW       : in  std_ulogic_vector(9 downto 0); 
         KEY0     : in  std_ulogic;
         DAC_MODE : out std_ulogic;    --1=dual port, 0=interleaved
         DAC_WRT_A : out std_ulogic;
         DAC_WRT_B : out std_ulogic;
         DAC_CLK_A : out std_ulogic;  -- PLL_OUT_DAC0 in User Manual
         DAC_CLK_B : out std_ulogic;  -- PLL_OUT_DAC1 in User Manual
         DAC_DA   : out std_ulogic_vector(13 downto 0);
         DAC_DB   : out std_ulogic_vector(13 downto 0);
         ADC_CLK_A : out std_ulogic;
         ADC_CLK_B : out std_ulogic;
         POWER_ON  : out std_ulogic;
         ADC_OEB_A : out std_ulogic;
         ADC_OEB_B : out std_ulogic;
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_dac is

  signal clk,rst_n : std_ulogic;
  signal cnt : unsigned(13 downto 0);
  signal phase_inc : unsigned(9 downto 0);
  signal dac_a_reg, dac_a_next, dac_b_reg : unsigned(13 downto 0);
  
begin

  clk <= CLOCK_50;
  rst_n <= KEY0;
  LEDR <= SW;
  
  DAC_MODE  <= '1'; --dual port
  DAC_CLK_A <= clk;
  DAC_CLK_B <= clk;
  DAC_WRT_A <= clk;
  DAC_WRT_B <= clk;

  phase_inc <= unsigned(SW);

  cnt <= (others => '0') when rst_n = '0' else cnt+phase_inc when rising_edge(clk);

  dac_a_next <= (others => '1') when cnt = 0 else (others => '0');
  dac_a_reg <= (others => '0') when rst_n = '0' else dac_a_next when falling_edge(clk);
  dac_b_reg <= (others => '0') when rst_n = '0' else cnt when falling_edge(clk); 
  DAC_DA <= std_ulogic_vector(dac_a_reg);
  DAC_DB <= std_ulogic_vector(dac_b_reg);

  -- ADC Section - switch off everything
  ADC_CLK_A <= '0';
  ADC_CLK_B <= '0';
  ADC_OEB_A <= '1';
  ADC_OEB_B <= '1';
  POWER_ON  <= '1';

end architecture rtl;
