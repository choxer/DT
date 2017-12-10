library IEEE;
use ieee.std_logic_1164.all;

entity reg_seriell is
	generic( n	: integer := 5);
	
	port (	din_ser_r   :  in  std_logic;
				din_ser_l   :  in  std_logic;	
				
				dout_ser_r 	:  out std_logic;
				dout_ser_l 	:  out std_logic;
				clk 			:  in  std_logic_vector(n-1 downto 0)); 
	
end reg_seriell;

architecture a_reg_seriell of reg_seriell is
	component d_ff is
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic
			);
	end component;
	
begin

	process(clk)
		
	end process;	

end a_reg_seriell;		
		

