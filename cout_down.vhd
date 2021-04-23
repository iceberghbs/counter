
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity count_down is
    Port ( CK : in STD_LOGIC;
           clk : in STD_LOGIC;
           DONE : in STD_LOGIC;
           upclk : in STD_LOGIC;
           dnclk : in STD_LOGIC;
           sw : in UNSIGNED (15 downto 0);
           D3 : out STD_LOGIC_VECTOR (3 downto 0);
           D2 : out STD_LOGIC_VECTOR (3 downto 0);
           D1 : out STD_LOGIC_VECTOR (3 downto 0);
           D0 : out STD_LOGIC_VECTOR (3 downto 0));
end count_down;

architecture Behavioral of count_down is
    signal tmpd3: std_logic_vector(3 downto 0):=(others =>'0');
    signal tmpd2: std_logic_vector(3 downto 0):=(others =>'0');
    signal tmpd1: std_logic_vector(3 downto 0):=(others =>'0');
    signal tmpd0: std_logic_vector(3 downto 0):=(others =>'0');
begin
     
          process(ck,upclk,dnclk)
            begin
            --Use if statement to realize the addition and subtraction of digital clock
            --According to different situations, countdown
                if(rising_edge(ck) and DONE = '1' ) then 
                -- By detecting the clock edge and pattern, it is set to count down.
                     if( tmpd0 /= 0) then tmpd0 <= tmpd0 - 1;
                     elsif (tmpd1 /= 0) then tmpd0 <="1001";tmpd1 <= tmpd1-1;
                     elsif (tmpd2 /= 0) then tmpd1 <="0101";tmpd2 <= tmpd2-1;
                     elsif (tmpd3 /= 0) then tmpd2 <="1001";tmpd3 <= tmpd3-1;
                     else 
                        tmpd0 <= "0000";tmpd1<="0000" ;tmpd2 <="0000" ;tmpd3 <="0000";
                     end if;
                elsif ( DONE ='0') THEN
                    IF ( rising_edge(upclk)) THEN 
                                 tmpd0 <= "0000";tmpd1 <="0000";
                                IF (tmpd2 /= "1001")THEN tmpd2 <= tmpd2 + 1;
                                    ELSIF (tmpd3 /="0101")THEN tmpd3<= tmpd3 + 1; tmpd2<="0000";
                                    ELSE tmpd3<="0000";
                                end if;                                 
                     elsif (rising_edge(dnclk)) THEN 
                            tmpd0 <= "0000";tmpd1 <="0000";
                            if ( tmpd2 /= "0000") THEN tmpd2 <= tmpd2 - 1;
                                ELSIF ( tmpd3 /="0000") THEN tmpd3<= tmpd3 - 1; tmpd2<="1001";
                                ELSE tmpd3<="0101";
                            end if; 
                      end if;
                 end if;
           end process;
       
           
       -- Put the temporary signal into the output port
         D3 <= tmpd3 ;
         D2 <= tmpd2 ;
         D1 <= tmpd1 ;
         D0 <= tmpd0 ;
         
end Behavioral;
