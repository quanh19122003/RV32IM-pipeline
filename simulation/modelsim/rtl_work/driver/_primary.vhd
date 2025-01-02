library verilog;
use verilog.vl_types.all;
entity driver is
    port(
        io_sw_i         : out    vl_logic_vector(31 downto 0);
        clk_i           : in     vl_logic;
        rst_ni          : in     vl_logic
    );
end driver;
