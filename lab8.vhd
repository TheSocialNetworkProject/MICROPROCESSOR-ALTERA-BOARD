library ieee;
use ieee.std_logic_1164.all;
 use IEEE.numeric_std.all;
 use ieee.std_logic_unsigned.all;
 use work.segment.all;
 
 entity lab8 is 
port(
      PC_out : out std_logic_vector(31 downto 0);
		branch_decision, jump_decision, reset, clk : in std_logic;
		instruction: out std_logic_vector (31 downto 0);
		branch_addr, jump_addr : in std_logic_vector(31 downto 0)
 );
end lab8;

architecture bhvr of lab8 is
 type mem_array is array(0 to 8) of std_logic_vector(31 downto 0);  
  
begin

 process(clk, reset)
  variable mem : mem_array := (

X"2001000a", --L: lw $2, 0($1) ; $2 <= mem[0+$1] 
X"20020014", -- lw $4, 1($3) ; $4 <= mem[1+$3] 
X"00411820", -- sub $4, $3, $2 ; $4 <= $3 - $2 
X"00000000", -- sw $4, 0($3) ; mem[0+$3] <=$4 
 x"00000000",
X"00000000", -- beq $1, $2, L ; if ($1=$2), branch_addr<=L 
X"00000000", -- and $4, $3, $1 ; $4 <= $3 and $4 
X"00000000", -- j L ; jump_addr <= L 
X"00000000"
  );
  variable PC : std_logic_vector(31 downto 0);
  variable index : integer := 0;
  
  begin 
      
         if(reset = '1') then
				  PC := x"00000000";
				  PC_out <= x"00000000";
				  instruction <= x"00000000";			
	
	elsif (clk'event and clk = '1') then
					if (branch_decision = '1') then 
					 PC := branch_addr; 
					elsif (jump_decision = '1') then 
					 PC := jump_addr;
					end if;
			
			 index := to_integer(unsigned(PC(3 downto 0))); 
          		
					PC := PC + x"1";

			 PC_out <= PC;
			 instruction <= mem(index);
		 
			end if;
   end process;
end bhvr;