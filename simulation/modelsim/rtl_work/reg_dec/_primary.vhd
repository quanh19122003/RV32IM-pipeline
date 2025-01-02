library verilog;
use verilog.vl_types.all;
entity reg_dec is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        rs1_addr        : out    vl_logic_vector(4 downto 0);
        rs2_addr        : out    vl_logic_vector(4 downto 0);
        rd_addr         : out    vl_logic_vector(4 downto 0)
    );
end reg_dec;
