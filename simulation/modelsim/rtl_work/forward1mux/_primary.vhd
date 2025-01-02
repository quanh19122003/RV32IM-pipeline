library verilog;
use verilog.vl_types.all;
entity forward1mux is
    port(
        rs1_dataE       : in     vl_logic_vector(31 downto 0);
        alu_dataM       : in     vl_logic_vector(31 downto 0);
        wb_data         : in     vl_logic_vector(31 downto 0);
        forward1sel     : in     vl_logic_vector(1 downto 0);
        forward1out     : out    vl_logic_vector(31 downto 0)
    );
end forward1mux;
