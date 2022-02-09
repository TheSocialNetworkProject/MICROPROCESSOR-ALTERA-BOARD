library ieee;                            --i
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity memory is
Port ( 
	address : in std_logic_vector (31 downto 0);
	reset,clk: in std_logic;
	write_data : in std_logic_vector (31 downto 0);
	MemWrite, MemRead : in std_logic;
	read_data : out std_logic_vector (31 downto 0));
	
end memory;

architecture bhv of memory is
type mem_array is array(0 to 7) of std_logic_vector(31 downto 0);
begin
ReadWrite1: process(clk,address, write_data)
variable data_mem : mem_array := (      --ii
	X"00000000",
	X"11111111",
	X"22222222",
	X"33333333",
	X"44444444",
	X"55555555",
	X"66666666",
	X"77777777"	
	);
					
variable addr: unsigned (2 downto 0); 
--variable addr: integer

variable mem_content : std_logic_vector(31 downto 0);

begin
	if (reset = '1') then

data_mem(0) := x"00000000"; 
data_mem(1) := X"00000001";
data_mem(2) := X"00000002";
data_mem(3) := X"00000003";
data_mem(4) := X"00000004";
data_mem(5) := X"00000005";
data_mem(6) := X"00000006";
data_mem(7) := X"00000007";

else

--addr := conv_integer(address(2 downto 0));

addr := unsigned (address(2 downto 0));
mem_content := write_data;
	
if (clk = '1' and clk'event) then
	if MemWrite = '1' then
	data_mem(to_integer(addr)) := mem_content;
	end if;
end if;
if MemRead = '1' then
	mem_content := data_mem(to_integer(addr));
	read_data <= mem_content ;
else
	read_data<=X"00000000";
end if;
end if;
end process ReadWrite1;
end bhv;
