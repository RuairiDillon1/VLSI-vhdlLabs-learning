--Copyright 2021 Friedrich Beckmann, Hochschule Augsburg
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

entity audio is
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
end;

architecture struct of audio is

  component i2c_sub is 
  port (
    clk_i:      in std_ulogic;
    reset_ni:    in std_ulogic;
    i2c_clk_o:   out std_ulogic;
    i2c_dat_o:   out std_ulogic;
    i2c_dat_i:   in std_ulogic
  );
  end component; 

  component adcintf is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic;
    en_i                   : in std_ulogic;
    valid_o                : out std_ulogic; 
    data_o                 : out std_ulogic_vector(15 downto 0); 
    start_i                : in std_ulogic; 
    ser_dat_i              : in std_ulogic);
  end component; 

  component dacintf is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic;
    load_i                 : in std_ulogic; 
    data_i                 : in std_ulogic_vector(15 downto 0); 
    en_i                   : in std_ulogic; 
    ser_dat_o              : out std_ulogic);
  end component;

  component bclk is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic; 
    bclk_o                 : out std_ulogic;
    bclk_falling_edge_en_o : out std_ulogic);
  end component; 

  component fsgen is 
  port (
    clk_i                   : in std_ulogic;
    reset_ni                : in std_ulogic;
    bclk_falling_edge_en_i  : in std_ulogic; 
    fs_o                    : out std_ulogic);
  end component; 

  component mclk is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic; 
    mclk_o                 : out std_ulogic);
  end component; 
  
  signal framesync             : std_ulogic;
  signal bclk_falling_edge_en  : std_ulogic; 
  
  signal adc_valid             : std_ulogic;
  signal dac_data, adc_data    : std_ulogic_vector(15 downto 0);  
    
begin
  
  i2c_sub_i0 : i2c_sub 
  port map (
    clk_i      => clk_i,
    reset_ni   => reset_ni,
    i2c_clk_o  => i2c_sclk_o,
    i2c_dat_o  => i2c_dat_o,
    i2c_dat_i  => i2c_dat_i);

  mclk_i0 : mclk
  port map(
    clk_i      => clk_i,
    reset_ni   => reset_ni,
    mclk_o     => aud_xck_o);

  bclk_i0 : bclk
  port map (
    clk_i                  => clk_i,
    reset_ni               => reset_ni,
    bclk_o                 => aud_bclk_o,
    bclk_falling_edge_en_o => bclk_falling_edge_en);

  fsgen_i0 : fsgen
  port map (
    clk_i                  => clk_i,
    reset_ni               => reset_ni,
    bclk_falling_edge_en_i => bclk_falling_edge_en,
    fs_o                   => framesync);

  dacintf_i0 : dacintf
  port map (
    clk_i                  => clk_i,
    reset_ni               => reset_ni,
    load_i                 => framesync,
    data_i                 => dac_data_i,
    en_i                   => bclk_falling_edge_en,
    ser_dat_o              => aud_dacdat_o);

  adcintf_i0 : adcintf
  port map (
    clk_i                  => clk_i,
    reset_ni               => reset_ni,
    valid_o                => adc_valid_o, 
    data_o                 => adc_data_o,
    start_i                => framesync,
    en_i                   => bclk_falling_edge_en,
    ser_dat_i              => aud_adcdat_i);
        
  aud_daclrck_o <= framesync; 
  aud_adclrck_o <= framesync;

  dac_strobe_o <= framesync and bclk_falling_edge_en;
  
end; -- architecture


