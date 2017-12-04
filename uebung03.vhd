library IEEE;
        use IEEE.std_logic_1164.all;
        use IEEE.std_logic_textio.all;
        use IEEE.std_logic_arith.all;
        use IEEE.numeric_bit.all;
        use IEEE.numeric_std.all;
        use IEEE.std_logic_signed.all;
        use IEEE.std_logic_unsigned.all;
        use IEEE.math_real.all;
        use IEEE.math_complex.all;

        library STD;
        use STD.textio;

entity uebung03 is
port( D,EN	: in 	std_logic;
		Q		: out std_logic	);
		
end uebung03;

architecture a_uebung03 of uebung03 is

	begin
	
	process(D,EN)
	  begin
		
		IF(EN = '0') 	THEN Q <= 	D;	 
		
		END IF;
	
	end Process;
end a_uebung03;
-----------------------------------------------------------------TESTBENCH-------------------------------------------------------
library IEEE;
        use IEEE.std_logic_1164.all;
        use IEEE.std_logic_textio.all;
        use IEEE.std_logic_arith.all;
        use IEEE.numeric_bit.all;
        use IEEE.numeric_std.all;
        use IEEE.std_logic_signed.all;
        use IEEE.std_logic_unsigned.all;
        use IEEE.math_real.all;
        use IEEE.math_complex.all;

        library STD;
        use STD.textio;

entity tb_uebung03 is

end tb_uebung03;

architecture a_tb_uebung03 of tb_uebung03 is

COMPONENT uebung03
port (D,EN	: in 	std_logic;
		Q		: out std_logic	);
END COMPONENT;

signal D		: std_logic:='0';
signal EN	: std_logic:='0'; --low active
signal Q		: std_logic;
	
	begin
	
	DUT	: uebung03
	port map( D => D,
				 EN => EN,
				 Q => Q	);
	
	
		
		D 	<= '1' after  50ns, '0' after 100ns, '1' after 150ns, '0' after 250ns, '1' after 300ns;
		EN <=	'1' after  200ns;
		
	
end a_tb_uebung03;