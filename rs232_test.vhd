library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RS232_test is
    Port ( 
--	        test_data     : in  unsigned (4 downto 0);
--         valid         : in  STD_LOGIC;
           clock         : in  STD_LOGIC;
           TX_serial_out : out  STD_LOGIC;
           TX_busy       : out  STD_LOGIC;
           RX_data       : out  unsigned (7 downto 0);
           RX_valid      : out  STD_LOGIC);
end RS232_test;

architecture Behavioral of RS232_test is

   COMPONENT RS232_TX
	PORT(
		Clock       : IN std_logic;
		parallel_in : IN unsigned(7 downto 0);
		TX_Valid       : IN std_logic;          
		TX_Busy        : OUT std_logic;
		Serial_out  : OUT std_logic
		);
	END COMPONENT;

	COMPONENT RS232_Rx
	PORT(
		Clock     : IN  std_logic;
		Serial_in : IN  std_logic;          
		RX_Data   : OUT unsigned(7 downto 0);
		RX_Valid  : OUT std_logic
		);
	END COMPONENT;


signal  test_data_int     :  unsigned (7 downto 0);
signal  valid_int         :  STD_LOGIC:='0';
signal  TX_serial_out_int :  STD_LOGIC;
signal  TX_busy_int       :  STD_LOGIC;
signal  RX_data_int       :  unsigned (7 downto 0);
signal  RX_valid_int      :  STD_LOGIC;

signal one_sec_counter: unsigned (27 downto 0):=	(others=>'0');


begin

   Inst_RS232_TX: RS232_TX PORT MAP(
		Clock       => clock ,
		parallel_in => test_data_int,
		TX_Valid       => valid_int ,
		TX_Busy        => TX_busy_int,
		Serial_out  => TX_serial_out_int
	);

   Inst_RS232_Rx: RS232_Rx PORT MAP(
		Clock  => clock,
		RX_Data   => RX_data_int,
		RX_Valid  => RX_valid_int ,
		Serial_in => TX_serial_out_int
	);
	
	  TX_serial_out <= TX_serial_out_int;
	  TX_busy       <= TX_busy_int;
	  RX_data       <= RX_data_int;
	  RX_valid      <= RX_valid_int;
				  
	process(Clock)
	begin
		if rising_edge(Clock) then
		   valid_int     <= '0';
		   test_data_int <= "10100111"; 

		   one_sec_counter<= one_sec_counter+1;
		   if one_sec_counter=to_unsigned(2,28) then
				  valid_int     <= '1';
	  		end if;

		end if;
	end process;	
end Behavioral;

