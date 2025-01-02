`timescale 1ps/1ps
module pipeline_tb;
    logic clk_i, rst_ni;
    logic [31:0] io_sw_i;
    logic [12:0] pc_debug_o;
	 //logic  stallF, stallD, flushD, flushE;
	 //logic [1:0] FW1, FW2;
    logic [31:0] io_lcd_o, io_ledg_o, io_ledr_o, io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, 
                 io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o;
    
    pipeline dut (.*);
 initial begin
        // Initialize
        rst_ni = 0;
        io_sw_i = 0;
        #10;
        rst_ni = 1;
        
        // Test 1: Check initial state (should be 00:00:00.00)
        $display("Test 1: Initial state check");
        #100;
        display_time();
        
        // Test 2: Start stopwatch (Mode 1)
        $display("\nTest 2: Start stopwatch");
        io_sw_i = 32'h1; // Set mode to 1 (Run)
        #1000;
        display_time();
        
        // Test 3: Let it run for a while
        $display("\nTest 3: Running state check");
        #5000;
        display_time();
        
        // Test 4: Stop stopwatch (Mode 0)
        $display("\nTest 4: Stop stopwatch");
        io_sw_i = 32'h0; // Set mode to 0 (Stop)
        #1000;
        display_time();
        
        // Test 5: Check if time is frozen
        $display("\nTest 5: Frozen state check");
        #2000;
        display_time();
        
        // Test 6: Resume stopwatch (Mode 1)
        $display("\nTest 6: Resume stopwatch");
        io_sw_i = 32'h1; // Set mode to 1 (Run)
        #3000;
        display_time();
        
        // Test 7: Reset stopwatch (Mode 2)
        $display("\nTest 7: Reset stopwatch");
        io_sw_i = 32'h2; // Set mode to 2 (Reset)
        #1000;
        display_time();
        
        // Test 8: Verify reset state
        $display("\nTest 8: Verify reset state");
        #500;
        display_time();
        
        // Test 9: Start after reset
        $display("\nTest 9: Start after reset");
        io_sw_i = 32'h1; // Set mode to 1 (Run)
        #2000;
        display_time();
        
        // Test 10: Quick mode changes
        $display("\nTest 10: Quick mode changes");
        // Stop -> Run -> Stop -> Reset sequence
        io_sw_i = 32'h0; #500;
        io_sw_i = 32'h1; #500;
        io_sw_i = 32'h0; #500;
        io_sw_i = 32'h2; #500;
        display_time();
        
        // End simulation
        #1000;
        $display("\nSimulation completed");
        $finish;
    end
    
    // Optional: Add waveform dumping
    initial begin
        $dumpfile("stopwatch.vcd");
        $dumpvars(0, pipeline_tb);
    end
    
endmodule
//initial begin
//		rst_ni       = 1'b0;
//		$dumpfile("pipelinedump.vcd");
//		$dumpvars;
//	end
//	
//	initial begin
//    clk_i = 1'b0;
//	 forever #1 clk_i = !clk_i;
//   end
//	
//	initial begin
//		#1
//      rst_ni   = 1'b1;
//      
//	
//
//	   #2000	$finish;
//		
//	end
//	   
//  
//
//endmodule 


