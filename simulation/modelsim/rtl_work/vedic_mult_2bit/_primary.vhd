library verilog;
use verilog.vl_types.all;
entity vedic_mult_2bit is
    port(
        a               : in     vl_logic_vector(1 downto 0);
        b               : in     vl_logic_vector(1 downto 0);
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end vedic_mult_2bit;
