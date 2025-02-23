library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity resize_function is
port(
	b : in signed (7 downto 0) := "11100010");
end resize_function;

architecture behavioral of resize_function is
	signal c : signed (11 downto 0);
begin 
	c <= resize(b & "01", 12);
end behavioral;