----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/28/2017 03:46:40 PM
-- Design Name: 
-- Module Name: KYPDSim - Behavioral
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

entity KYPDSim is
--  Port ( );
end KYPDSim;

architecture Behavioral of KYPDSim is

    component KYPD
        Port ( CLK    : in std_logic;
               RST    : in std_logic; -- asynchronous reset
               RowCol : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bit input, Row is 7 downto 4 and Col is 3 downto 0
               Button : out std_logic_vector (3 downto 0)); -- button is the 4 bit combination of row and col
    end component;
    signal CLK, RST : std_logic;
    signal RowCol   : std_logic_vector (7 downto 0);
    signal Button   : std_logic_vector (3 downto 0);

begin
    UUT : KYPD port map (
        CLK    => CLK,
        RST    => RST,
        RowCol => RowCol,
        Button => Button);
        
        clock : process begin
            CLK <= '0';
            wait for 10 ns;
            CLK <= '1';
            wait for 10 ns;
        end process;
        
        selection : process begin
            RowCol <= "00000000";  -- will store value of Button because there is no input  
            wait for 30 ns;
            RowCol <= "00010001";  -- Button 1
            wait for 30 ns;
            RowCol <= "00010010";  -- Button 2
            wait for 30 ns;
            RowCol <= "00010100";  -- Button 3
            wait for 30 ns;
            RowCol <= "00011000";  -- Button A
            wait for 30 ns;
            RowCol <= "00100001";  -- Button 4
            wait for 30 ns;
            RowCol <= "00100010";  -- Button 5
            wait for 30 ns;
            RowCol <= "00100100";  -- Button 6
            wait for 30 ns;
            RowCol <= "00101000";  -- Button B
            wait for 30 ns;
            RowCol <= "01000001";  -- Button 7
            wait for 30 ns;
            RowCol <= "01000010";  -- Button 8
            wait for 30 ns;
            RowCol <= "01000100";  -- Button 9
            wait for 30 ns;
            RowCol <= "01001000";  -- Button C
            wait for 30 ns;
            RowCol <= "10000001";  -- Button 0
            wait for 30 ns;
            RowCol <= "10000010";  -- Button F
            wait for 30 ns;
            RowCol <= "10000100";  -- Button E
            wait for 30 ns;
            RowCol <= "10001000";  -- Button D
            wait for 30 ns;
            RowCol <= "11111111";
            wait for 30 ns;
            RowCol <= "00000000";
            wait;
                            
    end process;
end behavioral;