module uart_tx (
    input logic clk,
    input logic rst,
    input logic baud_tick,
    input logic start,
    input logic [7:0] data_in,
    output logic tx,
    output logic busy,
    output logic done
);

    typedef enum logic [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        DONE
    } state_t;

    state_t state, next_state;
    logic [2:0] bit_index;
    logic [7:0] data_reg;

    always_ff @(posedge clk) begin
        if (rst) begin
            state <= IDLE;
            bit_index <= 3'd0;
            data_reg <= 8'd0;
        end
        else begin
            state <= next_state;

            if (state == IDLE && start) begin
                data_reg <= data_in;
                bit_index <= 3'd0;
            end

            if (state == DATA && baud_tick) begin
                if (bit_index == 3'd7)
                    bit_index <= 3'd0;
                else
                    bit_index <= bit_index + 3'd1;
            end
        end
    end

    always_comb begin
        next_state = state;

        case (state)
            IDLE: begin
                if (start)
                    next_state = START;
            end

            START: begin
                if (baud_tick)
                    next_state = DATA;
            end

            DATA: begin
                if (baud_tick && bit_index == 3'd7)
                    next_state = STOP;
            end

            STOP: begin
                if(baud_tick)
                    next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always_comb begin
        tx = 1'b1;
        busy = 1'b0;
        done = 1'b0;

        case (state)
            IDLE: begin
                tx = 1'b1;
                busy = 1'b0;
                done = 1'b0;
            end

            START: begin
                tx = 1'b0;
                busy = 1'b1;
                done = 1'b0;
            end

            DATA: begin
                tx = data_reg[bit_index];
                busy = 1'b1;
                done = 1'b0;
            end

            STOP: begin
                tx = 1'b1;
                busy = 1'b1;
                done = 1'b0;
            end

            DONE: begin
                tx = 1'b1;
                busy = 1'b0;
                done = 1'b1;
            end
        endcase
    end

endmodule