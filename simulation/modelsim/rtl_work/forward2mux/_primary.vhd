library verilog;
use verilog.vl_types.all;
entity forward2mux is
    port(
        rs2_dataE       : in     vl_logic_vector(31 downto 0);
        alu_dataM       : in     vl_logic_vector(31 downto 0);
        wb_data         : in     vl_logic_vector(31 downto 0);
        forward2sel     : in     vl_logic_vector(1 downto 0);
        forward2out     : out    vl_logic_vector(31 downto 0)
    );
end forward2mux;
