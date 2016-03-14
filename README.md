# axi_gpio

AXI based GPIO peripheral for Xilinx devices. Input is latched at the rising edge of the AXI input clock.

## The Registers

The GPIO pins have three registers used to control the GPIO function and set/read the value of a pin. These are:

Data Direction Register
Output Data Register
Input Data Register

The following sections provide a brief description of the registers.

### GPIOx_DDR Data Direction Register

This register determines which of the GPIO pins are outputs and which are inputs.
A value of zero in a bit sets a port line to output and one sets the port line to input.
You can set the value of the whole register or each individual bit in the register by first reading and then masking.

### GPIOx_IN/OUT – Input/Output Data Registers

These two registers allow you to read the value of an input pin and set the value of an output pin.
Writes to the data in register will be accepted but not fulfiled.

