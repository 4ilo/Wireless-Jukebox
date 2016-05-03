
#include "esp.h"


//
//	Set een song op de esp-module
//
void setSong(uint8_t nummer, const char* titel)
{
	char buffer[100];
	sprintf(buffer,"setSong(%d,'%s')\n",nummer,titel);
	HAL_UART_Transmit(&huart1,(uint8_t *)buffer,strlen(buffer),10);
}

//
//	Get het meest gestemde liedje op de esp
//	Returnt het meest gestemde lied of -1 bij een fout
//
int8_t getBest(void)
{
	char buffer[100];
	char Rx_Data[5] = {0};

	sprintf(buffer,"getBest()\n");

	// We sturen eerst het commando en krijgen de data terug in ascci
	HAL_UART_Transmit(&huart1,(uint8_t *)buffer,strlen(buffer),10);
	HAL_UART_Receive(&huart1,(uint8_t *)Rx_Data,4,500);

	// Omzetten en controleren van het ascci nummer
	int8_t best = Rx_Data[1] - '0';
	if(best == 1 || best == 2 || best == 3 || best == 4) return best;
	return -1;

}