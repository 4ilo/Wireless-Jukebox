
#include "stm32f4xx_hal.h"
#include <string.h>
#include <stdlib.h>

// Deze typedefs worden gemaakt in de main

extern UART_HandleTypeDef huart2;
extern UART_HandleTypeDef huart6;

void sendWelkom(void);
void setSong(uint8_t nummer, const char* titel);
int8_t getBest(void);
