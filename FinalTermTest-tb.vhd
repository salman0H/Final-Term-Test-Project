library ieee;
use ieee.std_logic_1164.all;

entity full_adder_tb is
end full_adder_tb;

architecture behavior of full_adder_tb is 
    -- Component Declaration for the Unit Under Test (UUT)
    component full_adder
        port(
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            cout : out std_logic;
            sum  : out std_logic
        );
    end component;
    
    -- Inputs
    signal a    : std_logic := '0';
    signal b    : std_logic := '0';
    signal cin  : std_logic := '0';
    
    -- Outputs
    signal cout : std_logic;
    signal sum  : std_logic;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: full_adder port map (
        a    => a,
        b    => b,
        cin  => cin,
        cout => cout,
        sum  => sum
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Wait 100 ns for global reset
        --wait for 100 ns;
        
        -- Test case 1: 0 + 0 + 0
        a <= '0'; b <= '0'; cin <= '0';
        wait for 10 ns;
        assert (cout = '0' and sum = '0')
            report "Test case 1 failed: 0 + 0 + 0"
            severity error;
            
        -- Test case 2: 0 + 0 + 1
        a <= '0'; b <= '0'; cin <= '1';
        wait for 10 ns;
        assert (cout = '0' and sum = '1')
            report "Test case 2 failed: 0 + 0 + 1"
            severity error;
            
        -- Test case 3: 0 + 1 + 0
        a <= '0'; b <= '1'; cin <= '0';
        wait for 10 ns;
        assert (cout = '0' and sum = '1')
            report "Test case 3 failed: 0 + 1 + 0"
            severity error;
            
        -- Test case 4: 0 + 1 + 1
        a <= '0'; b <= '1'; cin <= '1';
        wait for 10 ns;
        assert (cout = '1' and sum = '0')
            report "Test case 4 failed: 0 + 1 + 1"
            severity error;
            
        -- Test case 5: 1 + 0 + 0
        a <= '1'; b <= '0'; cin <= '0';
        wait for 10 ns;
        assert (cout = '0' and sum = '1')
            report "Test case 5 failed: 1 + 0 + 0"
            severity error;
            
        -- Test case 6: 1 + 0 + 1
        a <= '1'; b <= '0'; cin <= '1';
        wait for 10 ns;
        assert (cout = '1' and sum = '0')
            report "Test case 6 failed: 1 + 0 + 1"
            severity error;
            
        -- Test case 7: 1 + 1 + 0
        a <= '1'; b <= '1'; cin <= '0';
        wait for 10 ns;
        assert (cout = '1' and sum = '0')
            report "Test case 7 failed: 1 + 1 + 0"
            severity error;
            
        -- Test case 8: 1 + 1 + 1
        a <= '1'; b <= '1'; cin <= '1';
        wait for 10 ns;
        assert (cout = '1' and sum = '1')
            report "Test case 8 failed: 1 + 1 + 1"
            severity error;
            
        -- Test complete
        wait for 10 ns;
        report "Test completed successfully!"
        severity note;
        
        wait; -- End simulation
    end process;
end behavior;
