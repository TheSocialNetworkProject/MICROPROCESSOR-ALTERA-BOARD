library ieee;
use ieee.std_logic_1164.all;
use work.segment.all;

entity lab9 is
port
	(
		instruction,memory_data,alu_result : in STD_LOGIC_VECTOR (31 downto 0);
		regd,rw,mtr,clk,rst : in std_logic;
		immediate,jump_addr,register_rt,register_rs : out STD_LOGIC_VECTOR (31 downto 0)
		--rs, rt: out std_LOGIC_VECTOR (31 downto 0)
	);
end lab9;

architecture Behavioral of lab9 is
	signal reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : std_logic_vector(31 downto 0);
   signal rd : std_LOGIC_VECTOR(2 downto 0);
begin

	r_w: process(rst, memory_data, alu_result)
	variable write_value : std_logic_vector (31 downto 0);
	variable addr1, addr2, addr3 : std_logic_vector(2 downto 0);
begin
	if (rst = '1') then
		reg0 <= x"00000000"; reg1 <= x"11111111";
		reg2 <= x"22222222"; reg3 <= x"33333333";
		reg4 <= x"44444444"; reg5 <= x"55555555";
		reg6 <= x"66666666"; reg7 <= x"77777777";
	else
		addr2 := instruction(18 downto 16);
		addr3 := instruction(13 downto 11);
	
			if regd = '0' then
				addr3 := instruction(18 downto 16);
			else
				addr3 := instruction(13 downto 11);
			end if;
 if (rising_edge(clk)) then
	if rw = '1' then
		if mtr = '1' then
		write_value := memory_data;
		else
		write_value := alu_result;
	end if;
 
	case addr3 is
	when"000"=>
	reg0<=to_stdlogicvector(x"00000000");
	when"001"=>
	reg1<=write_value;
	when"010"=>
	reg2<=write_value;
	when"011"=>
	reg3<=write_value;
	when"100"=>
	reg4<=write_value;
	when"101"=>
	reg5<=write_value;
	when"110"=>
	reg6<=write_value;
	when"111"=>
	reg7<=write_value;
	when others =>
	reg7 <= write_value;
	end case;
 end if;
end if;
end if;
end process;

	reg_read: process(instruction)
    variable imm : std_logic_vector(31 downto 0);
	 variable rs, rt: std_LOGIC_VECTOR (31 downto 0);
		variable addr1, addr2 : std_logic_vector(2 downto 0);
	begin
		addr1 := instruction(23 downto 21);
		addr2 := instruction(18 downto 16);
	case addr1 is
		when "000" => rs := reg0;
		when "001" => rs := reg1;
		when "010" => rs := reg2;
		when "011" => rs := reg3;
		when "100" => rs := reg4;
		when "101" => rs := reg5;
		when "110" => rs := reg6;
		when "111" => rs := reg7;
	end case;

	case addr2 is
		when "000" => rt := reg0;
		when "001" => rt := reg1;
		when "010" => rt := reg2;
		when "011" => rt := reg3;
		when "100" => rt := reg4;
		when "101" => rt := reg5;
		when "110" => rt := reg6;
		when "111" => rt := reg7;
	end case;

	imm(15 downto 0) := instruction(15 downto 0);	
		if (instruction(15) = '1') then
			imm(31 downto 16) := x"ffff";
		else
		imm(31 downto 16) := x"0000";
	end if;

	jump_addr(31 downto 0) <= "000000" & instruction(25 downto 0);
	register_rs <= rs ;
	register_rt <= rt ;
	immediate <= imm ;
	
  end process;	

 end Behavioral;

