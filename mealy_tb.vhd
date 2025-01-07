library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mealy_machine_tb is
end mealy_machine_tb;

architecture Behavioral of mealy_machine_tb is

    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal input    : std_logic := '0';
    signal output   : std_logic;
    
    constant CLK_PERIOD : time := 10 ns;
    
    component mealy_machine is
        Port ( clk    : in  STD_LOGIC;
               reset  : in  STD_LOGIC;
               input  : in  STD_LOGIC;
               output : out STD_LOGIC);
    end component;
    
begin

    uut: mealy_machine port map (
        clk    => clk,
        reset  => reset,
        input  => input,
        output => output
    );
    

    clk_process: process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
    

    stim_proc: process
    begin
        reset <= '1';
        wait for CLK_PERIOD*2;
        reset <= '0';
        wait for CLK_PERIOD;

        input <= '1'; wait for CLK_PERIOD;
        input <= '1'; wait for CLK_PERIOD;
        input <= '0'; wait for CLK_PERIOD;
        input <= '1'; wait for CLK_PERIOD;
        assert output = '1'
            report "Test 1 Failed: Sequence 1101 not detected"
            severity ERROR;
        

        input <= '1'; wait for CLK_PERIOD;
        input <= '1'; wait for CLK_PERIOD;
        input <= '0'; wait for CLK_PERIOD;
        input <= '0'; wait for CLK_PERIOD;
        assert output = '0'
            report "Test 2 Failed: False detection"
            severity ERROR;
        

        input <= '1'; wait for CLK_PERIOD;
        input <= '1'; wait for CLK_PERIOD;
        input <= '0'; wait for CLK_PERIOD;
        input <= '1'; wait for CLK_PERIOD;
        assert output = '1'
            report "Test 3 Failed: Overlapping sequence not detected"
            severity ERROR;
        
        wait for CLK_PERIOD*5;
        
        report "Simulation Completed Successfully";
        wait;
    end process;
end Behavioral;
