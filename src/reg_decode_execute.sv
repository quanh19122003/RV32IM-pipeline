module reg_decode_execute (
    input         mem_wrenD, op_a_selD, op_b_selD, rd_wrenD, br_selD,
    input  [1:0]  wb_selD,
    input  [2:0]  ld_selD,
    input  [3:0]  byte_enD, 
    input  [4:0]  rs1_addrD, rs2_addrD, rd_addrD,alu_opD,
    input  [12:0] pcD, pc4D,
    input  [31:0] immD, rs1_dataD, rs2_dataD,

    input         clk, sclr, aclr,

    output logic        mem_wrenE, op_a_selE, op_b_selE, rd_wrenE, br_selE,
    output logic [1:0]  wb_selE,
    output logic [2:0]  ld_selE,
    output logic [3:0]  byte_enE, 
    output logic [4:0]  rs1_addrE, rs2_addrE, rd_addrE,alu_opE,
    output logic [12:0] pcE, pc4E,
    output logic [31:0] immE, rs1_dataE, rs2_dataE
);

    always_ff @ (posedge clk, negedge aclr)
    if (!aclr)     {wb_selE, ld_selE, mem_wrenE, byte_enE, alu_opE, op_b_selE, op_a_selE, rd_wrenE, br_selE, immE, rs1_dataE, rs2_dataE, rs1_addrE, rs2_addrE, rd_addrE, pcE, pc4E} = 'b0;
	else if (sclr) {wb_selE, ld_selE, mem_wrenE, byte_enE, alu_opE, op_b_selE, op_a_selE, rd_wrenE, br_selE, immE, rs1_dataE, rs2_dataE, rs1_addrE, rs2_addrE, rd_addrE, pcE, pc4E} = 'b0;
    else           {wb_selE, ld_selE, mem_wrenE, byte_enE, alu_opE, op_b_selE, op_a_selE, rd_wrenE, br_selE, immE, rs1_dataE, rs2_dataE, rs1_addrE, rs2_addrE, rd_addrE, pcE, pc4E} = {wb_selD, ld_selD, mem_wrenD, byte_enD, alu_opD, op_b_selD, op_a_selD, rd_wrenD, br_selD, immD, rs1_dataD, rs2_dataD, rs1_addrD, rs2_addrD, rd_addrD, pcD, pc4D};

endmodule