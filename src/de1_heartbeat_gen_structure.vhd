LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

entity de1_heartbeat_gen is 
    port(
    CLOCK_50  : in std_ulogic;
    KEY0       : in std_ulogic;
    LEDR      : out std_ulogic_vector(8 downto 0));
end entity;

architecture structure of de1_heartbeat_gen is 

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
        count_o : out   std_ulogic_vector(15 downto 0); 
        heartbeat_o    : out   std_ulogic
       );
  end component; 

  signal rst_n : std_ulogic; 
  signal heartbeat : std_ulogic;
  signal presc_en : std_ulogic;
begin 

    prescaler : cntdnmodm
    generic map(n => 32, m => 50000)
    port map(
            clk_i => CLOCK_50, 
            rst_ni => rst_n, 
            en_pi => '1', 
            count_o => open, 
            tc_o => presc_en
            );

    heart1 : heartbeat_gen
    port map(
            clk_i => CLOCK_50, 
            rst_ni => rst_n, 
            en_pi => presc_en, 
            count_o => open, 
            heartbeat_o => heartbeat 
            );

    LEDR <= (others => heartbeat);
    rst_n <= KEY0;

end architecture;
