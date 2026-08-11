`timescale 1ns/1ps

module tb_uart_tx;

    logic clk;
    logic rst;
    logic baud_tick;
    logic start;
    logic [7:0] data_in;
    logic tx;
    logic busy;
    logic done;

    uart_tx dut (
        .clk(clk),
        .rst(rst),
        .baud_tick(baud_tick),
        .start(start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy),
        .done(done)
    );

    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1;
        start = 0;
        data_in = 0;
        repeat (3) @(posedge clk);

        rst = 0;
        data_in = 8'd6;
        start = 1;
        repeat (1) @(posedge clk);
        start = 0;
        repeat (45) @(posedge clk);
        $finish;
    end

    initial begin
        baud_tick = 0;
        repeat (3) @(posedge clk);

        forever begin
            baud_tick = 1;
            repeat (1) @(posedge clk);
            baud_tick = 0;
            repeat (3) @(posedge clk);
        end
    end
endmodule