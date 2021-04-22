LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity t_heartbeat_gen is 
end entity; 

architecture tbench of t_heartbeat_gen is 

  COMPONENT cntdnmodm
    GENERIC (
      n : natural;
      m : natural);
    PORT (
      clk_i   : IN  std_ulogic;
      rst_ni  : IN  std_ulogic;
      en_pi   : IN  std_ulogic;
      count_o : OUT std_ulogic_vector(n-1 DOWNTO 0);
      tc_o    : OUT std_ulogic);
  END COMPONENT;

  component heartbeat_gen is
   port(
        clk_i   : in    std_ulogic; 
        rst_ni  : in    std_ulogic; 
        en_pi   : in    std_ulogic; 
        count_o : out   std_ulogic_vector(63 downto 0); 
        heartbeat_o    : out   std_ulogic
       );
  end component; 

  signal clk_50 : std_ulogic; 
  signal reset : std_ulogic;
  signal prescaler_en  : std_ulogic;
  signal beat : std_ulogic; 

  constant period : time := 20 ns; 
  signal clken_p : boolean := True;

begin 

    prescaler : cntdnmodm 
    generic map(n => 32, m => 21650000)
    port map(
            clk_i => clk_50, 
            rst_ni => reset, 
            en_pi => '1', 
            count_o => open, 
            tc_o => prescaler_en
            );

    heart1 : heartbeat_gen
    port map(
            clk_i => clk_50, 
            rst_ni => reset, 
            en_pi => prescaler_en, 
            count_o => open, 
            heartbeat_o => beat
            );

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
      wait for 21650000 * 2 * period;
      clken_p <= False;
      wait;
  end process; 
end architecture; 
