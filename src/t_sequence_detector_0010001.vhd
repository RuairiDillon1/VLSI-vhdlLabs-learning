LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity t_sequence_detector_0010001 is 
end entity;

architecture tbench of t_sequence_detector_0010001 is 
  component sequence_detector is 
    port(
        clk_i : in std_ulogic; 
        rst_n : in std_ulogic; 
        ser_i : in std_ulogic;
        done_o: out std_ulogic
        );
  end component;

  component lfsr_fibonacci is
      port(
          clk_i       : in std_ulogic;
          en_pi       : in std_ulogic;
          rst_n       : in std_ulogic;
          lfsr_o      : out std_ulogic_vector(17 downto 0);
          noise_o     : out std_ulogic; 
          eoc_po      : out std_ulogic 
          );
  end component; 

  signal random_sig, detected: std_ulogic;
  signal seq_boundary : std_ulogic;
  signal sr_val : std_ulogic_vector(17 downto 0);

  signal clk_50     : std_ulogic; 
  signal reset      : std_ulogic;
  constant period : time := 20 ns; 
  signal clken_p : boolean := True;
  signal prescaler : std_ulogic;
begin 

  prescaler <= '1';

  MUV : sequence_detector
  port map(clk_i => clk_50,
           rst_n => reset,           
           ser_i => random_sig,      
           done_o => detected);  

  pattern_generator : lfsr_fibonacci
  port map(clk_i => clk_50, 
           en_pi => prescaler, 
           rst_n => reset, 
           lfsr_o => sr_val, 
           noise_o => random_sig,
           eoc_po => seq_boundary); 

  clock_p : PROCESS
  BEGIN
    WHILE clken_p LOOP
      clk_50 <= '0'; WAIT FOR period/2;
      clk_50 <= '1'; WAIT FOR period/2;
    END LOOP;
    WAIT;
  END PROCESS;

  -- initial reset
  reset <= '0', '1' AFTER period;

  sim_p : process
  begin 
      wait for 262144 * period;
      clken_p <= False;
      wait;
  end process; 
end architecture;
