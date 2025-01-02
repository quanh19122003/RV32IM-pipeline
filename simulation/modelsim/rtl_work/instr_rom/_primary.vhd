library verilog;
use verilog.vl_types.all;
entity instr_rom is
    port(
        pc              : in     vl_logic_vector(12 downto 0);
        instr           : out    vl_logic_vector(31 downto 0)
    );
end instr_rom;
