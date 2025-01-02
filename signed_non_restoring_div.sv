module signed_non_restoring_div(
    input [31:0] src1,
    input [31:0] src2,
    output [31:0] qut,
    output [31:0] rmd
);
    // Internal variables for division algorithm
    reg [32:0] acc;
    reg [31:0] q;
    reg [31:0] m;
    reg sign_dividend, sign_divisor, sign_result;
    reg [31:0] abs_dividend, abs_divisor;
    integer i;

    always @(*) begin
        // Handle sign of dividend and divisor
        sign_dividend = src1[31];
        sign_divisor = src2[31];
        sign_result = sign_dividend ^ sign_divisor;

        // Take absolute values for computation
        abs_dividend = sign_dividend ? -src1 : src1;
        abs_divisor = sign_divisor ? -src2 : src2;

        m = abs_divisor;
        acc = 33'b0;
        q = abs_dividend;

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

        // Apply sign to quotient
        q = sign_result ? -q : q;

        // Correct remainder sign based on dividend sign
        acc[31:0] = sign_dividend ? -acc[31:0] : acc[31:0];

        // Ensure remainder sign matches dividend sign
//        if (sign_dividend && acc != 0) begin
//            acc[31:0] = -acc[31:0];
//        end
    end

    // Outputs
    assign qut = q;
    assign rmd = acc[31:0];
endmodule
