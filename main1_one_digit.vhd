----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: Luca Citi
-- 
-- Create Date:    09/01/2016
-- Design Name:    Assignment1
-- Module Name:    main1_one_digit - Behavioral 
-- Description:    main file for sub-design 1
--                 implementing a 1-digit 7-segment display
--                 decoder
-- Dependencies:   one_digit
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity main1_one_digit is
    Port (
        sw   : in  STD_LOGIC_VECTOR (15 downto 0);
        seg  : out STD_LOGIC_VECTOR (6 downto 0);
        dp   : out STD_LOGIC;
        an   : out STD_LOGIC_VECTOR (3 downto 0));
end main1_one_digit;

architecture Behavioral of main1_one_digit is
    component one_digit
    Port (
          digit: in std_logic_vector(3 downto 0); 
          seg  : out STD_LOGIC_VECTOR (6 downto 0);
          dp   : out STD_LOGIC;
          an   : out STD_LOGIC_VECTOR (3 downto 0)
          );
     end component;
     
     signal an_int :std_logic_vector(3 downto 0); 
     signal dp_int: std_logic;
begin
    -- instantiate one one_digit decoder that will decode the active digit
    an_int  <=  sw(15 downto 12);
    dp_int <= sw(5);
    U1:  one_digit Port map 
        (   digit => sw(3 downto 0),
            seg => seg
         );
end Behavioral;

