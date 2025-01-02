library verilog;
use verilog.vl_types.all;
entity ld_mux is
    port(
        main_addr       : in     vl_logic_vector(11 downto 0);
        mem_data        : in     vl_logic_vector(31 downto 0);
        out_data        : in     vl_logic_vector(31 downto 0);
        in_data         : in     vl_logic_vector(31 downto 0);
        data_out        : out    vl_logic_vector(31 downto 0)
    );
end ld_mux;
