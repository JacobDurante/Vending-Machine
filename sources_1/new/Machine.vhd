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
           DP             : out std_Logic; -- Decimal Point
           Anode          : out STD_LOGIC_VECTOR (3 downto 0);
           Cathode        : out STD_LOGIC_VECTOR (6 downto 0));
--           testSelection : out std_logic_vector (5 downto 0); -- testing the selection state, each bit will be assigned to a LED
--           testChange    : out std_logic_vector (2 downto 0)); -- testing the payment selection state, each bit will be assigned to a LED
           
            
end Machine;

architecture Behavioral of Machine is

    Signal NS, PS     : std_logic_vector (1 downto 0) := "00";
    Signal Button     : std_logic_vector (3 downto 0);
    Signal StartBus   : std_logic_vector (2 downto 0);
    Signal EndBus     : std_logic_vector (2 downto 0);
    signal NextBus    : std_logic_vector (2 downto 0);
    Signal StartCount : std_logic;
    Signal EndCount   : std_logic;
    signal PulseOut   : std_logic_vector (3 downto 0);
    Signal Selection  : std_logic_vector (7 downto 0); -- selection for vending machine, 7-4 is Row, 3-0 is Col
    Signal Change     : signed (8 downto 0); -- amount that you have paid or change back
    signal Paid       : signed (8 downto 0); -- amount that has been paid
    signal Price      : signed (8 downto 0) := "010010110"; -- assign fixed price of $1.50, 010010110 = 1500
    Signal ChangeBack : signed (8 downto 0); -- signal for the Change
    Signal RSTPay     : signed (8 downto 0); -- resets the payment when going from state 11 to 00
    
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
                             RSTPay : in signed (8 downto 0);
                             Paid   : out signed (8 downto 0);
                             Change : out signed (8 downto 0));
    end component;
    
--    component ThreeSecCounter Port ( CLK   : in STD_LOGIC;
--                                    Start : in STD_LOGIC;
--                                    Stop  : out STD_LOGIC);
--    end component;
    
    component Debounce Port ( CLK     : in std_logic;
                              Reset     : in std_logic;
                              button_in : in std_logic_vector (3 downto 0);
                              pulse_out : out std_logic_vector (3 downto 0));
    end component;
begin
    --Price <= "010010110";
    -- updates the present state on the clock edges
    state : process (CLK)
    begin
        if (rising_edge(ClK)) then
            PS <= NS;
            StartBus <= NextBus;
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
        InputPrice   => ChangeBack,
        CLK     => CLK,
        DP      => DP,
        Anode   => Anode,
        Cathode => Cathode);
    
    -- Ports the Payment module, sending the output from the module to the Dif signal 
    AmountPaid : Payment port map (
        Money  => PulseOut,
        RSTPay => RSTPay,
        Paid   => Paid,
        Change => ChangeBack);
        
--    Counter : ThreeSecCounter port map (
--        CLK   => CLK,
--        Start => StartCount,
--        Stop  => EndCount);
     
     -- Ports the buttons to the debounce
     ButtonDebounce : Debounce port map (
        CLK => CLK,
        Reset => RequestChange,
        button_in => MoneyIn,
        pulse_out => PulseOut);
        
        

        
    logic : process (PS, RequestChange, PulseOut, Paid, StartCount, EndCount, StartBus)
    variable count : unsigned (31 downto 0) := "00000000000000000000000000000000";
    begin
        case (PS) is
            when "00" => -- state 0
                case (PulseOut) is
                    when "0000" => NS <= "00";
                    when "0001" => NS <= "01";
                    when "0010" => NS <= "01";
                    when "0100" => NS <= "01";
                    when "1000" => NS <= "01";
                    when others => NS <= "00";    
                end case;
            when "01" => -- state 1
--            testChange <= "000";
                if (RequestChange = '1') then
                    NS <= "11";
--                    testChange <= "000";
                elsif (RequestChange = '0' and Paid = Price) then
                    NS <= "10";
--                    testChange <= "010";
                elsif (RequestChange = '0' and Paid < Price) then
                    NS <= "01";
--                    testChange <= "001";
                elsif (RequestChange = '0' and Paid > Price) then
                    NS <= "10";
--                    testChange <= "100";
                end if;
            when "10" => -- state 2 
                
                case (Button) is
                    when "1010" => -- Button A
                        NextBus <= "001";
                    when "1011" => -- Button B
                        NextBus <= "010";
                    when "1100" => -- Button C
                        NextBus <= "100";
                    when others =>
                        NS <= "10";
                end case;
                
                if (EndBus = "000") then 
                    NS <= "11";
                elsif (RequestChange = '1') then
                    NS <= "11";
                else
                    NS <= "10";
                end if;
            when "11" => -- state 3
                StartCount <= '1';
                    if (EndCount <= '1') then
                        NS <= "00";
                        StartCount <= '0';
                        RSTPay <= "000000000";
                    else
                        NS <= "11";
                    end if;
            when others =>
                NS <= "00";
        end case;
    end process;
    
    
     -- Logic for the selection substate   
    SelectionLogic : process (Button, StartBus)
    variable SelectedChoice : std_logic_vector (7 downto 0) := "00000000";
    variable Selected       : std_logic := '0';
    
        begin
        case (StartBus) is -- choosing Button: A, B, or C
            when "001" =>
                case (Button) is -- Choosing Button: 1, 2, or 3
                    when "0001" => -- Button 1
                        SelectedChoice := "10100001";
                        Selected := '1';
--                                testSelection <= "100100";
                    when "0010" => -- Button 2
                        SelectedChoice := "10100010";
                        Selected := '1';
--                                testSelection <= "100010";
                    when "0011" => -- Button 3
                        SelectedChoice := "10100011";
                        Selected := '1';
--                                testSelection <= "100001";
                    when others => -- dealing with other cases
                        SelectedChoice := "00000000";
                        Selected := '0';
                        NextBus <= "001";
--                                TestSelection <= "000000";
                    end case;
            when "010" =>
                case (Button) is -- Choosing Button: 4, 5, or 6
                    when "0100" => -- Button 4
                        SelectedChoice := "10110100";
                        Selected := '1';
--                                testSelection <= "010100";
                    when "0101" => -- Button 5
                        SelectedChoice := "10110101";
                        Selected := '1';
--                                testSelection <= "010010";
                    when "0110" => -- Button 6
                        SelectedChoice := "10110110";
                        Selected := '1';
--                                testSelection <= "010001";
                    when others => -- dealing with other cases
                        SelectedChoice := "00000000";
                        Selected := '0';
                        NextBus <= "010";
--                                testSelection <= "000000";
                    end case;
            when "100" =>
                case (Button) is -- Choosing Button: 7, 8, or 9
                    when "0111" => -- Button 7
                        SelectedChoice := "11000111";
                        Selected := '1';
--                                testSelection <= "001100";
                    when "1000" => -- Button 8
                        SelectedChoice := "11001000";
                        Selected := '1';
--                                testSelection <= "001010";
                    when "1001" => -- Button 9
                        SelectedChoice := "11001001";
                        Selected := '1';
--                                testSelection <= "001001";
                    when others => -- dealing with other cases
                        SelectedChoice := "00000000";
                        Selected := '0';
                        NextBus <= "100";
--                                testSelection <= "000000";
                    end case;
            when others => -- dealing with other cases
                NextBus <= "000";
--                        testSelection <= "000000";
            end case;   
            
        if (selected = '1') then
            if (StartCount = '1') then
                if (endCount <= '1') then
                    StartCount <= '0';
                    Selection <= SelectedChoice;
                    EndBus <= "000";
                end if;
            end if;
--            case (StartCount) is
--                when '1' =>
--                    if (EndCount <= '1') then
--                        StartCount <= '0';
--                        Selection <= SelectedChoice;
--                        EndBus <= "000";
--                    end if;
--                when others =>
--                    NextBus <= "000";
--            end case;
        end if;
    end process;
    
    ThreeSecCounter : process (CLK)
        variable count : unsigned (31 downto 0) := "00000000000000000000000000000000";
        begin
            if (StartCount = '1') then
                if (rising_edge(CLK)) then
                    if (count = "00001000111100110001110000000110") then
                        count := "00000000000000000000000000000000";
                            EndCount <= '1';
                    else
                        count := count + 1;
                            EndCount <= '0';
                    end if;
                end if;
            end if;
    end process;
    
end Behavioral;
