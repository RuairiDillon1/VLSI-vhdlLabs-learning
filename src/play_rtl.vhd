------------------------------------------------------------------
-- module     : play
------------------------------------------------------------------
-- author     : Friedrich Beckmann
-- company    : university of applied sciences augsburg
------------------------------------------------------------------
-- description: Statemachine for LED game
--              
------------------------------------------------------------------
-- revisions : 0.1 - 
------------------------------------------------------------------

-- 5 LED outputs
-- One one-second enable input
-- KEY input with preceding rising_edge detector

-- step LED4 LED3 LED2 LED1 LED0
--  1    x    -    -    -    -
--  2    -    x    -    -    -
--  3    -    -    x    -    -
--  4    -    -    -    x    -
--  5    -    -    -    -    x
--  6    x    -    -    -    -
--  ...  this pattern continues
-- If LED2 is on and KEY is pressed then the pattern continues as follows
--  1    x    -    -    -    -
--  2    -    -    -    -    x
--  ... this pattern continues until
--  KEY is pressed again. Then the previous pattern restarts from LED 2

library ieee;
use ieee.std_logic_1164.all;

entity play is
  port (clk        : in  std_ulogic;
        rst_n      : in  std_ulogic;
        onesec_i   : in  std_ulogic;
        key_i      : in  std_ulogic;
        led_o      : out std_ulogic_vector(4 downto 0));
end play;

architecture rtl of play is

  type state_t is (start_s,one_s,chance_s,four_s,last_s,hit0_s,hit1_s);
  signal current_state,next_state : state_t;

begin

  current_state <= start_s when rst_n = '0' else next_state when rising_edge(clk);

  next_p : process(current_state, onesec_i, key_i)
    begin
      next_state <= current_state;
      led_o <= "00000";
      case current_state is
        when start_s =>
          led_o <= "10000";
          if onesec_i = '1' then
            next_state <= one_s;            
          end if;
        when one_s =>
          led_o <= "01000";
          if onesec_i = '1' then 
            next_state <= chance_s;
          end if;
        when chance_s =>
          led_o <= "00100";
          if key_i = '1' then
            next_state <= hit0_s;
          elsif onesec_i = '1' then
            next_state <= four_s; 
          end if;
        when four_s =>
          led_o <= "00010";
          if onesec_i = '1' then
            next_state <= last_s;
          end if;
        when last_s =>
          led_o <= "00001";
          if onesec_i = '1' then
            next_state <= start_s;
          end if;
        when hit0_s =>
          led_o <= "10000";
          if key_i = '1' then
            next_state <= chance_s;
          elsif onesec_i = '1' then
            next_state <= hit1_s;
          end if;
        when hit1_s =>
          led_o <= "00001";
          if key_i = '1' then
            next_state <= chance_s;
          elsif onesec_i = '1' then
            next_state <= hit0_s;
          end if;         
        when others => null;
      end case;
    end process;
        
end architecture rtl;
