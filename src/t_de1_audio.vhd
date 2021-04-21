--Copyright 2013 Friedrich Beckmann, Hochschule Augsburg
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

entity t_de1_audio is
end; 

architecture tbench of t_de1_audio is

component de1_audio is
  port (
    CLOCK_50:   in std_ulogic;
    KEY0:       in std_ulogic;
    I2C_SCLK:   out std_ulogic;
    I2C_SDAT:   inout std_ulogic; 
    AUD_ADCLRCK: out std_ulogic;
    AUD_ADCDAT:  in std_ulogic;
    AUD_DACLRCK: out std_ulogic; 
    AUD_DACDAT:  out std_ulogic; 
    AUD_XCK:     out std_ulogic;
    AUD_BCLK:    out std_ulogic; 
    LEDR:       out std_ulogic_vector(9 downto 0)
  );
end component; 

  signal clk, reset_n : std_ulogic; 
  signal ledr : std_ulogic_vector(9 downto 0);
  signal i2c_clk, i2c_dat : std_ulogic; 
  signal key0 : std_ulogic;

  signal aud_adclrck, aud_adcdat, aud_daclrck, aud_dacdat, aud_xck, aud_bclk : std_ulogic;

  signal simrun : boolean := true;

begin

  de1_audio_i0 : de1_audio
    port map (
      CLOCK_50            => clk,
      KEY0                => reset_n,
      I2C_SCLK            => i2c_clk,
      I2C_SDAT            => i2c_dat,
      AUD_ADCLRCK         => aud_adclrck,
      AUD_ADCDAT          => aud_adcdat,
      AUD_DACLRCK         => aud_daclrck,
      AUD_DACDAT          => aud_dacdat,
      AUD_XCK             => aud_xck,
      AUD_BCLK            => aud_bclk,
      LEDR                => ledr);

  clock_p : process
  begin
    clk <= '0';
    wait for 10 ns;
    clk <= '1';
    wait for 10 ns;
    if not simrun then
      wait;
    end if;
  end process clock_p;

  simrun <= false after 1 ms; 

  reset_p : process
  begin
    reset_n <= '0';
    wait for 15 us;
    reset_n <= '1';
    wait; 
  end process reset_p; 

  aud_adcdat <= '1';

end; -- architecture
