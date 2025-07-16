interface tb_if (input CLK);
	logic RST_N;
	logic VALID;
	logic [7:0] DATA_IN;
	logic [1:0] PARITY_MODE;
	logic TXD;
/*
	clocking cb @(posedge CLK);
		default input #1ns output #1ns;
		output VALID, DATA_IN, PARITY_MODE;
		output RST_N;
		input TXD;
	endclocking
*/
	modport DUT (
		input CLK, RST_N,
		input VALID, DATA_IN, PARITY_MODE,
		output TXD
	);

endinterface
