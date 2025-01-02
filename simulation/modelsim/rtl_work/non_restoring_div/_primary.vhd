library verilog;
use verilog.vl_types.all;
entity non_restoring_div is
    port(
        src1            : in     vl_logic_vector(31 downto 0);
        src2            : in     vl_logic_vector(31 downto 0);
        qut             : out    vl_logic_vector(31 downto 0);
        rmd             : out    vl_logic_vector(31 downto 0)
    );
end non_restoring_div;
