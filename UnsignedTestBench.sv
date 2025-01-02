`timescale 1ns / 1ps

module UnsignedTestBench;

    // Inputs
    reg [31:0] src1;
    reg [31:0] src2;

    // Outputs
    logic [31:0] qut;
    logic [31:0] rmd;

    // Expected outputs
    reg [31:0] expected_qut;
    reg [31:0] expected_rmd;

    // Instantiate the Unit Under Test (UUT)
    non_restoring_div uut (
        .src1(src1),
        .src2(src2),
        .qut(qut),
        .rmd(rmd)
    );

    // Task to check the result
    task check_result;
        input [31:0] expected_q;
        input [31:0] expected_r;
        begin
            expected_qut = expected_q;
            expected_rmd = expected_r;
            #10; // Allow some delay for UUT output
            if (qut == expected_qut && rmd == expected_rmd) begin
                $display("PASS: src1 = %d, src2 = %d, qut = %d, rmd = %d", src1, src2, qut, rmd);
            end else begin
                $display("FAIL: src1 = %d, src2 = %d, qut = %d (expected: %d), rmd = %d (expected: %d)", 
                         src1, src2, qut, expected_qut, rmd, expected_rmd);
            end
        end
    endtask

    // Testbench logic
    initial begin
        // Test case 1: Divide by 1
        src1 = 32'd100; src2 = 32'd1; #10; check_result(32'd100, 32'd0);

        // Test case 2: Divide by itself
        src1 = 32'd12345; src2 = 32'd12345; #10; check_result(32'd1, 32'd0);

        // Test case 3: Divide by a larger number
        src1 = 32'd123; src2 = 32'd456; #10; check_result(32'd0, 32'd123);

        // Test case 4: Divide zero
        src1 = 32'd0; src2 = 32'd789; #10; check_result(32'd0, 32'd0);

        // Test case 5: Maximum values
        src1 = 32'hFFFFFFFF; src2 = 32'd2; #10; check_result(32'h7FFFFFFF, 32'd1);

        // Test case 6: Random values
        src1 = 32'd1000; src2 = 32'd33; #10; check_result(32'd30, 32'd10);
        src1 = 32'd98765; src2 = 32'd123; #10; check_result(32'd802, 32'd61);

        // Test case 7: Edge case (near power of two)
        src1 = 32'd1023; src2 = 32'd32; #10; check_result(32'd31, 32'd31);

        // End simulation
        $finish;
    end

endmodule
