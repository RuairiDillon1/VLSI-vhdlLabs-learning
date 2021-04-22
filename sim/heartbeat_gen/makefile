## ----------------------------------------------------------------------------
## Script     : makefile
## ----------------------------------------------------------------------------
## Author     : Johann Faerber, Friedrich Beckmann
## Company    : University of Applied Sciences Augsburg
## ----------------------------------------------------------------------------
## Description: This makefile allows automating design flow with ModelSim,
##              it is based on a design directory structure described in 
##              ../makefile
## ----------------------------------------------------------------------------

###################################################################
# Project Configuration: 
#
# assign variable PROJECT with the top level project name
#
# Prerequisite: 
#   - mandatory design directory structure (see end of file)
#   - assumes file name of testbench t_$(PROJECT).vhd
###################################################################

PROJECT =heartbeat_gen

include ./makefile.sources

# Add here the testbench file
SOURCE_FILES = $(SYN_SOURCE_FILES) \
../../src/heartbeat_gen_rtl.vhd \
../../src/t_$(PROJECT).vhd

include ../makefile

