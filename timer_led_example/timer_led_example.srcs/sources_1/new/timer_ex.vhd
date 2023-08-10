library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEE.STD_LOGIC_ARITH.ALL;

entity timer_ex is
generic(
	clk_freq : integer := 100_000_000
);
Port ( 
	clk : in std_logic;
	sw : in std_logic_vector(1 downto 0);
	counter : out std_logic_vector(7 downto 0)
);
end timer_ex;

architecture Behavioral of timer_ex is

constant timer2sec : integer := clk_freq*2;
constant timer1sec : integer := clk_freq;
constant timer500ms : integer := clk_freq/2;
constant timer250ms : integer := clk_freq/4;

signal timer : integer range 0 to timer2sec := 0;
signal s_counter : std_logic_vector(7 downto 0) := (others => '0');
signal timer_limit : integer range 0 to timer2sec := 0;

begin

timer_limit <= timer2sec when sw = "00" else
			   timer1sec when sw = "01" else
			   timer500ms when sw = "10" else
			   timer250ms when sw = "11";

process(clk) begin
	if(rising_edge(clk)) then
		if(timer >= timer_limit - 1) then
			timer <= 0;
			s_counter <= s_counter + 1;	
		else
			timer <= timer + 1;
		end if;
	end if;
end process;
	counter <= s_counter;
end Behavioral;
