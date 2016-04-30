
#include "wav.h"

uint16_t getTitels(FIL * file, char ** titels, uint16_t maxTitels)
{

	uint16_t teller = 0;
	char buffer[100];

	// We proberen de file met de titels te openen op de sd-kaart
	probeer(f_open(file, "titels.txt",FA_READ),"open titels.txt");

	// Nu lezen we alle lijnen met titles in de file
	while(f_eof(file) == 0)
	{
		f_gets(buffer, sizeof(buffer),file);     // We lezen 1 lijn
		titels[teller] = (char *) malloc(strlen(buffer));		// We zoeken wat plaats voor de nieuwe titel
		strcpy(titels[teller],buffer);		// We zetten de titel mee in de array
		
		if(teller > maxTitels) break;		// Als we het max aantal titels gelezen hebben, moeten we zeker stoppen

		teller ++;
	}

	f_close(file);

	return teller;
}

