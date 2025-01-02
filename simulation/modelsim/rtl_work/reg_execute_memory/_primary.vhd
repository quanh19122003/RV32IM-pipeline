library verilog;
use verilog.vl_types.all;
entity reg_execute_memory is
    port(
        mem_wrenE       : in     vl_logic;
        rd_wrenE        : in     vl_logic;
        wb_selE         : in     vl_logic_vector(1 downto 0);
        ld_selE         : in     vl_logic_vector(2 downto 0);
        byte_enE        : in     vl_logic_vector(3 downto 0);
        rd_addrE        : in     vl_logic_vector(4 downto 0);
        pc4E            : in     vl_logic_vector(12 downto 0);
        alu_dataE       : in     vl_logic_vector(31 downto 0);
        forward2outE    : in     vl_logic_vector(31 downto 0);
        clk             : in     vl_logic;
        aclr            : in     vl_logic;
        mem_wrenM       : out    vl_logic;
        rd_wrenM        : out    vl_logic;
        wb_selM         : out    vl_logic_vector(1 downto 0);
        ld_selM         : out    vl_logic_vector(2 downto 0);
        byte_enM        : out    vl_logic_vector(3 downto 0);
        rd_addrM        : out    vl_logic_vector(4 downto 0);
        pc4M            : out    vl_logic_vector(12 downto 0);
        alu_dataM       : out    vl_logic_vector(31 downto 0);
        forward2outM    : out    vl_logic_vector(31 downto 0)
    );
end reg_execute_memory;
