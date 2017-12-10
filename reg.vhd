library IEEE;
use ieee.std_logic_1164.all;

entity reg is
	
	port (	out_pl		:	out std_logic_vector(4 downto 0);
				in_pl			:  in  std_logic_vector(4 downto 0);		
				clk0 			:  in  std_logic_vector(4 downto 0);
						
				s0 			: in std_logic;
				s1				: in std_logic;
				
				din_ser_r   :  in  std_logic;
				din_ser_l   :  in  std_logic;	
				
				dout_ser_r 	:  out std_logic;
				dout_ser_l 	:  out std_logic);

end reg;

architecture a_reg of reg is

	component d_ff is
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic
			);
	end component;
	
-----
	signal Ds 	: std_logic_vector(4 downto 0);
	signal Qs   : std_logic_vector(4 downto 0);
-----	
begin	
	--
	Gen : for i in 0 to 4 generate 
		dFF : d_ff
		port map(	D   => Ds(i),
						Q 	 => Qs(i),
						CLK => clk0(i));
	end generate;
	--
	
	process(s0, s1)
	begin
		-- disable
		if(s0 = '0' and s1 = '0') then
			
		end if;
		-- ser. rechts schieben
		if(s0 = '0' and s1 = '1') then
			Ds(4) <= din_ser_r;
			Ds(3) <= Qs(4);
			Ds(2) <= Qs(3);
			Ds(1) <= Qs(2);	
			Ds(0) <= Qs(1);
			
			dout_ser_r <= Qs(0);
		end if;
		-- ser. links schieben
		if(s0 = '1' and s1 = '0') then
			Ds(4) <= Qs(3);
			Ds(3) <= Qs(2);
			Ds(2) <= Qs(1);
			Ds(1) <= Qs(0);	
			Ds(0) <= din_ser_l;	
			
			dout_ser_l <= Qs(4);
		end if;
		-- par. laden 
		if(s0 = '1' and s1 = '1') then
			Ds(4) <= in_pl(4);
			Ds(3) <= in_pl(3);
			Ds(2) <= in_pl(2);
			Ds(1) <= in_pl(1);	
			Ds(0) <= in_pl(0);
			
			out_pl(4) <= Qs(4);
			out_pl(3) <= Qs(3);
			out_pl(2) <= Qs(2);
			out_pl(1) <= Qs(1);
			out_pl(0) <= Qs(0);
		end if;
		
	end process;


end a_reg;		
		