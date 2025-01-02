library verilog;
use verilog.vl_types.all;
entity addr_dec is
    port(
        main_addr       : in     vl_logic_vector(11 downto 0);
        main_we         : in     vl_logic;
        data_addr       : out    vl_logic_vector(8 downto 0);
        out_addr        : out    vl_logic_vector(5 downto 0);
        in_addr         : out    vl_logic_vector(5 downto 0);
        data_en         : out    vl_logic;
        out_en          : out    vl_logic;
        in_en           : out    vl_logic
    );
end addr_dec;
