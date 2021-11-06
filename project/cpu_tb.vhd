LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;


entity cpu_tb IS
END cpu_tb ;


architecture BENCH of cpu_tb is

signal CLK : std_logic;
signal Reset : std_logic;
	
begin

    clk_doing:process
    
    begin
    
		while now <= 10000 NS loop
		Clk <= '0';
		wait for 5 NS;
		Clk <= '1';
		wait for 5 NS;
		end loop;
		
		--report "End of test. Verify that no error was reported.";

	  wait;
	end process;
	
	sim:process
    
    begin
    wait for 5 ns;
    Reset <= '1';
    wait for 5 ns;
    Reset <= '0';

	  wait;
	end process;
	
	 

UUT : entity work.test
port map (  
			 Clk=> Clk,
			 Reset => Reset
				);
		
end BENCH;
