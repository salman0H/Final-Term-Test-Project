LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE ieee.numeric_std.ALL;
 
ENTITY sm_adder_tb IS
END sm_adder_tb;
 
ARCHITECTURE behavior OF sm_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sm_adder
    PORT(
         A : IN  unsigned(15 downto 0);
         B : IN  unsigned(15 downto 0);
         S : OUT  unsigned(15 downto 0);
         AVF : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : unsigned(15 downto 0) := (others => '0');
   signal B : unsigned(15 downto 0) := (others => '0');

 	--Outputs
   signal S : unsigned(15 downto 0);
   signal AVF : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sm_adder PORT MAP (
          A => A,
          B => B,
          S => S,
          AVF => AVF
        );

   -- Clock process definitions
   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      --wait for <clock>_period*10;
		a <= "0000000000000101";
		b <= "1000000000000010";
      -- insert stimulus here 

      wait;
   end process;

END;

