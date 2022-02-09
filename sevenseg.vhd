Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sevenseg is
 port(
    input1 :in std_logic_vector(3 downto 0);
	 output1 :out std_logic_vector(6 downto 0));
 
 end sevenseg;
 
architecture behavioral of sevenseg is
begin 
output1 <= "1000000" when (input1 = "0000") else  --0
			  "1111001" when (input1 = "0001") else  --1
			  "0100100" when (input1 = "0010") else  --2
			  "0110000" when (input1 = "0011") else  --3
 			  "0011001" when (input1 = "0100") else  --4
			  "0010010" when (input1 = "0101") else  --5
			  "0000010" when (input1 = "0110") else  --6
			  "1111000" when (input1 = "0111") else  --7
			  "0000000" when (input1 = "1000") else  --8
			  "0011000" when (input1 = "1001") else  --9 
			  "0001000" when (input1 = "1010") else  --A
			  "0000011" when (input1 = "1011") else  --B
			  "1000110" when (input1 = "1100") else  --C
			  "0100001" when (input1 = "1101") else  --D
			  "0000110" when (input1 = "1110") else  --E
			  "0001110" when (input1 = "1111") else  --F
			  "1111111";
end behavioral;