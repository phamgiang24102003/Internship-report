build:
	vlib work
	vmap work work
	vlog rtl/rtl.sv tb/tb.sv
run:
	vsim -debugDB -l test.log -voptargs=+acc -assertdebug -c tb -do "log -r /*; run -all;"
wave:
	vsim -i -view vsim.wlf -do "add wave vsim: /tb/*; radix -decimal" &
