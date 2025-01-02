library verilog;
use verilog.vl_types.all;
entity lsu is
    port(
        clk_i           : in     vl_logic;
        rst_ni          : in     vl_logic;
        st_en           : in     vl_logic;
        addr            : in     vl_logic_vector(11 downto 0);
        byte_en         : in     vl_logic_vector(3 downto 0);
        ld_sel          : in     vl_logic_vector(2 downto 0);
        st_data         : in     vl_logic_vector(31 downto 0);
        io_sw           : in     vl_logic_vector(31 downto 0);
        ld_data         : out    vl_logic_vector(31 downto 0);
        io_lcd          : out    vl_logic_vector(31 downto 0);
        io_ledg         : out    vl_logic_vector(31 downto 0);
        io_ledr         : out    vl_logic_vector(31 downto 0);
        io_hex0         : out    vl_logic_vector(31 downto 0);
        io_hex1         : out    vl_logic_vector(31 downto 0);
        io_hex2         : out    vl_logic_vector(31 downto 0);
        io_hex3         : out    vl_logic_vector(31 downto 0);
        io_hex4         : out    vl_logic_vector(31 downto 0);
        io_hex5         : out    vl_logic_vector(31 downto 0);
        io_hex6         : out    vl_logic_vector(31 downto 0);
        io_hex7         : out    vl_logic_vector(31 downto 0)
    );
end lsu;
