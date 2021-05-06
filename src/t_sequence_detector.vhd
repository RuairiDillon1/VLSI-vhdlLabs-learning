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
use ieee.math_real.all;

entity t_sequence_detector is
end;

architecture tbench of t_sequence_detector is


component lfsr_fibonacci is 
    port(
        clk_i       : in std_ulogic;
        en_pi       : in std_ulogic;
        rst_n       : in std_ulogic;
        lfsr_o      : out std_ulogic_vector(3 downto 0);
        noise_o     : out std_ulogic; 
        eoc_po      : out std_ulogic );
end component;

component sequence_detector IS
  PORT (clk: IN std_ulogic;
        rst_n: IN std_ulogic;
        ser_i: IN std_ulogic;
        done_o: OUT std_ulogic);
END component; 

  signal clk, reset_n, noise, seq_detected   : std_ulogic;
  signal sig_counter : unsigned(15 downto 0);
 
  constant period : time := 20 ns; 
  signal clken_p : boolean := True;

begin

  muv  : sequence_detector
    port map (
      clk       =>  clk,
      rst_n     =>  reset_n,
      ser_i     =>  noise,
      done_o    =>  seq_detected
	);

  pattern_generator : lfsr_fibonacci
    port map(
        clk_i   =>    clk,
        en_pi   =>    '1',
        rst_n   =>    reset_n, 
        lfsr_o  =>    open,
        noise_o =>    noise, 
        eoc_po  =>    open
	);
---------------------------------------------------

sig_counter <= to_unsigned(0, sig_counter'length) when reset_n = '0' else 
		 sig_counter + to_unsigned(1, sig_counter'length) when seq_detected = '1' and rising_edge(clk);

  clock_p : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk <= '0'; WAIT FOR period/2;
      clk <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- initial reset
  reset_n <= '0', '1' AFTER period;

  sim_p : process
  begin 
      wait for 16*period*2 ;
      clken_p <= False;
      wait;
  end process; 
		


end;  -- architecture
