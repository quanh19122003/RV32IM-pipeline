library verilog;
use verilog.vl_types.all;
entity pc_reg is
    port(
        clk             : in     vl_logic;
        rstn            : in     vl_logic;
        en              : in     vl_logic;
        next_pc         : in     vl_logic_vector(12 downto 0);
        pc              : out    vl_logic_vector(12 downto 0)
    );
end pc_reg;
