`timescale 1ns/1ps

module tb_counter;

    logic clk;
    logic rst;
    logic [7:0] count;

    counter dut (
        .clk(clk),
        .rst(rst),
        .count(count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        repeat (2) @(posedge clk);
        rst = 0;
        repeat (10) @(posedge clk);
        $finish;
    end

endmodule