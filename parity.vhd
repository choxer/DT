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


entity parity is
port(	daten		: in std_logic_vector(2 to 0);
		s			: in std_logic;	--- S (select) für even=1 oder odd=0 
		pout		: out bit_vector(3 to 0)	);
end parity;

Architecture a_parity of parity is
	
	Begin
		process(daten(2 downto 0),s)
		
		variable pset	:  std_logic;
		variable i : integer;											 --counter: i = anzahl der 1en ; repräsentiert stelle der vektoren podd und peven!
		constant podd 	: std_logic_vector(0 to 3):="1010";		-- wenn ungerade parity: ungerade anzahl 1en -> paritybit = 0	
		constant peven : std_logic_vector(0 to 3):="0101";		-- wenn 	 gerade parity:   gerade anzahl 1en -> paritybit = 1 
			
			begin 
				
				i:=0;
				
				IF daten(0)='1' THEN i:=i+1; END IF; 
				IF daten(1)='1' THEN i:=i+1; END IF;
				IF daten(2)='1' THEN i:=i+1; END IF;
				
				IF S='0' 
					THEN pset := podd(i); 	
				
				ELSE
					
					IF S='1' 
						THEN pset := peven(i);	
					ELSE 
						pset := '0'; -- WICHTIG: 0 soll keine inhaltliche Aussage sein!! -> Z ? 
					END IF;
				
				END IF; 
														  
	
				pout(3 downto 0) <= pset & daten(2 downto 0); ---daten und pset zu ausgang bus zusammengefügt
																			 -- pset stelle 3 ; daten_vec stelle 2-0
																			 -- wenn pout(0 to 3): - pset: 0 ; daten(2): 1; daten(1): 2 ; daten(0): 3
		end process;
end a_parity;

