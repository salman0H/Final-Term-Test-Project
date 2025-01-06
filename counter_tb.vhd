
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity advanced_counter_tb is
end advanced_counter_tb;

architecture behavioral of advanced_counter_tb is
    -- Component Declaration
    component advanced_counter
        generic(
            max_count : integer := 9
        );
        port(
            clk      : in  std_logic;
            reset    : in  std_logic;
            enable   : in  std_logic;
            dir      : in  std_logic;
            load     : in  std_logic;
            data_in  : in  std_logic_vector(3 downto 0);
            count    : out std_logic_vector(3 downto 0);
            max_flag : out std_logic
        );
    end component;
    
    -- Signal declarations
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal enable   : std_logic := '0';
    signal dir      : std_logic := '0';
    signal load     : std_logic := '0';
    signal data_in  : std_logic_vector(3 downto 0) := (others => '0');
    signal count    : std_logic_vector(3 downto 0);
    signal max_flag : std_logic;
    
    -- Constants
    constant CLK_PERIOD : time := 10 ns;
    
begin
    -- Component instantiation
    UUT: advanced_counter
        generic map(
            max_count => 9
        )
        port map(
            clk      => clk,
            reset    => reset,
            enable   => enable,
            dir      => dir,
            load     => load,
            data_in  => data_in,
            count    => count,
            max_flag => max_flag
        );
        
    -- Clock process
    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    
    -- Stimulus process
    stim_proc: process
    begin
        -- Initial state
        wait for CLK_PERIOD*2;
        
        -- Test 1: Reset
        reset <= '1';
        wait for CLK_PERIOD*2;
        reset <= '0';
        wait for CLK_PERIOD;
        
        -- Test 2: Count up
        enable <= '1';
        dir <= '0';  -- Count up
        wait for CLK_PERIOD*12;  -- Wait enough cycles to see overflow
        
        -- Test 3: Count down
        dir <= '1';  -- Count down
        wait for CLK_PERIOD*12;  -- Wait enough cycles to see underflow
        
        -- Test 4: Load value
        load <= '1';
        data_in <= "0101";  -- Load value 5
        wait for CLK_PERIOD*2;
        load <= '0';
        
        -- Test 5: Count up from loaded value
        dir <= '0';
        wait for CLK_PERIOD*6;  -- Count up from 5 to max
        
        -- Test 6: Disable counting
        enable <= '0';
        wait for CLK_PERIOD*4;
        
        -- Test 7: Re-enable and count down
        enable <= '1';
        dir <= '1';
        wait for CLK_PERIOD*12;
        
        -- End simulation
        wait for CLK_PERIOD*2;
        assert false report "Simulation completed successfully" severity note;
        wait;
    end process;
    
    -- Monitor process to display results
    monitor_proc: process(clk)
    begin
        if rising_edge(clk) then
            report "Count = " & integer'image(to_integer(unsigned(count))) & 
                   ", Max Flag = " & std_logic'image(max_flag);
        end if;
    end process;
    
end behavioral;