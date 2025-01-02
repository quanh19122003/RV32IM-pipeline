library verilog;
use verilog.vl_types.all;
entity rs2d_mux is
    port(
        rs2_dataD       : in     vl_logic_vector(31 downto 0);
        alu_dataE       : in     vl_logic_vector(31 downto 0);
        alu_dataM       : in     vl_logic_vector(31 downto 0);
        ld_dataM        : in     vl_logic_vector(31 downto 0);
        rs2d_sel        : in     vl_logic_vector(1 downto 0);
        rs2d_out        : out    vl_logic_vector(31 downto 0)
    );
end rs2d_mux;
