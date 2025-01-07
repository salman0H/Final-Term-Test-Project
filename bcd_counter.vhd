library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
library ieee;
use ieee.std_logic_1164.all;

entity bcdcounter is
    Port ( clk : in  STD_LOGIC;
           f : out  unsigned (3 downto 0));
end bcdcounter;

architecture Behavioral of bcdcounter is


component dcm2
port
 (-- Clock in ports
  CLK_IN1           : in     std_logic;
  -- Clock out ports
  CLK_OUT1          : out    std_logic;
  CLK_OUT2          : out    std_logic;
  CLK_OUT3          : out    std_logic
 );
end component;
--
--
signal f_int: unsigned (3 downto 0):="0000";
signal clock_750Mhz: std_logic;
signal clock_750Mhz_buf: std_logic;

signal CLK_OUT1,CLK_OUT2,CLK_OUT3: std_logic;

begin
f<=f_int;
clock_750Mhz <=  CLK_OUT1 xor CLK_OUT2 xor CLK_OUT3;
--
your_instance_name : dcm2
  port map
   (-- Clock in ports
    CLK_IN1 => clk,
    -- Clock out ports
    CLK_OUT1 => CLK_OUT1,
    CLK_OUT2 => CLK_OUT2,
    CLK_OUT3 => CLK_OUT3);
--
--
	BUFG_inst : BUFG
   port map (
      O => clock_750Mhz_buf, -- 1-bit output: Clock buffer output
      I => clock_750Mhz -- 1-bit input: Clock buffer input
   );


process(clock_750Mhz_buf)
begin
   if rising_edge (clock_750Mhz_buf) then

			f_int<=f_int+1;
			if f_int="1001" then
				f_int<="0000";
			end if;

	end if;	
end process;


end Behavioral;

