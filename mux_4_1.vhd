
library ieee;
use ieee.std_logic_1164.all;

entity mux_4_1 is
port(
	i : in std_logic_vector (3 downto 0);
	s : in std_logic_vector (1 downto 0);
	en : in std_logic;
	f : out std_logic);
end mux_4_1;

architecture behavioral of mux_4_1 is
	signal sen : std_logic_vector (2 downto 0);
begin
--selected assignment
--	sen <= s & en;
--	with sen select
--		f <= i(0) when "001",
--			i(1) when "011",
--			i(2) when "101",
--			i(3) when "111",
--			'Z' when others;

--conditional assignment
	f <= i(0) when s = "00" and en = '1' else
		i(1) when s = "01" and en = '1' else
		i(2) when s = "10" and en = '1' else
		i(3) when s = "11" and en = '1' else	
		'0';
end behavioral;