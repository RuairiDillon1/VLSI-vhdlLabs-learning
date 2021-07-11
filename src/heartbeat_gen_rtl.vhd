LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity heartbeat_gen is 
   port(
        clk_i           : in    std_ulogic; 
        rst_ni          : in    std_ulogic; 
        en_pi           : in    std_ulogic; 
        count_o         : out   std_ulogic_vector(15 downto 0); 
        heartbeat_o     : out   std_ulogic
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


  type state_t is (QRS_s, ST_s, T_s, TQ_s);
  signal en_qrs, en_st, en_t, en_tq : boolean;
  signal heartbeat : std_ulogic;
  signal c_state, n_state : state_t;

  signal counter_val : std_ulogic_vector(15 downto 0); 
  signal counter_finished: std_ulogic;
begin 

  heartbeat_o <= heartbeat;  

  sm_p : process(c_state, en_qrs, en_st, en_t, en_tq)
  begin
    n_state <= c_state;
    heartbeat <= '0';

    case c_state is
      when TQ_s =>
        if unsigned(counter_val) = 400 then 
          n_state <= QRS_s; 
        end if;

      when QRS_s =>
        heartbeat <= '1';
        if unsigned(counter_val) = 300 then 
          n_state <= ST_s; 
        end if;

      when ST_s =>
        if unsigned(counter_val)= 160 then 
          n_state <= T_s; 
        end if;

      when T_s =>
        heartbeat <= '1';
        if counter_finished then n_state <= TQ_s; end if;
    end case;
  end process sm_p;

  c_state <= TQ_s when rst_ni = '0' else 
           n_state when rising_edge(clk_i) and en_pi = '1';

  counter_QRS : cntdnmodm
   generic map (n => 16, m => 833)
    PORT MAP(clk_i   => clk_i,
             rst_ni   => rst_ni,
             en_pi  => en_pi,
             count_o => counter_val,
             tc_o  => counter_finished);

  count_o <=  counter_val;

end architecture; 
