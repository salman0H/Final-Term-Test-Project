library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity frequency_divider is
    generic (
        N : positive := 4  -- N must be even
    );
    Port ( 
        clk_in : in STD_LOGIC;
        reset : in STD_LOGIC;
        clk_out : out STD_LOGIC
    );
end frequency_divider;

architecture Behavioral of frequency_divider is
    signal count : integer range 0 to N-1;
    signal temp_clk : STD_LOGIC;
begin
    process(clk_in, reset)
    begin
        if reset = '1' then
            count <= 0;
            temp_clk <= '0';
        elsif rising_edge(clk_in) then
            if count = N/2 - 1 then
                temp_clk <= not temp_clk;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temp_clk;
end Behavioral;
