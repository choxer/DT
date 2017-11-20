
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




entity uebung02 is 
port(
		DATEN2		: in std_logic_vector(2 downto 0);
		SParity2		: in std_logic;
		SMUX2			: in std_logic;
		EN2			: in std_logic;
		AndIn			: in std_logic;
		PCheck2		: out std_logic;
		MuxOut		: out std_logic;
		andout		: out std_logic
);

end uebung02;

architecture a_U02 of uebung02 is
	
	
	
	COMPONENT parity 						--Parity generater
	port(	daten	: in std_logic_vector(2 downto 0);
			s		: in std_logic;		--- S (select) für even=1 oder odd=0 
			pout	: out std_logic_vector(3 downto 0)
	);
	END COMPONENT;
	
	
	COMPONENT parity2						--Parity checker
	PORT(	POut		 : in std_logic_vector(3 downto 0);
			EN			 : in std_logic;
			s	  		 : in std_logic;
			pcheck	 :	out std_logic
	);
	END COMPONENT;

	COMPONENT uebung01					--2:1 MUX
	PORT(	I0, I1		: IN bit;
			S				: IN bit;
			EN				: IN bit;
			O1, O2, O3	: OUT bit
	);
	END COMPONENT;
	
	COMPONENT and2
	port(	I0 : in std_logic;
			I1 : in std_logic;
			O1 : out std_logic
	);
	END COMPONENT;
	
	-- paritygenerator signale
	signal daten 		: std_logic_vector(2 downto 0);
	signal sparity0 	: std_logic;
	signal pout0		: std_logic_vector(3 downto 0);
	
	-- paritychecker signale
	signal sparity1 	: std_logic;
	signal pout1		: std_logic_vector(3 downto 0);
	signal EN0 			: std_logic;
	signal pcheck 		: std_logic;
	
	--mux signale
	signal EN1 			: bit;
	signal smuX 		: bit;
	signal I0 			: bit ;
	signal I1 			: bit ;
	signal O1 			: bit ;
	signal O2 			: bit ;
	signal O3 			: bit ;
	
	--and signale
	signal AI0 			: std_logic ;
	signal AI1 			: std_logic ;
	signal AO1 			: std_logic ;
	
	begin
	
	paritygenerator : parity
			PORT MAP (	daten =>		daten,
							s 		=> 	sparity0,
							pout  =>    pout0  	); 
	
	
	paritychecker 	: parity2
			PORT MAP (	Pout 	 =>	Pout1,
							EN 	 => 	EN0,
							s 		 => 	sparity1,
							pcheck => 	pcheck  );
	
	MUltiplexer 	: uebung01
			PORT MAP (	I0 	=>		I0,
							I1 	=> 	I1,
							s 		=> 	smux,
							EN 	=> 	EN1,  
							O1 	=> 	O1,
							O2 	=>		O2,
							O3 	=> 	O3		);
		
	UND_gatter 		: and2
			PORT MAP (	I0 	=>		AI0,
							I1 	=> 	AI1,
							O1 	=> 	AO1	);
						
	-----zuweisung für paritygenerator
	
	
	daten(2 downto 0) 	<= Daten2(2 downto 0);	-- daten in parity generator
	sparity0 				<= sparity2;
	
	-----zuweisung für and
	
	AI0 						<= andIn;
	AI1 						<=	pout0(1);
	
	-----zuweisung für Mux
	
	I0							<= pout0(0);
	I0							<= not pout0(0);
	smux						<= smuX2;
	en1						<= En2;
	
	-----zuweisung für paritychecker
									--   .3       .2	.1	  .0
	pout1(3 downto 0) 	<= pout0(3 downto 2) &AO1 &O1; -- And(AO1) bekommt pout0(1), MUX(O1) bekommt pout0(0);
	en0						<=	en2;
	sparity1 				<=	sparity2;
	
	-----zuweisung für entity uebung02
	PCheck2 					<= pcheck;
	MuxOut 					<= O1;
	Andout					<= Ao1;

	
end a_U02;




	