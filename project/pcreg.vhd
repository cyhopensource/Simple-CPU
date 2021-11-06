library work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity pcreg is

	port(
			CLK : in std_logic;
			Reset : in std_logic;
			DataIn : in std_logic_vector(31 downto 0);
			DataOut : out std_logic_vector(31 downto 0)

		);
		
end pcreg;

architecture behavioural of pcreg is

signal temp : std_logic_vector(31 downto 0) := (others => '0');

begin
			
	process(CLK, Reset, DataIn)
			
	begin
	
		if(Reset = '1') then
			DataOut <= (others => '0');
		
		elsif rising_edge(CLK) then
			temp <= DataIn;
	
		end if;
		
		DataOut <= temp;
	end process;
			
			
end architecture behavioural;



