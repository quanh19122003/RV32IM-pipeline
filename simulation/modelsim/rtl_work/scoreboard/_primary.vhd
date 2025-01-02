library verilog;
use verilog.vl_types.all;
entity scoreboard is
    port(
        io_sw_i         : in     vl_logic_vector(31 downto 0);
        io_lcd_o        : in     vl_logic_vector(31 downto 0);
        io_ledg_o       : in     vl_logic_vector(31 downto 0);
        io_ledr_o       : in     vl_logic_vector(31 downto 0);
        io_hex0_o       : in     vl_logic_vector(6 downto 0);
        io_hex1_o       : in     vl_logic_vector(6 downto 0);
        io_hex2_o       : in     vl_logic_vector(6 downto 0);
        io_hex3_o       : in     vl_logic_vector(6 downto 0);
        io_hex4_o       : in     vl_logic_vector(6 downto 0);
        io_hex5_o       : in     vl_logic_vector(6 downto 0);
        io_hex6_o       : in     vl_logic_vector(6 downto 0);
        io_hex7_o       : in     vl_logic_vector(6 downto 0);
        pc_debug_o      : in     vl_logic_vector(31 downto 0);
        o_insn_vld      : in     vl_logic;
        clk_i           : in     vl_logic;
        rst_ni          : in     vl_logic
    );
end scoreboard;
