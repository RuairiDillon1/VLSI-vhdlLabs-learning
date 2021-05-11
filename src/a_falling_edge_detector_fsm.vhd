library IEEE;
use IEEE.std_logic_1164.all;

architecture fsm of falling_edge_detector is

type state_t is (high_s, detection_s, low_s, init);
  signal current_state, next_state: state_t;

begin

  sm_p : process(x_i, current_state)
  begin
    --default assignments
    fall_o <= '0';
    next_state <= current_state;

    --output-logic and next-state-logic
    case current_state is 
      when init     =>  -- initialising 
        if x_i = '0' then 
          next_state <= low_s;
        else 
          next_state <= high_s;
        end if;

      when low_s     =>  -- low state

        if x_i = '0' then 
          next_state <= low_s;
        else 
          next_state <= high_s;
        end if;

      when high_s     =>   -- high state
        if x_i = '0' then 
          next_state <= detection_s;
        else 
          next_state <= high_s;
        end if;

      when detection_s     =>  -- detection state
	fall_o <= '1';
        if x_i = '0' then 
          next_state <= low_s;
        else 
          next_state <= high_s;

        end if;


end case;
end process;

    current_state <= init when rst_ni = '0' else next_state when rising_edge(clk_i);

end architecture;
