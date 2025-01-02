module alu (
	input  [31:0] operand_a,
	input  [31:0] operand_b,
	input  [4:0]  alu_op,
	output logic [31:0] alu_data
);

	localparam ADD  = 5'b00000;
	localparam SUB  = 5'b00001;
	localparam SLT  = 5'b00010;
	localparam SLTU = 5'b00011;
	localparam XOR  = 5'b00100;
	localparam OR   = 5'b00101;
	localparam AND  = 5'b00110;
	localparam SLL  = 5'b00111;
	localparam SRL  = 5'b01000;
	localparam SRA  = 5'b01001;
	localparam MUL  = 5'b01010;
	localparam MULH = 5'b01011;
	localparam MULHU = 5'b01100;
	localparam MULHSU  = 5'b01101;
	localparam DIVU  = 5'b01110;
	localparam REMU  = 5'b01111;
	localparam DIV  = 5'b10000;
	localparam REM  = 5'b10001;

	wire [32:0] ua, ub, uc;
	wire [31:0] c, s,qut_u,qut_s,rmd_u,rmd_s;
	wire [63:0] m,mh,mhu,mhsu;	
	assign ua = {1'b0,operand_a};
	assign ub = {1'b0,operand_b};
	assign uc =        ua + ~       ub + 33'h1;
	assign  c = operand_a + ~operand_b + 32'h1;

	arith_right_shift ars (
		.din(operand_a),
		.amount(operand_b[4:0]),
		.dout(s)
	);
	signed_vedic_mult_32bit  mul(
	.a(operand_a),
	.b(operand_b),
	.out(m)
	);
	signed_vedic_mult_32bit  mulh(
	.a(operand_a),
	.b(operand_b),
	.out(mh)
	);
  vedic_mult_32bit  mulhu(
	.a(operand_a),
	.b(operand_b),
	.out(mhu)
	);
 signed_vedic_mult_32bit  mulhsu(
	.a(operand_a),
	.b(operand_b),
	.out(mhsu)
	);
	non_restoring_div divu(
	.src1(operand_a),
	.src2(operand_b),
	.qut (qut_u),
	.rmd (rmd_u)
	);
//	non_restoring_div remu(
//	.src1(operand_a),
//	.src2(operand_b),
//	.qut (qut_u1),
//	.rmd (rmd_u)
//	);
	signed_non_restoring_div div(
	.src1(operand_a),
	.src2(operand_b),
	.qut (qut_s),
	.rmd (rmd_s)
	);
//	signed_non_restoring_div rem(
//	.src1(operand_a),
//	.src2(operand_b),
//	.qut (qut_s1),
//	.rmd (rmd_s)
//	);


	always_comb
	case (alu_op)
		ADD:  alu_data =  operand_a + operand_b;
		SUB:  alu_data =  operand_a + ~operand_b + 32'h1;
		SLT:  alu_data = (c[31])  ? 32'h1 : 32'h0;
		SLTU: alu_data = (uc[32]) ? 32'h1 : 32'h0;
		XOR:  alu_data =  operand_a ^ operand_b;
		OR:   alu_data =  operand_a | operand_b;
		AND:  alu_data =  operand_a & operand_b;
		SLL:  alu_data =  operand_a << operand_b[4:0];
		SRL:  alu_data =  operand_a >> operand_b[4:0];
		SRA:  alu_data =  s;
      MUL:  alu_data =  m[31:0];
		MULH:  alu_data =  mh[63:32];
		MULHU:  alu_data =  mhu[63:32];
		MULHSU:  alu_data =  mhsu[63:32];
		DIVU:  alu_data =  qut_u;
		REMU:  alu_data =  rmd_u;
		DIV:  alu_data =  qut_s;
		REM:  alu_data =  rmd_s;
		default: alu_data = 32'h0;
	endcase

endmodule

//############################################
// >>> is useless, so I had to make one my own
//############################################

module arith_right_shift (
	input  [31:0] din,
	input   [4:0] amount,
	output logic [31:0] dout
);

	wire [31:0] logic_shift;
	
	assign logic_shift = din >> amount;
	
	always_comb
		if (din[31])
			case (amount)
				5'd0 : dout = logic_shift;
				5'd1 : dout = logic_shift | 32'b10000000000000000000000000000000;
				5'd2 : dout = logic_shift | 32'b11000000000000000000000000000000;
				5'd3 : dout = logic_shift | 32'b11100000000000000000000000000000;
				5'd4 : dout = logic_shift | 32'b11110000000000000000000000000000;
				5'd5 : dout = logic_shift | 32'b11111000000000000000000000000000;
				5'd6 : dout = logic_shift | 32'b11111100000000000000000000000000;
				5'd7 : dout = logic_shift | 32'b11111110000000000000000000000000;
				5'd8 : dout = logic_shift | 32'b11111111000000000000000000000000;
				5'd9 : dout = logic_shift | 32'b11111111100000000000000000000000;
				5'd10: dout = logic_shift | 32'b11111111110000000000000000000000;
				5'd11: dout = logic_shift | 32'b11111111111000000000000000000000;
				5'd12: dout = logic_shift | 32'b11111111111100000000000000000000;
				5'd13: dout = logic_shift | 32'b11111111111110000000000000000000;
				5'd14: dout = logic_shift | 32'b11111111111111000000000000000000;
				5'd15: dout = logic_shift | 32'b11111111111111100000000000000000;
				5'd16: dout = logic_shift | 32'b11111111111111110000000000000000;
				5'd17: dout = logic_shift | 32'b11111111111111111000000000000000;
				5'd18: dout = logic_shift | 32'b11111111111111111100000000000000;
				5'd19: dout = logic_shift | 32'b11111111111111111110000000000000;
				5'd20: dout = logic_shift | 32'b11111111111111111111000000000000;
				5'd21: dout = logic_shift | 32'b11111111111111111111100000000000;
				5'd22: dout = logic_shift | 32'b11111111111111111111110000000000;
				5'd23: dout = logic_shift | 32'b11111111111111111111111000000000;
				5'd24: dout = logic_shift | 32'b11111111111111111111111100000000;
				5'd25: dout = logic_shift | 32'b11111111111111111111111110000000;
				5'd26: dout = logic_shift | 32'b11111111111111111111111111000000;
				5'd27: dout = logic_shift | 32'b11111111111111111111111111100000;
				5'd28: dout = logic_shift | 32'b11111111111111111111111111110000;
				5'd29: dout = logic_shift | 32'b11111111111111111111111111111000;
				5'd30: dout = logic_shift | 32'b11111111111111111111111111111100;
				5'd31: dout = logic_shift | 32'b11111111111111111111111111111110;
			endcase
		else dout = logic_shift;

endmodule