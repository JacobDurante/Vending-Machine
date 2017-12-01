----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2017 12:14:25 AM
-- Design Name: 
-- Module Name: ThreeSecCounter - Behavioral
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

entity ThreeSecCounter is
    Port ( CLK   : in STD_LOGIC;
           Start : in STD_LOGIC;
           Stop  : out STD_LOGIC);
end ThreeSecCounter;

architecture Behavioral of ThreeSecCounter is

begin
ThreeSecCounter : process (CLK)
    variable count : unsigned (31 downto 0) := "00000000000000000000000000000000";
    begin
        if (Start = '1') then
            if (rising_edge(CLK)) then
                if (count = "00001000111100110001110000000110") then
                    count := "00000000000000000000000000000000";
                        Stop <= '1';
                else
                    count := count + 1;
                        Stop <= '0';
                end if;
            end if;
        end if;
end process;
end Behavioral;
