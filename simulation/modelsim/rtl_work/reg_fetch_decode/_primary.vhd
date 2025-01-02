library verilog;
use verilog.vl_types.all;
entity reg_fetch_decode is
    port(
        instrF          : in     vl_logic_vector(31 downto 0);
        pcF             : in     vl_logic_vector(12 downto 0);
        pc4F            : in     vl_logic_vector(12 downto 0);
        clk             : in     vl_logic;
        sclr            : in     vl_logic;
        aclr            : in     vl_logic;
        en              : in     vl_logic;
        instrD          : out    vl_logic_vector(31 downto 0);
        pcD             : out    vl_logic_vector(12 downto 0);
        pc4D            : out    vl_logic_vector(12 downto 0)
    );
end reg_fetch_decode;
