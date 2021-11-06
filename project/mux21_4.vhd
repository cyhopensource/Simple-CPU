LIBRARY ieee;
library work;
USE ieee.numeric_std.all;
USE ieee.std_logic_1164.all;

ENTITY mux21_4 IS

 PORT (A,B:in std_logic_vector(3 downto 0);
		COM :IN std_logic;
		S :OUT std_logic_vector(3 downto 0)
		);
		
END mux21_4;


ARCHITECTURE one OF mux21_4 IS

BEGIN
  
    process(A,B,COM)
    begin	
		CASE COM IS
			WHEN '0' => S<=A;
			WHEN '1' => S<=B;
			WHEN OTHERS => NULL;  -- You should take care of OTHERS.
			
		END CASE; 
      
    end process;  

END architecture one;