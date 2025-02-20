library verilog;
use verilog.vl_types.all;
entity datamem is
    port(
        address         : in     vl_logic_vector(8 downto 0);
        byteena         : in     vl_logic_vector(3 downto 0);
        clock           : in     vl_logic;
        data            : in     vl_logic_vector(31 downto 0);
        wren            : in     vl_logic;
        q               : out    vl_logic_vector(31 downto 0)
    );
end datamem;
