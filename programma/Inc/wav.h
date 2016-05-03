
#include "fatfs.h"
#include <string.h>
#include <stdlib.h>


uint16_t getTitels(FIL * file, char ** titels, uint16_t maxTitels);
uint8_t getData(FIL * fp, char data[],int aantal);
void startPwm(void);
void stopPwm(void);

extern UART_HandleTypeDef huart2;           // De uart typedef in de main
extern TIM_HandleTypeDef htim3;
extern TIM_HandleTypeDef htim4;
