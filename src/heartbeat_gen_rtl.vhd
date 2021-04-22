LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity heartbeat_gen is 
   port(
        clk_i   : in    std_ulogic; 
        rst_ni  : in    std_ulogic; 
        en_pi   : in    std_ulogic; 
        count_o : out   std_ulogic_vector(63 downto 0); 
        heartbeat_o    : out   std_ulogic
       );
end entity;

architecture rtl of heartbeat_gen is 

    component cntdnmodm is 
              GENERIC (
                n : natural := 4;                   -- counter width
                m : natural := 10);                 -- modulo value
              PORT (clk_i   : IN  std_ulogic;
                    rst_ni  : IN  std_ulogic;
                    en_pi   : IN  std_ulogic;
                    count_o : OUT std_ulogic_vector(n-1 DOWNTO 0);
                    tc_o    : OUT std_ulogic
                    );
    end component; 


  type state_t is (idle_s, QRS_s, ST_s, TU_s);
  signal QRS_ready : std_ulogic;
  signal TU_ready : std_ulogic;
  signal ST_ready : std_ulogic;
  signal heartbeat : std_ulogic;
  signal QRS_en : std_ulogic;
  signal ST_en : std_ulogic;
  signal TU_en : std_ulogic;
  signal c_state, n_state : state_t;



begin 

  heartbeat_o <= heartbeat;  

  sm_p : process(c_state, QRS_ready, TU_ready, ST_ready, en_pi)
  begin
  n_state <= c_state;
  heartbeat <= '0';
  ST_en <= '0';
  QRS_en <= '0';
  TU_en <= '0';

  case c_state is
    when idle_s =>
    if en_pi = '1' then n_state <= QRS_s; end if;

    when QRS_s =>
    heartbeat <= '1';
    QRS_en <= '1';
    if QRS_ready = '1' then n_state <= ST_s; end if;


    when ST_s =>
    ST_en <= '1';
    if ST_ready = '1' then n_state <= TU_s; end if;

    when TU_s =>
    heartbeat <= '1';
    TU_en <= '1';
    if TU_ready = '1' then n_state <= idle_s; end if;

  end case;
  end process sm_p;

c_state <= idle_s when rst_ni = '0' else 
           n_state when rising_edge(clk_i);

  counter_QRS : cntdnmodm
   generic map (n => 32, m => 5000000)

    PORT MAP(clk_i   => clk_i,
             rst_ni   => rst_ni,
             en_pi  => QRS_en,
             count_o => open,
             tc_o  => QRS_ready);

  counter_ST : cntdnmodm

   generic map (n => 32, m => 7000000)

    PORT MAP(clk_i   => clk_i,
             rst_ni   => rst_ni,
             en_pi  => ST_en,
             count_o => open,
             tc_o  => ST_ready);


  counter_TU : cntdnmodm

   generic map (n => 32, m => 8000000)

    PORT MAP(clk_i   => clk_i,
             rst_ni   => rst_ni,
             en_pi  => TU_en,
             count_o => open,
             tc_o  => TU_ready);


end architecture; 
