library verilog;
use verilog.vl_types.all;
entity signed_vedic_mult_32bit is
    port(
        a               : in     vl_logic_vector(31 downto 0);
        b               : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(63 downto 0)
    );
end signed_vedic_mult_32bit;
