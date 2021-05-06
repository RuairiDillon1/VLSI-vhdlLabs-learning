LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity sequence_detector is 
  port(
      clk_i : in std_ulogic; 
      rst_n : in std_ulogic; 
      ser_i : in std_ulogic;
      done_o: out std_ulogic; 
      );
end entity;

architecture rtl of sequence_detector is 
  type state_t is (first0, second0, third0, fourth0, fifth0, first1, second1, init); 
  signal c_state, n_state : state_t;
begin 

  sm_p : process(ser_i)
    --default assignments
    done_o <= '0';

    --output-logic and next-state-logic
    case c_state is 
      when init     => 
        if ser_i = '0' then 
          n_state <= first0;
        else 
          n_state <= init;

      when first0   => 
        if ser_i = '0' then 
          n_state <= second0;
        else 
          n_state <= init;

      when second0  => 
        if ser_i = '1' then 
          n_state <= first1;

      when first1   => 
        if ser_i = '0' then 
          n_state <= third0;
        else 
          n_state <= init;

      when third0   => 
        if ser_i = '0' then 
          n_state <= fourth0;
        else 
          n_state <= init;

      when fourth0  => 
        if ser_i = '0' then 
          n_state <= fifth0;
        else 
          n_state <= first1;

      when fifth0   =>
        if ser_i = '1' then 
          n_state <= second1;
        else 
          n_state <= second0;

      when second1  => 
        --sequence detected
        done_o <= '1';
        if ser_i = '0' then 
          n_state <= first0;
        else 
          n_state <= init;
    end case;

    c_state <= init when rst_n = '0' else n_state when rising_edge(clk_i);
end architecture;
