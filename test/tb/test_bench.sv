`timescale 1ns/1ns

//`include "top.sv"
`include "Transaction.sv"

module test_bench;
	bit CLK;

	always #10 CLK = ~CLK;				//CLK 50Mhz

	tb_if _if (CLK);
	top dut (.top_if (_if));

	initial begin
		Transaction _tr;
		$display("Starting TEST BENCH...");

		_tr = new();

		// TEST CASE 1: TEST RESET
		$display("TEST CASE 1: TEST RESET HIGH");
		$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
		_if.RST_N = 0;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		_if.PARITY_MODE = 2'b00;
		#30;

		_if.RST_N = 0;
		_if.VALID = 1;
		_if.DATA_IN = 8'hFF;
		_if.PARITY_MODE = 2'b01;
		#20;
		$display("END TEST CASE 1");

		// TEST CASE 2: TEST VALID
		$display("TEST CASE 2: TEST VALID LOW");
		$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
		_if.RST_N = 0;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		_if.PARITY_MODE = 2'b00;
		#20;

		_if.RST_N = 1;
		_if.VALID = 0;
		_if.DATA_IN = 8'hFF;
		_if.PARITY_MODE = 2'b01;
		#200;

		_if.RST_N = 0;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		_if.PARITY_MODE = 2'b00;
		#200;
		$display("END TEST CASE 2");

		//RESET = 1
		_if.RST_N = 1;
		#20;

		// TEST CASE 3: VALID = 1, no parity
		$display("TEST CASE 3: PARITY_MODE = {00 11}, DATA_IN = {8'ha3 8'hFF}");
		$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
		_if.VALID = 1;
		_if.DATA_IN = 8'ha3;
		_if.PARITY_MODE = 2'b00;
		#20;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		#200;

		_if.VALID = 1;
		_if.DATA_IN = 8'hFF;
		_if.PARITY_MODE = 2'b11;
		#20;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		#200;
		$display("END TEST CASE 3");

		// TEST CASE 4: VALID = 1, even parity
		$display("TEST CASE 4: PARITY_MODE = 01, DATA_IN = 8'hF4");
		$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
		_if.VALID = 1;
		_if.DATA_IN = 8'hF4;
		_if.PARITY_MODE = 2'b01;
		#20;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		#200;
		$display("END TEST CASE 4");

		// TEST CASE 5: VALID = 1, odd parity
		$display("TEST CASE 5: PARITY_MODE = 10, DATA_IN = 8'h4F");
		$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
		_if.VALID = 1;
		_if.DATA_IN = 8'h4F;
		_if.PARITY_MODE = 2'b10;
		#20;
		_if.VALID = 0;
		_if.DATA_IN = 8'h00;
		#200;
		$display("END TEST CASE 5");
/*
		//TEST CASE RANDOMIZATION
		$display("TEST CASE RANDOMIZATION");
		for (int i = 0; i < 3; i ++) begin
			_tr.randomize();
			_tr.display();
			$display("Time  RST_N   VALID   PARITY  DATA_IN  TXD");
			_if.VALID = 1;
			_if.DATA_IN = _tr.data_in;
			_if.PARITY_MODE = _tr.parity_mode;
			#20;

			_if.VALID = 0;
			_if.DATA_IN = 8'h00;
			#200;
		end
		$display("END TEST CASE RANDOMIZATION");
*/
		$display("Testbench completed.");
		$stop;
	end

	initial begin
		forever begin
			@(posedge CLK);#1;
			$display("%0t\t%b\t%b\t%02b\t%02h\t%b", $time, _if.RST_N, _if.VALID, _if.PARITY_MODE, _if.DATA_IN, _if.TXD);
		end
	end

	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
	end

endmodule
