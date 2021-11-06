LIBRARY ieee;
library work;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

entity extension is
	generic(
		N : integer := 8   
	);
	port(
	
		E : in std_logic_vector(N-1 downto 0);
		S : out std_logic_vector(31 downto 0)
	);
	
end entity extension;

architecture behavioural of extension is

begin 

	
	S(31 downto N) <= (others => E(N-1));
	S(N-1 downto 0) <= E;
		
			
end architecture behavioural;

				
			