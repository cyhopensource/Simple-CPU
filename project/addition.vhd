library work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity addition is

	port(
			A : in std_logic_vector(31 downto 0);
			B : in std_logic_vector(31 downto 0);
			S : out std_logic_vector(31 downto 0)

		);
		
end addition;

architecture behavioural of addition is

begin
			
	S <= A + B;	
			
end architecture behavioural;