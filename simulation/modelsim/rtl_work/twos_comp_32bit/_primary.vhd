library verilog;
use verilog.vl_types.all;
entity twos_comp_32bit is
    port(
        \in\            : in     vl_logic_vector(31 downto 0);
        \out\           : out    vl_logic_vector(31 downto 0);
        en              : in     vl_logic
    );
end twos_comp_32bit;
