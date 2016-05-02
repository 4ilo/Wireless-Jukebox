/**
  ******************************************************************************
  * @file   fatfs.c
  * @brief  Code for fatfs applications
  ******************************************************************************
  *
  * COPYRIGHT(c) 2016 STMicroelectronics
  *
  * Redistribution and use in source and binary forms, with or without modification,
  * are permitted provided that the following conditions are met:
  *   1. Redistributions of source code must retain the above copyright notice,
  *      this list of conditions and the following disclaimer.
  *   2. Redistributions in binary form must reproduce the above copyright notice,
  *      this list of conditions and the following disclaimer in the documentation
  *      and/or other materials provided with the distribution.
  *   3. Neither the name of STMicroelectronics nor the names of its contributors
  *      may be used to endorse or promote products derived from this software
  *      without specific prior written permission.
  *
  * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
  * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
  * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
  * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
  * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
  * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  ******************************************************************************
  */

#include "fatfs.h"

uint8_t retSD;    /* Return value for SD */
char SD_Path[4];  /* SD logical drive path */

/* USER CODE BEGIN Variables */

/* USER CODE END Variables */    

void MX_FATFS_Init(void) 
{
  /*## FatFS: Link the SD driver ###########################*/
  retSD = FATFS_LinkDriver(&SD_Driver, SD_Path);

  /* USER CODE BEGIN Init */
  
  uint8_t result;
  char buffer[50];

  if((result = f_mount(&SDFatFs, (TCHAR const*)SD_Path, 1)) != 0)
  {
    sprintf(buffer,"Mounten van sd mislukt met code: %d\n",result);
    errorHandler(buffer,strlen(buffer));
  }

  /* USER CODE END Init */
}

/**
  * @brief  Gets Time from RTC 
  * @param  None
  * @retval Time in DWORD
  */
DWORD get_fattime(void)
{
  /* USER CODE BEGIN get_fattime */
  return 0;
  /* USER CODE END get_fattime */  
}

/* USER CODE BEGIN Application */

//
//  Handelen van de error
//  We sturen een boodschap over de uart en toggelen een rood lampje aan
//
void errorHandler(char * buffer, uint8_t len)
{
  MX_FatFs_Unmount();
  while(1)
  {
    // Hier zitten we vast
    HAL_Delay(3000);
    HAL_UART_Transmit(&huart2,(uint8_t*)buffer,len,10);
  }
}

//
//  Unmount de sd-kaart
//  Returnt 0 als correct, anders 1
//
uint8_t MX_FatFs_Unmount(void)
{
  return FATFS_UnLinkDriver(SD_Path);
}


//
//  De filestructuur van de sd kaart opvragen
//
FRESULT scan_files(char * path)
{
  FRESULT res;
  FILINFO fileInfo;
  DIR dir;
  uint8_t teller = 0;
  char * fileName;
  char buffer[20];

  char bestanden[100][20];    // Array om alle bestandsnamen op te slaan

  if((res = f_opendir(&dir, path)) == FR_OK)  // de directory openen op de schijf
  {
    while(1)
    {
      res = f_readdir(&dir,&fileInfo);
      if((res != FR_OK) || (fileInfo.fname[0] == 0))
      {
        //bestanden[teller] = 0;
        strcpy(bestanden[teller],"0");
        break;          // break op einde
      }
      if(fileInfo.fname[0] == '.') continue;            // Een punt negeren

      fileName = fileInfo.fname;

      if(!(fileInfo.fattrib & AM_DIR))      // Kijken of het een bestand is(geen map)
      {
        strcpy(bestanden[teller],fileName);
        //sprintf(buffer,"%s\n",fileName);
        //HAL_UART_Transmit(&huart2,(uint8_t*)buffer,strlen(buffer),10);
        teller ++;
      }
      else    // Hier is het een map
      {
        //sprintf(buffer,"/%s\n",fileName);
        //HAL_UART_Transmit(&huart2,(uint8_t*)buffer,strlen(buffer),10);
      }

    }
  }

  teller = 0;

  while(strcmp(bestanden[teller],"0") != 0)
  {
    sprintf(buffer,"%s\n",bestanden[teller]);
    HAL_UART_Transmit(&huart2,(uint8_t*)buffer,strlen(buffer),10);
    teller++;
  }

  return res;

}

//
//  Probeer een functie uit te voeren.
//  Bij mislukken wordt een error bericht op uart gezet, en rood flikkert
//
void probeer(FRESULT status, char * message)
{
  char buffer[50];

  if(status != FR_OK)
  {
    sprintf(buffer,"%s is gestopt met code: %d\n",message,status);
    errorHandler(buffer,strlen(buffer));
  }
}
     
/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
