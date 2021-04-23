

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity controller is
   PORT(   UP,down,go: in STD_LOGIC;
           clk: in std_logic;
           upclk : out STD_LOGIC;
           dnclk : out STD_LOGIC;
           DONE: out STD_LOGIC);
end controller;

architecture Behavioral of controller is
signal tmp_done: std_logic:= '1';
signal btnu1,btnu2,btnd1,btnd2: STD_LOGIC;  

begin        
    process(GO)          
    begin  
        if (rising_edge(GO))then  
              tmp_done<= not tmp_done; 
              DONE <= tmp_done;
              END IF;
    end process; 
  
    upclk <= up;
    dnclk <= down;

end Behavioral;
