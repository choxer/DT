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
port(	daten		: in  std_logic_vector(2 downto 0);
		s			: in  std_logic;	--- S (select) für even=1 oder odd=0 
		pout		: out std_logic_vector(3 downto 0)
);
end parity;

Architecture a_parity of parity is
	
	 	
	
	Begin
	
	--with s select---s=0 odd s=1 even
	--dataflow
	--pset <=(not S and not daten(2)and not daten(1)and not daten(0))or(not S and not daten(2)and daten(1)and daten(0))or(not S and daten(2)and not daten(1)and daten(0))or(not S and daten(2)and daten(1)and not daten(0))or
	--(S and daten(2)and daten(1)and daten(0))or(S and daten(2)and not daten(1)and not daten(0))or(S and not daten(2)and daten(1)and not daten(0))or(S and not daten(2)and not daten(1)and daten(0));
	
		process(daten(2 downto 0),s)
		
		variable pset	:  std_logic;
		variable i : integer;											 --counter: i = anzahl der 1en ; repräsentiert stelle der vektoren podd und peven!
		constant podd 	: std_logic_vector(0 to 3):="1010";		-- wenn ungerade parity: ungerade anzahl 1en -> paritybit = 0	
		constant peven : std_logic_vector(0 to 3):="0101";		-- wenn 	 gerade parity:   gerade anzahl 1en -> paritybit = 1 
			
			begin 
				
				i:=0;
				
				IF daten(0)='1' 
					THEN i:=i+1; 
				ELSE i:=i;
				END IF; 
				
				IF daten(1)='1' 
					THEN i:=i+1; 
				ELSE i:=i;
				END IF;
				
				IF daten(2)='1' 
					THEN i:=i+1; 
				ELSE i:=i;
				END IF;
				
				
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

--------------------Testbench--------------------------------------------------------------------------------------------------------------------------------------
library IEEE;
        use IEEE.std_logic_1164.all;

entity tb_parity is

end tb_parity;


ARCHITECTURE tb_aparity OF tb_parity IS
	
	COMPONENT parity 
	port(	daten	: in std_logic_vector(2 downto 0);
			s		: in std_logic;		--- S (select) für even=1 oder odd=0 
			pout	: out std_logic_vector(3 downto 0)
	);
	END COMPONENT;
		
	
	signal daten: std_logic_vector(2 downto 0):="000";
	signal s 	: std_logic:='0';
	signal pout : std_logic_vector(3 downto 0);
	
	signal B	 : std_logic;	
	signal BO : std_logic;
	signal maskt : std_logic;
		
		BEGIN
		
		
		
		DUT : parity
		PORT MAP (	daten =>		daten,
						s 		=> 	s,
						pout  =>    pout  );
						
						
		--daten(0) <= 	'0' after 0ns		,'1' after 50ns	,'0'after 100ns	,'1'after 150ns			,'0' after 200ns	,'1' after 250ns	,'0'after 300ns	,'1'after 350ns, 
			--			'0' after 400ns	,'1' after 450ns	,'0'after 500ns	,'1'after 550ns			,'0' after 600ns	,'1' after 650ns	,'0'after 700ns	,'1'after 750ns;
 
 
		--daten(1)	<=		'0' after 0ns		,'1' after 100ns	,'0'after 200ns	,'1'after 300ns			,'0' after 400ns	,'1' after 500ns	,'0'after 600ns	,'1'after 700ns;

		--daten(2)	<=		'0' after 0ns		,'1' after 200ns														   ,'0'after 400ns	,'1'after 600ns;

		--s		  	<=		'0' after 0ns																						,'1' after 400ns;			
 
		
		
		
		--daten(0)	<='0' after 0ns;
		daten(0) <= not daten(0) after 50ns;
		--daten(1)	<='0' after 0ns;
		daten(1) <= not Daten(1) 	after 100ns;
		
		--daten(2)	<='0' after 0ns;
		daten(2) <= not Daten(2) 	after 200ns;
		
		S			<= not S 			after 400ns;
		
---------Bewerteter Ausgang(Wahrheitstabelle)---------------------------------------------------------------------------------------------------------------------
	
--B <= 			'0' after 5ns		,'1' after 55ns	,'0'after 105ns	,'1'after 155ns,			'0' after 205ns	,'1' after 255ns	,'0'after 305ns	,'1'after 355ns, 
				--'0' after 405ns	,'1' after 455ns	,'0'after 505ns	,'1'after 555ns,			'0' after 605ns	,'1' after 655ns	,'0'after 705ns	,'1'after 755ns;



 
	--process(B)
	--constant mask	: std_logic_vector(0 to 15):="1001011001101001";
	--variable n : integer:=0;
		--begin
			--BO	<= ( pout(3) ) xor ( mask(n) );
			--n:=n+1;
	--end process;
 
--END tb_aparity;

---------Bewerteter Ausgang(Wahrheitstabelle) 2.0---------------------------------------------------------------------------------------------------------------------

		process(pout(3)'transaction)			-- pout(3) entspricht paritybit: restliche daten in testbench vorgegeben
		
			variable n : integer:=0;			-- counter für stelle der maske 
			constant mask : std_logic_vector(0 to 15):="1001011001101001";		-- ergibt sich aus wahrheitstabelle: 1. 8 stellen mit s=0 ( odd ) 2. 8 stellen mit s=1 ( even )
			
			begin
				IF ( ((pout(3) = '1') or (pout(3)='0')) THEN	--n<16
					BO 	<= pout(3) xor mask(n);
					maskt <= mask(n);
					n := n+1;			-- da pout(3) sich geändert hat, muss stelle in der maske iterriene
				ElsE
				END IF;	
					
		end process;  

END tb_aparity;

		
				

