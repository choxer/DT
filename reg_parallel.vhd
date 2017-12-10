library IEEE;
use ieee.std_logic_1164.all;

entity reg_parallel is
	generic( n	: integer := 5);
	
	port (	out_pl		:	out std_logic_vector(n-1 downto 0);
				in_pl			:  in  std_logic_vector(n-1 downto 0);		
				clk 			:  in  std_logic_vector(n-1 downto 0);
				
end reg_parallel;

architecture a_reg of reg is
	component d_ff is
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic
			);
	end component;
	
begin

		d_ffgen: for i in 0 to n-1 generate			
					g_d_ff : d_ff
			port map(	D		=> in_pl(i) ,
							Q		=> out_pl(i),
							CLK   => clk(i)  );
		end generate;
			
end a_reg;		
		