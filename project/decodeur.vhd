library ieee;
library work;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

-- decodeur IP kernel.
-- copyright from cyh & lby  **** 2020.6 cpu-arm7_tdmi ****

entity decodeur is

	port(
	
		Instruction_in : in std_logic_vector(31 downto 0);
		PSR_in : in std_logic_vector(31 downto 0);
		
		nPCsel : out std_logic;
		RegWr : out std_logic;
		ALUSrc : out std_logic;
		ALUCtr : out std_logic_vector(1 downto 0);
		PSREn : out std_logic;
		MemWr : out std_logic;
		WrSrc : out std_logic;
		RegSel : out std_logic;
		Rn : out std_logic_vector(3 downto 0);
		Rd : out std_logic_vector(3 downto 0);
		Imm : out std_logic_vector(7 downto 0);
		Rm : out std_logic_vector(3 downto 0);
		OffSet : out std_logic_vector(23 downto 0)

	);

end entity decodeur;

architecture behavioural of decodeur is

type enum_instruction is (MOV, ADDi, ADDiGT, ADDr, CMPi, CMPr, LDR, STR, STRGT, BAL, BLT, BNE, SUB, SUBGT, SUBLT, WRONG);

signal instr_courante : enum_instruction;
--variable commandes : std_logic_vector(8 downto 0);

begin
			
	d1:process(Instruction_in)
			
		begin
		
			case Instruction_in(31 downto 20) is   -- imm_bit + op_code_bits.

				when "111000101000" => instr_courante <= ADDi;   -- ADDi
								   Rn <= Instruction_in(19 downto 16);
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);
								   
				when "110000101000" => instr_courante <= ADDiGT;   -- ADDiGT
								   Rn <= Instruction_in(19 downto 16);
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);
									
				when "111000001000" => instr_courante <= ADDr;   -- ADDr
							                 Rn <= Instruction_in(19 downto 16);
										     Rd <= Instruction_in(15 downto 12);
							                 Rm <= Instruction_in(3 downto 0);
							                 
				when "111000000000" => instr_courante <= SUB;   -- SUB       -- opcode: 0000 designed by cyh.
							                 Rn <= Instruction_in(19 downto 16);
										     Rd <= Instruction_in(15 downto 12);
							                 Rm <= Instruction_in(3 downto 0);
							                 
				when "110000000000" => instr_courante <= SUB;   -- SUBGT       -- opcode: 0000 designed by cyh.
							                 Rn <= Instruction_in(19 downto 16);
										     Rd <= Instruction_in(15 downto 12);
							                 Rm <= Instruction_in(3 downto 0);
							                 
				when "101100000000" => instr_courante <= SUB;   -- SUBLT       -- opcode: 0000 designed by cyh.
							                 Rn <= Instruction_in(19 downto 16);
										     Rd <= Instruction_in(15 downto 12);
							                 Rm <= Instruction_in(3 downto 0);
			
				when "111000110101" => instr_courante <= CMPi;   -- CMPi
                                   Rn <= Instruction_in(19 downto 16);
                                   Imm <= Instruction_in(7 downto 0);
                                   
				when "111000010101" => instr_courante <= CMPr;   -- CMPr         ************** CMPr ************  
                                   Rn <= Instruction_in(19 downto 16);
                                   Rm <= Instruction_in(3 downto 0);			

				when "111000111010" => instr_courante <= MOV;   -- MOV
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);	
								   
				when "111001100000" => instr_courante <= STR;   -- STR
				                   Rn <= Instruction_in(19 downto 16);
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);
								   
				when "110001100000" => instr_courante <= STRGT;   -- STRGT
				                   Rn <= Instruction_in(19 downto 16);
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);
				
				when "111001100001" => instr_courante <= LDR;   -- LDR
								   Rn <= Instruction_in(19 downto 16);
								   Rd <= Instruction_in(15 downto 12);
								   Imm <= Instruction_in(7 downto 0);
													   
			
				when "111010101111" => instr_courante <= BAL;   -- BAL
								   OffSet(23 downto 0) <= Instruction_in(23 downto 0);
				
				when "101110101111" => instr_courante <= BLT;   -- BLT
				                   OffSet(23 downto 0) <= Instruction_in(23 downto 0);
				                   
				when "000110101111" => instr_courante <= BNE;   -- BNE
				                   OffSet(23 downto 0) <= Instruction_in(23 downto 0);
				
				when others => instr_courante <= WRONG;     -- WRONG
				
			end case;
		
	end process;
	
	d2:process(instr_courante)
			variable commandes : std_logic_vector(8 downto 0);    -- using variable.
		begin
			
			case instr_courante is   -- imm_bit + op_code_bits.
			
			    when SUB => commandes := "01110000-";   -- SUB
			    
			    when SUBGT => 
							if (PSR_in(31) = '0') then
								commandes := "01110000-";    -- just like the STR.
							elsif(PSR_in(31) = '1') then
								commandes := "00---00--";    -- do nothing.
								
							end if;
							
				when SUBLT => 
							if (PSR_in(31) = '1') then
								commandes := "01110000-";    -- just like the STR.
							elsif(PSR_in(31) = '0') then
								commandes := "00---00--";    -- do nothing.
								
							end if;
			    
				when ADDi => commandes := "01100000-";	-- ADDi 
				
				when ADDiGT => 
							if (PSR_in(31) = '0') then
								commandes := "01100000-";    -- just like the STR.
							elsif(PSR_in(31) = '1') then
								commandes := "00---00--";    -- do nothing.
								
							end if;
							       
				when ADDr => commandes := "010000000";   -- ADDr
				             
				when BAL => commandes := "10---00--";    -- BAL
				when BLT => 
				      if (PSR_in(31) = '1') then
								commandes := "10---00--";    -- BLT
							elsif(PSR_in(31) = '0') then
								commandes := "00---00--";    -- do nothing.
								
							end if;
							
				when BNE => 
				      if (PSR_in(30) = '1') then
								commandes := "00---00--";    -- do nothing
					  else 
								commandes := "10---00--";    -- B 
								
					  end if;
								
				when CMPi => commandes := "00110100-";   -- CMPi    -- CMP
				when CMPr => commandes := "000101000";   -- CMPr
				
				when LDR => commandes := "01100001-";   -- LDR
				when MOV => commandes := "01101000-";   -- MOV
				when STR => commandes := "0010001-1";   -- STR
				when STRGT =>                           -- STRGT
							if (PSR_in(31) = '0') then
								commandes := "0010001-1";    -- just like the STR.
							elsif(PSR_in(31) = '1') then
								commandes := "00---00--";    -- do nothing.
								
							end if;
							
				when others => commandes := "ZZZZZZZZZ";
				
			end case;
			
		  nPCSel <= commandes(8);
	      RegWr <= commandes(7);
	      ALUSrc <= commandes(6);
	      ALUCtr <= commandes(5 downto 4);
	      PSREn <= commandes(3);
	      MemWr <= commandes(2);
	      WrSrc <= commandes(1);
	      RegSel <= commandes(0);
		
	end process;

			
end architecture behavioural;




