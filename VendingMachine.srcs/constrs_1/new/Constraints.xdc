set_property PACKAGE_PIN W5 [get_ports {CLK}]
set_property IOSTANDARD LVCMOS33 [get_ports {CLK}]
create_clock -period 10.00 -name CLK -waveform {0 5} - add [get_ports {CLK}]

set_property PACKAGE_PIN C16 [get_ports {RowCol[7]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[7]}]

set_property PACKAGE_PIN C15 [get_ports {RowCol[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[6]}]

set_property PACKAGE_PIN A17 [get_ports {RowCol[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[5]}]

set_property PACKAGE_PIN A15 [get_ports {RowCol[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[4]}]

set_property PACKAGE_PIN B16 [get_ports {RowCol[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[3]}]

set_property PACKAGE_PIN B15 [get_ports {RowCol[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[2]}]

set_property PACKAGE_PIN A16 [get_ports {RowCol[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[1]}]

set_property PACKAGE_PIN A14set_property PACKAGE_PIN T18 [get_ports {MoneyIn[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MoneyIn[3]}]

set_property PACKAGE_PIN W19 [get_ports {MoneyIn[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MoneyIn[2]}]

set_property PACKAGE_PIN U17 [get_ports {MoneyIn[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MoneyIn[1]}]

set_property PACKAGE_PIN T17 [get_ports {MoneyIn[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {MoneyIn[0]}] [get_ports {RowCol[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RowCol[0]}]



set_property PACKAGE_PIN U18 [get_ports {RequestChange}]
set_property IOSTANDARD LVCMOS33 [get_ports {RequestChange}]

set_property PACKAGE_PIN L1 [get_ports {testSelection[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[5]}]

set_property PACKAGE_PIN P1 [get_ports {testSelection[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[4]}]

set_property PACKAGE_PIN N3 [get_ports {testSelection[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[3]}]

set_property PACKAGE_PIN P3 [get_ports {testSelection[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[2]}]

set_property PACKAGE_PIN U3 [get_ports {testSelection[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[1]}]

set_property PACKAGE_PIN W3 [get_ports {testSelection[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testSelection[0]}]

set_property PACKAGE_PIN U19 [get_ports {testChange[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testChange[2]}]

set_property PACKAGE_PIN E19 [get_ports {testChange[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testChange[1]}]

set_property PACKAGE_PIN U16 [get_ports {testChange[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {testChange[0]}]

