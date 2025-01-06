library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity signed_adder is
port(
	a : in signed (7 downto 0);
	b : in signed (7 downto 0);
	sum : out signed (8 downto 0));
end signed_adder;

architecture behavioral of signed_adder is
begin
	process(a, b)
	begin		
		sum <= a + b;
	end process;
end behavioral;
