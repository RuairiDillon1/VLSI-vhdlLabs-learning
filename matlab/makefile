###################################################################
# Main Targets
###################################################################

help:
	@echo '"make" does intentionally nothing. Type:'
	@echo '  "make hdl"      - create vhdl files from matlab simulink model'
	@echo '  "make clean"    - to remove all generated files'

hdl: $(PROJECT).slx
	# create hdl from matlab
	matlab -nodisplay -nosplash -nodesktop -r "$(PROJECT); makehdl('$(TOPLEVEL)') ;exit;"

clean:
	rm -rf hdl_prj slprj *~
