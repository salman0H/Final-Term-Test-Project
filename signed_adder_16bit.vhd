library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel_adder_16bit is
port(
	a : in signed (15 downto 0);
	b : in signed (15 downto 0);
	cin : in signed (15 downto 0);
	sum : out signed (15 downto 0);
	cout : out std_logic 
);
end parallel_adder_16bit;

architecture behavioral of parallel_adder_16bit is
signal c_int : signed (16 downto 0);
begin
	c_int <= resize(a, 17) + b + signed('0' & cin);
	sum <= c_int(15 downto 0);
	cout <= a(15) xor b(15) xor c_int(16);
end behavioral;
