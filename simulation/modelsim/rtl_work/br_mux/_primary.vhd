library verilog;
use verilog.vl_types.all;
entity br_mux is
    port(
        br_sel          : in     vl_logic;
        alu_data        : in     vl_logic_vector(12 downto 0);
        pc_four         : in     vl_logic_vector(12 downto 0);
        next_pc         : out    vl_logic_vector(12 downto 0)
    );
end br_mux;
