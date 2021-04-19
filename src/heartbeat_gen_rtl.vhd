LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity heartbeat_gen is 
   port(
        clk_i   : in    std_ulogic; 
        rst_ni  : in    std_ulogic; 
        en_pi   : in    std_ulogic; 
        count_o : out   std_ulogic_vector(63 downto 0); 
        tc_o    : out   std_ulogic
       );
end entity;

architecture rtl of heartbeat_gen is 

    component cntdnmodm is 
        port map (
              GENERIC (
                n : natural := 4;                   -- counter width
                m : natural := 10);                 -- modulo value
              PORT (clk_i   : IN  std_ulogic;
                    rst_ni  : IN  std_ulogic;
                    en_pi   : IN  std_ulogic;
                    count_o : OUT std_ulogic_vector(n-1 DOWNTO 0);
                    tc_o    : OUT std_ulogic
                    );
                 );
    end component; 

begin 


end architecture; 
