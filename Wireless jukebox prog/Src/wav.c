
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


//
//  We gaan data opvragen uit de wav file
//
uint8_t getData(FIL * fp, char data[],int aantal)
{
    int teller = 0;
    static uint8_t dataGevonden = 0;

    char byte;
    uint8_t bytesRead;

    uint16_t i;

    // eerst moeten we de header over springen tot aan de data chunck

    while(f_eof(fp) == 0)            // we lezen tot aan het einde van de file
    {
    	f_read(fp,&byte,1 * sizeof(char),(UINT*)&bytesRead);
        if(dataGevonden == 0)                       // Kijken of we de data header al gevonden hadden
        {
            if(byte == 'd')         // we hebben een d gevonden, nu zoeken we naar "ata" van data
            {
                //fgets(keyword,4,fp);
            	f_read(fp,&byte,1 * sizeof(char),(UINT*)&bytesRead);
                if(byte == 'a')
                {
                    dataGevonden = 1;

                    for(i=0; i<6;i++)
                    {
                    	f_read(fp,&byte,1 * sizeof(char),(UINT*)&bytesRead);  // De volgende 6 bytes zijn nog onbelangrijk
                    }
                }
            }
        }
        else                                // de data header is gevonden, vanaf nu komt de data
        {
            data[teller] = byte;            // We slagen het aantal gevraagde databytes op in de array
            teller ++;
            if(teller == aantal)
            {
                return 0;
            }
        }
    }
    return 1;
}
