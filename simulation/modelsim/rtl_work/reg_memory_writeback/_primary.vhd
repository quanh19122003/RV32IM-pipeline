library verilog;
use verilog.vl_types.all;
entity reg_memory_writeback is
    port(
        rd_wrenM        : in     vl_logic;
        wb_selM         : in     vl_logic_vector(1 downto 0);
        rd_addrM        : in     vl_logic_vector(4 downto 0);
        pc4M            : in     vl_logic_vector(12 downto 0);
        alu_dataM       : in     vl_logic_vector(31 downto 0);
        ld_dataM        : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        aclr            : in     vl_logic;
        rd_wrenW        : out    vl_logic;
        wb_selW         : out    vl_logic_vector(1 downto 0);
        rd_addrW        : out    vl_logic_vector(4 downto 0);
        pc4W            : out    vl_logic_vector(12 downto 0);
        alu_dataW       : out    vl_logic_vector(31 downto 0);
        ld_dataW        : out    vl_logic_vector(31 downto 0)
    );
end reg_memory_writeback;
