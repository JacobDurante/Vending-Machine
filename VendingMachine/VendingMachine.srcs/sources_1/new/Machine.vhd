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
    Port ( RowCol         : in STD_LOGIC_VECTOR (7 downto 0); -- 8 bit, 7-4 is Row, 3-0 is Col
           CLK            : in std_logic;
           RequestChange  : in std_logic; -- Change is an asynchronous reset
           MoneyIn        : in std_logic_vector (3 downto 0); -- money inputed, 3 is Dollar, 2 is Quarter, 1 is Dime, 0 is Nickle
           Change         : out signed (8 downto 0); -- amount that you have paid or change back
           DP             : out std_Logic; -- Decimal Point
           Selection      : out std_logic_vector (7 downto 0); -- section for vending machine, 7-4 is Row, 3-0 is Col
           Anode          : out STD_LOGIC_VECTOR (3 downto 0);
           Cathode        : out STD_LOGIC_VECTOR (6 downto 0));
           
            
end Machine;

architecture Behavioral of Machine is

    Signal NS, PS     : std_logic_vector (1 downto 0) := "00";
    Signal Button     : std_logic_vector (3 downto 0);
    Signal StartBus   : std_logic;
    Signal EndBus     : std_logic;
    signal Paid       : signed (8 downto 0); -- amount that has been paid
    signal Price      : signed (8 downto 0) := "010010110"; -- assign fixed price of $1.50, 010010110 = 1500
    Signal ChangeBack : signed (8 downto 0); -- signal for the Change
    
    component SevenSegmentDisplay Port ( InputPrice   : in signed (8 downto 0); -- This will need to be updated
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
    
    component Payment Port ( Money  : in std_logic_vector (3 downto 0); -- 3 is Dollars, 2 is Quarters, 1 is Dimes, 0 is Nickles
                             Paid    : out signed (8 downto 0);
                             Change : out signed (8 downto 0));
    end component;
    
begin
    --Price <= "010010110";
    -- updates the present state on the clock edges
    state : process (CLK, RequestChange)
    begin
        if (rising_edge(ClK)) then
            PS <= NS;
        end if;
    end process;
    
    -- Ports the KYPD module, sending the output from the KYPD module to the Button
    ButtonRegister : KYPD port map (
        CLK    => CLK,
        RST    => RequestChange,
        RowCol => RowCol,
        Button => Button);
        
    -- Ports the SevenSegmentDisplay module, sending the selection and Difference in Price    
    Display : SevenSegmentDisplay port map ( -- This Will need to be updated
        InputPrice   => Price,
        CLK     => CLK,
        DP      => DP,
        Anode   => Anode,
        Cathode => Cathode);
    
    -- Ports the Payment module, sending the output from the module to the Dif signal 
    AmountPaid : Payment port map (
        Money  => MoneyIn,
        Paid    => Paid,
        Change => ChangeBack);
        
        
 logic : process (PS, RequestChange, MoneyIn, Paid, Button)
    variable SelectedChoice : std_logic_vector (7 downto 0) := "11111111";
    variable count : unsigned (31 downto 0) := "00000000000000000000000000000000";
    begin
        case (PS) is
            when "00" => -- state 0
                case (MoneyIn) is 
                    when "0000" => NS <= "00";
                    when "0001" => NS <= "01";
                    when "0010" => NS <= "01";
                    when "0100" => NS <= "01";
                    when "1000" => NS <= "01";
                    when others => NS <= "00";    
                end case;
            when "01" => -- state 1
                if (RequestChange = '1') then
                    NS <= "11";
                elsif (RequestChange = '0' and Paid = Price) then
                    NS <= "10";
                elsif (RequestChange = '0' and Paid < Price) then
                    NS <= "01";
                elsif (RequestChange = '0' and Paid > Price) then
                    NS <= "10";
                end if;
            when "10" => -- state 2 
                case (Button) is -- choosing Button: A, B, or C
                    when "1010" => -- Button A
                        case (Button) is -- Choosing Button: 1, 2, or 3
                            when "0001" => -- Button 1
                                SelectedChoice := "10100001";
                            when "0010" => -- Button 2
                                SelectedChoice := "10100010";
                            when "0011" => -- Button 3
                                SelectedChoice := "10100011";
                            when others => -- dealing with other cases
                                SelectedChoice := "00000000";
                        end case;
                    when "1011" => -- Button B
                        case (Button) is -- Choosing Button: 4, 5, or 6
                            when "0100" => -- Button 4
                                SelectedChoice := "10110100";
                            when "0101" => -- Button 5
                                SelectedChoice := "10110101";
                            when "0110" => -- Button 6
                                SelectedChoice := "10110110";
                            when others => -- dealing with other cases
                                SelectedChoice := "00000000";
                        end case;
                    when "1100" => -- Button C
                        case (Button) is -- Choosing Button: 7, 8, or 9
                            when "0111" => -- Button 7
                                SelectedChoice := "11000111";
                            when "1000" => -- Button 8
                                SelectedChoice := "11001000";
                            when "1001" => -- Button 9
                                SelectedChoice := "11001001";
                            when others => -- dealing with other cases
                                SelectedChoice := "00000000";
                        end case;
                    when others => -- dealing with other cases
                        SelectedChoice := "00000000";
                    end case;
                    -- 3 second counter
                    if (count = "00001000111100110001110000000110") then
                        NS <= "11";
                        Selection <= SelectedChoice;
                        count := "00000000000000000000000000000000";
                    else
                        count := count + 1;
                        NS <= "10";
                    end if;
            when "11" => -- state 3
             -- 3 second counter
                if (count = "00001000111100110001110000000110") then
                    NS <= "00";
                    Change <= ChangeBack;
                    count := "00000000000000000000000000000000";
                else
                    count := count + 1;
                    NS <= "11";
                end if;
            when others =>
                NS <= "00";
        end case;
    end process;

end Behavioral;
