`include "cud_if.sv"

module counter_ud (cud_if.DUT cnter_IF);
	always_ff @ (posedge cnter_IF.clk or negedge cnter_IF.rstn) begin
		if (cnter_IF.rstn == 1'b0)
			cnter_IF.count <= 0;
		else if (cnter_IF.load_en)
			cnter_IF.count <= cnter_IF.load;
		else begin
			if (cnter_IF.ud)
				cnter_IF.count <= cnter_IF.count + 1;
			else
				cnter_IF.count <= cnter_IF.count - 1;
		end
	end

	assign cnter_IF.rollover = &cnter_IF.count;

endmodule
