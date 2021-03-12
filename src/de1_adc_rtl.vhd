library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- PLL for 100 MHz speed
library altera_mf;
use altera_mf.all;

entity de1_adc is 
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
         ADC_DA    : in  std_ulogic_vector(13 downto 0);
         ADC_DB    : in  std_ulogic_vector(13 downto 0);
         ADC_OTR_A : in  std_ulogic;
         ADC_OTR_B : in  std_ulogic;
         LEDR     : out std_ulogic_vector(9 downto 0));  -- red LEDs
end entity;

architecture rtl of de1_adc is

    -- Altera PLL
  component altpll
    generic (
      clk0_divide_by         : natural;
      clk0_duty_cycle        : natural;
      clk0_multiply_by       : natural;
--              clk0_phase_shift                : STRING;
--              compensate_clock                : STRING;
      inclk0_input_frequency : natural;
--              intended_device_family          : STRING;
--              lpm_hint                : STRING;
--              lpm_type                : STRING;
      operation_mode         : string;
      port_inclk0            : string;
      port_clk0              : string
      );
    port (
      clk   : out std_logic_vector (5 downto 0);
      inclk : in  std_logic_vector (1 downto 0)
      );
  end component;

  signal pll_inclk : std_logic_vector(1 downto 0);
  signal pll_outclk : std_logic_vector(5 downto 0);

  signal clk,rst_n : std_ulogic;
  signal dac_a_dat, dac_b_dat, adc_a_dat, adc_b_dat : std_ulogic_vector(13 downto 0);
  
begin

    pll_i0 : altpll
    generic map (
      clk0_divide_by         => 10,
      clk0_duty_cycle        => 50,
      clk0_multiply_by       => 13,
--              clk0_phase_shift => "0",
--              compensate_clock => "CLK0",
      inclk0_input_frequency => 20000,
      operation_mode         => "NORMAL",
      port_inclk0            => "PORT_USED",
      port_clk0              => "PORT_USED"
      )
    port map (
      inclk => pll_inclk,
      clk   => pll_outclk
      );

  pll_inclk(0) <= CLOCK_50;
  pll_inclk(1) <= '0';
  clk <= pll_outclk(0);
  --clk <= CLOCK_50;

  rst_n <= KEY0;
  LEDR <= "00000000" & ADC_OTR_A & ADC_OTR_B when rising_edge(clk);
  
  DAC_MODE  <= '1'; --dual port
  DAC_CLK_A <= clk;
  DAC_CLK_B <= clk;
  DAC_WRT_A <= clk;
  DAC_WRT_B <= clk;

  dac_a_dat <= (others => '0') when rst_n = '0' else adc_a_dat when falling_edge(clk);
  dac_b_dat <= (others => '0') when rst_n = '0' else adc_b_dat when falling_edge(clk);

  DAC_DA <= dac_a_dat;
  DAC_DB <= dac_b_dat;

  -- ADC Section
  ADC_CLK_A <= clk;
  ADC_CLK_B <= clk;
  ADC_OEB_A <= '0';
  ADC_OEB_B <= '0';
  POWER_ON  <= '1';

  adc_a_dat <= (others => '0') when rst_n = '0' else ADC_DA when rising_edge(clk);
  adc_b_dat <= (others => '0') when rst_n = '0' else ADC_DB when rising_edge(clk);            

end architecture rtl;
