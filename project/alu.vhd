library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity ual_component is
port(
		OP : in std_logic_vector(1 downto 0);
		A : in std_logic_vector(31 downto 0);
		B : in std_logic_vector(31 downto 0);
    flag : out std_logic_vector(31 downto 0);
		S : out std_logic_vector(31 downto 0)

	);
end ual_component;

architecture alu of ual_component is
signal result : std_logic_vector(31 downto 0);
signal N : std_logic;
signal Z : std_logic;
begin

	process(A,B, OP)		
	begin

		case OP is
			when "00" => 
				result <= std_logic_vector(signed(A) + signed(B));   -- turn to sigend.
				
			when "01" => 
				result <= B;
				
			when "10" => 
				result <= std_logic_vector(signed(A) - signed(B)); 
				
			when "11" => 
				result <= A;
				
			when others => 
				result <= (others=>'0');
				
		end case;
		
	end process;
	
	S <= result;
	flag <= result;	
	
end architecture alu;













