/*****************************************************************************
* | File      	:   DEV_Config.c
* | Author      :   Waveshare team
* | Function    :   Hardware underlying interface
* | Info        :
*----------------
* |	This version:   V1.0
* | Date        :   2020-02-19
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
#include "DEV_Config.h"
#include "driver/spi_master.h"

void GPIO_Config(void)
{
    
    

    pinMode(EPD_BUSY_PIN,  INPUT);
    pinMode(EPD_RST_PIN , OUTPUT);
    pinMode(EPD_DC_PIN  , OUTPUT);
    pinMode(EPD_PWR_PIN,  OUTPUT);

    pinMode(EPD_SCK_PIN, OUTPUT);
    pinMode(EPD_MOSI_PIN, OUTPUT);
    pinMode(EPD_CS_M_PIN , OUTPUT);
    pinMode(EPD_CS_S_PIN , OUTPUT);

   // digitalWrite(EPD_CS_M_PIN , HIGH);
   // digitalWrite(EPD_CS_S_PIN , HIGH);
   // digitalWrite(EPD_SCK_PIN, LOW);
   // digitalWrite(EPD_PWR_PIN , HIGH);

  //  pinMode(40, OUTPUT);
  //  pinMode(38, OUTPUT);
  //  pinMode(39, OUTPUT);

  //  digitalWrite(EPD_DC_PIN , LOW);
  //  digitalWrite(EPD_RST_PIN , LOW);  //!!!!
}

void GPIO_Mode(UWORD GPIO_Pin, UWORD Mode)
{
    if(Mode == 0) {
        pinMode(GPIO_Pin , INPUT);
	} else {
		pinMode(GPIO_Pin , OUTPUT);
	}
}
/******************************************************************************
function:	Module Initialize, the BCM2835 library and initialize the pins, SPI protocol
parameter:
Info:
******************************************************************************/
spi_device_handle_t spi;
spi_bus_config_t buscfg = {    
    .mosi_io_num = EPD_MOSI_PIN,
    .miso_io_num = -1,    
    .sclk_io_num = EPD_SCK_PIN,
    .quadwp_io_num = -1,
    .quadhd_io_num = -1,    
    .max_transfer_sz = 4096,
};


spi_device_interface_config_t devcfg = {
    .command_bits = 8,
    .address_bits = 24,
    .dummy_bits = 0,
    .mode = 0,
    .duty_cycle_pos = 128,
    .cs_ena_pretrans = 1,
    .cs_ena_posttrans = 1,
    .clock_speed_hz = 10 * 1000 * 1000,
    .spics_io_num = EPD_CS_M_PIN,
    .flags = SPI_DEVICE_HALFDUPLEX | SPI_DEVICE_3WIRE,
    .queue_size = 3,
};


void send_qspi_command(uint8_t cmd, uint8_t* data, size_t data_len) {
    spi_transaction_t trans = {
        .flags = SPI_TRANS_MODE_QIO,
        .cmd = cmd,
        .length = data_len * 8, // длина в битах
        .rxlength = 0,
        .tx_buffer = data       
        
    };

    spi_device_handle_t spi;
    spi_device_transmit(spi, &trans);
}


UBYTE DEV_Module_Init(void)
{
	//gpio
	GPIO_Config();

    // Инициализация шины QSPI
    //spi_bus_initialize(SPI2_HOST, &buscfg, 2);
    
    // Добавление устройства на шину
    //spi_device_handle_t spi;
    //spi_bus_add_device(SPI2_HOST, &devcfg, &spi);


	//serial printf
	

	// spi
	// SPI.setDataMode(SPI_MODE0);
	// SPI.setBitOrder(MSBFIRST);
	// SPI.setClockDivider(SPI_CLOCK_DIV4);
	// SPI.begin();

    //uint8_t command = 0xAA; // Пример команды
    //uint8_t data[4] = {0x01, 0x02, 0x03, 0x04}; // Пример данных
    
    //send_qspi_command(command, data, sizeof(data));

    //delay(15000);


	return 0;
}

/******************************************************************************
function:
			SPI read and write
******************************************************************************/


void DEV_SPI_WriteByte(UBYTE data)
{
    for (int i = 0; i < 8; i++)
    {
        if ((data & 0x80) == 0) digitalWrite(EPD_MOSI_PIN, GPIO_PIN_RESET); 
        else                    digitalWrite(EPD_MOSI_PIN, GPIO_PIN_SET);

        data <<= 1;
        digitalWrite(EPD_SCK_PIN, GPIO_PIN_SET);     
        digitalWrite(EPD_SCK_PIN, GPIO_PIN_RESET);
    }

}

UBYTE DEV_SPI_ReadByte()
{
    UBYTE j=0xff;
    GPIO_Mode(EPD_MOSI_PIN, 0);
    for (int i = 0; i < 8; i++)
    {
        j = j << 1;
        if (digitalRead(EPD_MOSI_PIN))  j = j | 0x01;
        else                            j = j & 0xfe;
        
        digitalWrite(EPD_SCK_PIN, GPIO_PIN_SET);     
        digitalWrite(EPD_SCK_PIN, GPIO_PIN_RESET);
    }
    GPIO_Mode(EPD_MOSI_PIN, 1);
    return j;
}

void DEV_SPI_Write_nByte(UBYTE *pData, UDOUBLE len)
{
   // digitalWrite(EPD_DC_PIN , HIGH);
    for (uint32_t i = 0; i < len; i++)
        DEV_SPI_WriteByte(pData[i]);
}

void DEV_Module_Exit(void)
{
    digitalWrite(EPD_PWR_PIN , LOW);
    digitalWrite(EPD_RST_PIN , LOW);
}
