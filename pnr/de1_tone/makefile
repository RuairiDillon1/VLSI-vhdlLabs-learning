SIM_PROJECT_NAME = de1_tone
PROJECT = $(SIM_PROJECT_NAME)

# Here the VHDL files for synthesis are defined. 
include ../../sim/$(SIM_PROJECT_NAME)/makefile.sources

# Add the toplevel fpga vhdl file
SOURCE_FILES = $(SYN_SOURCE_FILES)

FAMILY = "Cyclone II"
DEVICE = EP2C20F484C7
PROGFILEEXT = sof

include ../makefile
