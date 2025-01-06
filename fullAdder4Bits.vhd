library ieee;
use ieee.std_logic_1164.all;

entity full_adder_4bits is
	port(
		a : in std_logic_vector (3 downto 0);
		b : in std_logic_vector (3 downto 0);
		cin : in std_logic;
		cout : out std_logic;
		sum : out std_logic_vector (3 downto 0)
	);
end full_adder_4bits;

architecture behavioral of full_adder_4bits is
component full_adder
	port(
		a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		cout : out std_logic;
		sum : out std_logic
	);
end component;
signal c : std_logic_vector (2 downto 0);
begin
fa0: full_adder port map(
	a => a(0),
	b => b(0),
	cin => cin,
	cout => c(0),
	sum => sum(0)
);

fa1: full_adder port map(
	a => a(1),
	b => b(1),
	cin => c(0),
	cout => c(1),
	sum => sum(1)
);

fa2: full_adder port map(
	a => a(2),
	b => b(2),
	cin => c(1),
	cout => c(2),
	sum => sum(2)
);

fa3: full_adder port map(
	a => a(3),
	b => b(3),
	cin => c(2),
	cout => cout,
	sum => sum(3)
);


end behavioral;
