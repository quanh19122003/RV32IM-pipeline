module pipeline (
    input clk_i, rst_ni,
    input [31:0] io_sw_i,
    output [31:0] pc_debug_o,
	// output stallF, stallD, flushD, flushE,
	 //output [1:0] FW1, FW2,
    output [31:0] io_lcd_o, io_ledg_o, io_ledr_o, io_hex0_o, io_hex1_o, io_hex2_o, io_hex3_o, io_hex4_o, io_hex5_o, io_hex6_o, io_hex7_o
);

    logic        br_equal, br_less, br_unsigned, mem_wrenD, mem_wrenE, mem_wrenM, op_a_selD, op_a_selE, op_b_selD, op_b_selE,
                 rd_wrenD, rd_wrenE, rd_wrenM, rd_wrenW, br_selD, br_selE,stallF, stallD, flushD, flushE;
    logic  [1:0] wb_selD, wb_selE, wb_selM, wb_selW, forward1sel, forward2sel, rs1d_sel, rs2d_sel;
    logic  [2:0] ld_selD, ld_selE, ld_selM;
    logic  [3:0] byte_enD, byte_enE, byte_enM;
    logic  [4:0] rs1_addrD, rs1_addrE, rs2_addrD, rs2_addrE, rd_addrD, rd_addrE, rd_addrM, alu_opD, alu_opE, rd_addrW;
    logic [12:0] next_pc, pcF, pc4F, pcD, pc4D, pcE, pc4E, pc4M, pc4W;
    logic [31:0] instrF, instrD, immD, immE, rs1_dataD, rs1_dataE, rs2_dataD, rs2_dataE, operand_a, operand_b,
                 alu_dataE, alu_dataM, alu_dataW, ld_dataM, ld_dataW, wb_data, forward1out, forward2out, forward2outM, rs1d_out, rs2d_out;

    assign pc_debug_o = pcF;
//assign FW1 = forward1sel;
//assign FW2 = forward2sel;
    br_mux brsel (.br_sel(br_selE),
                  .alu_data(alu_dataE[12:0]),
                  .pc_four(pc4F),
                  .next_pc(next_pc));

    pc_reg fetch_address (.clk(clk_i),
                          .rstn(rst_ni),
                          .en(!stallF),
                          .next_pc(next_pc),
                          .pc(pcF));

    add4 plus4 (.pc_in(pcF),
                .pc_out(pc4F));

    instr_rom fetch_data (.pc(pcF),
                          .instr(instrF));

    reg_fetch_decode decode (.clk(clk_i),
                             .sclr(flushD),
                             .aclr(rst_ni),
                             .en(!stallD),
                             .instrF(instrF),
                             .pcF(pcF),
                             .pc4F(pc4F),
                             .instrD(instrD),
                             .pcD(pcD),
                             .pc4D(pc4D));

    reg_dec regdec (.instr(instrD),
                    .rs1_addr(rs1_addrD),
                    .rs2_addr(rs2_addrD),
                    .rd_addr(rd_addrD));

    immGen iG (.instr(instrD),
               .imm(immD));

    brcomp brc (.rs1_data(rs1d_out),
                .rs2_data(rs2d_out),
                .br_unsigned(br_unsigned),
                .br_less(br_less),
                .br_equal(br_equal));

    ctrl_unit cu (.instr(instrD),
                  .br_less(br_less),
                  .br_equal(br_equal),
                  .br_sel(br_selD),
                  .rd_wren(rd_wrenD),
                  .br_unsigned(br_unsigned),
                  .op_a_sel(op_a_selD),
                  .op_b_sel(op_b_selD),
                  .mem_wren(mem_wrenD),
                  .alu_op(alu_opD),
                  .byte_en(byte_enD),
                  .wb_sel(wb_selD),
                  .ld_sel(ld_selD));

    regfile rf (.clk_i(clk_i),
                .rst_ni(rst_ni),
                .rs1_addr(rs1_addrD),
                .rs2_addr(rs2_addrD),
                .rd_addr(rd_addrW),
                .rd_data(wb_data),
                .rd_wren(rd_wrenW),
                .rs1_data(rs1_dataD),
                .rs2_data(rs2_dataD));

    rs1d_mux rd1m (.rs1_dataD(rs1_dataD),
                   .alu_dataE(alu_dataE),
                   .alu_dataM(alu_dataM),
                   .ld_dataM(ld_dataM),
                   .rs1d_sel(rs1d_sel),
                   .rs1d_out(rs1d_out));

    rs2d_mux rd2m (.rs2_dataD(rs2_dataD),
                   .alu_dataE(alu_dataE),
                   .alu_dataM(alu_dataM),
                   .ld_dataM(ld_dataM),
                   .rs2d_sel(rs2d_sel),
                   .rs2d_out(rs2d_out));

    reg_decode_execute execute (.clk(clk_i),
                                .sclr(flushE),
                                .aclr(rst_ni),
                                .mem_wrenD(mem_wrenD),
                                .op_a_selD(op_a_selD),
                                .op_b_selD(op_b_selD),
                                .rd_wrenD(rd_wrenD),
                                .br_selD(br_selD),
                                .wb_selD(wb_selD),
                                .ld_selD(ld_selD),
                                .byte_enD(byte_enD),
                                .alu_opD(alu_opD),
                                .rs1_addrD(rs1_addrD),
                                .rs2_addrD(rs2_addrD),
                                .rd_addrD(rd_addrD),
                                .pcD(pcD),
                                .pc4D(pc4D),
                                .immD(immD),
                                .rs1_dataD(rs1_dataD),
                                .rs2_dataD(rs2_dataD),
                                .mem_wrenE(mem_wrenE),
                                .op_a_selE(op_a_selE),
                                .op_b_selE(op_b_selE),
                                .rd_wrenE(rd_wrenE),
                                .br_selE(br_selE),
                                .wb_selE(wb_selE),
                                .ld_selE(ld_selE),
                                .byte_enE(byte_enE),
                                .alu_opE(alu_opE),
                                .rs1_addrE(rs1_addrE),
                                .rs2_addrE(rs2_addrE),
                                .rd_addrE(rd_addrE),
                                .pcE(pcE),
                                .pc4E(pc4E),
                                .immE(immE),
                                .rs1_dataE(rs1_dataE),
                                .rs2_dataE(rs2_dataE));

    forward1mux f1m (.rs1_dataE(rs1_dataE),
                     .alu_dataM(alu_dataM),
                     .wb_data(wb_data),
                     .forward1sel(forward1sel),
                     .forward1out(forward1out));

    forward2mux f2m (.rs2_dataE(rs2_dataE),
                     .alu_dataM(alu_dataM),
                     .wb_data(wb_data),
                     .forward2sel(forward2sel),
                     .forward2out(forward2out));

    op_a_mux oam (.pc(pcE),
                  .rs1_data(forward1out),
                  .op_a_sel(op_a_selE),
                  .operand_a(operand_a));

    op_b_mux obm (.imm(immE),
                  .rs2_data(forward2out),
                  .op_b_sel(op_b_selE),
                  .operand_b(operand_b));

    alu al (.operand_a(operand_a),
            .operand_b(operand_b),
            .alu_op(alu_opE),
            .alu_data(alu_dataE));

    reg_execute_memory memory (.clk(clk_i),
                               .aclr(rst_ni),
                               .mem_wrenE(mem_wrenE),
                               .rd_wrenE(rd_wrenE),
                               .wb_selE(wb_selE),
                               .ld_selE(ld_selE),
                               .byte_enE(byte_enE),
                               .rd_addrE(rd_addrE),
                               .pc4E(pc4E),
                               .alu_dataE(alu_dataE),
							   .forward2outE(forward2out),
                               .mem_wrenM(mem_wrenM),
                               .rd_wrenM(rd_wrenM),
                               .wb_selM(wb_selM),
                               .ld_selM(ld_selM),
                               .byte_enM(byte_enM),
                               .rd_addrM(rd_addrM),
                               .pc4M(pc4M),
                               .alu_dataM(alu_dataM),
							   .forward2outM(forward2outM));
    
    lsu dmem (.clk_i(clk_i),
              .rst_ni(rst_ni),
              .st_en(mem_wrenM),
              .addr(alu_dataM[11:0]),
              .byte_en(byte_enM),
              .ld_sel(ld_selM),
              .st_data(forward2outM),
              .io_sw(io_sw_i),
              .ld_data(ld_dataM),
              .io_lcd(io_lcd_o),
              .io_ledg(io_ledg_o),
              .io_ledr(io_ledr_o),
              .io_hex0(io_hex0_o),
              .io_hex1(io_hex1_o),
              .io_hex2(io_hex2_o),
              .io_hex3(io_hex3_o),
              .io_hex4(io_hex4_o),
              .io_hex5(io_hex5_o),
              .io_hex6(io_hex6_o),
              .io_hex7(io_hex7_o));

    reg_memory_writeback writeback (.clk(clk_i),
                                    .aclr(rst_ni),
                                    .rd_wrenM(rd_wrenM),
                                    .wb_selM(wb_selM),
                                    .rd_addrM(rd_addrM),
                                    .pc4M(pc4M),
                                    .alu_dataM(alu_dataM),
                                    .ld_dataM(ld_dataM),
                                    .rd_wrenW(rd_wrenW),
                                    .wb_selW(wb_selW),
                                    .rd_addrW(rd_addrW),
                                    .pc4W(pc4W),
                                    .alu_dataW(alu_dataW),
                                    .ld_dataW(ld_dataW));

    wb_mux wbm (.pc_four(pc4W),
                .alu_data(alu_dataW),
                .ld_data(ld_dataW),
                .wb_sel(wb_selW),
                .wb_data(wb_data));

    hazard_unit hu (.br_selE(br_selE),
                    .wb_selE(wb_selE[0]),
                    .wb_selM(wb_selM[0]),
                    .rs1_addrD(rs1_addrD),
                    .rs2_addrD(rs2_addrD),
                    .rs1_addrE(rs1_addrE),
                    .rs2_addrE(rs2_addrE),
                    .rd_wrenE(rd_wrenE),
                    .rd_addrE(rd_addrE),
                    .rd_wrenM(rd_wrenM),
                    .rd_addrM(rd_addrM),
                    .rd_wrenW(rd_wrenW),
                    .rd_addrW(rd_addrW),
                    .stallF(stallF),
                    .stallD(stallD),
                    .flushD(flushD),
                    .flushE(flushE),
                    .forward1sel(forward1sel),
                    .forward2sel(forward2sel),
                    .rs1d_sel(rs1d_sel),
                    .rs2d_sel(rs2d_sel));

endmodule