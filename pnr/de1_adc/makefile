SIM_PROJECT_NAME = de1_adc
PROJECT = $(SIM_PROJECT_NAME)

FAMILY = "Cyclone II"
DEVICE = EP2C20F484C7
PROGFILEEXT = sof

SOURCE_FILES = ../../src/de1_adc_rtl.vhd 

include ../makefile

# Use the specific sdc file
$(PROJECT).sdc: $(PROJECT)_special.sdc
	ln -s $(PROJECT)_special.sdc $(PROJECT).sdc
