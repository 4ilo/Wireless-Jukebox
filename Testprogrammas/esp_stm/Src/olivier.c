
#include "olivier.h"

char uartRxData;
int bestSong;
uint8_t UartRxSucces = 0;

//
//	Stuurt een welkom message naar de computer over uart
//
void sendWelkom(void)
{
	char welkomText[40] = {"Wireless Jukebox v1.0 - Hoofdmodule\n"};
	HAL_UART_Transmit(&huart2,(uint8_t *)welkomText,strlen(welkomText),10);
}


//
//	Set een song op de esp-module
//
void setSong(uint8_t nummer, const char* titel)
{
	char buffer[100];
	sprintf(buffer,"setSong(%d,'%s')\n",nummer,titel);
	HAL_UART_Transmit(&huart2,(uint8_t *)buffer,strlen(buffer),10);
}

//
//	Get het meest gestemde liedje op de esp
//
char getBest(void)
{
	char buffer[100];
	sprintf(buffer,"getBest()\n");

	UartRxSucces = 0;		// We zetten de indicator op 0;
	HAL_UART_Transmit(&huart2,(uint8_t *)buffer,strlen(buffer),10);
	HAL_UART_Receive_IT(&huart2,&uartRxData,1);

	while(uartRxData == 0);
	//return bestSong;
	return uartRxData;

}

void HAL_UART_RxCpltCallback(UART_HandleTypeDef *huart)
{
	if(huart->Instance == USART2)
	{
		UartRxSucces = 1;
		//bestSong = atoi(uartRxData);
	}
}

