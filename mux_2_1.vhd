library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2_1 is
    Port ( i : in  STD_LOGIC_VECTOR (1 downto 0);
           s : in  STD_LOGIC;
           f : out  STD_LOGIC);
end mux2_1;

architecture Behavioral of mux2_1 is

signal g:STD_LOGIC;
signal j:STD_LOGIC;


begin

f <= g or j;
g <= i(0) and not s;
j <= i(1) and s;


end Behavioral;

