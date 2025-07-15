module rtl (
	input bit rst, clk,
	input logic [1:0] request,
	output logic [1:0] grant
);
	always_ff@(posedge clk or posedge rst) begin
		if (rst)
			grant <= 2'b00;
		else if (request[0])
			grant <= 2'b01;
		else if (request[1])
			grant <= 2'b10;
		else
			grant <= 'b0;
	end

endmodule
