LIBRARY ieee;
library work;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity extension_instruction is
	generic(
		N : integer := 24   
	);
	port(
	
		E : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(31 downto 0)
	);
	
end entity extension_instruction;

architecture behavioural of extension_instruction is

begin 

	
	S(31 downto N) <= (others => E(N-1));
	S(N-1 downto 0) <= E;
		
			
end architecture behavioural;

				
			