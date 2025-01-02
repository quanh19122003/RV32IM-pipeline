module ctrl_unit (
    input [31:0] instr,
    input br_less, br_equal,
    output logic br_sel, rd_wren, br_unsigned, op_a_sel, op_b_sel, mem_wren,
    output logic [4:0] alu_op, 
	 output logic [3:0] byte_en,
    output logic [1:0] wb_sel,
    output logic [2:0] ld_sel
);

    logic [6:0] opcode, funct7;
    logic [2:0] funct3;

    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7 = instr[31:25];

    localparam LUI   = 7'b0110111;
    localparam AUIPC = 7'b0010111;
    localparam JAL   = 7'b1101111;
    localparam JALR  = 7'b1100111;
    localparam B     = 7'b1100011;
    localparam L     = 7'b0000011;
    localparam S     = 7'b0100011;
    localparam LSW   = 3'b010;
    localparam LSB   = 3'b000;
    localparam LSH   = 3'b001;
    localparam LBU   = 3'b100;
    localparam LHU   = 3'b101;
    localparam I     = 7'b0010011;
    localparam R     = 7'b0110011;
    localparam Rf7   = 7'b0000000;
    localparam Rf7n  = 7'b0100000;
	 localparam Rf7md = 7'b0000001;
    localparam EQ    = 3'b000;
    localparam NE    = 3'b001;
    localparam LT    = 3'b100;
    localparam GE    = 3'b101;
    localparam LTU   = 3'b110;
    localparam GEU   = 3'b111;
    localparam ADDs  = 3'b000;
    localparam SLLs  = 3'b001;
    localparam SLTs  = 3'b010;
    localparam SLTUs = 3'b011;
    localparam XORs  = 3'b100;
    localparam SRs   = 3'b101;
    localparam ORs   = 3'b110;
    localparam ANDs  = 3'b111;
    
	 localparam MUL   = 3'b000;
    localparam MULH  = 3'b001;
    localparam MULHSU = 3'b010;
    localparam MULHU= 3'b011;
    localparam DIV  = 3'b100;
    localparam DIVU  = 3'b101;
    localparam REM   = 3'b110;
    localparam REMU   = 3'b111;

    always_comb
     
        if (opcode == LUI)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == AUIPC)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == JAL)
        begin
            br_sel = 1; rd_wren = 1; br_unsigned = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 2;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
 
        if (opcode == JALR && funct3 == 3'b000)
        begin
            br_sel = 1; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 2;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
 
        if (opcode == B && funct3 == EQ)
        begin
            if (br_equal)
            begin
                br_sel = 1; rd_wren = 0; br_unsigned = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else

        if (opcode == B && funct3 == NE)
        begin
            if (!br_equal)
            begin
                br_sel = 1; rd_wren = 0; br_unsigned = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else

        if (opcode == B && funct3 == LT)
        begin
            br_unsigned = 0;
            if (br_less)
            begin
                br_sel = 1; rd_wren = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else

        if (opcode == B && funct3 == GE)
        begin
            br_unsigned = 0;
            if ((!br_less && !br_equal) || br_equal)
            begin
                br_sel = 1; rd_wren = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else
        //#############################################################################################################
        // BLTU
        //#############################################################################################################
        if (opcode == B && funct3 == LTU)
        begin
            br_unsigned = 1;
            if (br_less)
            begin
                br_sel = 1; rd_wren = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else
       
        if (opcode == B && funct3 == GEU)
        begin
            br_unsigned = 1;
            if ((!br_less && !br_equal) || br_equal)
            begin
                br_sel = 1; rd_wren = 0; op_a_sel = 1; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
            else
            begin
                br_sel = 0; rd_wren = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
                byte_en = 4'b0000; ld_sel = 0;
            end
        end
        else
     
        if (opcode == L && funct3 == LSB)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 1;
            byte_en = 4'b0000; ld_sel = 2;
        end
        else
  
        if (opcode == L && funct3 == LSH)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 1;
            byte_en = 4'b0000; ld_sel = 4;
        end
        else

        if (opcode == L && funct3 == LBU)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 1;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
     
        if (opcode == L && funct3 == LHU)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 1;
            byte_en = 4'b0000; ld_sel = 1;
        end
        else

        if (opcode == L && funct3 == LSW)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 1;
            byte_en = 4'b0000; ld_sel = 6;
        end
        else

        if (opcode == S && funct3 == LSB)
        begin
            br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 1; wb_sel = 0;
            byte_en = 4'b0001; ld_sel = 0;
        end
        else

        if (opcode == S && funct3 == LSH)
        begin
            br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 1; wb_sel = 0;
            byte_en = 4'b0011; ld_sel = 0;
        end
        else

        if (opcode == S && funct3 == LSW)
        begin
            br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 1; wb_sel = 0;
            byte_en = 4'b1111; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == ADDs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 0; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
 
        if (opcode == I && funct3 == SLTs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 2; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == SLTUs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 3; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
 
        if (opcode == I && funct3 == XORs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 4; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
   
        if (opcode == I && funct3 == ORs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 5; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == ANDs)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 6; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == SLLs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 7; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == SRs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 8; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == I && funct3 == SRs && funct7 == Rf7n)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 1; alu_op = 9; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == ADDs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == ADDs && funct7 == Rf7n)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 1; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
 
        if (opcode == R && funct3 == SLTs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 2; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
   
        if (opcode == R && funct3 == SLTUs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 3; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == XORs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 4; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == ORs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 5; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == ANDs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 6; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == SLLs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 7; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == SRs && funct7 == Rf7)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 8; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else

        if (opcode == R && funct3 == SRs && funct7 == Rf7n)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 9; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
        if (opcode == R && funct3 == MUL && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 10; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		    if (opcode == R && funct3 == MULH && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 11; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		    if (opcode == R && funct3 == MULHU && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 12; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		    if (opcode == R && funct3 == MULHSU && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 13; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		    if (opcode == R && funct3 == DIVU && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 14; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		    if (opcode == R && funct3 == REMU && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 15; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		   if (opcode == R && funct3 == DIV && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 16; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
		   if (opcode == R && funct3 == REM && funct7 == Rf7md)
        begin
            br_sel = 0; rd_wren = 1; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 17; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end
        else
        begin
            br_sel = 0; rd_wren = 0; br_unsigned = 0; op_a_sel = 0; op_b_sel = 0; alu_op = 0; mem_wren = 0; wb_sel = 0;
            byte_en = 4'b0000; ld_sel = 0;
        end

endmodule