----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2017 04:31:33 PM
-- Design Name: 
-- Module Name: Debounce - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity DeBounce is
   port( CLK     : in std_logic;
         Reset     : in std_logic;
         button_in : in std_logic_vector (3 downto 0);
         pulse_out : out std_logic_vector (3 downto 0)
       );
end DeBounce;

architecture behav of DeBounce is

--the below constants decide the working parameters.
--the higher this is, the more longer time the user has to press the button.
constant COUNT_MAX : integer := 10; 
--set it '1' if the button creates a high pulse when its pressed, otherwise '0'.
constant BTN_ACTIVE : std_logic := '1';

signal count : integer := 0;
type state_type is (idle,wait_time); --state machine
signal state : state_type := idle;

begin
 
process(Reset, CLK)
begin
   if(Reset = '1') then
       state <= idle;
       pulse_out <= "0000";
  elsif(rising_edge(CLK)) then
       case (state) is
           when idle =>
               if(button_in(0) = BTN_ACTIVE) then  
                   state <= wait_time;
               elsif(button_in(1) = BTN_ACTIVE) then  
                   state <= wait_time;
               elsif(button_in(2) = BTN_ACTIVE) then  
                   state <= wait_time;
               elsif(button_in(3) = BTN_ACTIVE) then  
                   state <= wait_time;                                   
               else
                   state <= idle; --wait until button is pressed.
               end if;
               pulse_out <= "0000";
           
           when wait_time =>
               if(count = COUNT_MAX) then
                   count <= 0;
                   if(button_in(0) = BTN_ACTIVE) then
                       pulse_out <= "0001";
                   elsif(button_in(2) = BTN_ACTIVE) then
                       pulse_out <= "0100";
                   elsif(button_in(1) = BTN_ACTIVE) then
                       pulse_out <= "0010";
                   elsif(button_in(3) = BTN_ACTIVE) then
                       pulse_out <= "1000";
                   end if;
                   state <= idle;  
               else
                   count <= count + 1;
               end if; 
       end case;       
   end if;        
end process;                  
                                                                               
end architecture behav;

