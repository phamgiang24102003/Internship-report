`timescale 1ps/1ps

module tb;
    // Tín hiệu kiểm tra
    bit clk, rst;
    logic [1:0] request;
    logic [1:0] grant;

    // Bộ sinh xung clock: chu kỳ 10ps
    always #5 clk = ~clk;

    // Gắn RTL vào testbench
    rtl dut (
        .clk(clk),
        .rst(rst),
        .request(request),
        .grant(grant)
    );

    // Reset ban đầu
    initial begin
        clk = 0;
        rst = 1;
        request = 0;
        #12;   // Đảm bảo reset giữ trong ít nhất 1.2 chu kỳ
        rst = 0;
    end

    // Test logic
    initial begin
        // Chờ sau reset
        @(negedge rst);

        // Đợi cạnh lên tiếp theo, rồi đưa request
        @(posedge clk);
        #1;  // delay nhỏ để tránh race
        request = 2'b01;
        $display("@%0t: Drove request = %b", $time, request);

        // Đợi 1 chu kỳ để DUT phản hồi
        @(posedge clk);
        #1;
        if (grant == 2'b01)
            $display("@%0t: ✅ Success: grant == %b", $time, grant);
        else
            $display("@%0t: ❌ Fail: grant == %b (expected 2'b01)", $time, grant);

        // Thử thêm 1 trường hợp nữa
        @(posedge clk);
        #1;
        request = 2'b10;
        $display("@%0t: Drove request = %b", $time, request);

        @(posedge clk);
        #1;
        if (grant == 2'b10)
            $display("@%0t: ✅ Success: grant == %b", $time, grant);
        else
            $display("@%0t: ❌ Fail: grant == %b (expected 2'b10)", $time, grant);

        // Dừng mô phỏng
        $finish;
    end

    // Theo dõi toàn bộ biến
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, tb);
    end

endmodule
