-- ????? ??? ???? ????? ????? "1101"
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity moore_machine is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end moore_machine;

architecture Behavioral of moore_machine is
    type state_type is (S0, S1, S2, S3, S4);
    signal current_state, next_state : state_type;
begin
    -- ?????? ??? ????
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- ?????? ???? ???? ????
    process(current_state, input)
    begin
        case current_state is
            when S0 =>
                if input = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                if input = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;
            when S2 =>
                if input = '0' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                if input = '1' then
                    next_state <= S4;
                else
                    next_state <= S0;
                end if;
            when S4 =>
                if input = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;
        end case;
    end process;

    -- ????? ??? (??? ?? ???? ?????? ???)
    output <= '1' when current_state = S4 else '0';

-- ????? ???? ???? ???? ?????
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mealy_machine is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           input : in STD_LOGIC;
           output : out STD_LOGIC);
end mealy_machine;

architecture Behavioral of mealy_machine is
    type state_type is (S0, S1, S2, S3);
    signal current_state, next_state : state_type;
begin
    -- ?????? ??? ????
    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= S0;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if;
    end process;

    -- ?????? ???? ???? ???? ? ?????
    process(current_state, input)
    begin
        output <= '0';  -- ????? ???????
        case current_state is
            when S0 =>
                if input = '1' then
                    next_state <= S1;
                else
                    next_state <= S0;
                end if;
            when S1 =>
                if input = '1' then
                    next_state <= S2;
                else
                    next_state <= S0;
                end if;
            when S2 =>
                if input = '0' then
                    next_state <= S3;
                else
                    next_state <= S2;
                end if;
            when S3 =>
                if input = '1' then
                    next_state <= S0;
                    output <= '1';  -- ????? ????
                else
                    next_state <= S0;
                end if;
        end case;
    end process;
end Behavioral;
