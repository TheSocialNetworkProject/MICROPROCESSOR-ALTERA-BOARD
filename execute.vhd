library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std;

entity execute is
port (
	register_rs, register_rt: in std_logic_vector (31 downto 0);
	PC4, immediate: in std_logic_vector (31 downto 0);
	ALUOp: in std_logic_vector (1 downto 0);
	ALUSrc, beq_control, clock: in std_logic;
	alu_result, branch_addr: out std_logic_vector (31 downto 0);
	branch_decision: out std_logic
	);
end execute;

architecture behav of execute is
	begin
	
		process (clock)
			variable alu_output: std_logic_vector (31 downto 0);
			variable zero: std_logic;
			variable branch_offset, temp_branch_addr: std_logic_vector(31 downto 0);
			
			begin
				--if (clock'event and clock = '1') then
					case ALUOp is
						when "00" => --load
							alu_output := register_rs + immediate;
							zero := '0';
						when "01"=> --branch
							alu_output := register_rs - register_rt;
							zero := '1';
						when "10" =>
							case immediate (5 downto 0) is
								when "100000" => --add
									alu_output := register_rs + register_rt;
									zero := '0';
								when "100010" =>
									alu_output := register_rs - register_rt;
								zero := '0';
								when "100100" =>
								alu_output := register_rs and register_rt;
								when "100101" =>
									alu_output := register_rs or register_rt;
									when "100001" =>
									alu_output := register_rs + register_rt;
									when "100011" =>
									alu_output := register_rs - register_rt;
									when others =>
									alu_output := x"f0ffffff";
									end case;
						when others =>
							alu_output := x"fffffff0";
							zero := '0';
					end case;

				branch_offset:=immediate;
				temp_branch_addr:=PC4+branch_offset;
				branch_decision <= (beq_control and zero);
				branch_addr <= temp_branch_addr;
				alu_result <= alu_output;
--end if;
				end process;
end behav;	
						


									
									
									
									
						
						
							
							
	