@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 7c89689237c44d4980330852a7660c71 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot Machine_behav xil_defaultlib.Machine -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
