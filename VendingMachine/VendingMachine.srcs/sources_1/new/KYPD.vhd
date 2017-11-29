----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2017 09:33:18 AM
-- Design Name: 
-- Module Name: KYPD - Behavioral
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

entity KYPD is
    Port ( CLK    : in std_logic;
           RST    : in std_logic; -- asynchronous reset
           RowCol : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bit input, Row is 7 downto 4 and Col is 3 downto 0
           Button : out std_logic_vector (3 downto 0)); -- button is the 4 bit combination of row and col
           
end KYPD;

architecture Behavioral of KYPD is
    signal ButtonSig : std_logic_vector (3 downto 0);
    signal Valid     :  std_logic; -- output 1 if the Row and Col are a valid digit, so there is only 1 button being pushed
    signal NoButton  :  std_logic; -- output 1 if there is no button being pushed

begin

   KYPDInput : process (RowCol)
        begin     
            case (RowCol) is
                when "00000000" => -- will store value of Button because there is no input
                    ButtonSig   <= "0000"; -- when no button has been pressed, dont really care what the button value for this one is
                    Valid       <= '0';
                    NoButton    <= '1';                 
                when "00010001" => 
                    ButtonSig   <= "0001"; -- Button 1
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00010010" => 
                    ButtonSig   <= "0010"; -- Button 2
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00010100" => 
                    ButtonSig   <= "0011"; -- Button 3
                    Valid       <= '1';
                    NoButton    <= '0';
                 when "00011000" => 
                    ButtonSig   <= "1010"; -- Button A
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00100001" => 
                    ButtonSig   <= "0100"; -- Button 4
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00100010" => 
                    ButtonSig   <= "0101"; -- Button 5
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00100100" => 
                    ButtonSig   <= "0110"; -- Button 6
                    Valid       <= '1';
                    NoButton    <= '0';
                when "00101000" => 
                    ButtonSig   <= "1011"; -- Button B
                    Valid       <= '1';
                    NoButton    <= '0';
                when "01000001" => 
                    ButtonSig   <= "0111"; -- Button 7
                    Valid       <= '1';
                    NoButton    <= '0';
                when "01000010" => 
                    ButtonSig   <= "1000"; -- Button 8
                    Valid       <= '1';
                    NoButton    <= '0';
                when "01000100" => 
                    ButtonSig   <= "1001"; -- Button 9
                    Valid       <= '1';
                    NoButton    <= '0';
                when "01001000" => 
                    ButtonSig   <= "1100"; -- Button C
                    Valid       <= '1';
                    NoButton    <= '0';
                when "10000001" => 
                    ButtonSig   <= "0000"; -- Button 0
                    Valid       <= '0'; -- set to 0 for this machine since we are limiting the inputs
                    NoButton    <= '0';
                when "10000010" => 
                    ButtonSig   <= "1111"; -- Button F
                    Valid       <= '1'; -- set to 0 for this machine since we are limiting the inputs
                    NoButton    <= '0';
                when "10000100" => 
                    ButtonSig   <= "1110"; -- Button E
                    Valid       <= '0'; -- set to 0 for this machine since we are limiting the inputs
                    NoButton    <= '0';
                when "10001000" => 
                    ButtonSig   <= "1101"; -- Button D
                    Valid       <= '0'; -- set to 0 for this machine since we are limiting the inputs
                    NoButton    <= '0';
                when others     => 
                    ButtonSig   <= "0000"; -- This value for button does not matter since it is not a valid input
                    Valid       <= '0';
                    NoButton    <= '0'; 
            end case;
    end process;
    
    FourDigitFlop : process (CLK, ButtonSig, Valid, NoButton, RST) -- 4 bit flop to deal with no valid inputs and where there is no button being pushed
    begin
        if (RST = '0') then -- asynchronous reset
            Button <= "0000"; -- reset Button to default value, which is 0000
        elsif (rising_edge(CLK)) then
            if (Valid = '1') then
                Button <= ButtonSig; -- Button will store the value
            end if; -- if valid = 0 then Button will retain its value
        end if;  
    end process;   
end Behavioral;
