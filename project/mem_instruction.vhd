library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mem_instruction is

	port(
			Instruction : out std_logic_vector(31 downto 0);
			PC : in std_logic_vector(31 downto 0)

		);
		
end mem_instruction;

architecture behavioural of mem_instruction is

	type table is array(63 downto 0) of std_logic_vector(31 downto 0);

	function init_banc return table is
	variable result : table;
	begin
		for i in 63 downto 0 loop
			result(i) := (others=>'0');
		end loop;
			result(0) := X"E3A00020"; 
			result(1) := X"E3A02001";
			result(2) := X"E3A02000";
			result(3) := X"E3A01001";
			result(4) := X"E6103000";
			result(5) := X"E6104001";
			result(6) := X"E1530004";
			result(7) := X"C6004000";
			result(8) := X"C6003001";
			result(9) := X"C2822001";
			result(10) := X"E2800001";
			result(11) := X"E2811001";
			result(12) := X"E3510007";
			result(13) := X"BAFFFFF6";
			result(14) := X"E3520000";
			result(15) := X"E3A00020";
			result(16) := X"1AFFFFF1";
			result(17) := X"BAFFFFFF";
			return result;
	end init_banc;

	signal Banc : table := init_banc;

	begin
	

		Instruction <= Banc(to_integer(unsigned(PC)));

				
end architecture behavioural;

				
			

