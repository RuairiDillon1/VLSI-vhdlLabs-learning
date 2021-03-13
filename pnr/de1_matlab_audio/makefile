MATLAB_PROJECT_NAME = audio
PROJECT = de1_matlab_$(MATLAB_PROJECT_NAME)

# Matlab produces a xxx_compile.do file which contains the vhdl files belonging to the project
# Here I produce a list of these source files with full relative path to the matlab project
SIMULINK_PATH=../../matlab/$(MATLAB_PROJECT_NAME)/hdl_prj/hdlsrc/$(MATLAB_PROJECT_NAME)
MATLAB_SOURCE_FILE_NAMES = $(shell grep vcom $(SIMULINK_PATH)/*_compile.do | sed "s/vcom  \(.*\)/\1/g")
MATLAB_SOURCE_FILES = $(foreach file,$(MATLAB_SOURCE_FILE_NAMES),$(SIMULINK_PATH)/$(file))

SOURCE_FILES = \
../../src/adcintf.vhd \
../../src/bclk.vhd \
../../src/dacintf.vhd \
../../src/fsgen.vhd \
../../src/i2c_sub.vhd \
../../src/i2c.vhd \
../../src/i2c_write.vhd \
../../src/mclk.vhd \
../../src/audio.vhd \
../../src/de1_matlab_audio.vhd $(MATLAB_SOURCE_FILES)

FAMILY = "Cyclone II"
DEVICE = EP2C20F484C7
PROGFILEEXT = sof

include ../makefile
