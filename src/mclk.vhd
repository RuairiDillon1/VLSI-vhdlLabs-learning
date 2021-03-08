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

-- Master Clock Generator
-- Generate 12 MHz from 24 MHz

entity mclk is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic; 
    mclk_o                 : out std_ulogic);
end; 

architecture rtl of mclk is
  signal mclk : std_ulogic;
begin

  mclk_p : process(clk_i, reset_ni)
  begin
    if reset_ni = '0' then
      mclk <= '0'; 
    elsif rising_edge(clk_i) then
      mclk <= not mclk;
    end if;
  end process mclk_p;

  mclk_o <= mclk;
			   
end; -- architecture


