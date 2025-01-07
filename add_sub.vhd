library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sm_adder is
    Port ( A : in  unsigned (15 downto 0);
           B : in  unsigned (15 downto 0);
           S : out  unsigned (15 downto 0);
           AVF : out  STD_LOGIC);
end sm_adder;

architecture Behavioral of sm_adder is
	signal x_or : std_logic;
	signal c_s : unsigned ( 15 downto 0);
	signal m_s : unsigned ( 14 downto 0);
	signal s_s : std_logic;
begin
	x_or <= a(15) xor b(15); --check add or sub
	c_s <= resize (a(14 downto 0 ), 16) + b(14 downto 0 ) when x_or = '0' else
			 resize (a(14 downto 0 ), 16) + not b(14 downto 0 ) + 1;

	avf <= c_s (15) when x_or = '0' else '0';
	
	m_s <= not c_s(14 downto 0) + 1 when x_or = '1' and c_s(15) = '0' else
			 c_s( 14 downto 0);
	
	s_s <= not a(15) when c_s(15) = '0' and x_or = '1' else 
			 '0' when a( 14 downto 0 ) = "000000000000000" and c_s(15) = '1' and x_or = '1' else 
			 a(15);
			
	s <= s_s & m_s;
	
end Behavioral;


