library ieee;
library work;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity psr is

	port(

		DataIn : in std_logic_vector(31 downto 0);
		Reset : in std_logic;
		CLK : in std_logic;
		WE : in std_logic;
		
		DataOut : out std_logic_vector(31 downto 0)

	);
	
end entity psr;

architecture behavioural of psr is

--signal temp : std_logic_vector(31 downto 0);
--signal N : std_logic;
--signal Z :std_logic;

begin 
			
	process(CLK, Reset)
	variable temp : std_logic_vector(31 downto 0);
	variable N : std_logic;
	variable Z : std_logic;
	begin
	
		if(Reset = '1') then
			DataOut <= (others => '0');
		elsif rising_edge(CLK) then
			if(WE = '1') then
				temp := DataIn;      -- memoriser la valeur placee sur DataIn.
				N := temp(31);
				Z := not (temp(31) or temp(30) or temp(29) or temp(28) or temp(27) or temp(26) or temp(25) or temp(24) or temp(23) or
							temp(22) or temp(21) or temp(20) or temp(19) or temp(18) or temp(17) or temp(16) or temp(15) or temp(14) or temp(13) or
							temp(12) or temp(11) or temp(10) or temp(9) or temp(8) or temp(7) or temp(6) or temp(5) or temp(4) or temp(3) or
							temp(2) or temp(1) or temp(0));
				temp(31) := N;
				temp(30) := Z;
			end if;
			
		end if;
		
		DataOut <= temp;
	
	end process;

			
end architecture behavioural;


