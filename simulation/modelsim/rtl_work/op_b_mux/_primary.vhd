library verilog;
use verilog.vl_types.all;
entity op_b_mux is
    port(
        imm             : in     vl_logic_vector(31 downto 0);
        rs2_data        : in     vl_logic_vector(31 downto 0);
        op_b_sel        : in     vl_logic;
        operand_b       : out    vl_logic_vector(31 downto 0)
    );
end op_b_mux;
