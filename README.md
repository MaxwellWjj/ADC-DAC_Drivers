# ADC-DAC_Drivers
Drivers of some ADC &amp; DAC, coding with verilog/system verilog
## 感谢
这些驱动其实是很多人的，并不是全部我自己原创的，都是HUST电工基地的小伙伴们智慧的结晶。
## Overview
These drivers had been implementated in Xilinx Artix-7 & Zynq-7020 borad. Thus, they are all useful.
## In Detail
1. Named with "_Highest" means this driver can be used in their highest sampling rate(such as DAC8811, highest ope frequency is about 3MHz.)
2. Named with "axis_" means this driver has an AXI4-Stream Communication protocol(u can Refer to some user guide of Xilinx), ADC is Master, DAC is Slave.
3. What's more, "Rising2En.sv" is a based module which provides a "change signal rising to a clock enable" feature.
