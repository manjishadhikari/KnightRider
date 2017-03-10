

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ratecounter_source is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable: in STD_LOGIC;
            ended: out STD_LOGIC;
           --count : out STD_LOGIC_VECTOR(23 downto 0)
           step1: in std_logic;
           step2: in std_logic;
           step3: in std_logic;
           step4: in std_logic
         );
end ratecounter_source;

architecture Behavioral of ratecounter_source is
signal temp: STD_LOGIC_VECTOR(23 downto 0):=(others=>'0');
signal limit : STD_LOGIC_VECTOR(23 downto 0):=(others=>'0');
begin
process(clk,reset,step1,step2,step3,step4)
begin
  if step1='1' then 
  limit<= "000010111110101111000010";                   --0.25 sec
  end if ;
  if step2='1' then 
    limit<="000101111101011110000100";    --0.5 sec
    end if ;
  if step3='1' then 
      limit<="001011111010111100001000";                   --1 sec
      end if ;
      if step4='1' then 
        limit<="010111110101111000010000" ;    --2 sec
        end if ;
   if rising_edge(clk) then
       if reset='1' then
         temp<=(others=>'0');
         else
            if enable='0' then  
                temp<=temp;
            else
                if temp=limit then
                    temp<=(others=>'0');
                    ended<='1';
                else
                    temp<=temp+1;
                    ended<='0';
                end if;
             end if;
        end if;
      end if;
 end process;
    --count<=temp;
end Behavioral;
