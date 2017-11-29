----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/27/2017 09:03:06 AM
-- Design Name: 
-- Module Name: Machine - Behavioral
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

entity Machine is -- Top level state machine
    Port ( RowCol  : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bit, 7-4 is Row, 3-0 is Col
           CLK     : in std_logic;
           Change  : in std_logic; -- Change is an asynchronous reset
           Payment : in std_logic_vector (4 downto 0);
           --Price : out std_logic_vector (15 downto 0); -- Digit3: 15-12, Digit2: 11-8, Digit1: 7-4, Digit0: 3-0
           DP      : out std_Logic;
           Anode   : out STD_LOGIC_VECTOR (3 downto 0);
           Cathode : out STD_LOGIC_VECTOR (6 downto 0));
           
            
end Machine;

architecture Behavioral of Machine is

    Signal NS, PS : std_logic_vector (1 downto 0) := "00";
    Signal Button : std_logic_vector (3 downto 0);
    Signal Price  : std_logic_vector (15 downto 0); -- Digit3: 15-12, Digit2: 11-8, Digit1: 7-4, Digit0: 3-0
    
    component SevenSegmentDisplay Port ( Price   : in STD_LOGIC_VECTOR (15 downto 0);
                                         CLK     : in STD_LOGIC;
                                         DP      : out std_Logic;
                                         Anode   : out STD_LOGIC_VECTOR (3 downto 0);
                                         Cathode : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    
    component KYPD Port ( CLK    : in std_logic;
                          RST    : in std_logic; -- asynchronous reset
                          RowCol : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bit input, Row is 7 downto 4 and Col is 3 downto 0
                          Button : out std_logic_vector (3 downto 0)); -- button is the 4 bit combination of row and col
    end component;
    
begin

    state : process (CLK, Change)
    begin
        if (Change = '1') then
            PS <= "00";
        elsif (rising_edge(ClK)) then
            PS <= NS;
        end if;
    end process;
    
    ButtonRegister : KYPD port map (
        CLK    => CLK,
        RST    => Change,
        RowCol => RowCol,
        Button => Button);
        
    PriceDisplay : SevenSegmentDisplay port map (
        Price   => Price,
        CLK     => CLK,
        DP      => DP,
        Anode   => Anode,
        Cathode => Cathode);
        
--    logic : process (PS)
        
--    begin
    
--    end process;

end Behavioral;
