module non_restoring_div(
    input [31:0] src1,
    input [31:0] src2,
    output [31:0] qut,
    output [31:0] rmd
);
    // Internal variables for division algorithm
    reg [32:0] acc;
    reg [31:0] q;
    reg [31:0] m;
    integer i;

    always @(*) begin
        // Initialize variables
        m = src2;
        acc = 33'b0;
        q = src1;

        // Non-restoring division algorithm
        for (i = 0; i < 32; i = i + 1) begin
            // Left shift accumulator and quotient
            {acc, q} = {acc, q} << 1;

            // Subtract divisor
            acc = acc - {1'b0, m};

            // Check sign of accumulator
            if (acc[32]) begin
                // If negative, restore and set quotient bit to 0
                acc = acc + {1'b0, m};
                q[0] = 0;
            end else begin
                // If positive, keep result and set quotient bit to 1
                q[0] = 1;
            end
        end

        // Final correction if needed
        if (acc[32]) begin
            acc = acc + {1'b0, m};
        end
    end

    // Outputs
    assign qut = q;
    assign rmd = acc[31:0];
endmodule