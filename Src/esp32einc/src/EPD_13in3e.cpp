/*****************************************************************************
* | File        :   EPD_12in48.c
* | Author      :   Waveshare team
* | Function    :   Electronic paper driver
* | Info     :
*----------------
* | This version:   V1.0
* | Date     :   2018-11-29
* | Info     :
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documnetation files(the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to  whom the Software is
# furished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS OR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#
******************************************************************************/
#include "EPD_13in3e.h"
#include "Debug.h"


// const UBYTE spiCsPin[2] = {
// 		SPI_CS0, SPI_CS1
// };
const UBYTE PSR_V[2] = {
	0xDF, 0x69
};
const UBYTE PWR_V[6] = {  //Настраивает уровни напряжения 
	0x0F, 0x00, 0x28, 0x2C, 0x28, 0x38
};
const UBYTE POF_V[1] = {
	0x00
};
const UBYTE DRF_V[1] = { //Display Refresh
	0x00
};
const UBYTE CDI_V[1] = { //время удержания изображения.
	0xF7
};
const UBYTE TCON_V[2] = { //Настраивает тайминги сигналов управления:
	0x03, 0x03
};
const UBYTE TRES_V[4] = { //Задает разрешение дисплея: 0x04B0 = 1200 пикселей (высота).  0x0320 = 800 пикселей (ширина).
	0x04, 0xB0, 0x03, 0x20
};
const UBYTE CMD66_V[6] = {
	0x49, 0x55, 0x13, 0x5D, 0x05, 0x10
};
const UBYTE EN_BUF_V[1] = {
	0x07
};
const UBYTE CCSET_V[1] = {  //Настраивает режим работы чипа (например, выбор интерфейса SPI/I2C).
	0x01
};
const UBYTE PWS_V[1] = { 
	0x22
};
const UBYTE AN_TM_V[9] = {  //Длительность импульсов для заряда/разряда пикселе
	0xC0, 0x1C, 0x1C, 0xCC, 0xCC, 0xCC, 0x15, 0x15, 0x55
};

const UBYTE SPIM_V[1] = {
    0x10    };

const UBYTE AGID_V[1] = {
	0x10
};

const UBYTE BTST_P_V[2] = {
    0xD8, 0x18//0xE8, 0x28
};
const UBYTE BOOST_VDDP_EN_V[1] = {
	0x01
};
const UBYTE BTST_N_V[2] = {
	0xD8, 0x18//0xE8, 0x28
};
const UBYTE BUCK_BOOST_VDDN_V[1] = {
	0x01
};
const UBYTE TFT_VCOM_POWER_V[1] = {  //VCOM Power Control Настраивает источник опорного напряжения VCOM
	0x02
};


static void EPD_13IN3E_CS_ALL(UBYTE Value)
{
    DEV_Digital_Write(EPD_CS_M_PIN, Value);
    DEV_Digital_Write(EPD_CS_S_PIN, Value);
}


static void EPD_13IN3E_SPI_Sand(UBYTE Cmd, const UBYTE *buf, UDOUBLE Len)
{
    DEV_SPI_WriteByte(Cmd);
    DEV_SPI_Write_nByte((UBYTE *)buf,Len);
}


/******************************************************************************
function :	Software reset
parameter:
******************************************************************************/
static void EPD_13IN3E_Reset(void)
{
    DEV_Digital_Write(EPD_RST_PIN, 1);
    DEV_Delay_ms(30);
    DEV_Digital_Write(EPD_RST_PIN, 0);
    DEV_Delay_ms(30);
    DEV_Digital_Write(EPD_RST_PIN, 1);
    DEV_Delay_ms(30);
    DEV_Digital_Write(EPD_RST_PIN, 0);
    DEV_Delay_ms(30);
    DEV_Digital_Write(EPD_RST_PIN, 1);
    DEV_Delay_ms(30);
}

/******************************************************************************
function :	send command
parameter:
     Reg : Command register
******************************************************************************/

static void EPD_13IN3E_SendCommand(UBYTE Reg)
{
    DEV_SPI_WriteByte(Reg);
}

/******************************************************************************
function :	send data
parameter:
    Data : Write data
******************************************************************************/
static void EPD_13IN3E_SendData(UBYTE Reg)
{
    DEV_SPI_WriteByte(Reg);
}
static void EPD_13IN3E_SendData2(const UBYTE *buf, uint32_t Len)
{
    DEV_SPI_Write_nByte((UBYTE *)buf,Len);
}

/******************************************************************************
function :	Wait until the busy_pin goes LOW
parameter:
******************************************************************************/
static void EPD_13IN3E_ReadBusyH(void)
{
    Debug("e-Paper busy\r\n");
	while(!DEV_Digital_Read(EPD_BUSY_PIN)) {      //LOW: busy, HIGH: idle
        DEV_Delay_ms(5);
        // Debug("e-Paper busy release\r\n");
    }
	//DEV_Delay_ms(20);
    Debug("e-Paper busy release\r\n");
}


/******************************************************************************
function :  Turn On Display
parameter:
******************************************************************************/

static void EPD_13IN3E_TurnOnDisplay(void)
{

   // printf("Write PON \r\n");
    //EPD_13IN3E_CS_ALL(0);
   // EPD_13IN3E_SendCommand(0xF4); // ???
   // EPD_13IN3E_CS_ALL(1);

    printf("Write PON \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SendCommand(PON); // POWER_ON
    EPD_13IN3E_ReadBusyH();
    EPD_13IN3E_CS_ALL(1);
    EPD_13IN3E_CS_ALL(0);
    DEV_Delay_ms(30);
    

    //printf("Write DRF \r\n");
   //
    //EPD_13IN3E_CS_ALL(0);
    //DEV_Delay_ms(30);
   // EPD_13IN3E_SendCommand(0x12);
   // DEV_SPI_WriteByte(0x00);
    EPD_13IN3E_SPI_Sand(DRF, DRF_V, sizeof(DRF_V));
    EPD_13IN3E_ReadBusyH();
    EPD_13IN3E_CS_ALL(1);
    

   //printf("Write POF \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SPI_Sand(POF, POF_V, sizeof(POF_V));
    EPD_13IN3E_ReadBusyH();
   
    // EPD_13IN3E_SendCommand(0x02);
  // DEV_SPI_WriteByte(0x00);
    EPD_13IN3E_CS_ALL(1);
    // 
    printf("Display Done!! \r\n");
    
}

static void EPD_13IN3E_TurnOnDisplay1(void)
{
    printf("Write PON \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SendCommand(0x04); // POWER_ON
    EPD_13IN3E_CS_ALL(1);
    EPD_13IN3E_ReadBusyH();

    printf("Write DRF \r\n");
    DEV_Delay_ms(50);
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SPI_Sand(DRF, DRF_V, sizeof(DRF_V));
    EPD_13IN3E_CS_ALL(1);
    EPD_13IN3E_ReadBusyH();

 /*   printf("Write POF \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SPI_Sand(POF, POF_V, sizeof(POF_V));
    EPD_13IN3E_CS_ALL(1);
    // EPD_13IN3E_ReadBusyH();
    printf("Display Done!! \r\n");
   */ 
}


static void EPD_13IN3E_TurnOnDisplay2(void)
{
    printf("Write PON \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SendCommand(0x04); // POWER_ON
    EPD_13IN3E_CS_ALL(1);
    EPD_13IN3E_ReadBusyH();
/*
    printf("Write DRF \r\n");
    DEV_Delay_ms(50);
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SPI_Sand(DRF, DRF_V, sizeof(DRF_V));
    EPD_13IN3E_CS_ALL(1);
    EPD_13IN3E_ReadBusyH();
*/
    printf("Write POF \r\n");
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SPI_Sand(POF, POF_V, sizeof(POF_V));
    EPD_13IN3E_CS_ALL(1);
    // EPD_13IN3E_ReadBusyH();
    printf("Display Done!! \r\n");
   
}

/******************************************************************************
function :	Initialize the e-Paper register
parameter:
******************************************************************************/
void EPD_13IN3E_Init(void)
{
    EPD_13IN3E_CS_ALL(1);
	EPD_13IN3E_Reset();
    EPD_13IN3E_ReadBusyH();
   // EPD_13IN3E_CS_ALL(1);
   

   //EPD_13IN3E_CS_ALL(0);
   //EPD_13IN3E_SPI_Sand(SPIM, SPIM_V, sizeof(SPIM_V));
   //EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(0, 0);
	EPD_13IN3E_SPI_Sand(AN_TM, AN_TM_V, sizeof(AN_TM_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(CMD66, CMD66_V, sizeof(CMD66_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(PSR, PSR_V, sizeof(PSR_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(CDI, CDI_V, sizeof(CDI_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(TCON, TCON_V, sizeof(TCON_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(AGID, AGID_V, sizeof(AGID_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(PWS, PWS_V, sizeof(PWS_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(CCSET, CCSET_V, sizeof(CCSET_V));
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_CS_ALL(0);
	EPD_13IN3E_SPI_Sand(TRES, TRES_V, sizeof(TRES_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(PWR_epd, PWR_V, sizeof(PWR_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(EN_BUF, EN_BUF_V, sizeof(EN_BUF_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(BTST_P, BTST_P_V, sizeof(BTST_P_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(BOOST_VDDP_EN, BOOST_VDDP_EN_V, sizeof(BOOST_VDDP_EN_V));
    EPD_13IN3E_CS_ALL(1);
	
    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(BTST_N, BTST_N_V, sizeof(BTST_N_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(BUCK_BOOST_VDDN, BUCK_BOOST_VDDN_V, sizeof(BUCK_BOOST_VDDN_V));
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
	EPD_13IN3E_SPI_Sand(TFT_VCOM_POWER, TFT_VCOM_POWER_V, sizeof(TFT_VCOM_POWER_V));
    EPD_13IN3E_CS_ALL(1);
   
    
}



#define BLACK         0x00
#define WHITE         0x11
#define YELLOW        0x22
#define RED           0x33
#define BLUE          0x55
#define GREEN         0x66




uint8_t BLACK2 = 0x00;



void epdDisplayColorBar(void)
{
	unsigned long i;

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
    DEV_Digital_Write(EPD_CS_S_PIN, 1);
	EPD_13IN3E_SendCommand(DTM);

// BLACK
for (UDOUBLE j = 0; j < 160000; j++) {
    DEV_SPI_WriteByte(BLACK);
    //if (((j+1)%2400 == 0) && (j>0))
    //  BLACK2=BLACK2+0x11;
    }
// WHITE
for (UDOUBLE j = 0; j < 160000; j++) {
    DEV_SPI_WriteByte(WHITE);
    }
// YELLOW
for (UDOUBLE j = 0; j < 160000-2; j++) {
    DEV_SPI_WriteByte(YELLOW);
    }
    
    DEV_Digital_Write(EPD_CS_M_PIN, 1);
    DEV_Digital_Write(EPD_CS_S_PIN, 0);
    EPD_13IN3E_SendCommand(DTM);
   

// RED
for (UDOUBLE j = 0; j < 160000; j++) {
    DEV_SPI_WriteByte(RED);
    }
// BLUE
for (UDOUBLE j = 0; j < 160000; j++) {
    DEV_SPI_WriteByte(BLUE);
    }
// GREEN
for (UDOUBLE j = 0; j < 160000-2; j++) {
    DEV_SPI_WriteByte(GREEN);
    }
    
	EPD_13IN3E_CS_ALL(1);

	EPD_13IN3E_TurnOnDisplay();


}


#define DONE 0
#define ERROR 1
char partialWindowUpdateStatus = DONE;


void writeEpdImage(unsigned char csx, unsigned char const *imageData, unsigned long imageDataLength)
{

	DEV_Digital_Write(csx,0);
    EPD_13IN3E_SendCommand(DTM);    

    for (UDOUBLE j = 0; j < imageDataLength; j++) {
        DEV_SPI_WriteByte(imageData[j]);
    }


	DEV_Digital_Write(csx,1);

#if SHOW_LOG
	printf("Writing data is completed. \r\n");
#endif

}


char partialWindowUpdateWithImageData(unsigned char csx, unsigned char const *imageData, unsigned long imageDataLength,
    unsigned int xStart, unsigned int yStart, unsigned int xPixel, unsigned int yLine, unsigned char epdDisplayEnable)
{
   unsigned char status = DONE;
   unsigned int HRST, HRED, VRST, VRED;
   unsigned char partialWindowData[9];

   HRST = xStart * 2;
   HRED = (xStart + xPixel) * 2 - 1; // The range is 0 ~ 1199
   VRST = yStart / 2;
   VRED = (yStart + yLine) / 2 - 1; // The range is 0 ~ 799

#if SHOW_LOG
   printf("csx = %d ; HRST = %d ; HRED = %d ; VRST = %d ; VRED = %d \r\n",csx, HRST, HRED, VRST, VRED);
#endif

   // HRST[10:0] = 8n (n = 0,1,2…)
   if (HRST % 8 != 0){
       status = -1;
#if SHOW_LOG
       printf("status = -1 ; There is a problem with xStart. \r\n");
#endif
   }
   // HRED[10:0] = 8m+3 (m = 4,5,6…)
   else if ((HRED - 7) % 8 != 0) {
       status = -2;
#if SHOW_LOG
       printf("status = -2 ; There is a problem with xPixel. \r\n");
#endif
   }
   //  xStart <= 584 ; xPixel <= 600
   else if ((xStart > 584) | (xPixel > 600)) {
       status = -3;
#if SHOW_LOG
       printf("status = -3 ; xStart or xPixel is over range. \r\n");
#endif
   }
   // HRED - HRST + 1 >= 32 & HRED + 1 <= 1200
   else if ((HRED - HRST + 1 < 32) | (HRED + 1 > 1200)){
       status = -4;
#if SHOW_LOG
       printf("status = -4 ; There is a problem with xStart & xPixel. \r\n");
#endif
   }
   else if ((yStart + yLine) % 2 != 0){
       status = -5;
#if SHOW_LOG
       printf("status = -5 ; yStart + yLine must be an even number. \r\n");
#endif
   }
   // yStart <= 1596 ; yLine <= 1600
   else if ((yStart > 1596) | (yLine > 1600)) {
       status = -6;
#if SHOW_LOG
       printf("status = -6 ; yStart or yLine is over range. \r\n");
#endif
   }
   //VRST - VRED + 1 > 0 & VRED + 1 <= 800
   else if (((int)(VRED - VRST) + 1 <= 0) | (VRED + 1 > 800)){
       status = -7;
#if SHOW_LOG
       printf("status = -7 ; There is a problem with yStart & yLine. \r\n");
#endif
   }
   else if(csx > 1){
       status = -8;
#if SHOW_LOG
       printf("status = -8 ; There is a problem with cxs. \r\n");
#endif
   }
   else
   {
       memset(partialWindowData,0,sizeof(partialWindowData));
       partialWindowData[0] = (unsigned char)(HRST >> 8);
       partialWindowData[1] = (unsigned char)(HRST);
       partialWindowData[2] = (unsigned char)(HRED >> 8);
       partialWindowData[3] = (unsigned char)(HRED);
       partialWindowData[4] = (unsigned char)(VRST >> 8);
       partialWindowData[5] = (unsigned char)(VRST);
       partialWindowData[6] = (unsigned char)(VRED >> 8);
       partialWindowData[7] = (unsigned char)(VRED);
       partialWindowData[8] = PTLW_ENABLE;

       DEV_Digital_Write(csx,0);
       EPD_13IN3E_SPI_Sand(PTLW, partialWindowData, sizeof(partialWindowData));
       DEV_Digital_Write(csx,1);

       DEV_Digital_Write(csx,0);
   //    EPD_13IN3E_SPI_Sand(DTM, imageData, imageDataLength);

  EPD_13IN3E_SendCommand(DTM);    

for (UDOUBLE j = 0; j < 7200; j++) {
    DEV_SPI_WriteByte(0x11);
    }

       DEV_Digital_Write(csx,1);

   }

   if(status != DONE)
   {
       partialWindowUpdateStatus = ERROR;
#if SHOW_LOG
       printf("partialWindowUpdateStatus = ERROR \r\n");
#endif
   }

   if(epdDisplayEnable)
   {
       if(partialWindowUpdateStatus == DONE) EPD_13IN3E_TurnOnDisplay();

       DEV_Delay_ms(300);

       //========================= Turn off PTLW =========================
       memset(partialWindowData,0,sizeof(partialWindowData));
       partialWindowData[8] = PTLW_DISABLE;
       partialWindowUpdateStatus = DONE;

       EPD_13IN3E_CS_ALL(0);
       EPD_13IN3E_SPI_Sand(PTLW, partialWindowData, sizeof(partialWindowData));
       EPD_13IN3E_CS_ALL(1);
       //=================================================================
   }

   return status;
}


char  partialWindowUpdateWithoutImageData(unsigned char csx, unsigned int xStart, unsigned int yStart,
    unsigned int xPixel, unsigned int yLine, unsigned char epdDisplayEnable)
{
   unsigned char status = DONE;
   unsigned int HRST, HRED, VRST, VRED;
   unsigned char partialWindowData[9];

   HRST = xStart * 2;
   HRED = (xStart + xPixel) * 2 - 1; // The range is 0 ~ 1199
   VRST = yStart / 2;
   VRED = (yStart + yLine) / 2 - 1; // The range is 0 ~ 799

#if SHOW_LOG
   printf("csx = %d ; HRST = %d ; HRED = %d ; VRST = %d ; VRED = %d \r\n",csx, HRST, HRED, VRST, VRED);
#endif

   // HRST[10:0] = 8n (n = 0,1,2…)
   if (HRST % 8 != 0){
       status = -1;
#if SHOW_LOG
       printf("status = -1 ; There is a problem with xStart. \r\n");
#endif
   }
   // HRED[10:0] = 8m+3 (m = 4,5,6…)
   else if ((HRED - 7) % 8 != 0) {
       status = -2;
#if SHOW_LOG
       printf("status = -2 ; There is a problem with xPixel. \r\n");
#endif
   }
   //  xStart <= 584 ; xPixel <= 600
   else if ((xStart > 584) | (xPixel > 600)) {
       status = -3;
#if SHOW_LOG
       printf("status = -3 ; xStart or xPixel is over range. \r\n");
#endif
   }
   // HRED - HRST + 1 >= 32 & HRED + 1 <= 1200
   else if ((HRED - HRST + 1 < 32) | (HRED + 1 > 1200)){
       status = -4;
#if SHOW_LOG
       printf("status = -4 ; There is a problem with xStart & xPixel. \r\n");
#endif
   }
   else if ((yStart + yLine) % 2 != 0){
       status = -5;
#if SHOW_LOG
       printf("status = -5 ; yStart + yLine must be an even number. \r\n");
#endif
   }
   // yStart <= 1596 ; yLine <= 1600
   else if ((yStart > 1596) | (yLine > 1600)) {
       status = -6;
#if SHOW_LOG
       printf("status = -6 ; yStart or yLine is over range. \r\n");
#endif
   }
   //VRST - VRED + 1 > 0 & VRED + 1 <= 800
   else if (((int)(VRED - VRST) + 1 <= 0) | (VRED + 1 > 800)){
       status = -7;
#if SHOW_LOG
       printf("status = -7 ; There is a problem with yStart & yLine. \r\n");
#endif
   }
   else if(csx > 1){
       status = -8;
#if SHOW_LOG
       printf("status = -8 ; There is a problem with cxs. \r\n");
#endif
   }
   else
   {
       memset(partialWindowData,0,sizeof(partialWindowData));
       partialWindowData[0] = (unsigned char)(HRST >> 8);
       partialWindowData[1] = (unsigned char)(HRST);
       partialWindowData[2] = (unsigned char)(HRED >> 8);
       partialWindowData[3] = (unsigned char)(HRED);
       partialWindowData[4] = (unsigned char)(VRST >> 8);
       partialWindowData[5] = (unsigned char)(VRST);
       partialWindowData[6] = (unsigned char)(VRED >> 8);
       partialWindowData[7] = (unsigned char)(VRED);
       partialWindowData[8] = PTLW_ENABLE;

       DEV_Digital_Write(csx,0);

       EPD_13IN3E_SendCommand(PTLW);    
      // for (UDOUBLE j = 0; j < sizeof(partialWindowData); j++) {
        DEV_SPI_Write_nByte(partialWindowData,sizeof(partialWindowData) );
      // }


       DEV_Digital_Write(csx,1);
   }

   if(status != DONE)
   {
       partialWindowUpdateStatus = ERROR;
#if SHOW_LOG
       printf("partialWindowUpdateStatus = ERROR \r\n");
#endif
   }

   if(epdDisplayEnable)
   {
       if(partialWindowUpdateStatus == DONE) EPD_13IN3E_TurnOnDisplay();

       DEV_Delay_ms(300);

       //========================= Turn off PTLW =========================
       memset(partialWindowData,0,sizeof(partialWindowData));
       partialWindowData[8] = PTLW_DISABLE;
       partialWindowUpdateStatus = DONE;

       EPD_13IN3E_CS_ALL(0);

       EPD_13IN3E_SendCommand(PTLW);    
       DEV_SPI_Write_nByte(partialWindowData,sizeof(partialWindowData) );
       //for (UDOUBLE j = 0; j < sizeof(partialWindowData); j++) {
       //   DEV_SPI_WriteByte(partialWindowData[j]);
      // }


       EPD_13IN3E_CS_ALL(1);
       //=================================================================
   }

   return status;
}

/******************************************************************************
function :  Clear screen
parameter:
******************************************************************************/
void EPD_13IN3E_Clear(UBYTE color)
{
    UDOUBLE Width, Height;
    UBYTE Color;
    Height = EPD_13IN3E_HEIGHT;//(EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width = EPD_13IN3E_WIDTH;
    Color = 0x11;//(color<<4)|color;
    
  //  UBYTE buf[480000];
    
   // for (UDOUBLE j = 0; j < 480000; j++) {
  //      buf[j] = Color;
   // }
   
    DEV_Digital_Write(EPD_CS_M_PIN, 0);
    DEV_Digital_Write(EPD_CS_S_PIN, 1);
    
   // 
    EPD_13IN3E_SendCommand(DTM);    

    for (UDOUBLE j = 0; j < 480000-2; j++) {
    DEV_SPI_WriteByte(0x11);
    }

    DEV_Digital_Write(EPD_CS_M_PIN, 1);
     DEV_Digital_Write(EPD_CS_S_PIN, 0);
     EPD_13IN3E_SendCommand(DTM);

     for (UDOUBLE j = 0; j < 480000-2; j++) {
        DEV_SPI_WriteByte(0x11);
        }

   // EPD_13IN3E_SendCommand(PTLW);
   // DEV_Digital_Write(EPD_CS_M_PIN, 1);
   // DEV_Digital_Write(EPD_CS_S_PIN, 0);
    
   // EPD_13IN3E_SendCommand(DTM);

    //for (UDOUBLE j = 0; j < 480000; j++) {
    //    DEV_SPI_WriteByte(0x11);
    //    }
     //   EPD_13IN3E_SendCommand(PTLW);
    //for (uint32_t j = 0; j < 48000; j++)
    //    DEV_SPI_WriteByte(buf[j]);

    //for (UDOUBLE j = 0; j < EPD_13IN3E_HEIGHT/2; j++) {
      //  EPD_13IN3E_SendData2(buf, 480000);
       // EPD_13IN3E_SendData2(buf, Width);
        //DEV_Delay_ms(1);
    //}

    

    EPD_13IN3E_CS_ALL(1);

    //DEV_Delay_ms(5);
    //EPD_13IN3E_CS_ALL(0);

    /*
    
    DEV_Digital_Write(EPD_CS_M_PIN, 1);
    DEV_Digital_Write(EPD_CS_S_PIN, 0);
    EPD_13IN3E_SendCommand(DTM);

    //EPD_13IN3E_CS_ALL(1);

    for (UDOUBLE j = 0; j < 480000; j++) {
        DEV_SPI_WriteByte(0x11);
        }

   // for (UDOUBLE j = 0; j < EPD_13IN3E_HEIGHT/2; j++) {
       // EPD_13IN3E_SendData2(buf, Width);
       // EPD_13IN3E_SendData2(buf, Width);
        // DEV_Delay_ms(1);
    //}

    //EPD_13IN3E_SendData2(buf, Width);
    //DEV_Delay_ms(20);
    EPD_13IN3E_CS_ALL(1);
*/
   // DEV_Digital_Write(EPD_CS_S_PIN, 0);
   // DEV_Delay_ms(20);
   // EPD_13IN3E_CS_ALL(1);  

    /*
    DEV_Digital_Write(EPD_CS_M_PIN, 0);
     //04
    for (UDOUBLE j = 0; j < EPD_13IN3E_HEIGHT; j++) {
        EPD_13IN3E_SendData2(buf, Width/2);
        DEV_Delay_ms(1);
    }
    //DEV_Digital_Write(EPD_CS_M_PIN, 1);
    EPD_13IN3E_CS_ALL(1);


    DEV_Digital_Write(EPD_CS_S_PIN, 0);
  //  EPD_13IN3E_SendCommand(0x10);
    for (UDOUBLE j = 0; j < EPD_13IN3E_HEIGHT; j++) {
        EPD_13IN3E_SendData2(buf, Width/2);
        DEV_Delay_ms(1);
    }
    EPD_13IN3E_CS_ALL(1);    
    */
  
    EPD_13IN3E_TurnOnDisplay();
}


void EPD_13IN3E_Display(const UBYTE *Image)
{
    UDOUBLE Width, Width1, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width1 = (Width % 2 == 0)? (Width / 2 ): (Width / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    
    DEV_Digital_Write(EPD_CS_M_PIN, 0);
     //!!   EPD_13IN3E_SendCommand(0x10);
    for(UDOUBLE i=0; i<Height; i++ )
    {
        EPD_13IN3E_SendData2(Image + i*Width,Width1);
        DEV_Delay_ms(1);
    }
    EPD_13IN3E_CS_ALL(1);

    DEV_Digital_Write(EPD_CS_S_PIN, 0);
    //!!    EPD_13IN3E_SendCommand(0x10);
    for(UDOUBLE i=0; i<Height; i++ )
    {
        EPD_13IN3E_SendData2(Image + i*Width + Width1,Width1);
        DEV_Delay_ms(1);
    }
       
    EPD_13IN3E_CS_ALL(1);
    
    EPD_13IN3E_TurnOnDisplay();
}


void EPD_13IN3E_DisplayPart(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh)
{
    UDOUBLE Width, Width1, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width1 = (Width % 2 == 0)? (Width / 2 ): (Width / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    
    UWORD Xend = ((xstart + image_width)%2 == 0)?((xstart + image_width) / 2 - 1): ((xstart + image_width) / 2 );
    UWORD Yend = ystart + image_heigh-1;
    xstart = xstart / 2;
    
    if(xstart > 300 )
    {
        Xend = Xend - 300;
        xstart = xstart - 300;
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }
    else if(Xend < 300 )
    {
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }
    else
    {
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend-300)) {
                    EPD_13IN3E_SendData(Image[(j+300-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }

    EPD_13IN3E_TurnOnDisplay();
}



void EPD_13IN3E_DisplayPart2(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh)
{
    UDOUBLE Width, Width1, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width1 = (Width % 2 == 0)? (Width / 2 ): (Width / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    
    UWORD Xend = ((xstart + image_width)%2 == 0)?((xstart + image_width) / 2 - 1): ((xstart + image_width) / 2 );
    UWORD Yend = ystart + image_heigh-1;
    xstart = xstart / 2;
    
    if(xstart > 300 )
    {
        Xend = Xend - 300;
        xstart = xstart - 300;
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }
    else if(Xend < 300 )
    {
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }
    else
    {
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
        //!!    EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend-300)) {
                    EPD_13IN3E_SendData(Image[(j+300-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
    }

    EPD_13IN3E_TurnOnDisplay();
}

void EPD_13IN3E_TurnOnDisplayAll()
{
    EPD_13IN3E_TurnOnDisplay();
}

void EPD_13IN3E_DisplayPartMaster(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh)
{
    UDOUBLE Width, Width1, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width1 = (Width % 2 == 0)? (Width / 2 ): (Width / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    
    UWORD Xend = ((xstart + image_width)%2 == 0)?((xstart + image_width) / 2 - 1): ((xstart + image_width) / 2 );
    UWORD Yend = ystart + image_heigh-1;
    xstart = xstart / 2;

    if (Xend==299) { Xend = 300;}
    
    if(xstart > 300 )
    {
        Xend = Xend - 300;
        xstart = xstart - 300;
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        
    }
    else if(Xend < 300 )
    {
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);       
        
       
    }
    else
    {
        DEV_Digital_Write(EPD_CS_M_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
       
    }

 //   EPD_13IN3E_TurnOnDisplay();
}


void EPD_13IN3E_DisplayPartSlave(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh)
{
   
  /*  DEV_Digital_Write(EPD_CS_S_PIN, 0);
    EPD_13IN3E_SendCommand(0x10);
    UDOUBLE a = 0;
    for (UDOUBLE i = 0; i < image_heigh; i++) {
        for (UDOUBLE j = 0; j < image_width; j++) {
                EPD_13IN3E_SendData(Image[a]);  
                a++;      
        }
      DEV_Delay_ms(1);
    }
    EPD_13IN3E_CS_ALL(1);    

*/
   
    UDOUBLE Width, Width1, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Width1 = (Width % 2 == 0)? (Width / 2 ): (Width / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    
    UWORD Xend = ((xstart + image_width)%2 == 0)?((xstart + image_width) / 2 - 1): ((xstart + image_width) / 2 );
    UWORD Yend = ystart + image_heigh-1;
    xstart = xstart / 2;
    
    if(xstart > 300 )
    {
        Xend = Xend - 300;
        xstart = xstart - 300;
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
        
    }
    else if(Xend < 300 )
    {
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j<Xend) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);       
        
       
    }
    else
    {
        DEV_Digital_Write(EPD_CS_S_PIN, 0);
            EPD_13IN3E_SendCommand(0x10);
        for (UDOUBLE i = 0; i < Height; i++) {
            for (UDOUBLE j = 0; j < Width1; j++) {
                if((i<Yend) && (i>=ystart) && (j>=xstart)) {
                    EPD_13IN3E_SendData(Image[(j-xstart) + (image_width/2*(i-ystart))]);
                }
                else
                    EPD_13IN3E_SendData(0x11);
            }
            DEV_Delay_ms(1);
        }
        EPD_13IN3E_CS_ALL(1);
        
        
       
    }
    

  //  EPD_13IN3E_TurnOnDisplay();
}


void EPD_13IN3E_DisplayEpp()
{
    u32_t base_addr =  0x820000 + SPI_FLASH_SEC_SIZE;

    u8_t tmp0;
    //first

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
    EPD_13IN3E_SendCommand(0x10);


    for (int i = 0; i < 480000; i++) {
        spi_flash_read(base_addr, &tmp0, 1);
       // Serial.print(tmp0, HEX);
       // Serial.print(" ");
        EPD_13IN3E_SendData(tmp0);
        base_addr++;
    }
    EPD_13IN3E_CS_ALL(1);
    
    DEV_Digital_Write(EPD_CS_S_PIN, 0);
    EPD_13IN3E_SendCommand(0x10);

    for (int i = 0; i < 480000; i++) {
        spi_flash_read(base_addr, &tmp0, 1);
        EPD_13IN3E_SendData(tmp0);      
        base_addr++;
    }
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_TurnOnDisplay();
}


#define ARRAY_SIZE 240000
uint8_t array1[ARRAY_SIZE];

void EPD_13IN3E_DisplayEppFast(uint8_t im)
{
    u32_t base_addr =  0x820000 + SPI_FLASH_SEC_SIZE + im * ARRAY_SIZE * 4;

    u8_t tmp0;
    //first

    DEV_Digital_Write(EPD_CS_M_PIN, 0);
    EPD_13IN3E_SendCommand(0x10);


    spi_flash_read(base_addr, array1, ARRAY_SIZE);
    for (int i = 0; i < ARRAY_SIZE; i++) {
        EPD_13IN3E_SendData(array1[i]);        
    }
    base_addr=base_addr+ARRAY_SIZE;

    spi_flash_read(base_addr, array1, ARRAY_SIZE);
    for (int i = 0; i < ARRAY_SIZE; i++) {
        EPD_13IN3E_SendData(array1[i]);        
    }
    base_addr=base_addr+ARRAY_SIZE;

    EPD_13IN3E_CS_ALL(1);
    
    DEV_Digital_Write(EPD_CS_S_PIN, 0);
    EPD_13IN3E_SendCommand(0x10);

    spi_flash_read(base_addr, array1, ARRAY_SIZE);
    for (int i = 0; i < ARRAY_SIZE; i++) {
        EPD_13IN3E_SendData(array1[i]);        
    }
    base_addr=base_addr+ARRAY_SIZE;

    spi_flash_read(base_addr, array1, ARRAY_SIZE);
    for (int i = 0; i < ARRAY_SIZE; i++) {
        EPD_13IN3E_SendData(array1[i]);        
    }
    base_addr=base_addr+ARRAY_SIZE;
    
    EPD_13IN3E_CS_ALL(1);

    EPD_13IN3E_TurnOnDisplay();
}

void EPD_13IN3E_Show6Block(void)
{
    unsigned long i, j, k;
    UWORD Width, Height;
    Width = (EPD_13IN3E_WIDTH % 2 == 0)? (EPD_13IN3E_WIDTH / 2 ): (EPD_13IN3E_WIDTH / 2 + 1);
    Height = EPD_13IN3E_HEIGHT;
    unsigned char const Color_seven[6] = 
    {EPD_13IN3E_BLACK, EPD_13IN3E_BLUE, EPD_13IN3E_GREEN,
    EPD_13IN3E_RED, EPD_13IN3E_YELLOW, EPD_13IN3E_WHITE};
    
    DEV_Digital_Write(EPD_CS_M_PIN, 0);
    //!!    EPD_13IN3E_SendCommand(0x10);
    for (k = 0; k < 6; k++) {
        for (j = 0; j < Height/6; j++) {
            for (i = 0; i < Width/2; i++) {
                EPD_13IN3E_SendData(Color_seven[k]|(Color_seven[k]<<4));
            }
        }
        DEV_Delay_ms(1);
    }
    EPD_13IN3E_CS_ALL(1);
    
    DEV_Digital_Write(EPD_CS_S_PIN, 0);
     //!!   EPD_13IN3E_SendCommand(0x10);
    for (k = 0; k < 6; k++) {
        for (j = 0; j < Height/6; j++) {
            for (i = 0; i < Width/2; i++) {
                EPD_13IN3E_SendData(Color_seven[k]|(Color_seven[k]<<4));
            }
        }
        DEV_Delay_ms(1);
    }
    EPD_13IN3E_CS_ALL(1);
    
    EPD_13IN3E_TurnOnDisplay();
}


/******************************************************************************
function :  Enter sleep mode
parameter:
******************************************************************************/
void EPD_13IN3E_Sleep(void)
{
    EPD_13IN3E_CS_ALL(0);
    EPD_13IN3E_SendCommand(0x07); // DEEP_SLEEP
    EPD_13IN3E_SendData(0XA5);
    EPD_13IN3E_CS_ALL(1);
    
}





