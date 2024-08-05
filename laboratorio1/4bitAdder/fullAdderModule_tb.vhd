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
S : OUT std_logic_vector(3 downto 0);
Cout : OUT std_logic
);

 END COMPONENT;
 
 --Inputs
 signal A : std_logic_vector(3 downto 0) := (others => '0');
signal B : std_logic_vector(3 downto 0) := (others => '0');
signal Cin : std_logic := '0';

 
 --Outputs
signal S : std_logic_vector(3 downto 0);
signal Cout : std_logic;
 
BEGIN
 
 -- Instantiate the Unit Under Test (UUT)
 uut: fullAdderModule PORT MAP (
 A => A,
 B => B,
 Cin => Cin,
 S => S,
 Cout => Cout
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
