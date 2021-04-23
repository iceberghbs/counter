----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/02/12 18:20:07
-- Design Name: 
-- Module Name: frq_div - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity frq_div is
    generic(n:integer);  -- frq_div_coefficient
    Port (  clk : in STD_LOGIC;
            clkout : out std_logic
            );
end frq_div;

architecture Behavioral of frq_div is
-- this is a frequence divider.
-- in order to obtain lower frquency pulse signal for tik-tok.
-- a 50MHz clock is embedded on BASYS3.
-- to have an 1Hz pulse signal we use a frq_div with coefficient 50000000
-- but for testbench, this number is too large to run simulate(cost too much time)
-- as we use a relatively small number see in top design main3_final.vhd
begin
    process(clk) 
        variable count:integer range n downto 0:=n;
    begin
        if (clk'event AND clk='1') then 
            count:=count-1;
            if (count>=n/2) then  -- half clock period is n/2.
                clkout<='0';
            else
                clkout<='1';
            end if;
            if count<=0 then
                count:=n;
            end if;
        end if;
    end process;


end Behavioral;
