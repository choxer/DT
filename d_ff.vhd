library IEEE;
	use IEEE.std_logic_1164.all;

entity d_ff is
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic
			);
end d_ff;

architecture a_d_ff of d_ff is

	begin
	process(CLK, D)
	begin
	if ( CLK'event and CLK = '1' )
		
		then	Q <= D;
		
	end if;
	end process;
	
end a_d_ff;

------------------------------------------
------------------------------------------
--TB
library IEEE;
	use IEEE.std_logic_1164.all;
	
entity tb_d_ff is
end tb_d_ff;

architecture a_tb_d_ff of tb_d_ff is

	component d_ff 
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic
			);	
	end component;
	
	signal D		:	std_logic := '0';
	signal CLK	:	std_logic := '0';
	signal Q		:	std_logic;
	
	begin
	DUT : d_ff
	port map	(	D 		=> D,
					CLK 	=> CLK,
					Q		=> Q
				);
	
	D 	 <= '1' after  50ns, '0' after 100ns, '1' after 150ns, '0' after 250ns, '1' after 300ns;
	CLK <= not CLK after  50ns;
	
end a_tb_d_ff;