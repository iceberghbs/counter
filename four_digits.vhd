library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity four_digits is
   PORT (
      ck   : IN STD_LOGIC;
	  d0,d1,d2,d3 : IN STD_LOGIC_VECTOR(3 downto 0);-- input 4 4-bits binary
      seg  : OUT STD_LOGIC_VECTOR(6 downto 0);-- display 7 segment tube
      an   : OUT STD_LOGIC_VECTOR(3 downto 0)--select 4 tube 
   );
end four_digits;

ARCHITECTURE Behavioral OF four_digits is 
   SIGNAL an_ctrl    : integer := 0;-- count 0 to 3
   SIGNAL number     : STD_LOGIC_VECTOR(3 downto 0);
begin   
      
     -- instantiate one one_digit decoder that will decode the active digit
    one_digit_unit : entity work.one_digit(Behavioral)
        Port map ( x => number, seg => seg);
     
   --¼ÆÊýÆ÷
   process (ck)
   begin
      if (ck'EVENT AND ck = '1') then
         if(an_ctrl=3) then--counr 3 to 0
            an_ctrl <= 0;
         else
            an_ctrl <= an_ctrl + 1;--count 0 to 3
         end if;
      end if;
   end process;
   
   --Display different content according to count control
   process (an_ctrl,d0,d1,d2,d3)
   begin
      if(an_ctrl=0)then  number <= d0;
      elsif(an_ctrl=1)then  number <= d1;
      elsif(an_ctrl=2)then  number <= d2;
      elsif(an_ctrl=3)then  number <= d3;
      else number <= "0000";
      end if;
   end process;
   
   process (an_ctrl)
   begin
     -- output an by counting
      if(an_ctrl=0)then an<="0111";
      elsif(an_ctrl=1)then an<="1011";
      elsif(an_ctrl=2)then an<="1101";
      elsif(an_ctrl=3)then an<="1110";
      else an<="1111";
      end if;
   end process;
   

end Behavioral;




