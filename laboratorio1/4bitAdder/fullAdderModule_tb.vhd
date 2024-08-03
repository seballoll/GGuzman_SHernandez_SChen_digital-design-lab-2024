LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY fullAdderModule_tb IS
END fullAdderModule_tb;
 
ARCHITECTURE behavior OF fullAdderModule_tb IS
 
 -- Component Declaration for the Unit Under Test (UUT)
 
 COMPONENT fullAdderModule
 PORT(
 A : IN std_logic;
 B : IN std_logic;
 Cin : IN std_logic;
 S : OUT std_logic;
 Cout : OUT std_logic
 );
 END COMPONENT;
 
 --Inputs
 signal A : std_logic := '0';
 signal B : std_logic := '0';
 signal Cin : std_logic := '0';
 
 --Outputs
 signal S : std_logic;
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
 A <= '1';
 B <= '0';
 Cin <= '0';
 wait for 10 ns;
 
 A <= '0';
 B <= '1';
 Cin <= '0';
 wait for 10 ns;
 
 A <= '1';
 B <= '1';
 Cin <= '0';
 wait for 10 ns;
 
 A <= '0';
 B <= '0';
 Cin <= '1';
 wait for 10 ns;
 
 A <= '1';
 B <= '0';
 Cin <= '1';
 wait for 10 ns;
 
 A <= '0';
 B <= '1';
 Cin <= '1';
 wait for 10 ns;
 
 A <= '1';
 B <= '1';
 Cin <= '1';
 wait for 10 ns;
 
 end process;
 
END;
