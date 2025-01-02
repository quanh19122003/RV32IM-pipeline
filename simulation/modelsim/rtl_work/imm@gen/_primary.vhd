library verilog;
use verilog.vl_types.all;
entity immGen is
    port(
        instr           : in     vl_logic_vector(31 downto 0);
        imm             : out    vl_logic_vector(31 downto 0)
    );
end immGen;
