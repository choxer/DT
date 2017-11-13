--übung aufgabe 2 optional
--



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


entity parity2 is
port(	pout 		 : in bit_vector,
		EN			 : in std_logic,
		s	  		 : in std_logic,
		pcheck:	out std_logic
);
end parity2;

architecture apcheck of pcheck is
---------------with s select
				
------------	pset <=  (not x2 and not x1 and not x0) 	or (not x2 and x1 and x0) 		or (x2 and not x1 and x0) 		or 	(x2 and x1 and not x0) 	    when	'0',
------------				(x2 and x1 and x0) 					or (x2 and not x1 and not x0) or (not x2 and x1 and not x0) or 	(not x2 and not x1 and  x0) when	'1';
------------aus parity1 pset = pout(3)
begin 

	process
	variable n : integer;
	variable z : integer;
	variable check : integer;
	constant mask : bit_vector;:=""
	begin
	n:=0;
	z:=0;
	
					----Anzahl der 1sen-----
					if pout(3):='1' 	THEN n:=n+1; 	end if;
					if pout(2):='1'	THEN n:=n+1; 	end if;
					if pout(1):='1'	THEN n:=n+1; 	end if;
					if pout(0):='1'	THEN n:=n+1; 	end if;	
					
					
					-------für odd(s=0) even(s=1) parity bit erstellt ---------
					with s select
					
					(	if n:=0  THEN check:='1', 		
						if n:=1  THEN check:='0',
						if n:=2  THEN check:='1',
						if n:=3  THEN check:='0'	);when s='0'; 
					
					
					(	if n:=0  THEN check:='0', 		
						if n:=1  THEN check:='1',
						if n:=2  THEN check:='0',
						if n:=3  THEN check:='1'	);when s='1';
					
					
					-------parity bit mit pout vergleichen und auf pcheck setzen '1' bedeutet fehler --------- 
					
		 
	
					pcheck <= pout(3) xor check	,after 70ns; 
						wait on pcheck;
						z:=z+1;	
	
end apcheck;


--------------------------------Testbench------------------------------------------------------------------------------------------


constant mask : bit_vector;:="1001011001100001";-----für bewerteten ausgang--negiren für pcheckeven
