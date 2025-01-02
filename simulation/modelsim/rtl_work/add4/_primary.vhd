library verilog;
use verilog.vl_types.all;
entity add4 is
    port(
        pc_in           : in     vl_logic_vector(12 downto 0);
        pc_out          : out    vl_logic_vector(12 downto 0)
    );
end add4;
