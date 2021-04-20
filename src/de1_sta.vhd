library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de1_sta is
  port (
    CLOCK_50 : in  std_ulogic;
    x_i      : in  unsigned(7 downto 0);
    y_o      : out unsigned(x_i'range)
    );
end de1_sta;

architecture rtl of de1_sta is

signal a,b,c,d : unsigned(x_i'range);
signal sum : unsigned(x_i'range);
signal clk : std_ulogic;

begin

clk <= CLOCK_50;

sum <= a + b + c + d;

y_o <= sum when rising_edge(clk);

a <= x_i when rising_edge(clk);
b <= a when rising_edge(clk);
c <= b when rising_edge(clk);
d <= c when rising_edge(clk);

end architecture;
