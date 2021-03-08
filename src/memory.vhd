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

-- This VHDL memory description will result in FPGA memory usage. 
-- The EPC2C20 series provides a total of 52 M4K memory blocks
-- Each M4K memory block contains 4608 Bits. The following configurations are supported: 
-- 4K  1, 2K  2, 1K  4, 512  8, 512  9, 256  16, 256  18
-- The maximum is therefore 52 x 256 = 13312 samples. 

entity memory is 
  port (
    clk_i       : in std_ulogic;
    we_i        : in std_ulogic;
    waddr_i     : in unsigned(12 downto 0); 
    raddr_i     : in unsigned(12 downto 0);
    wdata_i     : in std_ulogic_vector(15 downto 0); 
    rdata_o     : out std_ulogic_vector(15 downto 0)
  );
end; 

architecture rtl of memory is
  type ram_t is array(0 to 2 ** 13 - 1) of std_ulogic_vector(15 downto 0);
  signal ram : ram_t;
begin

  mem_p : process(clk_i)
  begin
    if rising_edge(clk_i) then
      if we_i = '1' then
        ram(to_integer(waddr_i)) <= wdata_i;
      end if; 
      rdata_o <= ram(to_integer(raddr_i)); 
    end if; 
  end process mem_p;  
			   
end; -- architecture


