`timescale 1ns/1ps

module tb_baud_tick_gen;

    logic clk;
    logic rst;
    logic tick;

    baud_tick_gen #(
        .CLKS_PER_BIT(4)
    ) dut (
        .clk(clk),
        .rst(rst),
        .tick(tick)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        repeat (2) @(posedge clk);

        rst = 0;
        repeat (20) @(posedge clk);

        $finish;
    end

endmodule