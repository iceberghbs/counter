----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/02/16 16:35:30
-- Design Name: 
-- Module Name: fre_div - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity fre_div is
    GENERIC ( N: integer := 100);
    PORT ( ck_in : IN STD_LOGIC;
           ck_out: out std_logic;
           ck_1s: out std_logic
           );
end fre_div;

architecture Behavioral of fre_div is
signal clk1k,clk1: std_logic:='0';
begin
    ck_out <= clk1k;
    ck_1s  <= clk1;
    process(ck_in)
    variable c0: integer range 0 to 8;
    variable c1: integer range 0 to 2;
    begin
        if rising_edge(ck_in) then 
            c0:=c0+1;
            c1:=c1+1;
            if c0=8 then 
                 clk1 <= not clk1;
                 c0:=0;end if;
            if c1= 2  then 
                clk1k<= not clk1k;
                c1:=0;end if;
       end if;
    end process;             

end Behavioral;
