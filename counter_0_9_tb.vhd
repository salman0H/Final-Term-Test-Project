library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is
end counter_tb;

architecture Behavioral of counter_tb is
    -- Component Declaration
    component counter is
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               count : out STD_LOGIC_VECTOR(3 downto 0));
    end component;
    
    -- Signal Declaration
    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal count_tb : std_logic_vector(3 downto 0);
    
    -- Constants
    constant CLK_PERIOD : time := 20 ns;  -- 50MHz clock period
    
begin
    -- Unit Under Test (UUT)
    UUT: counter port map (
        clk => clk_tb,
        reset => reset_tb,
        count => count_tb
    );
    
    -- Clock Process
    clk_process: process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD/2;
        clk_tb <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus Process
    stim_proc: process
    begin
        -- Initialize
        reset_tb <= '1';
        wait for 100 ns;
        
        -- Release reset
        reset_tb <= '0';
        
        -- Wait for first count increment (1 second)
        wait for 1 sec;
        assert count_tb = "0001"
            report "Counter failed to increment to 1"
            severity ERROR;
            
        -- Wait for second count increment
        wait for 1 sec;
        assert count_tb = "0010"
            report "Counter failed to increment to 2"
            severity ERROR;
            
        -- Test reset during counting
        wait for 500 ms;
        reset_tb <= '1';
        wait for 100 ns;
        assert count_tb = "0000"
            report "Reset failed"
            severity ERROR;
            
        -- Release reset and test counting again
        reset_tb <= '0';
        wait for 1 sec;
        assert count_tb = "0001"
            report "Counter failed to restart from 0"
            severity ERROR;
            
        -- Wait for counter to reach 9 and roll over
        wait for 8 sec;
        assert count_tb = "1001"  -- 9 in binary
            report "Counter failed to reach 9"
            severity ERROR;
            
        wait for 1 sec;
        assert count_tb = "0000"
            report "Counter failed to roll over to 0"
            severity ERROR;
            
        -- End simulation
        wait for 100 ns;
        report "Test Completed Successfully";
        wait;
    end process;
    
end Behavioral;
