library ieee;
use ieee.std_logic_1164.all;

entity and_or is
port(
	a : in std_logic;
	b : in std_logic;
	c : in std_logic;
	z : out std_logic
);
end and_or;

architecture behavioral of and_or is
	signal d : std_logic;
	signal h : std_logic;
	signal f : std_logic;
begin
	d <= a and b;
	h <= not c or b;
	f <= d and d;
	z <= f or h;
end behavioral;
