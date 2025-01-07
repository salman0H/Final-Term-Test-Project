LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY RS232_tb IS
END RS232_tb;
 
ARCHITECTURE behavior OF RS232_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RS232_test
    PORT(
         clock : IN  std_logic;
         TX_serial_out : OUT  std_logic;
         TX_busy : OUT  std_logic;
         RX_data : OUT  unsigned(7 downto 0);
         RX_valid : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';

 	--Outputs
   signal TX_serial_out : std_logic;
   signal TX_busy : std_logic;
   signal RX_data : unsigned(7 downto 0);
   signal RX_valid : std_logic;

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RS232_test PORT MAP (
          clock => clock,
          TX_serial_out => TX_serial_out,
          TX_busy => TX_busy,
          RX_data => RX_data,
          RX_valid => RX_valid
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
--    wait for 100 ns;	
--
--      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
