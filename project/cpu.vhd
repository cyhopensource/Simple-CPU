library work;
library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

entity test is

	port(
		
		Reset : in std_logic;
		CLK : in std_logic
		
	);

end entity test;

architecture behavioural of test is

signal nPCsel : std_logic;
signal Instruction : std_logic_vector(31 downto 0);
signal RegSel : std_logic;
signal RegSelOut : std_logic_vector(3 downto 0);
signal RegWr : std_logic;
signal ALUSrc : std_logic;
signal WrSrc : std_logic;
signal ALUCtr : std_logic_vector(1 downto 0);
signal MemWr : std_logic;
signal flag : std_logic_vector(31 downto 0);
signal PSREn : std_logic;
signal PSROut : std_logic_vector(31 downto 0);
signal Rn : std_logic_vector(3 downto 0);
signal Rd : std_logic_vector(3 downto 0);
signal Rm : std_logic_vector(3 downto 0);
signal Imm : std_logic_vector(7 downto 0);
signal OffSet : std_logic_vector(23 downto 0);

begin

	G0: entity work.mux21_4(one) port map (COM => RegSel, S => RegSelOut, A => Rm, B => Rd);
	G1: entity work.partie_1(behavioural) port map (Ra => Rn, 
													Rb => RegSelOut, 
													Rw => Rd, 
													WE => RegWr, 
													COM_1 => ALUSrc, COM_2 => WrSrc, 
													OP => ALUCtr, WrEn => MemWr,
														Reset => Reset, CLK => CLK, Imm => Imm, flag => flag);
	G2: entity work.partie_2(behavioural) port map (OffSet => OffSet, Instruction => Instruction, nPCsel => nPCsel, 
	                                                 Reset => Reset, CLK => CLK);
	G3: entity work.psr(behavioural) port map (DataIn => flag, DataOut => PSROut, CLK => CLK, Reset => Reset, WE => PSREn);
	G4: entity work.decodeur(behavioural) port map (Instruction_in => Instruction, PSR_in => PSROut, nPCsel => nPCsel, RegWr => RegWr, ALUSrc => ALUSrc,
													ALUCtr => ALUCtr, PSREn => PSREn, MemWr => MemWr, WrSrc => WrSrc, RegSel => RegSel, Rn => Rn, Rd => Rd, Rm => Rm, 
													OffSet => OffSet, Imm => Imm);
	

end architecture behavioural;






