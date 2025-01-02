library verilog;
use verilog.vl_types.all;
entity ld_sel_mux is
    port(
        LW              : in     vl_logic_vector(31 downto 0);
        LB              : in     vl_logic_vector(7 downto 0);
        LBU             : in     vl_logic_vector(7 downto 0);
        LH              : in     vl_logic_vector(15 downto 0);
        LHU             : in     vl_logic_vector(15 downto 0);
        ld_sel          : in     vl_logic_vector(2 downto 0);
        ld_data         : out    vl_logic_vector(31 downto 0)
    );
end ld_sel_mux;
