library ieee;
use ieee.std_logic_1164.all;

package segment is

component sevenseg is
port(
     input1 :in std_logic_vector(3 downto 0);
	 output1 :out std_logic_vector(6 downto 0));
end component;

component lab8 is
port(
      PC_out : out std_logic_vector(31 downto 0);
		branch_decision, jump_decision, reset, clk : in std_logic;
		instruction: out std_logic_vector (31 downto 0);
		branch_addr, jump_addr : in std_logic_vector(31 downto 0)
 );
end component;

component lab9 is
port
	(
		instruction,memory_data,alu_result : in STD_LOGIC_VECTOR (31 downto 0);
		regd,rw,mtr,clk,rst : in std_logic;
		immediate,jump_addr,register_rt,register_rs : out STD_LOGIC_VECTOR (31 downto 0)
		--rs, rt: out std_LOGIC_VECTOR (31 downto 0)
	);
end component;
component Lab10 is
port (
instruction:in std_logic_vector(31 downto 0);
  reset: in std_logic;
  RegDst:out std_logic;
  MemToReg: out std_logic;
  ALUOp: out std_logic_vector(1 downto 0);
  jump, beq_control, MemRead, MemWrite, ALUSrc, RegWrite: out std_logic
 );
 end component;
component memory is
Port ( 
	address : in std_logic_vector (31 downto 0);
	reset,clk: in std_logic;
	write_data : in std_logic_vector (31 downto 0);
	MemWrite, MemRead : in std_logic;
	read_data : out std_logic_vector (31 downto 0));
end component;

component execute is
port (
	register_rs, register_rt: in std_logic_vector (31 downto 0);
	PC4, immediate: in std_logic_vector (31 downto 0);
	ALUOp: in std_logic_vector (1 downto 0);
	ALUSrc, beq_control, clock: in std_logic;
	alu_result, branch_addr: out std_logic_vector (31 downto 0);
	branch_decision: out std_logic
	);
end component;

end segment;