module pc_reg (
    input clk, rstn, en,
    input [12:0] next_pc,
    output logic [12:0] pc
);
    // Thêm một flip-flop để phát hiện chu kỳ đầu tiên sau reset
    logic first_cycle;
    
    // Quản lý first_cycle
    always_ff @ (posedge clk or negedge rstn) begin
        if (!rstn)
            first_cycle <= 1'b1; // Set về 1 khi reset
        else
            first_cycle <= 1'b0; // Các chu kỳ sau sẽ là 0
    end
    
    // PC register với điều kiện first_cycle
    always_ff @ (posedge clk or negedge rstn) begin
        if (!rstn)
            pc <= 0;
        else if (en && (first_cycle || pc != 0)) // Chỉ cập nhật khi là chu kỳ đầu hoặc đã bắt đầu chạy
            pc <= {next_pc[12:1], 1'b0};
    end
endmodule