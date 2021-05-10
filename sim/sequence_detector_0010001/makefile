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

PROJECT =sequence_detector_0010001

include ./makefile.sources

# Add here the testbench file
SOURCE_FILES = $(SYN_SOURCE_FILES) \
../../src/sequence_detector_0010001.vhd \
../../src/t_$(PROJECT).vhd

include ../makefile

