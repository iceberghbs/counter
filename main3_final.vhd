----------------------------------------------------------------------------------
-- Company: University of Essex
-- Engineer: 
-- 
-- Create Date:    03/02/2021
-- Design Name:    Assignment1
-- Module Name:    main3_four_digits - Behavioral 
-- Description:    main file for final design
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity main3_final is port (
   sw : in UNSIGNED (15 downto 0);
   clk  : in  STD_LOGIC;
   btnU, btnD,  btnC  : in  STD_LOGIC;--btnL, btnR,
   seg  : out STD_LOGIC_VECTOR (6 downto 0);
   dp  : out STD_LOGIC;
   an   : out STD_LOGIC_VECTOR (3 downto 0));
   
end main3_final;

architecture Behavioral of main3_final is
signal DD3,DD2,DD1,DD0: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others =>'0');
signal CK1khz,DONE,CK1hz: STD_LOGIC :='0';
signal tmp_AN : STD_LOGIC_VECTOR(3 DOWNTO 0):="0000";
signal tupclk,tdnclk :std_logic;
 
begin
    Fre_div_unit: entity work.fre_div(Behavioral)
      port map( CK_IN => clk, CK_OUT => CK1khz,CK_1s => CK1HZ);    
    
    four_digits_unit: entity work.four_digits(behavioral)
      port map ( D3 =>DD3,D2 =>DD2,
                 D1 =>DD1,D0 =>DD0,
                 Ck =>CK1khz, SEG=>SEG, AN => tmp_AN); 
    controller_unit: entity work.controller (Behavioral)
      port map( clk=> clk,DONE => DONE, Down => btnD, up => btnU, Go => btnC, 
                upclk=>tupclk, dnclk=>tdnclk);
   count_down_unit:  entity work.count_down(behavioral)
      port map( CK => CK1hz, clk=>clk,DONE => DONE, sw => sw, 
               upclk=> tupclk, dnclk=>tdnclk,
               D3 => DD3,D2=>DD2,D1=>DD1,D0=>DD0);

   DP <= '0' When tmp_AN= "1011"else'1';
   AN <= tmp_AN;
end Behavioral;
