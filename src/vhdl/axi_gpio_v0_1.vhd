library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity axi_gpio_v0_1 is
	generic(
		-- Parameters of GPIO0 interface
		C_GPIO0_WIDTH          : integer                       := 8; -- 1 to 32
		C_GPIO0_DEFAULT_OUTPUT : std_logic_vector(31 downto 0) := x"FFFFFFFF";
		C_GPIO0_DEFAULT_DDR    : std_logic_vector(31 downto 0) := x"FFFFFFFF";
		-- Parameters of GPIO1 interface
		C_GPIO1_WIDTH          : integer                       := 8; -- 1 to 32
		C_GPIO1_DEFAULT_OUTPUT : std_logic_vector(31 downto 0) := x"FFFFFFFF";
		C_GPIO1_DEFAULT_DDR    : std_logic_vector(31 downto 0) := x"FFFFFFFF";
		-- Parameters of AXI Slave Bus Interface S_AXI
		C_S_AXI_DATA_WIDTH     : integer                       := 32;
		C_S_AXI_ADDR_WIDTH     : integer                       := 5
	);
	port(
		-- Ports of the GPIO interface
		GPIO0         : inout std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
		GPIO1         : inout std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
		-- Ports of AXI Slave Bus Interface S_AXI
		s_axi_aclk    : in    std_logic;
		s_axi_aresetn : in    std_logic;
		s_axi_awaddr  : in    std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		s_axi_awvalid : in    std_logic;
		s_axi_awready : out   std_logic;
		s_axi_wdata   : in    std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
		s_axi_wstrb   : in    std_logic_vector((C_S_AXI_DATA_WIDTH / 8) - 1 downto 0);
		s_axi_wvalid  : in    std_logic;
		s_axi_wready  : out   std_logic;
		s_axi_bresp   : out   std_logic_vector(1 downto 0);
		s_axi_bvalid  : out   std_logic;
		s_axi_bready  : in    std_logic;
		s_axi_araddr  : in    std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
		s_axi_arvalid : in    std_logic;
		s_axi_arready : out   std_logic;
		s_axi_rdata   : out   std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
		s_axi_rresp   : out   std_logic_vector(1 downto 0);
		s_axi_rvalid  : out   std_logic;
		s_axi_rready  : in    std_logic
	);
end axi_gpio_v0_1;

architecture arch of axi_gpio_v0_1 is

	-- component declaration

	component axi_gpio_v0_1_S_AXI
		generic(C_S_AXI_DATA_WIDTH       : integer                       := 32;
			    C_S_AXI_ADDR_WIDTH       : integer                       := 5;
			    C_S_AXI_SLV_REG1_DEFAULT : std_logic_vector(31 downto 0) := x"00000000";
			    C_S_AXI_SLV_REG2_DEFAULT : std_logic_vector(31 downto 0) := x"00000000";
			    C_S_AXI_SLV_REG4_DEFAULT : std_logic_vector(31 downto 0) := x"00000000";
			    C_S_AXI_SLV_REG5_DEFAULT : std_logic_vector(31 downto 0) := x"00000000");
		port(S_AXI_ACLK    : in  std_logic;
			 S_AXI_ARESETN : in  std_logic;
			 S_AXI_AWADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
			 S_AXI_AWVALID : in  std_logic;
			 S_AXI_AWREADY : out std_logic;
			 S_AXI_WDATA   : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_WSTRB   : in  std_logic_vector((C_S_AXI_DATA_WIDTH / 8) - 1 downto 0);
			 S_AXI_WVALID  : in  std_logic;
			 S_AXI_WREADY  : out std_logic;
			 S_AXI_BRESP   : out std_logic_vector(1 downto 0);
			 S_AXI_BVALID  : out std_logic;
			 S_AXI_BREADY  : in  std_logic;
			 S_AXI_ARADDR  : in  std_logic_vector(C_S_AXI_ADDR_WIDTH - 1 downto 0);
			 S_AXI_ARVALID : in  std_logic;
			 S_AXI_ARREADY : out std_logic;
			 S_AXI_RDATA   : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_RRESP   : out std_logic_vector(1 downto 0);
			 S_AXI_RVALID  : out std_logic;
			 S_AXI_RREADY  : in  std_logic;
			 S_AXI_REG0    : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_REG1    : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_REG2    : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_REG3    : in  std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_REG4    : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
			 S_AXI_REG5    : out std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0));
	end component axi_gpio_v0_1_S_AXI;

	-- signal declaration

	signal gpio0_din  : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	signal gpio0_dout : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	signal gpio0_ddr  : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	--
	signal gpio1_din  : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	signal gpio1_dout : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	signal gpio1_ddr  : std_logic_vector(C_GPIO0_WIDTH - 1 downto 0);
	--
	signal s_axi_reg0 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	signal s_axi_reg1 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	signal s_axi_reg2 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	signal s_axi_reg3 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	signal s_axi_reg4 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);
	signal s_axi_reg5 : std_logic_vector(C_S_AXI_DATA_WIDTH - 1 downto 0);

begin

	-- Instantiation of AXI Bus Interface S_AXI
	axi_gpio_v0_1_S_AXI_inst : axi_gpio_v0_1_S_AXI
		generic map(
			C_S_AXI_DATA_WIDTH       => C_S_AXI_DATA_WIDTH,
			C_S_AXI_ADDR_WIDTH       => C_S_AXI_ADDR_WIDTH,
			C_S_AXI_SLV_REG1_DEFAULT => C_GPIO0_DEFAULT_OUTPUT,
			C_S_AXI_SLV_REG2_DEFAULT => C_GPIO0_DEFAULT_DDR,
			C_S_AXI_SLV_REG4_DEFAULT => C_GPIO1_DEFAULT_OUTPUT,
			C_S_AXI_SLV_REG5_DEFAULT => C_GPIO1_DEFAULT_DDR
		)
		port map(
			S_AXI_ACLK    => s_axi_aclk,
			S_AXI_ARESETN => s_axi_aresetn,
			S_AXI_AWADDR  => s_axi_awaddr,
			S_AXI_AWVALID => s_axi_awvalid,
			S_AXI_AWREADY => s_axi_awready,
			S_AXI_WDATA   => s_axi_wdata,
			S_AXI_WSTRB   => s_axi_wstrb,
			S_AXI_WVALID  => s_axi_wvalid,
			S_AXI_WREADY  => s_axi_wready,
			S_AXI_BRESP   => s_axi_bresp,
			S_AXI_BVALID  => s_axi_bvalid,
			S_AXI_BREADY  => s_axi_bready,
			S_AXI_ARADDR  => s_axi_araddr,
			S_AXI_ARVALID => s_axi_arvalid,
			S_AXI_ARREADY => s_axi_arready,
			S_AXI_RDATA   => s_axi_rdata,
			S_AXI_RRESP   => s_axi_rresp,
			S_AXI_RVALID  => s_axi_rvalid,
			S_AXI_RREADY  => s_axi_rready,
			S_AXI_REG0    => s_axi_reg0,
			S_AXI_REG1    => s_axi_reg1,
			S_AXI_REG2    => s_axi_reg2,
			S_AXI_REG3    => s_axi_reg3,
			S_AXI_REG4    => s_axi_reg4,
			S_AXI_REG5    => s_axi_reg5
		);

	-- Instantiation of IOBUFs for the GPIOs
	GEN_GPIO0_IOBUF : for i in 0 to C_GPIO0_WIDTH - 1 generate
		IOBUF_inst : IOBUF
			generic map(
				DRIVE      => 12,
				IOSTANDARD => "DEFAULT",
				SLEW       => "SLOW")
			port map(
				O  => gpio0_din(i),
				IO => GPIO0(i),
				I  => gpio0_dout(i),
				T  => gpio0_ddr(i)
			);
	end generate GEN_GPIO0_IOBUF;

	GEN_GPIO1_IOBUF : for i in 0 to C_GPIO1_WIDTH - 1 generate
		IOBUF_inst : IOBUF
			generic map(
				DRIVE      => 12,
				IOSTANDARD => "DEFAULT",
				SLEW       => "SLOW")
			port map(
				O  => gpio1_din(i),
				IO => GPIO1(i),
				I  => gpio1_dout(i),
				T  => gpio1_ddr(i)
			);
	end generate GEN_GPIO1_IOBUF;

	-- Assigining signals so that they may be read/written through the AXI interface
	s_axi_reg0 <= (C_S_AXI_DATA_WIDTH - 1 downto C_GPIO0_WIDTH => '0') & gpio0_din;
	gpio0_dout <= s_axi_reg1(C_GPIO0_WIDTH - 1 downto 0);
	gpio0_ddr  <= s_axi_reg2(C_GPIO0_WIDTH - 1 downto 0);
	--
	s_axi_reg3 <= (C_S_AXI_DATA_WIDTH - 1 downto C_GPIO1_WIDTH => '0') & gpio1_din;
	gpio1_dout <= s_axi_reg4(C_GPIO1_WIDTH - 1 downto 0);
	gpio1_ddr  <= s_axi_reg5(C_GPIO1_WIDTH - 1 downto 0);

end arch;
