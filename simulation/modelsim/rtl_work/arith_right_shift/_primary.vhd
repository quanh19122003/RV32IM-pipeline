library verilog;
use verilog.vl_types.all;
entity arith_right_shift is
    port(
        din             : in     vl_logic_vector(31 downto 0);
        amount          : in     vl_logic_vector(4 downto 0);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end arith_right_shift;
