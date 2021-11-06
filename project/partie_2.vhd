library work;
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity partie_2 is

	port(
	
		OffSet : in std_logic_vector(23 downto 0);
		CLK : in std_logic;
		Reset : in std_logic;
		nPCsel : in std_logic;
		
		Instruction : out std_logic_vector(31 downto 0)
		
	);
	
end entity partie_2;

architecture behavioural of partie_2 is

signal Add1 : std_logic_vector(31 downto 0);
signal Add2 : std_logic_vector(31 downto 0);
signal AddrIn : std_logic_vector(31 downto 0);
signal PcIn : std_logic_vector(31 downto 0);
signal ExOut : std_logic_vector(31 downto 0);

begin

	G1: entity work.pcreg(behavioural) port map (DataIn => PcIn, DataOut => AddrIn, Reset => Reset, CLK => CLK);
	G2: entity work.mem_instruction(behavioural) port map (PC => AddrIn, Instruction => Instruction);
	G3: entity work.addition_plus(behavioural) port map (A => AddrIn, S => Add2);
	G4: entity work.addition(behavioural) port map (A => Add2, B => ExOut, S => Add1);
	G5: entity work.extension_instruction(behavioural) port map (E => OffSet, S => ExOut);
	G6: entity work.mux21_instruction(one) port map (A => Add2, B => Add1, COM => nPCsel, S => PcIn);
	
			
end architecture behavioural;





