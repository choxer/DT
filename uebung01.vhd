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

ENTITY uebung01 IS
PORT(	I0, I1		: IN bit;
		S				: IN bit;
		EN				: IN bit;	--low active en
		O1				: OUT bit;
		O2				: OUT bit;
		O3				: OUT bit	);
END uebung01;

ARCHITECTURE MUX OF uebung01 IS

BEGIN
	O1 <=		(not EN AND I0 AND NOT S) OR 
				(not EN AND I1 AND S);
	
	WITH S SELECT 
   O2 <= 	(not EN AND not I0)   WHEN '0',---std_logic datentyp führt zu fehler, da nicht alle zustände beschrieben sind 
				(not EN AND I1)	WHEN '1';
				
		
	O3 <= 	(not EN AND I0) WHEN S='0' ELSE  
				(not EN AND I1);
	
END MUX;

------------>>>> TESTBENCH <<<<<----------------------------------------------------
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

ENTITY tb_2_1MUX IS 

END tb_2_1MUX;

ARCHITECTURE tb OF tb_2_1MUX IS
		COMPONENT uebung01
		PORT(	I0, I1		: IN bit;
				S				: IN bit;
				EN				: IN bit;
				O1, O2, O3	: OUT bit	);
		END COMPONENT;
		
		SIGNAL I0	: bit :='0';
		SIGNAL I1	: bit :='0';
		SIGNAL  S	: bit :='0';
		SIGNAL EN	: bit :='0';----alle eingänge sollen bei 0 anfnagen		
		
		SIGNAL O1	: bit ;
		SIGNAL O2	: bit ;
		SIGNAl O3	: bit ;
		
		--SIGNAL B		: bit ;	--bewertete Ausgänge
		SIGNAL B1	: bit ;	--maske
		SIGNAL B2	: bit ;	--
		SIGNAl B3	: bit ;	--

BEGIN
		
		DUT : uebung01
			PORT MAP (	I0 => I0,
							I1 => I1,
							S  =>  S,
							EN => EN,
							O1 => O1,
							O2 => O2,
							O3 => O3 );
											
				--I0 <= '0' AFTER   0ns, '1' AFTER  70ns,  '0' AFTER 140ns, '1' AFTER 210ns,		 '0' AFTER 280ns, '1' AFTER 350ns, '0' AFTER 420ns, '1' AFTER  490ns,
						--'0' AFTER 560ns, '1' AFTER  630ns, '0' AFTER 700ns, '1' AFTER 770ns,		 '0' AFTER 840ns, '1' AFTER 910ns, '0' AFTER 980ns, '1' AFTER 1050ns;

				--I1 <= '0' AFTER 	0ns, '1' AFTER  140ns, '0' AFTER 280ns, '1' AFTER 420ns, 	 '0' AFTER 560ns, '1' AFTER 700ns, '0' AFTER 840ns, '1' AFTER  980ns;    

				--S  <= '0' After 	0ns, '1' After 280ns,  '0' After 560ns,	'1' AFTER 840ns;

				--EN <= '0' AFTER 	0ns, '1' AFTER 560ns;
	
				
				I0 <= not I0  	AFTER   70ns;
				
				I1 <= not I1  	AFTER   140ns;
				
				S 	<= not S  	AFTER   280ns;
				
				EN <= not EN  	AFTER   560ns;
								
				--I0 <= '0' AFTER   70ns, '1' AFTER  140ns,  '0' AFTER 210ns, '1' AFTER 280ns,		 '0' AFTER 350ns, '1' AFTER 420ns, '0' AFTER 490ns, '1' AFTER  560ns,
						--'0' AFTER 630ns, '1' AFTER  700ns, '0' AFTER 770ns, '1' AFTER 840ns,		 '0' AFTER 910ns, '1' AFTER 980ns, '0' AFTER 1050ns, '1' AFTER 1120ns;

		      --I1 <= '0' AFTER 	70ns, '1' AFTER  210ns, '0' AFTER 350ns, '1' AFTER 490ns, 	 '0' AFTER 630ns, '1' AFTER 770ns, '0' AFTER 910ns, '1' AFTER  1050ns;    

				--S  <= '0' After 	70ns, '1' After 350ns,  '0' After 630ns,	'1' AFTER 910ns;

				--EN <= '0' AFTER 	70ns, '1' AFTER 630ns;
	

------------------------------------------------bewertete Ausgänge(Wahrheitstabelle)-----------------------------------------------------------------------------------------------	
	
	--B 	<= '0' AFTER   0ns, '1' AFTER  75ns,  '0' AFTER 145ns, '1' AFTER 215ns,		 '0' AFTER 285ns, '1' AFTER 355ns, '0' AFTER 425ns, '1' AFTER  495ns,
	--'0' AFTER 565ns, '1' AFTER  635ns, '0' AFTER 705ns, '1' AFTER 775ns,		 '0' AFTER 845ns, '1' AFTER 915ns, '0' AFTER 985ns, '1' AFTER 1055ns;
	
	
	--process
	--variable n :	integer:=0;
		
		--begin
			
			--process(B)
			--constant mask1	: bit_vector(0 to 15):="0101001100000000";	--s=0=> z=x0 || s=1=> z=x1--
				
				--begin	
					--B1 <=	O1 xor mask1(n);			
					
			--end process;
	
			--process(B)
			--variable n2 :	integer:=0;
			--constant mask2	: bit_vector(0 to 15):="0101001100000000";
				
				--begin
					--B2	<=	O2 xor mask2(n);	
						 
			--end process;		
	
			--process(B)
			--variable n3 :	integer:=0;
			--constant mask3	: bit_vector(0 to 15):="0101001100000000";					
				
				--begin 
					--B3 <=	O3 xor mask3(n);	
						 
			--end process;
		
		--n:=n+1;	 
		--end process;

		
--END tb;

------------------------------------------------bewertete Ausgänge(Automatisch)
	
	--B 	<= '0' AFTER   0ns, '1' AFTER  75ns,  '0' AFTER 145ns, '1' AFTER 215ns,		 '0' AFTER 285ns, '1' AFTER 355ns, '0' AFTER 425ns, '1' AFTER  495ns,
		--	'0' AFTER 565ns, '1' AFTER  635ns, '0' AFTER 705ns, '1' AFTER 775ns,		 '0' AFTER 845ns, '1' AFTER 915ns, '0' AFTER 985ns, '1' AFTER 1055ns;

	
	
	
	--process(B)
		--begin
			--B1 <= ((not EN AND I0 AND NOT S)OR(not EN AND I1 AND S))and not O1;
			--B2 <= ((not EN AND I0 AND NOT S)OR(not EN AND I1 AND S))and not O2;
			--B3 <= not ( ((not EN AND I0 AND NOT S)OR(not EN AND I1 AND S))and not O3 );		--falsch um zu testen
	--end process;

	
------------------------------------------------bewertete Ausgänge(Wahrheitstabelle) 2.0 	

	--B 	<= '0' AFTER   0ns, '1' AFTER   5ns,  '0' AFTER  75ns, '1' AFTER 145ns, '0' AFTER 215ns, '1' AFTER 285ns, '0' AFTER 355ns, '1' AFTER 425ns, '0' AFTER  495ns,
			--'1' AFTER 565ns, '0' AFTER  635ns, '1' AFTER 705ns, '0' AFTER 775ns,	'1' AFTER 845ns, '0' AFTER 915ns, '1' AFTER 985ns, '0' AFTER 1055ns;
	
		process
			
			variable n : integer:=0;		-- counter für stelle der maske 
			constant mask: bit_vector(0 to 15):="0101001100000000";	-- maske: Wertetabelle der Ausgäng(e) 
			
				begin
				wait on O1'transaction;		-- transaction -> neuzuweisung //// event -> änderung 
				
				b1<= mask(n);					-- maske an stelle 'n'  -> soll mit nächster Stelle der Wertetabelle vergleichen!	
				b2<= O2 xor mask(n);			-- bewerteter ausgang 02  -- auf antivalenz prüfen!! 
				b3<= O3 xor mask(n);			-- bewerteter ausgang 03 
				n:=n+1;
				
		end process;
END tb;