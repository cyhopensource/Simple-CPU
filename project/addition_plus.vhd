library work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity addition_plus is

	port(
			A : in std_logic_vector(31 downto 0);
			S : out std_logic_vector(31 downto 0)

		);
		
end addition_plus;

architecture behavioural of addition_plus is

begin
			
	S <= A + 1;	
			
end architecture behavioural;