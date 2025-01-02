library verilog;
use verilog.vl_types.all;
entity reg32_cp is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        en              : in     vl_logic;
        A               : in     vl_logic_vector(11 downto 0);
        B               : in     vl_logic_vector(11 downto 0);
        byte_en         : in     vl_logic_vector(3 downto 0);
        ins             : in     vl_logic_vector(31 downto 0);
        outs            : out    vl_logic_vector(31 downto 0)
    );
end reg32_cp;
