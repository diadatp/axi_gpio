#ifndef AXI_GPIO_H
#define AXI_GPIO_H

/**
 *
 * Read a value from the GPIO port.
 *
 * @param   Channel is the selector between GPIO0 and GPIO1.
 *
 * @return  The read data.
 *
 */
#define axi_gpio_read(Channel) (*(volatile uint32_t *) ((AXI_GPIO_BASE_ADDRESS) + (12 * (Channel))))

/**
 *
 * Write a value to the GPIO port.
 *
 * @param   Channel is the selector between GPIO0 and GPIO1.
 * @param   Data is the data to be written.
 *
 * @return  none
 *
 */
 #define axi_gpio_write(Channel, Data) (*(volatile uint32_t *) ((AXI_GPIO_BASE_ADDRESS) + (12 * (channel)) + 4)) = Data
 
 /**
 *
 * Sets the Data Direction Register for the given channel.
 *
 * @param   Channel is the selector between GPIO0 and GPIO1.
 * @param   DDR is the value to be put inside the data direction register.
 *
 * @return  none
 *
 */
 #define axi_gpio_ddr(Channel, DDR) (*(volatile uint32_t *) ((AXI_GPIO_BASE_ADDRESS) + (12 * (channel)) + 8)) = DDR

#endif // AXI_GPIO_H
