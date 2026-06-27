module baud_tick_gen #(
    parameter int CLKS_PER_BIT = 4
)(
    input logic clk,
    input logic rst,
    output logic tick
);

    logic [31:0] count;

    always_ff @(posedge clk) begin
        if (rst) begin
            count <= 32'd0;
            tick <= 1'b0;
        end
        else begin
            if (count == CLKS_PER_BIT - 1) begin
                count <= 32'd0;
                tick <= 1'b1;
            end
            else begin
                count <= count + 32'd1;
                tick <= 1'b0;
            end
        end
    end

endmodule