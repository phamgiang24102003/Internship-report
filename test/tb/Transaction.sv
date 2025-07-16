class Transaction;
	rand bit [7:0] data_in;
	rand bit [1:0] parity_mode;

	constraint c_parity_mode {
		parity_mode inside {[2'b00:2'b11]};
	}

	constraint c_data_in {
		data_in inside {[8'd0:8'd255]};
	}

	function void display ();
		$display ("PARITY_MODE = %0b, DATA_IN = %0h", parity_mode, data_in);
	endfunction

endclass
