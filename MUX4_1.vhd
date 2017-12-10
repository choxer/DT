library IEEE;
	use IEEE.std_logic_1164.all;
	
entity MUX4_1 is
	port (	in0, in1, in2, in3	: in std_logic;
				s1, s0					: in std_logic;
				out_mux					: out std_logic);
end MUX4_1;

architecture a_MUX4_1 of MUX4_1 is
	
	begin
	
		if(s1 = '0' and s0 = '0')
			out_mux <= in0;
		end if;
		
		if(s1 = '1' and s0 = '0')
			out_mux <= in1;
		end if;
		
		if(s1 = '0' and s0 = '1')
			out_mux <= in2;
		end if;
		
		if(s1 = '1' and s0 = '1')
			out_mux <= in3;
		end if;
		
	end a_MUX4_1;