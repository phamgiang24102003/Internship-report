//`include "../tb/tb_if.sv"

module top (tb_if.DUT top_if);
	reg [1:0] state;
	localparam	IDLE = 2'd0,
			SEND_BYTE = 2'd1,
			SEND_PARITY = 2'd2,
			DONE = 2'd3;

	reg [8:0] data;
	reg [3:0] bit_cnt;

	always@(posedge top_if.CLK or negedge top_if.RST_N) begin
		if (!top_if.RST_N) begin
			state <= IDLE;
			data <= 9'b0;
			bit_cnt <= 4'd0;
			top_if.TXD <= 1'b0;
		end
		else begin
			case (state)
				IDLE : begin
					if (top_if.VALID) begin
						bit_cnt <= 4'd0;
						data[7:0] <= top_if.DATA_IN;
						if (top_if.PARITY_MODE == 2'b01 || top_if.PARITY_MODE == 2'b10) begin
							data[8] <= (top_if.PARITY_MODE == 2'b01) ? ~(^top_if.DATA_IN) : (^top_if.DATA_IN);
						end
						else begin
							data[8] <= 1'b0;
						end
						state <= SEND_BYTE;
					end
				end

				SEND_BYTE : begin
					top_if.TXD <= data[bit_cnt];
					bit_cnt <= bit_cnt + 1;
					if (bit_cnt == 4'd7) begin
						if (top_if.PARITY_MODE == 2'b01 || top_if.PARITY_MODE == 2'b10) begin
							state <= SEND_PARITY;
						end
						else begin
							state <= DONE;
						end
					end
				end

				SEND_PARITY : begin
					top_if.TXD <= data[8];
					state <= DONE;
				end

				DONE : begin
					top_if.TXD <= 1'b0;
					state <= IDLE;
				end
			endcase
		end
	end

endmodule
