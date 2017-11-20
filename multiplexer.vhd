library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library STD;
use STD.textio;
----------------------------------------

entity multiplexer is
	port (	I0 : in bit; 
				I1 : in bit;
				S	: in bit;
				EN : in bit;
				O1 : out bit;
				O2 : out bit;
				O3 : out bit
			);
end multiplexer;

architecture mux of multiplexer is

begin
		O1 <= (not EN AND I0 AND NOT S) OR 
				(not EN AND I1 AND S);
------------
		with s select
		O2 <= (not EN and I0)	when '0',
				(not EN and I1)	when '1';
------------
		O3 <= (not EN and I0) 	when S='0'
				else (not EN and I1);	
end mux;

-----------------------------------------
----------------TESTBENCH----------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library STD;
use STD.textio;

entity tb_multiplexer is 
end tb_multiplexer;

architecture tb of tb_multiplexer is
	component multiplexer
	port (	I0 : in bit; 
				I1 : in bit;
				S	: in bit;
				EN : in bit;
				O1 : out bit;
				O2 : out bit;
				O3 : out bit
			); 	
	end component;
	
	--signale deklarieren:
	signal I0	: bit := '0';
	signal I1	: bit := '0';
	signal  S	: bit := '0';
	signal EN	: bit := '0';

	signal O1 	: bit ;
	signal O2 	: bit ;
	signal O3 	: bit ;

	signal MA   : bit ;
	signal B1	: bit ;
	signal B2 	: bit ;
	signal B3 	: bit ;
	
	begin DUT : multiplexer
	-- signale 'verknüpfen':
			port map (	I0 => I0,
							I1 => I1,
							 S =>  S,
							EN => EN,
							O1 => O1,
							O2 => O2,
							O3 => O3 
						);
	--simulationsverhalten beschreiben:
	--eingänge wurden mit '0' 'initialisiert'
	--doppelte Frequenz(?)
	
	I0 <= not I0 after  70ns; 	
	I1 <= not I1 after 140ns;
	 S <= not  S after 280ns;
	EN <= not EN after 560ns;
	
	--prozess der Maske aus Wahrheitstabelle und 
	--die 3 B-Ausgänge auf antivalenz prüft:
	
	process
		--Iterationsvariable:
		variable    i : integer := 0;	
		--Maske:
		constant mask : bit_vector(0 to 15) := "0101001100000000"; 
	
			begin 
			wait on O1'transaction; 		-- wartet auf Neuzuweisung für Output 0 / (event prüft nur auf änderung)
			
			MA	<= mask(i);
			B1 <= O1 xor mask(i);
			B2 <= O2 xor mask(i);
			B3 <= O3 xor mask(i);
			 i := i+1;
			 
	end process;
end tb;
			
			