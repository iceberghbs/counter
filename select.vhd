--- import library
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity selectd is -- set port 
 PORT( DT3,DT2,DT1,DT0,DC3,DC2,DC1,DC0: in STD_LOGIC_VECTOR(3 DOWNTO 0);
       DONE: IN STD_LOGIC;
       DD3,DD2,DD1,DD0:OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end selectd;


architecture Behavioral of selectd is
begin
    process(DONE)  -- This part is to select the set and go modes, which part of the digital output
    begin 
    if DONE ='0' THEN --  set model
        DD0<=DC0;DD1<=DC1;DD2<=DC2;DD3<=DC3;
    ELSE IF DONE='1' THEN -- go model
        DD0<=DT0;DD1<=DT1;DD2<=DT2;DD3<=DT3;
    END IF;
    END IF;
    END PROCESS;

end Behavioral;
