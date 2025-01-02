library verilog;
use verilog.vl_types.all;
entity ctrl_unit is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        br_less         : in     vl_logic;
        br_equal        : in     vl_logic;
        br_sel          : out    vl_logic;
        rd_wren         : out    vl_logic;
        br_unsigned     : out    vl_logic;
        op_a_sel        : out    vl_logic;
        op_b_sel        : out    vl_logic;
        mem_wren        : out    vl_logic;
        alu_op          : out    vl_logic_vector(4 downto 0);
        byte_en         : out    vl_logic_vector(3 downto 0);
        wb_sel          : out    vl_logic_vector(1 downto 0);
        ld_sel          : out    vl_logic_vector(2 downto 0)
    );
end ctrl_unit;
