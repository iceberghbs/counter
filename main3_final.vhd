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
   btnU, btnD,  btnC  : in  STD_LOGIC;
   seg  : out STD_LOGIC_VECTOR (6 downto 0);
   dp  : out STD_LOGIC;
   an   : out STD_LOGIC_VECTOR (3 downto 0));
end main3_final;

architecture Behavioral of main3_final is

component frq_div
    generic(n:integer);  -- frq_div_coefficient
    Port (  clk : in STD_LOGIC;
            clkout : out std_logic
            );
end component;

component counter
  Port (clk_sec : in std_logic;
        btnC : in std_logic;  -- outside set_go control signal 
        btnU, btnD : in std_logic;
        digit_3 : out std_logic_vector(3 downto 0);
        digit_2 : out std_logic_vector(3 downto 0);
        digit_1 : out std_logic_vector(3 downto 0);
        digit_0 : out std_logic_vector(3 downto 0)
         );
end component;

signal digit_3 : std_logic_vector(3 downto 0); -- corresponding to d3 of the 4 digit LED controller
signal digit_2 : std_logic_vector(3 downto 0); -- corresponding to d2 of the 4 digit LED controller
signal digit_1 : std_logic_vector(3 downto 0); -- corresponding to d1 of the 4 digit LED controller
signal digit_0 : std_logic_vector(3 downto 0); -- corresponding to d0 of the 4 digit LED controller
signal clk_sec : std_logic;  -- second hand signal
signal clk_led : std_logic;
--signal set_go : std_logic:='0';  -- the timer is at set mode when it is first started
--signal flag : std_logic;

begin

    uut_frq_div_sec:frq_div
        generic map (n => 100)  -- for testbench the clock period is 1ns, n have to be 100000000 to obtain 1Hz signal. But costs too much time.
        port map (clk => clk, clkout => clk_sec);
        
    uut_frq_div_led:frq_div
        generic map (n => 5)  -- clock signal that is used to refresh the 4 digits LED
        port map (clk => clk, clkout => clk_led);

    uut_counter:counter  -- this is the settable timer
        port map (clk_sec => clk_sec, 
                  btnC => btnC,
                  btnU => btnU, btnD => btnD,
                  digit_3 => digit_3, digit_2 => digit_2, digit_1 => digit_1, digit_0 => digit_0
                  );
        
    four_digits_unit : entity work.four_digits(Behavioral)  -- reuse LED controller 
        Port map (d3 => digit_3(3 downto 0),
                  d2 => digit_2(3 downto 0),
                  d1 => digit_1(3 downto 0),
                  d0 => digit_0(3 downto 0),
                  ck => clk_led, seg => seg, an => an, dp => dp);
                     
          
end Behavioral;
