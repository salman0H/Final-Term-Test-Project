library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity RS232_TX is
    Port ( Clock      : in  STD_LOGIC;
           parallel_in: in  unsigned (7 downto 0);
           TX_Valid   : in  STD_LOGIC;
           TX_Busy    : out  STD_LOGIC;
           Serial_out : out  STD_LOGIC);
end RS232_TX;

architecture Behavioral of RS232_TX is

   signal  parallel_in_signal   :   unsigned (7 downto 0):= (others => '0');
   signal  TX_Valid_signal      :  STD_LOGIC := '0';
	signal  TX_Valid_signal_prev :  STD_LOGIC :='0';
   signal  TX_Busy_signal       :   STD_LOGIC:='0';
   signal  Serial_out_signal    :  STD_LOGIC :='0';
	
	signal TX_Bit_count    : unsigned (3 downto 0):= (others => '0');
	signal TX_Parity_bit   :  STD_LOGIC := '0';
   signal Packet_generate :  STD_LOGIC := '0';
   signal Start_sending   :  STD_LOGIC := '0';
   signal RS232_Packet    :  unsigned (11 downto 0):= (others => '0');
	
	signal   Bit_width_reg : unsigned (13 downto 0):= (others => '0');
   constant Baud_rate_9600: unsigned (13 downto 0):= to_unsigned(10417,14);

begin

   Serial_out  <=  serial_out_signal;
	TX_Busy        <=  TX_Busy_signal;

   process (clock)
	begin
	
	    if rising_edge (clock) then
		 
		     parallel_in_signal     <= parallel_in;   
			  TX_Valid_signal			 <= TX_Valid;
			  TX_Valid_signal_prev   <= TX_Valid_signal;
			  Packet_generate        <= '0';
			  Serial_out_signal      <= '1';  
			  
			  Bit_width_reg <= Bit_width_reg + 1;
			  if Bit_width_reg = Baud_rate_9600 then
			  
			     Bit_width_reg    <= (others => '0');
				  TX_Bit_count     <=  TX_Bit_count + 1 ;
			  
			  end if;
	
	        if (TX_Valid_signal = '1' and TX_Valid_signal_prev = '0' and TX_busy_signal = '0') then
		 
		        TX_busy_signal    <= '1';
				  Packet_generate   <= '1';
				  TX_Parity_Bit     <= parallel_in_signal (0) xor parallel_in_signal (1) xor parallel_in_signal (2) xor
					                    parallel_in_signal (3) xor parallel_in_signal (4) xor parallel_in_signal (5) xor
							              parallel_in_signal (6) xor parallel_in_signal (7);
	    
		     end if;
		 
		     if Packet_generate = '1' then
			  
			     start_sending  <=  '1';
				  RS232_Packet   <=  '1'&'1'&TX_Parity_Bit&parallel_in_signal&'0';
				  TX_Bit_count   <=  (others => '0');
		        Bit_width_reg  <=  (others => '0');
				  
			  end if;
			  
			  if Start_sending = '1' then
			  
			     Serial_out_signal  <= RS232_Packet (to_integer (TX_Bit_count));
			     
			  end if;   
			  
			  if TX_Bit_count = to_unsigned (11,4) then
			  
			     start_sending  <=  '0';
              TX_busy_signal <= '0';

			  end if;
			  
	  end if;
	  
	end process;
			     

end Behavioral;

