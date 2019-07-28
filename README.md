# ADC-DAC_Drivers
Drivers of some ADC &amp; DAC, coding with verilog/system verilog
## Overview
These drivers had been implementated in Xilinx Artix-7 & Zynq-7020 borad. Thus, they are all useful.
## In Detail
1. Named with "_Highest" means this driver can be used in their highest sampling rate(such as DAC8811, highest ope frequency is about 3MHz.)
2. Named with "axis_" means this driver has an AXI4-Stream Communication protocol(u can Refer to some user guide of Xilinx), ADC is Master, DAC is Slave.
