LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY fullAdderModule_tb IS
END fullAdderModule_tb;
 
ARCHITECTURE behavior OF fullAdderModule_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 
 COMPONENT fullAdderModule
 PORT(
 A : IN std_logic_vector(3 downto 0);
 B : IN std_logic_vector(3 downto 0);
 Cin : IN std_logic;
 S : BUFFER std_logic_vector(3 downto 0);
 Cout : BUFFER std_logic;
 seg1: out STD_LOGIC_VECTOR (6 downto 0);
 seg2: out STD_LOGIC_VECTOR (6 downto 0);
 dp1: out STD_LOGIC;
 dp2: out STD_LOGIC

 );

 END COMPONENT;
 
 --Inputs
 signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal Cin : std_logic := '0';

 
 --Outputs
signal S : std_logic_vector(3 downto 0);
signal Cout : std_logic;
signal seg1 : std_logic_vector(6 downto 0);
signal seg2 : std_logic_vector(6 downto 0);
signal dp1: STD_LOGIC;
signal dp2: STD_LOGIC;

 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
 uut: fullAdderModule PORT MAP (
 A => A,
 B => B,
 Cin => Cin,
 S => S,
 Cout => Cout,
 seg1 => seg1,
 seg2 => seg2,
 dp1 => dp1,
 dp2 => dp2

 );
 
 
 -- Stimulus process
 stim_proc: process
 begin
 -- hold reset state for 100 ns.
 wait for 100 ns;
 
 -- insert stimulus here
 A <= "0110";
 B <= "1100";
 
 wait for 10 ns;
 
 A <= "1111";
 B <= "1100";
 
 wait for 10 ns;
 
 A <= "0110";
 B <= "0111";
 wait for 10 ns;
 
 A <= "0110";
 B <= "1100";
 wait for 10 ns;
 
  A <= "1111";
 B <= "1111";
 wait for 10 ns;

 A <= "0000";
 B <= "0000";
 wait;
 end process;
 
END;
