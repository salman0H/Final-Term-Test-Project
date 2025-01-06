library ieee;
use ieee.std_logic_1164.all;

entity example_process is
port(
	a, b : in std_logic;
	c : out std_logic);
end example_process;

architecture behavioral of example_process is
begin 
	process(a, b)
	begin
		if a = '1' then
			c  <= b;
		else
			c <= '0';
		end if;
	end process;
end behavioral;
