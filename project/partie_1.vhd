library ieee;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity partie_1 is
	port(
	
		Ra : in std_logic_vector(3 downto 0);
		Rb : in std_logic_vector(3 downto 0);
		Rw : in std_logic_vector(3 downto 0);
		WE : in std_logic;
		COM_1 : in std_logic;
		COM_2 : in std_logic;
		CLK : in std_logic;
		OP : in std_logic_vector(1 downto 0);
		WrEn : in std_logic;
		Reset : in std_logic;
		Imm : in std_logic_vector(7 downto 0);
		flag : out std_logic_vector(31 downto 0)
		
	);
	
end partie_1;

architecture behavioural of partie_1 is

	signal busA : std_logic_vector(31 downto 0);
	signal busB : std_logic_vector(31 downto 0);
	signal busW : std_logic_vector(31 downto 0);
	signal busImm : std_logic_vector(31 downto 0);
	signal busLC : std_logic_vector(31 downto 0);
	signal AluOut : std_logic_vector(31 downto 0);
	signal DataOut : std_logic_vector(31 downto 0);

begin

		G1: entity work.BDR(behavioural) port map (W=>busW, A=>busA, B=>busB, CLK=>CLK, 
														RA=>RA, RB=>RB, WE=>WE, RW=>RW, Reset=>Reset);
		G2: entity work.multiplexeur(one) port map (A => busB, B => busImm, COM => COM_1, S => busLC);
		G3: entity work.ual_component(alu) port map (A => busA, B => busLC, OP => OP, flag => flag, S => AluOut);
		G4: entity work.extension(behavioural) port map (E => Imm, S => busImm);
		G5: entity work.mem(behavioural) port map (WrEn => WrEn, Addr => AluOut(5 downto 0),  DataOut => DataOut, DataIn => busB, CLK => CLK);
		G6: entity work.multiplexeur(one) port map (A => AluOut, B => DataOut, COM => COM_2, S => busW);

		--Test <= AluOut;

end architecture behavioural;











