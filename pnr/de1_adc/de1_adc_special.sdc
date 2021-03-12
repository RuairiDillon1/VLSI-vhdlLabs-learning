create_clock -period 20.000 -name CLOCK_50 [get_ports CLOCK_50]
# PLL to generate 65 MHz from 50 MHz
create_generated_clock -source altpll:pll_i0|pll|inclk[0] \
  -name pll_clk \
  -multiply_by 13 \
  -divide_by 10 \
  -master_clock CLOCK_50 \
  [get_pins altpll:pll_i0|pll|clk[0]]

set default_inputs [get_ports KEY0]
set default_inputs [add_to_collection $default_inputs [get_ports ADC_OTR*]]

# The PLL also provides some clock for ADC/DAC Board
set clock_outputs [get_ports ADC_CLK*]
set clock_outputs [add_to_collection $clock_outputs [get_ports DAC_CLK*]]
set clock_outputs [add_to_collection $clock_outputs [get_ports DAC_WRT*]]

set default_outputs [remove_from_collection [all_outputs] [get_ports DAC_D*]] 
set default_outputs [remove_from_collection $default_outputs $clock_outputs]

# Default Timing Constrains for Inputs/Outputs
set_input_delay -clock pll_clk 5 $default_inputs
set_output_delay -clock pll_clk 5 $default_outputs
# Special Timing for ADC and DAC Data I/O
set_input_delay -clock pll_clk 12 [get_ports ADC_D*]
set_output_delay -clock pll_clk -clock_fall 10 [get_ports DAC_D*]
# Special Timing for clock outputs 
set_output_delay -clock pll_clk 2 $clock_outputs
