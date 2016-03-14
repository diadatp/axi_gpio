#include <stdio.h>

#define AXI_GPIO_BASE_ADDRESS 0x00000000;

#include "axi_gpio.h"

int main(int argc, char* argv[]){
	
	while (1) {
		axi_gpio_ddr(0, 0xFFFFFFFF);
		axi_gpio_write(1, axi_gpio_read(0));
	}
	return 0;
}

