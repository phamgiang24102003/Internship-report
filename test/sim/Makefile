build:
	vlib work
	vmap work work
	vlog -f compile.f
run:
	vsim -debugDB -l test.log -voptargs=+acc -assertdebug -c test_bench -do "log -r /*; run -all;"
wave:
	vsim -i -view vsim.wlf -do "add wave vsim: /_if/*; radix -decimal" &
