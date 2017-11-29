----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2017 09:30:05 PM
-- Design Name: 
-- Module Name: 7segmentdisplay - Behavioral
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

entity SevenSegmentDisplay is
    Port ( Price   : in STD_LOGIC_VECTOR (15 downto 0);
           --Digit0 : in std_Logic_vector (3 downto 0);
           --Digit1 : in std_logic_vector (3 downto 0);
           --Digit2 : in std_logic_vector (3 downto 0);
           --Digit3 : in std_logic_vector (3 downto 0);
           CLK     : in STD_LOGIC;
           DP      : out std_Logic;
           Anode   : out STD_LOGIC_VECTOR (3 downto 0);
           Cathode : out STD_LOGIC_VECTOR (6 downto 0));
end SevenSegmentDisplay;

architecture Behavioral of SevenSegmentDisplay is
    signal Digit3, Digit2, Digit1, Digit0 : std_logic_vector (3 downto 0);
    signal CLK_240 : std_logic := '0';
begin
    Digit3 <= Price(15 downto 12);
    Digit2 <= Price(11 downto 8);
    Digit1 <= Price(7 downto 4);
    Digit0 <= Price(3 downto 0);
    
    process (CLK)
        variable count : unsigned (19 downto 0) := "00000000000000000000";
        
        begin
            if (rising_edge(CLK)) then
                if (count = "00110010110111001101") then
                    CLK_240 <= not CLK_240;
                    count := "00000000000000000000";
                else
                    count := count + 1;
                end if;
            end if;
        end process;
        
    process(Digit3, Digit2, Digit1, Digit0, CLK_240)
        variable digit : unsigned(1 downto 0) := "00";
        
        begin
            if (rising_edge(CLK_240)) then
                case (digit) is
                    when "00" =>
                        Anode <= "0111"; -- left most
                        DP <= '1';
                        case (digit3) is -----------------abcdefg
                            when "0000" => Cathode <= "0000001"; -- 0
                            when "0001" => Cathode <= "1001111"; -- 1
                            when "0010" => Cathode <= "0010010"; -- 2
                            when "0011" => Cathode <= "0000110"; -- 3
                            when "0100" => Cathode <= "1001100"; -- 4
                            when "0101" => Cathode <= "0100100"; -- 5
                            when "0110" => Cathode <= "0100000"; -- 6
                            when "0111" => Cathode <= "0001111"; -- 7
                            when "1000" => Cathode <= "0000000"; -- 8
                            when "1001" => Cathode <= "0000100"; -- 9
                            when "1010" => Cathode <= "0001000"; -- A
                            when "1011" => Cathode <= "1100000"; -- B
                            when "1100" => Cathode <= "0110001"; -- C
                            when "1101" => Cathode <= "1000010"; -- D
                            when "1110" => Cathode <= "0110000"; -- E
                            when "1111" => Cathode <= "0111000"; -- F
                            when others => Cathode <= "1111111";
                        end case;
                    when "01" =>
                        Anode <= "1011";
                        DP <= '0';
                        case (digit2) is -----------------abcdefg
                            when "0000" => Cathode <= "0000001"; -- 0
                            when "0001" => Cathode <= "1001111"; -- 1
                            when "0010" => Cathode <= "0010010"; -- 2
                            when "0011" => Cathode <= "0000110"; -- 3
                            when "0100" => Cathode <= "1001100"; -- 4
                            when "0101" => Cathode <= "0100100"; -- 5
                            when "0110" => Cathode <= "0100000"; -- 6
                            when "0111" => Cathode <= "0001111"; -- 7
                            when "1000" => Cathode <= "0000000"; -- 8
                            when "1001" => Cathode <= "0000100"; -- 9
                            when "1010" => Cathode <= "0001000"; -- A
                            when "1011" => Cathode <= "1100000"; -- B
                            when "1100" => Cathode <= "0110001"; -- C
                            when "1101" => Cathode <= "1000010"; -- D
                            when "1110" => Cathode <= "0110000"; -- E
                            when "1111" => Cathode <= "0111000"; -- F
                            when others => Cathode <= "1111111";
                        end case;
                    when "10" =>
                        Anode <= "1101";
                        DP <= '1';
                        case (digit1) is -----------------abcdefg
                            when "0000" => Cathode <= "0000001"; -- 0
                            when "0001" => Cathode <= "1001111"; -- 1
                            when "0010" => Cathode <= "0010010"; -- 2
                            when "0011" => Cathode <= "0000110"; -- 3
                            when "0100" => Cathode <= "1001100"; -- 4
                            when "0101" => Cathode <= "0100100"; -- 5
                            when "0110" => Cathode <= "0100000"; -- 6
                            when "0111" => Cathode <= "0001111"; -- 7
                            when "1000" => Cathode <= "0000000"; -- 8
                            when "1001" => Cathode <= "0000100"; -- 9
                            when "1010" => Cathode <= "0001000"; -- A
                            when "1011" => Cathode <= "1100000"; -- B
                            when "1100" => Cathode <= "0110001"; -- C
                            when "1101" => Cathode <= "1000010"; -- D
                            when "1110" => Cathode <= "0110000"; -- E
                            when "1111" => Cathode <= "0111000"; -- F
                            when others => Cathode <= "1111111";
                        end case;
                    when "11" =>
                        Anode <= "1110";
                        DP <= '1';
                        case (digit0) is -----------------abcdefg
                            when "0000" => Cathode <= "0000001"; -- 0
                            when "0001" => Cathode <= "1001111"; -- 1
                            when "0010" => Cathode <= "0010010"; -- 2
                            when "0011" => Cathode <= "0000110"; -- 3
                            when "0100" => Cathode <= "1001100"; -- 4
                            when "0101" => Cathode <= "0100100"; -- 5
                            when "0110" => Cathode <= "0100000"; -- 6
                            when "0111" => Cathode <= "0001111"; -- 7
                            when "1000" => Cathode <= "0000000"; -- 8
                            when "1001" => Cathode <= "0000100"; -- 9
                            when "1010" => Cathode <= "0001000"; -- A
                            when "1011" => Cathode <= "1100000"; -- B
                            when "1100" => Cathode <= "0110001"; -- C
                            when "1101" => Cathode <= "1000010"; -- D
                            when "1110" => Cathode <= "0110000"; -- E
                            when "1111" => Cathode <= "0111000"; -- F
                            when others => Cathode <= "1111111";
                        end case;
                    when others => 
                        Anode   <= "1111";
                        Cathode <= "1111111";
                    end case;
                digit := digit + 1;
            end if;
            
    end process;
                    
end Behavioral;
