library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mem is

	port(
			CLK : in std_logic;
			WrEN : in std_logic;
			DataOut : out std_logic_vector(31 downto 0);
			DataIn : in std_logic_vector(31 downto 0);
			Addr : in std_logic_vector(5 downto 0)

		);
end mem;

architecture behavioural of mem is

	type table is array(63 downto 0) of std_logic_vector(31 downto 0);
	
	function init_banc return table is
	variable result : table;
	begin
		for i in 63 downto 0 loop
			result(i) := (others=>'0');
		end loop;
			result(63) := X"00000080";
			
			result(32) := X"00000003";
			result(33) := X"0000006B"; 
			result(34) := X"0000001B";
			result(35) := X"0000000C";
			result(36) := X"00000142";
			result(37) := X"0000009B";
			result(38) := X"00000000";
			result(39) := X"0000003F";

			return result;
	end init_banc;

	signal Banc : table := init_banc;

	begin
	
		d1:process(CLK,DataIn) 
		 			
		begin
				
			if rising_edge(CLK) then
				
				if(WrEn = '1') then
					Banc(conv_integer(Addr)) <= DataIn;
				end if;
				
			end if;
		end process;
		
		DataOut <= Banc(to_integer(unsigned(Addr)));
		
			
end architecture behavioural;

				
			

