library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        clk_i           : in     vl_logic;
        rst_ni          : in     vl_logic;
        rs1_addr        : in     vl_logic_vector(4 downto 0);
        rs2_addr        : in     vl_logic_vector(4 downto 0);
        rd_addr         : in     vl_logic_vector(4 downto 0);
        rd_data         : in     vl_logic_vector(31 downto 0);
        rd_wren         : in     vl_logic;
        rs1_data        : out    vl_logic_vector(31 downto 0);
        rs2_data        : out    vl_logic_vector(31 downto 0)
    );
end regfile;
