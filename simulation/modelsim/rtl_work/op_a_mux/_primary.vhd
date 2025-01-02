library verilog;
use verilog.vl_types.all;
entity op_a_mux is
    port(
        pc              : in     vl_logic_vector(12 downto 0);
        rs1_data        : in     vl_logic_vector(31 downto 0);
        op_a_sel        : in     vl_logic;
        operand_a       : out    vl_logic_vector(31 downto 0)
    );
end op_a_mux;
