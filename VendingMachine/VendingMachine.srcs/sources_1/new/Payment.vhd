----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2017 10:06:19 PM
-- Design Name: 
-- Module Name: Payment - Behavioral
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

entity Payment is
    Port ( Money  : in std_logic_vector (3 downto 0); -- 3 is Dollars, 2 is Quarters, 1 is Dimes, 0 is Nickles
           Change : out signed (8 downto 0));
end Payment;

architecture Behavioral of Payment is
    signal Dollar : signed (8 downto 0) := "001100100"; -- 001100100 = 100
    signal Quarter : signed (8 downto 0) := "000011001"; -- 000011001 = 25
    signal Dime : signed (8 downto 0) := "000001010"; -- 000001010 = 10
    signal Nickle : signed ( 8 downto 0) := "000000101"; -- 000000101 = 5
    signal Price : signed (8 downto 0) := "010010110"; -- assign fixed price of $1.50, 010010110 = 150
begin
    
    Payment : process (Money) 
        variable Difference : signed (8 downto 0) := "010010110"; -- default difference is the price
        begin
            case (Money) is
                when "0000" => -- no Payment being made
                    Difference := Difference; -- stores the output
                when "1000" => -- paying a dollar
                    Difference := Difference - Dollar;
                when "0100" => -- paying a quarter
                    Difference := Difference - Quarter;
                when "0010" => -- paying a Dime
                    Difference := Difference - Dime;
                when "0001" => -- paying a Nickle
                    Difference := Difference - Nickle;
                when others => -- dealling with other cases
                    Difference := Difference;
            end case;
            Change <= Difference;
    end process;

end Behavioral;
