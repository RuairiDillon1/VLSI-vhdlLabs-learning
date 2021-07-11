--Copyright 2013,2021 Friedrich Beckmann, Hochschule Augsburg
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library altera; 
use altera.altera_primitives_components.all;

entity de1_matlab_audio_mixer is 
  port (
    CLOCK_50:   in std_ulogic;
    KEY0:       in std_ulogic;
	 SW:         in std_ulogic_vector(9 downto 0);
    I2C_SCLK:   out std_ulogic;
    I2C_SDAT:   inout std_logic; 
    AUD_ADCLRCK: out std_ulogic;
    AUD_ADCDAT:  in std_ulogic;
    AUD_DACLRCK: out std_ulogic; 
    AUD_DACDAT:  out std_ulogic; 
    AUD_XCK:     out std_ulogic;
    AUD_BCLK:    out std_ulogic; 
    LEDR:       out std_ulogic_vector(9 downto 0));
end; 

architecture struct of de1_matlab_audio_mixer is

  -- Matlab generated toplevel
  component audio_mixer_wrapper is
  PORT( clk                               :   IN    std_logic;
        rst_n                             :   IN    std_logic;
        clk_enable                        :   IN    std_logic;
        ce_out                            :   OUT   std_logic;
        phase_inc1_i                      :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        phase_inc2_i                      :   IN    std_logic_vector(15 DOWNTO 0);  -- ufix16_En16
        signal_o                          :   OUT   std_logic_vector(15 DOWNTO 0)  -- sfix17_En14
        );
  end component;

  -- Wolfson AudioCodec Interface block
  component audio is
    port (
      clk_i         : in  std_ulogic;
      reset_ni      : in  std_ulogic;
      i2c_sclk_o    : out std_ulogic;
      i2c_dat_i     : in  std_ulogic;
      i2c_dat_o     : out std_ulogic;
      aud_adclrck_o : out std_ulogic;
      aud_adcdat_i  : in  std_ulogic;
      aud_daclrck_o : out std_ulogic;
      aud_dacdat_o  : out std_ulogic;
      aud_xck_o     : out std_ulogic;
      aud_bclk_o    : out std_ulogic;
      adc_data_o    : out std_ulogic_vector(15 downto 0);
      adc_valid_o   : out std_ulogic;
      dac_data_i    : in  std_ulogic_vector(15 downto 0);
      dac_strobe_o  : out std_ulogic);
  end component;

  signal clk, reset_n          : std_ulogic;
  
  signal i2c_dat_o             : std_ulogic;
  signal i2c_dat_i             : std_ulogic; 
  
  signal adc_valid             : std_ulogic;
  signal dac_strobe            : std_ulogic;
  signal dac_data : std_logic_vector(15 downto 0);
  signal adc_data, dac_data_reg : std_ulogic_vector(15 downto 0);
  signal audio_mixer_out_valid : std_ulogic;

  signal phase_sw : std_ulogic_vector(15 downto 0);
  
begin
  
  reset_n <= KEY0;
  clk     <= CLOCK_50;

  phase_sw <= x"1555" when SW(0) = '1' else (others => '0');

  audio_mixer1 : audio_mixer_wrapper 
    port map (
      clk => clk,
      rst_n => reset_n,
      clk_enable => adc_valid,
      ce_out => audio_mixer_out_valid,
      phase_inc1_i => x"1000",
      phase_inc2_i => std_logic_vector(phase_sw),
      signal_o => dac_data);

  dac_data_reg <= std_ulogic_vector(dac_data) when rising_edge(clk) and audio_mixer_out_valid = '1';

  -- Wolfson Audio Codec
  audio_i0 : audio
    port map (
      clk_i => clk,
      reset_ni => reset_n,
      i2c_sclk_o => I2C_SCLK,
      i2c_dat_i  => i2c_dat_i,
      i2c_dat_o  => i2c_dat_o,
      aud_adclrck_o => AUD_ADCLRCK,
      aud_adcdat_i  => AUD_ADCDAT,
      aud_daclrck_o => AUD_DACLRCK,
      aud_dacdat_o  => AUD_DACDAT,
      aud_xck_o     => AUD_XCK,
      aud_bclk_o    => AUD_BCLK,
      adc_data_o    => adc_data,
      adc_valid_o   => adc_valid,
      dac_data_i    => dac_data_reg,
      dac_strobe_o  => dac_strobe);
  
  LEDR <= SW;
  
  -- i2c has an open-drain ouput
  i2c_dat_i <= I2C_SDAT; 
  i2c_data_buffer_i : OPNDRN
    port map (a_in => i2c_dat_o, a_out => I2C_SDAT);

end; -- architecture
