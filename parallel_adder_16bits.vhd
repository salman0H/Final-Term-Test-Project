library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity parallel_adder_16bit is
port(
	a : in unsigned (15 downto 0);
	b : in unsigned (15 downto 0);
	cin : in unsigned (15 downto 0);
	sum : out unsigned (15 downto 0);
	cout : out std_logic 
);
end parallel_adder_16bit;

architecture behavioral of parallel_adder_16bit is
signal c_int : unsigned (16 downto 0);
begin
	c_int <= resize(a, 17) + b + cin;
	sum <= c_int(15 downto 0);
	cout <= c_int(16);
end behavioral;
