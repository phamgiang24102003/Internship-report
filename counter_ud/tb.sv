`timescale 1ns/1ps

`include "cud_if.sv"
`include "counter_ud.sv"

module tb;
	bit clk;

	always # 10 clk = ~clk;

	cud_if cnter_IF (clk);

	counter_ud dut0 (cnter_IF);

	initial begin
		clk = 0;
        cnter_IF.rstn     = 0;
        cnter_IF.load_en  = 0;
        cnter_IF.load     = 4'd0;
        cnter_IF.ud       = 1'b1;

        // Reset giữ trong 2 chu kỳ clock
        #25;
        cnter_IF.rstn = 1;

        // Tải giá trị = 5
        @(posedge clk);
        cnter_IF.load     = 4'd5;
        cnter_IF.load_en  = 1'b1;
        @(posedge clk);
        cnter_IF.load_en  = 1'b0;

        // Đếm lên trong 25 chu kỳ
        cnter_IF.ud = 1'b1;
        repeat (25) @(posedge clk);

        // Đếm xuống trong 3 chu kỳ
        cnter_IF.ud = 1'b0;
        repeat (3) @(posedge clk);

        $finish;
    end

    // Quan sát kết quả
	always @(posedge clk) begin
	    $display("[%0t ns] count = %0d, ud = %0b, rollover = %0b", 
	             $time, cnter_IF.count, cnter_IF.ud, cnter_IF.rollover);
	end

endmodule
