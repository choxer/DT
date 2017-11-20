

entity and2 is 
	
			port(	
			I0 : in std_logic;
			I1 : in std_logic;
			O1 : out std_logic
			);
		
end and2;		

architecture a_and2 of and2 is

	begin
		O1 <= I0 and I1;

end a_and2; 
