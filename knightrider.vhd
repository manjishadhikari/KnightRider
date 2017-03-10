----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/06/2017 07:42:04 PM
-- Design Name: 
-- Module Name: knightrider - Behavioral
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



entity knightrider is
    Port ( clk1 : in STD_LOGIC;
           reset1 : in STD_LOGIC;
            step1: in STD_LOGIC;
            step2: in STD_LOGIC;
             step3: in STD_LOGIC;
            step4: in STD_LOGIC;
            ce: in STD_LOGIC;
           led : out STD_LOGIC_VECTOR(15 downto 0)
           );
end knightrider;

architecture Behavioral of knightrider is
component memory_01 is
    port (CLK  : in std_logic;
          WE   : in std_logic;
          EN   : in std_logic;
          ADDR : in std_logic_vector(4 downto 0);
          DI   : in std_logic_vector(15 downto 0);
          DO   : out std_logic_vector(15 downto 0));
end component;

component addrcounter_source is
    Port ( clk : in STD_LOGIC;
        
          enable: in STD_LOGIC;
          
          count : out STD_LOGIC_VECTOR(4 downto 0)
        );
end component;

component ratecounter_source is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable: in STD_LOGIC;
            ended: out STD_LOGIC;
             step1: in std_logic;
                      step2: in std_logic;
                      step3: in std_logic;
                      step4: in std_logic
           --count : out STD_LOGIC_VECTOR(23 downto 0)
         );
end component;

signal com: STD_LOGIC;
signal addr:  std_logic_vector(4 downto 0);
signal data:  std_logic_vector(15 downto 0);
begin

ratecounter: ratecounter_source port map(clk=>clk1,reset=>reset1,enable=>ce,ended=>com,step1=>step1,step2=>step2,step3=>step3,step4=>step4); 
addrcounter: addrcounter_source port map(clk=>clk1,enable=>com,count=>addr);
mem: memory_01 port map(CLK=>clk1,WE=>'0',EN=>'1',ADDR=>addr,DO=>data,DI=>(others=>'0'));
led<=data;
end Behavioral;
