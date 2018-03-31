library ieee;
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all;


entity alu is
	generic (n : integer := 4);
	port(
	X : in std_logic_vector(n-1 downto 0);
	Y : in std_logic_vector(n-1 downto 0);
	AluControl : in std_logic_vector(1 downto 0);
	Result : out std_logic_vector(n-1 downto 0);
	ZeroFlag : out std_logic
	);
end alu;

architecture alu of alu is	
signal AluResult : std_logic_vector(n-1 downto 0);	
signal ZeroFlagResult: std_logic := '0';
begin	
	alup:process(X,Y,AluControl)
	begin		
		case AluControl is
		when "00" =>
		AluResult <= X + Y;
		when "01" => 
		AluResult <= X - Y;
		when "10" =>
		AluResult <= X(n-2 downto 0) & '0';
		when others =>
		AluResult <= '0' & X(n-1 downto 1);
		end case;
	end process;
	zero:for i in 0 to n-1 generate
		ZeroFlagResult <= ZeroFlagResult or AluResult(i);
	end generate;
	ZeroFlag <= not(ZeroFlagResult);
end alu;