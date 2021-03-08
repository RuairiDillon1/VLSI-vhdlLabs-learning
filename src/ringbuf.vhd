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

-- Ring Buffer stores samples in a circular buffer
-- The read buffer pointer is one buffer entry ahead 
-- of the write buffer pointer. 

entity ringbuf is 
  port (
    clk_i                  : in std_ulogic;
    reset_ni               : in std_ulogic;
    en_i                   : in std_ulogic; 
    data_i                 : in std_ulogic_vector(15 downto 0); 
    data_o                 : out std_ulogic_vector(15 downto 0));
end; 

architecture rtl of ringbuf is

component memory is 
  port (
    clk_i       : in std_ulogic;
    we_i        : in std_ulogic;
    waddr_i     : in unsigned(12 downto 0); 
    raddr_i     : in unsigned(12 downto 0);
    wdata_i     : in std_ulogic_vector(15 downto 0); 
    rdata_o     : out std_ulogic_vector(15 downto 0)
  );
end component; 

  signal raddr, waddr : unsigned(12 downto 0);
 
begin

  mem_i0 : memory
  port map (
    clk_i      => clk_i,
    we_i       => en_i, 
    raddr_i    => raddr,
    waddr_i    => waddr,
    rdata_o    => data_o,
    wdata_i    => data_i);

  buffer_pointer_p : process(clk_i, reset_ni)
  begin
    if reset_ni = '0' then
      waddr <= to_unsigned(0, 13); 
      raddr <= to_unsigned(1, 13); 
    elsif rising_edge(clk_i) then
      if en_i = '1' then
        raddr <= raddr + 1; 
        waddr <= waddr + 1;         
      end if;  
    end if; 
  end process buffer_pointer_p; 
			   
end; -- architecture


