module instr_rom (
	input  [12:0] pc,
	output [31:0] instr
);

	reg [31:0] mem [0:11'h7ff];

	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/Stopwatch.mem", mem);
	//initial $readmemh("../mem/ALL_testbench.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/Fibonacci.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/pipeline.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/RV32IM.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/Division_special.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/pipeline_hazard.mem", mem);
	//initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/calculator.mem", mem);
	initial $readmemh("C:/Users/Admin/Downloads/Compressed/pipeline-main/pipeline-main/mem/mem.dump", mem);
	assign instr = mem[pc[12:2]];

endmodule
