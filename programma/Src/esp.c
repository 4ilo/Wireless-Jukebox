
#include "esp.h"


//
//	Set een song op de esp-module
//
void setSong(uint8_t nummer, char titel[])
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

//
//	4 random nummers voor volgende stemming nemen
//
void randomNummers(uint8_t * selectedSongs, uint8_t aantalSongs)
{
	uint8_t temp = 0;
	uint8_t teller = 0;

	for (teller = 0; teller < 4; teller++)
	{
		selectedSongs[teller] = 5;
	}

	teller = 0;

	// we nemen 4 random nummers en slagen deze op, ze mogen niet dezelfde zijn
  	while(teller <= 4)
  	{
      	temp = rand() % aantalSongs;
      	if(temp != selectedSongs[0] && temp != selectedSongs[1] && 
      		temp != selectedSongs[2] && temp != selectedSongs[3] && temp <= aantalSongs-1)
      	{
      		selectedSongs[teller] = temp;
      		teller++;
      	}
      	
  	}
}

//
//	We sturen de 4 titels naar de esp
//
void sendSongsToEsp(char * titels[], uint8_t selectedSongs[])
{
	uint8_t teller = 0;
	// We sturen 4 liedjes naar de esp
  	for(teller = 0; teller<4; teller++)
  	{
    	setSong(1,titels[selectedSongs[0]]);
    	setSong(2,titels[selectedSongs[1]]);
    	setSong(3,titels[selectedSongs[2]]);
    	setSong(4,titels[selectedSongs[3]]);
    	HAL_Delay(100);
  	}
}
