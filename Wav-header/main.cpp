#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void getData(FILE * fp, char data[],int aantal);

int main()
{

    FILE * file;

    if((file = fopen("muziek.wav","r")) == NULL)     // file openen in read mode
    {
        printf("Bestand kan niet worden geopend.\n");
        exit(2);
    }

    char array[255];

    getData(file,array,255);
    getData(file,array,255);

    fclose(file);           // file afsluiten

    return 0;
}

//
//  We gaan data opvragen uit de wav file
//
void getData(FILE * fp, char data[],int aantal)
{
    int teller = 0;
    static bool dataGevonden = 0;

    char byte;
    char keyword[4];

    // eerst moeten we de header over springen tot aan de data chunck

    while((byte = fgetc(fp)) != EOF)            // we lezen tot aan het einde van de file
    {
        if(!dataGevonden)                       // Kijken of we de data header al gevonden hadden
        {
            if(byte == 'd')         // we hebben een d gevonden, nu zoeken we naar "ata" van data
            {
                fgets(keyword,4,fp);
                if(strcmp(keyword,"ata") == 0)
                {
                    dataGevonden = 1;
                    for(int i=0; i<4;i++)
                    {
                        fgetc(fp);          // De volgende 4 bytes zijn nog onbelangrijk
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
                return;
            }
        }
    }
}