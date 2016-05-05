
#include "stm32f4xx_hal.h"
#include <string.h>
#include <stdlib.h>

// Deze typedefs worden gemaakt in de main
extern UART_HandleTypeDef huart1;
extern ADC_HandleTypeDef hadc1;

void setSong(uint8_t nummer, char titel[]);
int8_t getBest(void);
void randomNummers(uint8_t * selectedSongs, uint8_t aantalSongs);
void sendSongsToEsp(char * titels[], uint8_t selectedSongs[]);
