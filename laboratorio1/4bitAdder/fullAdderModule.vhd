library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity fullAdderModule is
 Port ( 
	A : in STD_LOGIC_VECTOR (3 downto 0);
	B : in STD_LOGIC_VECTOR (3 downto 0);
	Cin : in STD_LOGIC;
	S : out STD_LOGIC_VECTOR (3 downto 0);
	Cout : out STD_LOGIC);
end fullAdderModule;
 
architecture fullAdderModuleFourBits of fullAdderModule is

  component fullAdderModuleOneBit
      port (
        A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        S: out std_logic;
        Cout: out std_logic
      );
    end component;

    signal i_carry: std_logic_vector(2 downto 0);
	 
  begin
    cell_1: fullAdderModuleOneBit
      port map (A(0), B(0), Cin, S(0), i_carry(0));

    cell_2: fullAdderModuleOneBit
      port map (A(1), B(1), i_carry(0), S(1), i_carry(1));

    cell_3: fullAdderModuleOneBit
      port map (A(2), B(2), i_carry(1), S(2), i_carry(2));

    cell_4: fullAdderModuleOneBit
      port map (A(3), B(3), i_carry(2), S(3), Cout);

 
end fullAdderModuleFourBits;
