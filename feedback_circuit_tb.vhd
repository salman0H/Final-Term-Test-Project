library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity feedback_circuit_tb is
end feedback_circuit_tb;

architecture testbench of feedback_circuit_tb is
    -- Component Declaration
    component feedback_circuit
        port(
            clock : in std_logic;
            a : in std_logic_vector(7 downto 0);
            f : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for driving the component
    signal clock : std_logic := '0';
    signal a : std_logic_vector(7 downto 0) := (others => '0');
    signal f : std_logic_vector(7 downto 0);

    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: feedback_circuit
        port map(
            clock => clock,
            a => a,
            f => f
        );

    -- Clock generation process
    clock_process: process
    begin
        while true loop
            clock <= '0';
            wait for clk_period / 2;
            clock <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Test case 1: Add 5 repeatedly
        a <= std_logic_vector(to_unsigned(5, 8));
        wait for 100 ns;

        -- Test case 2: Change input to 10
        a <= std_logic_vector(to_unsigned(10, 8));
        wait for 100 ns;

        -- Test case 3: Add 0
        a <= std_logic_vector(to_unsigned(0, 8));
        wait for 100 ns;

        -- Stop simulation
        wait;
    end process;

end testbench;

