library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity RS232_Rx is
    Port ( 
				Clock 	      : in  	STD_LOGIC;
				RX_Data	: out  	unsigned 	(7 downto 0);
				RX_Valid		   : out  	STD_LOGIC;
				Serial_IN 	   : in  	STD_LOGIC);
end RS232_Rx;

architecture Behavioral of RS232_Rx is

	signal	RX_Data_Int					:	unsigned	(10 downto 0)				:=	(others=>'0');
	signal	RX_Valid_Int				:	std_logic								:=	'0';
	signal	Serial_Int				:	std_logic								:=	'0';
	signal	Serial_Prev				:	std_logic								:=	'0';
	
	signal	RX_Data_Bit_Count			:	unsigned	(3 downto 0)				:=	(others=>'0');
	signal	RX_Parity_Bit				:	std_logic								:=	'0';
	signal	Packet_Detection		:	std_logic								:=	'0';
	signal	Find_Bit_Center_State:	std_logic								:=	'0';
	
	-----		Baud rate = 9600 => bit width = 1/9600 = 104.16 us.
	-----		Clock Freq. = 50 MHz => Clock Period = 20 ns.
	-----		Bit sample = 104.16 us / 20 ns = 5208.
	constant	Baud_Rate_9600			:	unsigned	(13 downto 0)				:=	to_unsigned(10416,14);--5207
	constant	Half_Baud_Rate_9600	:	unsigned	(12 downto 0)				:=	to_unsigned(5208,13);--2603
	signal	Bit_Width_Count		:	unsigned	(13 downto 0)				:=	(others=>'0');
	
begin

	RX_Data									<=		RX_Data_Int(7 downto 0);
	RX_Valid									<=		RX_Valid_Int;

	process(Clock)
	begin
		if rising_edge(Clock) then
			Serial_Int					<=		Serial_IN;
			Serial_Prev					<=		Serial_Int;
			RX_Valid_Int				<=		'0';
			Bit_Width_Count			<=		Bit_Width_Count + 1;
			if (Bit_Width_Count = Baud_Rate_9600) and RX_Data_Bit_Count /= 9 then
			   Bit_Width_Count		<=		(others=>'0');
				RX_Data_Bit_Count		<=		RX_Data_Bit_Count + 1;
				RX_Data_Int(to_integer(RX_Data_Bit_Count))<=	Serial_Int;
				RX_Parity_Bit			<=		RX_Parity_Bit xor Serial_Int;
			end if;
--			if (Bit_Width_Count = Baud_Rate_9600) and RX_Data_Bit_Count = 4 then
--			   Bit_Width_Count		<=		(others=>'0');
--				RX_Data_Bit_Count			<=		RX_Data_Bit_Count + 1;
--				RX_Data_Int(to_integer(RX_Data_Bit_Count))<=	not Serial_Int;
--				RX_Parity_Bit				<=		RX_Parity_Bit xor (not Serial_Int);
--			end if;
			if (RX_Data_Bit_Count = to_unsigned(9,4) and Packet_Detection = '1') then
			    RX_Valid_Int			<=		not RX_Parity_Bit;
				Packet_Detection		<=		'0';
			end if;
			if (Serial_Int = '0' and Serial_Prev = '1' and Packet_Detection = '0') then
				Packet_Detection		<=		'1';
				Find_Bit_Center_State<=		'1';
				RX_Parity_Bit			<=		'0';				
				RX_Data_Bit_Count		<=		(others=>'0');						
				Bit_Width_Count		<=		(others=>'0'); 
			end if;
			if (Bit_Width_Count = Half_Baud_Rate_9600 and Find_Bit_Center_State = '1') then
				Find_Bit_Center_State<=	'0';			
				Bit_Width_Count		<=	(others=>'0');						
			end if;
		end if;
	end process;
end Behavioral;

