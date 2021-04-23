----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2021/02/12 21:10:01
-- Design Name: 
-- Module Name: counter - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
  Port (clk_sec : in std_logic;
        btnC : in std_logic;  -- controlling the mode of the counter
        btnU, btnD : in std_logic;
        digit_3 : out std_logic_vector(3 downto 0);
        digit_2 : out std_logic_vector(3 downto 0);
        digit_1 : out std_logic_vector(3 downto 0);
        digit_0 : out std_logic_vector(3 downto 0)
         );
end counter;

architecture Behavioral of counter is

begin
    
    process(btnC, clk_sec, btnU, btnD)
    
    variable min : integer range 0 to 60 := 0;
    variable sec : integer range 0 to 59 := 0;
    variable set_go : std_logic:='0';
    
    begin
--        set_go: represents the modes of the timer. '1': counting mode; '0': set mode
--        the mode of the timer shifts when pushes the central button or time is up
        if (btnC'event and btnC='1') then  -- pushing button C will immediately change the mode
            if (set_go='0') then
                set_go := '1';  -- mode changes
            else
                set_go := '0';
            end if;
        end if;
        if set_go='1' then  ----------------------------- counting mode: the timer now is counting downwards unless there is no time
            if (clk_sec'event and clk_sec='1') then  -- when rise edge comes, tik tok
                if (sec=0 and min>0) then  -- this minute is up
                    sec := 59;  -- from 00 second jump to 59
                    min := min - 1;  -- min changes
                elsif (sec=1 and min=0) then  -- last second is up
                    sec := sec - 1;
                    set_go := '0';  -- time is up (counting down to)
                elsif sec>0 then
                    sec := sec - 1;  -- countdown
                end if;       
            end if;
        end if;
        if set_go='0' then  --------------------------------------- set mode: now the minute digits is settable
            if (btnU'event and btnU='1') then  -- pushing the up button
                sec := 0;  -- resets digits_second
                if min<60 then
                    min := min + 1;  -- minute digit adds by 1
                else
                    min := 0;  -- back to 0 when adds beyond 60
                end if;
            end if;
            if (btnD'event and btnD='1') then  -- pushing the down button
                if sec=0 then 
                    if min=0 then  -- when now is 00:00, push the down button
                        min := 60;  -- go to 60
                    else
                        min := min - 1;
                    end if;
                else
                    sec := 0;  -- reseting the second digits
                end if;
            end if;
        end if;
        
        -- conver to digits: for example, 12:34 will convers to '0001', '0010', '0011', '0100'. sent to decoder to display.
        digit_3 <= std_logic_vector(to_unsigned (min/10, 4));
        digit_2 <= std_logic_vector(to_unsigned (min rem 10, 4));
        digit_1 <= std_logic_vector(to_unsigned (sec/10, 4));
        digit_0 <= std_logic_vector(to_unsigned (sec rem 10, 4));

    end process;
    
    
end Behavioral;
