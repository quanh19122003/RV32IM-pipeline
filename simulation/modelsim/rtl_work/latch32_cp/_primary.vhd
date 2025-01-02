library verilog;
use verilog.vl_types.all;
entity latch32_cp is
    port(
        A               : in     vl_logic_vector(11 downto 0);
        B               : in     vl_logic_vector(11 downto 0);
        ins             : in     vl_logic_vector(31 downto 0);
        outs            : out    vl_logic_vector(31 downto 0)
    );
end latch32_cp;
