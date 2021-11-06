library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity BDR is
	generic(
		depth : integer := 4;   
		width_t : integer := 32
	);
	port(
			CLK : in std_logic;
			Reset : in std_logic;
			WE : in std_logic;
			RA : in std_logic_vector(depth-1 downto 0);
			RB : in std_logic_vector(depth-1 downto 0);
			RW : in std_logic_vector(depth-1 downto 0);
			W : in std_logic_vector(width_t-1 downto 0);
			A : out std_logic_vector(width_t-1 downto 0); 
			B : out std_logic_vector(width_t-1 downto 0)

		);
end BDR;

architecture behavioural of BDR is

	-- To use the array here.
	type table is array(15 downto 0) of std_logic_vector(width_t-1 downto 0);

	function init_banc return table is
	variable result : table;
	begin
		for i in 14 downto 0 loop
			result(i) := (others=>'0');
		end loop;
			result(15) := X"00000030";
			return result;
	end init_banc;
	
	--variable Banc : table := init_banc;   -- To use the type of ram.
	signal Banc : table := init_banc;

	begin
	
		d1:process(CLK,Reset,W) 
		 			
		begin
			if(Reset = '1') then
				Banc <= init_banc;
				
			elsif rising_edge(CLK) then
				
				if(WE = '1') then
					Banc(conv_integer(RW)) <= W;
				end if;
				
			end if;
		end process;
		
		A <= Banc(to_integer(unsigned(RA)));
		B <= Banc(to_integer(unsigned(RB)));
		
			
end architecture behavioural;

				
			

