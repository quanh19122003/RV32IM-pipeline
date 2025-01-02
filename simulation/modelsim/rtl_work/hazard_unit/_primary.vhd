library verilog;
use verilog.vl_types.all;
entity hazard_unit is
    port(
        br_selE         : in     vl_logic;
        rd_wrenE        : in     vl_logic;
        rd_wrenM        : in     vl_logic;
        rd_wrenW        : in     vl_logic;
        wb_selE         : in     vl_logic_vector(1 downto 0);
        wb_selM         : in     vl_logic_vector(1 downto 0);
        rs1_addrD       : in     vl_logic_vector(4 downto 0);
        rs2_addrD       : in     vl_logic_vector(4 downto 0);
        rs1_addrE       : in     vl_logic_vector(4 downto 0);
        rs2_addrE       : in     vl_logic_vector(4 downto 0);
        rd_addrE        : in     vl_logic_vector(4 downto 0);
        rd_addrM        : in     vl_logic_vector(4 downto 0);
        rd_addrW        : in     vl_logic_vector(4 downto 0);
        stallF          : out    vl_logic;
        stallD          : out    vl_logic;
        flushD          : out    vl_logic;
        flushE          : out    vl_logic;
        forward1sel     : out    vl_logic_vector(1 downto 0);
        forward2sel     : out    vl_logic_vector(1 downto 0);
        rs1d_sel        : out    vl_logic_vector(1 downto 0);
        rs2d_sel        : out    vl_logic_vector(1 downto 0)
    );
end hazard_unit;
