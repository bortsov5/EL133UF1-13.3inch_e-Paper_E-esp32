/*****************************************************************************
* | File      	:	EPD_12in48.h
* | Author      :   Waveshare team
* | Function    :   Electronic paper driver
* | Info        :
*----------------
* |	This version:   V1.0
* | Date        :   2018-11-29
* | Info        :
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documnetation files (the "Software"), to deal
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
#ifndef _EPD_13IN3E_H_
#define _EPD_13IN3E_H_

#include "DEV_Config.h"

// M/S 控制区域 600*1600
#define EPD_13IN3E_WIDTH        1200
#define EPD_13IN3E_HEIGHT       1600    


#define EPD_13IN3E_BLACK        0x00
#define EPD_13IN3E_WHITE        0x11
#define EPD_13IN3E_YELLOW       0x22  //BLUE
#define EPD_13IN3E_RED          0x33
#define EPD_13IN3E_BLUE         0x55
#define EPD_13IN3E_GREEN        0x66

#define PSR             0x00
#define PWR_epd         0x01
#define POF             0x02
#define PON             0x04
#define BTST_N          0x05//0xD8
#define BTST_P          0x06//0x18
#define DTM             0x10
#define DRF             0x12
#define CDI             0x50
#define TCON            0x60
#define TRES            0x61
#define PTLW            0x83
#define AN_TM           0x74
#define AGID            0x86
#define BUCK_BOOST_VDDN 0xB0
#define TFT_VCOM_POWER  0xB1
#define EN_BUF          0xB6
#define BOOST_VDDP_EN   0xB7
#define CCSET           0xE0
#define PWS             0xE3
#define CMD66           0xF0
#define SPIM            0xE6

#define PTLW_ENABLE  0x01
#define PTLW_DISABLE 0x00




void EPD_13IN3E_Init(void);
void EPD_13IN3E_Clear(UBYTE color);
void epdDisplayColorBar(void);
void EPD_13IN3E_Display(const UBYTE *Image);
void EPD_13IN3E_DisplayPart(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh);
void EPD_13IN3E_DisplayPart2(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh);
void EPD_13IN3E_DisplayPartMaster(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh);
void EPD_13IN3E_DisplayPartSlave(const UBYTE *Image, UWORD xstart, UWORD ystart, UWORD image_width, UWORD image_heigh);
void EPD_13IN3E_Show6Block(void);
void EPD_13IN3E_Sleep(void);
char partialWindowUpdateWithImageData(unsigned char csx, unsigned char const *imageData, unsigned long dataSize, unsigned int xStart, unsigned int yStart, unsigned int xPixel, unsigned int yLine, unsigned char displayEnable);
void writeEpdImage(unsigned char csx, unsigned char const *imageData, unsigned long imageDataLength);
char partialWindowUpdateWithoutImageData(unsigned char csx, unsigned int xStart, unsigned int yStart, unsigned int xPixel, unsigned int yLine, unsigned char epdDisplayEnable);
void EPD_13IN3E_TurnOnDisplayAll();
void EPD_13IN3E_DisplayEpp();
void EPD_13IN3E_DisplayEppFast(uint8_t im);

#endif

