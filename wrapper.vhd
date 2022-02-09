library ieee;
use ieee.std_logic_1164.all;
use work.segment.all;

entity wrapper is
   port(
	   reset, clk : in STD_LOGIC;
		cathod0, cathod1, cathod2, cathod3, cathod4, cathod5, cathod6, cathod7 : out std_logic_vector(6 downto 0);
		rs_sw,rt_sw,pc_sw,imm_sw,rd_s,alu_sw,rd_sw : in std_LOGIC
		);
	end wrapper;
	
architecture bhvr of wrapper is
    signal jump_addr : std_logic_vector(31 downto 0);
	 signal branch_addr : std_LOGIC_VECTOR(31 downto 0);
    signal immediate, register_rs, register_rt: STD_LOGIC_VECTOR (31 downto 0);  
    signal instruction : std_LOGIC_VECTOR(31 downto 0);
    signal memory_data, alu_result : STD_LOGIC_VECTOR (31 downto 0);
	 signal call : std_LOGIC_VECTOR(31 downto 0);
	 signal PC_out : std_logic_vector(31 downto 0);
	 signal aluop : std_LOGIC_VECTOR(1 downto 0);
	 signal s_RD, s_RW, s_J, s_beq, s_MTR, s_MR, s_MW, alusrc : std_LOGIC;
	 signal branch_decision, jump_decision: std_logic;
    signal   regDst, RegWrite, MemToReg : std_LOGIC;
begin

   u1: work.lab8 port map(	PC_out,branch_decision, jump_decision, reset, clk,instruction,branch_addr, jump_addr);
	u2: work.lab9 port map (instruction,memory_data,alu_result,	RegDst, RegWrite, MemToReg,clk, reset, immediate, jump_addr, register_rt, register_rs);
	u11 : work.lab10 port map(
instruction, reset, regDst, MemtoReg, aluop, jump_decision, s_beq, s_MR, s_MW, alusrc, RegWrite 
	--instruction,reset,s_J,s_RW,s_MTR,alusrc,s_beq,s_MR,s_MW,s_RD,aluop
	
	);
	u22: work.execute port map (register_rs, register_rt, PC_out, immediate, aluop, alusrc, s_beq, clk,alu_result, branch_addr,branch_decision);
	u33: work.memory port map (alu_result,	reset,clk,register_rt,s_MW, s_MR,memory_data);
	process(rs_sw,rt_sw,PC_sw,imm_sw, rd_s, alu_sw,rd_sw)
	begin
		   if(rs_sw = '1') then
          call <= register_rs;
			elsif(rt_sw = '1') then
			 call <= register_rt;
			elsif(PC_sw = '1') then
			 call <= PC_out;
			elsif(imm_sw = '1') then
			 call <= immediate;
			elsif (rd_s = '1') then
				call <= x"00000000";
			elsif (alu_sw = '1') then
				call <=alu_result;
			elsif (rd_sw = '1') then
				call <= memory_data;
			else
				call <= instruction;
		 end if;
		
	end process;
	
   u3 : work.sevenseg port map(call(3 downto 0), cathod0);
   u4 : work.sevenseg port map(call(7 downto 4), cathod1);
   u5 : work.sevenseg port map(call(11 downto 8), cathod2);
   u6 : work.sevenseg port map(call(15 downto 12), cathod3);
	u7 : work.sevenseg port map(call(19 downto 16), cathod4);
   u8 : work.sevenseg port map(call(23 downto 20), cathod5);
   u9 : work.sevenseg port map(call(27 downto 24), cathod6);
   u10 : work.sevenseg port map(call(31 downto 28), cathod7);
	

end bhvr;