library IEEE;
	use IEEE.std_logic_1164.all;

	
	entity schiebe is
	port(p0,p1,p2,p3,p4	: in std_logic;		--paralle daten
		  rd,ld				: in std_logic;		--serielle dasten, rd schiebt von rechts, ld schiebt von links
		  s0,s1				: in std_logic;		--steuereingänge	
		  clk_schiebe		: in std_logic;		--clock
		  ro,lo				: out std_logic;		--serielle ausgänge
		  o0,o1,o2,o3,o4	: out std_logic	);	--paralle ausgänge
	end schiebe;
	
	architecture a_schiebe of schiebe is
	
	component d_ff 
	port(		D	: in std_logic;
				CLK: in std_logic;
				Q	: out std_logic	);	
	end component;
	
	
	signal D0		: std_logic;
	signal clk0		: std_logic;
	signal Q0		: std_logic;
	
	signal D1		: std_logic;
	signal clk1		: std_logic;
	signal Q1		: std_logic;
	
	signal D2		: std_logic;
	signal clk2		: std_logic;
	signal Q2		: std_logic;
	
	signal D3		: std_logic;
	signal clk3		: std_logic;
	signal Q3		: std_logic;
	
	signal D4		: std_logic;
	signal clk4		: std_logic;
	signal Q4		: std_logic;
		
		begin
		
		ff0 : d_ff
		port map	(	D 		=> D0,
						CLK 	=> CLK0,
						Q		=> Q0		);
						
		
		ff1 : d_ff
		port map	(	D 		=> D1,
						CLK 	=> CLK1,
						Q		=> Q1		);
		
		ff2 : d_ff
		port map	(	D 		=> D2,
						CLK 	=> CLK2,
						Q		=> Q2		);
		
		ff3 : d_ff
		port map	(	D 		=> D3,
						CLK 	=> CLK3,
						Q		=> Q3		);
		
		ff4 : d_ff
		port map	(	D 		=> D4,
						CLK 	=> CLK4,
						Q		=> Q4		);
		
		
		clk0	<= clk_schiebe;
		clk1	<= clk_schiebe;
		clk2	<= clk_schiebe;
		clk3	<= clk_schiebe;
		clk4	<= clk_schiebe;
		
		
		process(clk_schiebe)	--d0,d1,d2,d3,d4,rd,ld,s0,s1
		
			begin
				
				if(s0='0' and s1='0') then		--not enabled
				
				end if;
				
				if(s0='1' and s1='0') then		--seriell laden links
						
						lo	<=	Q0;
						D0	<=	Q1;
						D1	<=	Q2;
						D2	<=	Q3;
						D3	<=	Q4;
						D4	<=	rd;
						
				end if;
				
				if(s0='0' and s1='1') then		--seriell laden rechts
						
						ro	<=	Q4;
						D4	<=	Q3;
						D3	<=	Q2;
						D2	<=	Q1;
						D1	<=	Q0;
						D0	<=	ld;
					
				end if;
		
				if(s0='1' and s1='1') then		--parall laden 
						
						o0	<=	p0;
						o1	<=	p1;
						o2	<=	p2;
						o3	<=	p3;
						o4	<=	p4;
					
				end if;
		end process;
		
	end a_schiebe;
	
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-------TESTBENCH
library IEEE;
	use IEEE.std_logic_1164.all;


entity tb_schiebe is
end tb_schiebe;

architecture a_tb_schiebe of tb_schiebe is 
	
	component	schiebe
	port(p0,p1,p2,p3,p4	: in std_logic;		--paralle daten
		  rd,ld				: in std_logic;		--serielle dasten, rd schiebt von rechts, ld schiebt von links
		  s0,s1				: in std_logic;		--steuereingänge	
		  clk_schiebe		: in std_logic;		--clock
		  ro,lo				: out std_logic;		--serielle ausgänge
		  o0,o1,o2,o3,o4	: out std_logic	);	--paralle ausgänge
	end component;
	
	signal p0,p1,p2,p3,p4	:  std_logic:='1';
	signal rd,ld				:  std_logic:='1';
	signal s0,s1				: 	std_logic:='0';
	signal clk_schiebe		: 	std_logic:='0';
	
	signal ro,lo				:  std_logic; 
	signal o0,o1,o2,o3,o4	:  std_logic;
		
		begin
		
		dut : schiebe
		port map ( p0 				=>		p0,
					  p1				=>		p1,
					  p2				=>		p2,
					  p3				=>		p3,
					  p4				=>		p4,
					  rd				=>		rd,
					  ld				=>		ld,
					  s0				=>		s0,
					  s1				=>		s1,
					  clk_schiebe	=>		clk_schiebe,
					  ro				=>		ro,
					  lo				=>		lo,
					  o0				=>		o0,
					  o1				=>		o1,
					  o2				=>		o2,
					  o3				=>		o3,
					  o4				=>		o4				);
					  
			clk_schiebe <= not clk_schiebe after 	50ns;
			s0				<= not s0 after  200ns;
			s1				<= not s1 after  400ns;
			rd				<= not rd after  800ns;
			ld 			<= not ld after 1600ns;
				  
	end a_tb_schiebe;