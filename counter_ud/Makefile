build:
	vlib work
	vmap work work
	vlog tb.sv
run:
	vsim -debugDB -l test.log -voptargs=+acc -assertdebug -c tb -do "log -r /*; run -all;"
wave:
	vsim -i -view vsim.wlf -do "add wave vsim: /cnter_IF/*; radix -decimal" &
