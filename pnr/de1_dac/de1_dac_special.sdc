create_clock -period 20.000 -name CLOCK_50 [get_ports CLOCK_50]
# PLL to generate 100 MHz clock
create_generated_clock -source altpll:pll_i0|pll|inclk[0] \
  -name pll_clk \
  -multiply_by 2 \
  -master_clock CLOCK_50 \
  [get_pins altpll:pll_i0|pll|clk[0]]

set_input_delay -clock CLOCK_50 2 [all_inputs]
set_output_delay -clock CLOCK_50 2 [all_outputs]


