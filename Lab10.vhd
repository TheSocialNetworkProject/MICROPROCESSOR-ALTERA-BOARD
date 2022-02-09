library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Lab10 is
port (
instruction:in std_logic_vector(31 downto 0);
  reset: in std_logic;
  RegDst:out std_logic;
  MemToReg: out std_logic;
  ALUOp: out std_logic_vector(1 downto 0);
  jump, beq_control, MemRead, MemWrite, ALUSrc, RegWrite: out std_logic
 );
end Lab10;


architecture Bhv of Lab10 is

begin
process(instruction,reset)

variable opcode :std_logic_vector(5 downto 0);

begin

 if(reset = '1') then
   Regdst <= '0';
   MemToReg <= '0';
   ALUOp <= "00";
   jump <= '0';
   beq_control <= '0';
   MemRead <= '0';
   MemWrite <= '0';
   ALUSrc <= '0';
   RegWrite <= '0';
	
 else 
   
 opcode(5 downto 0) := instruction(31 downto 26);
	   
 case opcode is
  when "000000" => --rformat
    RegDst <= '1';
    MemToReg <= '0';
    ALUOp <= "10";
    jump <= '0';
    beq_control <= '0';
    MemRead <= '0';
    MemWrite <= '0';
    ALUSrc <= '0';
    RegWrite <= '1';
	 
  when "100011" => --lw
   RegDst <= '0';
   MemToReg <= '1';
   ALUOp <= "00";
   jump <= '0';
   beq_control <= '0';
   MemRead <= '1';
   MemWrite <= '0';
   ALUSrc <= '1';
   RegWrite <= '1';
	
  when "101011" => -- sw
   RegDst <= '0';
   MemToReg <= '0';
   ALUOp <= "00";
   jump <= '0';
   beq_control <= '0';
   MemRead <= '0';
   MemWrite <= '1';
   ALUSrc <= '1';
   RegWrite <= '0';
	
  when "000100" => -- beq
   RegDst <= '0';
   MemToReg <= '0';
   AlUOp <= "01";
   jump <= '0';
   beq_control <= '1';
   MemRead <= '0';
   MemWrite <= '0';
   ALUSrc <= '0';
   RegWrite <= '0';
	
   when "000010" =>   
   Regdst <= '0';
   MemToReg <= '0';
   ALUOp <= "00";
   jump <= '1';
   beq_control <= '0';
   MemRead <= '0';
   MemWrite <= '0';
   ALUSrc <= '0';
   RegWrite <= '0';
	
	when "001000" =>		--addi
		regDst <= '0';
		ALUSrc <= '1';
		MemToReg <= '0';
		regWrite <= '1';
		MemRead <= '0';
		MemWrite <= '0';
		ALUOp <= "00";
		Jump <= '0';
		beq_control <= '0';
	
  when others =>   
   Regdst <= '0';
   MemToReg <= '0';
   ALUOp <= "00";
   jump <= '0';
   beq_control <= '0';
   MemRead <= '0';
   MemWrite <= '0';
   ALUSrc <= '0';
   RegWrite <= '0';
   end case;
	
  end if;
 end process;
end bhv;