library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        operand_a       : in     vl_logic_vector(31 downto 0);
        operand_b       : in     vl_logic_vector(31 downto 0);
        alu_op          : in     vl_logic_vector(4 downto 0);
        alu_data        : out    vl_logic_vector(31 downto 0)
    );
end alu;
