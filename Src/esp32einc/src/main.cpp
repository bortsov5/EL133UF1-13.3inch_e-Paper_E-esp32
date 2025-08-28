#include "EPD_13in3e.h"
#include "GUI_Paint.h"
#include "fonts.h"
#include "ImageData.h"
#include <WiFi.h>
#include <WebServer.h>
#include <SD.h>
#include <SPI.h>

#include <HTTPClient.h>
#include <WiFiClientSecure.h>
#include <TJpg_Decoder.h>

//#define EPD_IMAGE_DATA_BUFFER 160200
//unsigned char epdImageDataBuffer[EPD_IMAGE_DATA_BUFFER];

const char* ssid = "RestfrontMI"; // Замените на имя вашей сети Wi-Fi
const char* password = "Rf7531711"; // Замените на пароль вашей сети Wi-Fi

// sd-card
#define PIN_MOSI 21
#define PIN_MISO 14
#define PIN_SCK 12
#define PIN_CS 46

unsigned long previousMillis = 0;
unsigned long interval = 90000; // Интервал проверки соединения (90 секунд)
byte Vifl = false;
const char* filename = "/image.jpg";

WebServer server(80);

char cntP = 0;
int Fyes = 0;


void ShowEpp() {
  u32_t base_addr =  0x820000 + SPI_FLASH_SEC_SIZE;

  u8_t tmp0;
  //500 first
  for (int i = 0; i < 500; i++) {
    spi_flash_read(base_addr, &tmp0, 1);
    Serial.print(tmp0, HEX);
    Serial.print(" ");
    base_addr++;
  }
  Serial.println("====");

  base_addr = 0x820000 + SPI_FLASH_SEC_SIZE + 959500;

  for (int i = 0; i < 505; i++) {
    spi_flash_read(base_addr, &tmp0, 1);
    Serial.print(tmp0, HEX);
    Serial.print(" ");
    base_addr++;
  }
  Serial.println();


  server.send(200, "text/html", "sh ok");
}


void EraseEpp() {
  u32_t base_addr =  0x820000 + SPI_FLASH_SEC_SIZE;

 for (int i = 0; i < 235; i++) {

  spi_flash_erase_sector(base_addr / SPI_FLASH_SEC_SIZE);
  base_addr = base_addr + SPI_FLASH_SEC_SIZE;
 }

  server.send(200, "text/html", "erase ok");
}


void ViewEpp2()
{
  Vifl = true; 
  EPD_13IN3E_Init();
  EPD_13IN3E_DisplayEppFast(0);
  EPD_13IN3E_Sleep();
  server.send(200, "text/html", "view ok");
}

void ViewEpp()
{
  Vifl = true; 
  EPD_13IN3E_Init();
  EPD_13IN3E_Clear(0x11);
  EPD_13IN3E_DisplayEppFast(0);
  EPD_13IN3E_Sleep();
  server.send(200, "text/html", "view ok");
}

#define IMAGE_WIDTH 600
#define IMAGE_HEIGHT 8

static const uint8_t font5x7[][5] = {
  {0x00, 0x00, 0x00, 0x00, 0x00}, //  
  {0x00, 0x00, 0x5F, 0x00, 0x00}, // !
  {0x00, 0x07, 0x00, 0x07, 0x00}, // "
  // ... добавьте остальные символы по аналогии
  {0x3E, 0x51, 0x49, 0x45, 0x3E}, // 0
  {0x00, 0x42, 0x7F, 0x40, 0x00}, // 1
  {0x42, 0x61, 0x51, 0x49, 0x46}, // 2
  {0x21, 0x41, 0x45, 0x4B, 0x31}, // 3
  {0x18, 0x14, 0x12, 0x7F, 0x10}, // 4
  {0x27, 0x45, 0x45, 0x45, 0x39}, // 5
  {0x3C, 0x4A, 0x49, 0x49, 0x30}, // 6
  {0x01, 0x71, 0x09, 0x05, 0x03}, // 7
  {0x36, 0x49, 0x49, 0x49, 0x36}, // 8
  {0x06, 0x49, 0x49, 0x29, 0x1E}, // 9
  {0x00, 0x36, 0x36, 0x00, 0x00}, // :
  {0x00, 0x56, 0x36, 0x00, 0x00}, // ;
  {0x08, 0x14, 0x22, 0x41, 0x00}, // <
  
  {0x3E, 0x51, 0x49, 0x45, 0x3E}, // 0
  {0x00, 0x42, 0x7F, 0x40, 0x00}, // 1
  {0x42, 0x61, 0x51, 0x49, 0x46}, // 2
  {0x21, 0x41, 0x45, 0x4B, 0x31}, // 3
  {0x18, 0x14, 0x12, 0x7F, 0x10}, // 4
  {0x27, 0x45, 0x45, 0x45, 0x39}, // 5
  {0x3C, 0x4A, 0x49, 0x49, 0x30}, // 6
  {0x01, 0x71, 0x09, 0x05, 0x03}, // 7
  {0x36, 0x49, 0x49, 0x49, 0x36}, // 8
  {0x06, 0x49, 0x49, 0x29, 0x1E}, // 9

  {0x14, 0x14, 0x14, 0x14, 0x14}, // =
  {0x00, 0x41, 0x22, 0x14, 0x08}, // >
  {0x02, 0x01, 0x51, 0x09, 0x06}, // ?
  {0x32, 0x49, 0x79, 0x41, 0x3E}, // @
  // ... добавьте остальные нужные символы
  {0x00, 0x00, 0x00, 0x00, 0x00}, // . (точка)
};

#define CHAR_WIDTH 5
#define CHAR_HEIGHT 7
#define SPACING 1

void draw_text_to_buffer(uint8_t *buffer, int width, int height, const char *text) {
  int x_pos = 0;
  int y_pos = (height - CHAR_HEIGHT) / 2 + 1; // Центрируем текст по вертикали
  
  for (int i = 0; text[i] != '\0'; i++) {
      char c = text[i];
      
      // Пропускаем символы, которые не можем отобразить
      if (c < ' ' || c > '~') continue;
      
      // Получаем глиф символа из шрифта
      const uint8_t *glyph = font5x7[c - ' '];
      
      // Рисуем символ в буфере
      for (int y = 0; y < CHAR_HEIGHT; y++) {
          for (int x = 0; x < CHAR_WIDTH; x++) {
              if (glyph[x] & (1 << y)) {
                  // Рассчитываем позицию в буфере
                  int buf_x = x_pos + x;
                  int buf_y = y_pos + y;
                  
                  // Проверяем границы
                  if (buf_x >= 0 && buf_x < width && buf_y >= 0 && buf_y < height) {
                      // Устанавливаем бит (черный пиксель)
                      buffer[buf_y * width + buf_x] = EPD_13IN3E_BLACK;
                  }
              }
          }
      }
      
      // Сдвигаем позицию для следующего символа
      x_pos += CHAR_WIDTH + SPACING;
      
      // Проверяем, не вышли ли за границы изображения
      if (x_pos >= width) break;
  }
}


void DrawText()
{
  
  //Подготовка места к отображению
  u32_t base_addr =  0x820000 + SPI_FLASH_SEC_SIZE+240000*4;
  for (int i = 0; i < 235; i++) {
   spi_flash_erase_sector(base_addr / SPI_FLASH_SEC_SIZE);
   base_addr = base_addr + SPI_FLASH_SEC_SIZE;
  }

  const size_t image_size = IMAGE_WIDTH * IMAGE_HEIGHT;
  base_addr =  0x820000 + SPI_FLASH_SEC_SIZE+240000*4;
  uint8_t *image_buffer = (uint8_t *)malloc(image_size);
    if (!image_buffer) {
        ESP_LOGE("IP_IMAGE", "Failed to allocate memory for image buffer");
        return;
    }
  memset(image_buffer, EPD_13IN3E_WHITE, image_size);  


  char IP[] = "xxx.xxx.xxx.xxx";          // buffer
  IPAddress ip = WiFi.localIP();
  ip.toString().toCharArray(IP, 16);

  //char ip_addr[16];
  //snprintf(ip_addr, sizeof(ip_addr), "123456789 123;;;");
  draw_text_to_buffer(image_buffer, IMAGE_WIDTH, IMAGE_HEIGHT, IP);


 // Записываем данные
 esp_err_t err = spi_flash_write(base_addr, (uint32_t *)image_buffer, image_size);
 if (err != ESP_OK) {
     ESP_LOGE("IP_IMAGE", "Failed to write image to flash: %s", esp_err_to_name(err));
 } else {
     ESP_LOGI("IP_IMAGE", "Image with IP %s saved successfully at 0x%06x", ip_address, base_addr);
 }
 
 // Освобождаем память
  free(image_buffer);


  EPD_13IN3E_Init();
  //EPD_13IN3E_Clear(0x11);
  UBYTE *BlackImage;


  //Paint_DrawString_EN(145, 140, "LS Pro E-inc", &Font16, EPD_13IN3E_YELLOW, EPD_13IN3E_BLACK);
  EPD_13IN3E_DisplayEppFast(1);
  EPD_13IN3E_Sleep();
  server.send(200, "text/html", "DrawText ok");
}

void handleRoot() {
    server.send(200, "text/html", "<form method='POST' action='/upload' enctype='multipart/form-data'>"
                                    "<input type='file' name='file'><br>"
                                    "<input type='submit' value='Upload'>"
                                    "</form>");
  }


// Размер массивов

//uint8_t array2[ARRAY_SIZE];

void OpenBinFile()
{

    
}

  uint32_t totaluploaded = 0;

  void handleFileUpload() {
    static size_t base_addr;
  
    //if (server.args() == 0) return;
  
    HTTPUpload& upload = server.upload();
    
    if (upload.status == UPLOAD_FILE_START) {
      base_addr = 0x820000 + SPI_FLASH_SEC_SIZE;
      totaluploaded = 0;
      
      spi_flash_erase_sector(base_addr / SPI_FLASH_SEC_SIZE);
      spi_flash_erase_sector(base_addr / SPI_FLASH_SEC_SIZE + 1);
  
    } else if (upload.status == UPLOAD_FILE_WRITE) {
      if (totaluploaded >= 0x17D0000) return;
  
      size_t data_len = upload.currentSize;
      uint8_t* data_buf = upload.buf;
  
      // Удаление служебных символов (CRLF)
      if (data_len > 2 && data_buf[0] == 0x0D && data_buf[1] == 0x0A) {
        data_len -= 2;
        data_buf += 2;
      }
  
      if (data_len > 0) {
        spi_flash_write(base_addr, (uint32_t*)data_buf, data_len);
        base_addr += data_len;
        totaluploaded += data_len;
      }
  
      // Дополнительная обработка секторов при необходимости
      if (totaluploaded % SPI_FLASH_SEC_SIZE == 0) {
        spi_flash_erase_sector(base_addr / SPI_FLASH_SEC_SIZE + 1);
      }
  
    } else if (upload.status == UPLOAD_FILE_END) {
      // Уберите return перед send!
      server.send(200, "text/plain", "File uploaded successfully");
     // OpenBinFile();
    }
  }
  //-------------

  // Структуры данных
struct TError {
  float R, G, B;
};

struct TRGBTriple {
  uint8_t B, G, R;
};

// Коэффициенты дизеринга (используем MODIFIED_COEFFS из вашего кода)
const struct {
  int8_t dx, dy;
  float weight;
} MODIFIED_COEFFS[] = {
  {1, 0, 0.25},
  {-1, 1, 0.25},
  {0, 1, 0.2},
  {1, 1, 0.1},
  {2, 0, 0.05},
  {-2, 1, 0.05},
  {-1, 2, 0.03},
  {0, 2, 0.03},
  {1, 2, 0.02},
  {2, 1, 0.02},
  {-1, 0, 0.01},
  {0, -1, 0.01}
};
const int COEFFS_COUNT = sizeof(MODIFIED_COEFFS) / sizeof(MODIFIED_COEFFS[0]);

// Функция ограничения значения
int clamp(int value, int min, int max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}

// Квантование в монохром
TRGBTriple quantizeMono(TRGBTriple color) {
  uint8_t avg = (color.R + color.G + color.B) / 3;
  return {avg > 128 ? 255 : 0, avg > 128 ? 255 : 0, avg > 128 ? 255 : 0};
}

// Квантование в цвет
TRGBTriple quantizeColor(TRGBTriple color) {
  return {
      color.B > 128 ? 255 : 0,
      color.G > 128 ? 255 : 0,
      color.R > 128 ? 255 : 0
  };
}




// Структура для заголовка BMP
#pragma pack(push, 1)
struct BMPHeader {
  uint16_t bfType = 0x4D42; // 'BM'
  uint32_t bfSize;          // Размер файла в байтах
  uint16_t bfReserved1 = 0;
  uint16_t bfReserved2 = 0;
  uint32_t bfOffBits;       // Смещение до данных изображения
};

struct DIBHeader {
  uint32_t biSize = 40;     // Размер DIB заголовка
  int32_t biWidth;          // Ширина изображения
  int32_t biHeight;         // Высота изображения
  uint16_t biPlanes = 1;    // Количество цветовых плоскостей
  uint16_t biBitCount = 24; // Битность пикселя
  uint32_t biCompression = 0; // Тип сжатия
  uint32_t biSizeImage;     // Размер изображения в байтах
  int32_t biXPelsPerMeter = 0; // Горизонтальное разрешение
  int32_t biYPelsPerMeter = 0; // Вертикальное разрешение
  uint32_t biClrUsed = 0;    // Количество используемых цветов
  uint32_t biClrImportant = 0; // Количество важных цветов
};
#pragma pack(pop)

size_t getBMPRowSize(int width) {
  return ((width * 3 + 3) / 4) * 4; // 24 бита на пиксель, выравнивание до 4 байт
}

// Функция для сохранения изображения в формате BMP
bool saveBMP(const char* outputPath, TRGBTriple* image, int width, int height) {
  File outputFile = SD.open(outputPath, FILE_WRITE);
  if (!outputFile) {
      Serial.println("Failed to open output file");
      return false;
  }

  BMPHeader bmpHeader;
  DIBHeader dibHeader;

  size_t rowSize = getBMPRowSize(width);
  dibHeader.biWidth = width;
  dibHeader.biHeight = height;
  dibHeader.biSizeImage = rowSize * height;
  bmpHeader.bfOffBits = sizeof(BMPHeader) + sizeof(DIBHeader);
  bmpHeader.bfSize = bmpHeader.bfOffBits + dibHeader.biSizeImage;

  outputFile.write((uint8_t*)&bmpHeader, sizeof(BMPHeader));
  outputFile.write((uint8_t*)&dibHeader, sizeof(DIBHeader));

  // Буфер для выровненной строки
  uint8_t* rowBuffer = new uint8_t[rowSize];
  memset(rowBuffer, 0, rowSize);

  for (int y = height - 1; y >= 0; y--) {
      // Копируем пиксели в буфер с выравниванием
      for (int x = 0; x < width; x++) {
          TRGBTriple pixel = image[y * width + x];
          rowBuffer[x * 3 + 0] = pixel.B;
          rowBuffer[x * 3 + 1] = pixel.G;
          rowBuffer[x * 3 + 2] = pixel.R;
      }
      outputFile.write(rowBuffer, rowSize);
  }

  delete[] rowBuffer;
  outputFile.close();
  return true;
}


// Флаг успешного декодирования
static bool jpegDecoded = false;
static TRGBTriple* jpegImage = nullptr;
static uint32_t imgWidth = 0;
static uint32_t imgHeight = 0;

// Функция дизеринга
bool ditherImage(const char* inputPath, const char* outputPath, bool blackWhite) {
  // 1. Загрузка изображения
  File inputFile = SD.open(inputPath, FILE_READ);
  if (!inputFile) {
      Serial.println("Failed to open input file");
      return false;
  }

  // Здесь должен быть код для декодирования JPEG в массив пикселей
  // Для примера предположим, что у нас есть изображение в памяти
  // В реальности вам нужно использовать библиотеку для декодирования JPEG
  
// Получаем размер файла
size_t fileSize = inputFile.size();
uint8_t* jpegBuf = new uint8_t[fileSize];
if (!jpegBuf) {
    Serial.println("Memory allocation failed");
    inputFile.close();
    return false;
}

    // Читаем весь файл в буфер
    inputFile.read(jpegBuf, fileSize);
    inputFile.close();

    // Получаем размеры изображения
    //!!!!TJpgDec.getJpgSize(&imgWidth, &imgHeight, jpegBuf, fileSize);


  // 2. Подготовка данных
  // Предположим, что мы знаем размеры изображения
  int width = 1600; // Замените на реальные размеры
  int height = 1200;
  
  // Выделение памяти для изображения и ошибок
  TRGBTriple* image = new TRGBTriple[width * height];
  TError* currentErrors = new TError[width + 4]();
  TError* nextErrors = new TError[width + 4]();


  // Декодируем JPEG
  jpegDecoded = false;
  int res = TJpgDec.drawJpg(0, 0, jpegBuf, fileSize);
  delete[] jpegBuf;

  if (res == 0) {
      jpegDecoded = true;
      return true;
  } else {
      Serial.printf("JPEG decoding failed: %d\n", res);
      delete[] jpegImage;
      jpegImage = nullptr;
      return false;
  }


  // 3. Дизеринг
  for (int y = 0; y < height; y++) {
      bool isEvenLine = (y % 2) == 0;
      
      if (isEvenLine) {
          // Слева направо
          for (int x = 0; x < width; x++) {
              TRGBTriple oldColor = image[y * width + x];
              oldColor.R = clamp(round(oldColor.R + currentErrors[x].R), 0, 255);
              oldColor.G = clamp(round(oldColor.G + currentErrors[x].G), 0, 255);
              oldColor.B = clamp(round(oldColor.B + currentErrors[x].B), 0, 255);

              TRGBTriple newColor = blackWhite ? quantizeMono(oldColor) : quantizeColor(oldColor);
              image[y * width + x] = newColor;

              float errR = oldColor.R - newColor.R;
              float errG = oldColor.G - newColor.G;
              float errB = oldColor.B - newColor.B;

              for (int i = 0; i < COEFFS_COUNT; i++) {
                  int nx = x + MODIFIED_COEFFS[i].dx;
                  int ny = y + MODIFIED_COEFFS[i].dy;
                  
                  if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
                      if (MODIFIED_COEFFS[i].dy == 0) {
                          currentErrors[nx].R += errR * MODIFIED_COEFFS[i].weight;
                          currentErrors[nx].G += errG * MODIFIED_COEFFS[i].weight;
                          currentErrors[nx].B += errB * MODIFIED_COEFFS[i].weight;
                      } else if (MODIFIED_COEFFS[i].dy > 0) {
                          nextErrors[nx].R += errR * MODIFIED_COEFFS[i].weight;
                          nextErrors[nx].G += errG * MODIFIED_COEFFS[i].weight;
                          nextErrors[nx].B += errB * MODIFIED_COEFFS[i].weight;
                      }
                  }
              }

              currentErrors[x] = {0, 0, 0};
          }
      } else {
          // Справа налево
          for (int x = width - 1; x >= 0; x--) {
              TRGBTriple oldColor = image[y * width + x];
              oldColor.R = clamp(round(oldColor.R + currentErrors[x].R), 0, 255);
              oldColor.G = clamp(round(oldColor.G + currentErrors[x].G), 0, 255);
              oldColor.B = clamp(round(oldColor.B + currentErrors[x].B), 0, 255);

              TRGBTriple newColor = blackWhite ? quantizeMono(oldColor) : quantizeColor(oldColor);
              image[y * width + x] = newColor;

              float errR = oldColor.R - newColor.R;
              float errG = oldColor.G - newColor.G;
              float errB = oldColor.B - newColor.B;

              for (int i = 0; i < COEFFS_COUNT; i++) {
                  int nx = x - MODIFIED_COEFFS[i].dx;
                  int ny = y + MODIFIED_COEFFS[i].dy;
                  
                  if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
                      if (MODIFIED_COEFFS[i].dy == 0) {
                          currentErrors[nx].R += errR * MODIFIED_COEFFS[i].weight;
                          currentErrors[nx].G += errG * MODIFIED_COEFFS[i].weight;
                          currentErrors[nx].B += errB * MODIFIED_COEFFS[i].weight;
                      } else if (MODIFIED_COEFFS[i].dy > 0) {
                          nextErrors[nx].R += errR * MODIFIED_COEFFS[i].weight;
                          nextErrors[nx].G += errG * MODIFIED_COEFFS[i].weight;
                          nextErrors[nx].B += errB * MODIFIED_COEFFS[i].weight;
                      }
                  }
              }

              currentErrors[x] = {0, 0, 0};
          }
      }

      // Перенос ошибок для следующей строки
      if (y < height - 1) {
          memcpy(currentErrors, nextErrors, (width + 4) * sizeof(TError));
          memset(nextErrors, 0, (width + 4) * sizeof(TError));
      }
  }

  // 4. Сохранение результата
// 4. Сохранение результата в BMP
if (!saveBMP(outputPath, image, width, height)) {
  Serial.println("Failed to save BMP file");
  return false;
}
  
  // 5. Очистка
  delete[] image;
  delete[] currentErrors;
  delete[] nextErrors;
  inputFile.close();
  
  return true;
}


uint8_t colorTo4Bit(uint32_t color) {

  #define COLOR_BLACK   0x000000
  #define COLOR_WHITE   0xFFFFFF
  #define COLOR_YELLOW  0xFFFF00
  #define COLOR_RED     0xFF0000
  #define COLOR_BLUE    0x0000FF
  #define COLOR_GREEN   0x00FF00

  switch(color) {
      case COLOR_BLACK:  return 0;
      case COLOR_WHITE:  return 1;
      case COLOR_YELLOW: return 2;
      case COLOR_RED:    return 3;
      case COLOR_BLUE:   return 5;
      case COLOR_GREEN:  return 6;
      default:          return 0; // По умолчанию считаем черным
  }
}


  void DrawIP()
  {

    char IP[] = "xxx.xxx.xxx.xxx";          // buffer
    IPAddress ip = WiFi.localIP();
    ip.toString().toCharArray(IP, 16);

    Paint_DrawString_EN(145, 0, IP, &Font16, EPD_13IN3E_BLACK, EPD_13IN3E_WHITE);
    server.send(200, "text/html", "down ok");
    EPD_13IN3E_TurnOnDisplayAll();
    EPD_13IN3E_Sleep();
  }

  void SaveDump()
  {

    u32_t BASE_ADDRESS = 0x820000;
    #define FLASH_SECTOR_SIZE SPI_FLASH_SEC_SIZE

    File file = SD.open("/image_d.bmp");
    if (!file) {
      Serial.println("Failed to open image file");
        return;
    }

    const int width = 1600;
    const int height = 1200;
    const int rowSize = (width * 3 + 3) & ~3; // Выравнивание строк в BMP
    const int resultSize = (width * height + 1) / 2; // 2 пикселя на байт
    uint8_t* resultArray = (uint8_t*)malloc(resultSize);
    
    if (!resultArray) {
        Serial.println("Memory allocation failed");
        file.close();
        return;
    }

    // Пропускаем заголовок BMP (54 байта для 24-битного BMP)
    file.seek(54);

    uint32_t baseAddr = BASE_ADDRESS + FLASH_SECTOR_SIZE;
    uint32_t bytesWritten = 0;
    uint32_t byteIndex = 0;

    // Буфер для строки изображения
    uint8_t* rowBuffer = (uint8_t*)malloc(rowSize);
    if (!rowBuffer) {
        Serial.println("Row buffer allocation failed");
        free(resultArray);
        file.close();
        return;
    }

    // Обрабатываем изображение построчно (снизу вверх)
    for (int y = height - 1; y >= 0; y--) {
        file.read(rowBuffer, rowSize);
        
        for (int x = 0; x < width; x += 2) {
            // Читаем два пикселя (BGR формат)
            uint32_t pixel1 = rowBuffer[x*3] | (rowBuffer[x*3+1] << 8) | (rowBuffer[x*3+2] << 16);
            uint32_t pixel2 = (x+1 < width) ? 
                             (rowBuffer[(x+1)*3] | (rowBuffer[(x+1)*3+1] << 8) | (rowBuffer[(x+1)*3+2] << 16)) : 
                             pixel1;

            // Конвертируем в 4-битные значения
            uint8_t bit1 = colorTo4Bit(pixel1);
            uint8_t bit2 = colorTo4Bit(pixel2);

            // Формируем байт
            resultArray[byteIndex++] = (bit1 << 4) | bit2;

            // Если буфер заполнен или последняя итерация - записываем во Flash
            if (byteIndex >= 4096 || (y == 0 && x + 2 >= width)) {
                esp_err_t err = spi_flash_write(baseAddr + bytesWritten, (uint32_t*)resultArray, byteIndex);
                if (err != ESP_OK) {
               //   Serial.println( "Flash write failed: %s", esp_err_to_name(err));
                    free(rowBuffer);
                    free(resultArray);
                    file.close();
                    return;
                }
                bytesWritten += byteIndex;
                byteIndex = 0;
            }
        }
    }

    free(rowBuffer);
    free(resultArray);
    file.close();

    Serial.println("Image processed successfully. Total bytes written: ");
    Serial.println(bytesWritten);

  }


  //-------------

  const char* imageUrl = "http://elitcomplex.by/downim.php?id=20821501";

  void downloadImage(const char* url, const char* path) {
    HTTPClient http;
    
    Serial.print("Загрузка изображения с ");
    Serial.println(url);
    
    http.begin(url);
    int httpCode = http.GET();
    
    if (httpCode == HTTP_CODE_OK) {
      // Открываем файл на SD-карте для записи
      File file = SD.open(path, FILE_WRITE);
      if (!file) {
        Serial.println("Ошибка при открытии файла на SD-карте");
        http.end();
        return;
      }
      
      // Получаем поток данных и записываем в файл
      http.writeToStream(&file);
      file.close();
      
      Serial.print("Изображение сохранено как: ");
      Serial.println(path);

      // Обработка изображения
      bool success = ditherImage("/image.jpg", "/image_d.bmp", true); // true для Ч/Б, false для цвета
          
      if (success) {
          Serial.println("Dithering completed successfully");

          SaveDump();
      } else {
          Serial.println("Dithering failed");
      }

    } else {
      Serial.print("Ошибка при загрузке. Код: ");
      Serial.println(httpCode);
    }
    
    http.end();
  }
  

  void Dimage() {
    File file = SD.open("/image_d.bmp");
    if (!file) {
      Serial.println("File not found");
      server.send(404, "text/plain", "File not found");
      return;
    }
  
    server.setContentLength(file.size()); // Установка длины содержимого
    server.send(200, "image/bmp", ""); // Отправка заголовка ответа
  
    while (file.available()) {
      server.sendContent(file.readStringUntil('\0')); // Отправка содержимого файла
    }
  
    file.close(); // Закрытие файла
  }

  void Simage() {
    File file = SD.open("/image.jpg");
    if (!file) {
      Serial.println("File not found");
      server.send(404, "text/plain", "File not found");
      return;
    }
  
    server.setContentLength(file.size()); // Установка длины содержимого
    server.send(200, "image/jpeg", ""); // Отправка заголовка ответа
  
    while (file.available()) {
      server.sendContent(file.readStringUntil('\0')); // Отправка содержимого файла
    }
  
    file.close(); // Закрытие файла
  }

  void fetchAndDisplayImage() {

    downloadImage(imageUrl, filename);
    server.send(200, "text/html", "down ok");

   /* HTTPClient http;
    http.begin(imageUrl);
    int httpCode = http.GET();
    
    if (httpCode == HTTP_CODE_OK) {
      WiFiClient* stream = http.getStreamPtr();
      size_t len = http.getSize();
      uint8_t* buffer = (uint8_t*)malloc(len);
      stream->readBytes(buffer, len);
      
      // Декодирование JPEG
      JPEGDEC jpeg;
      if (jpeg.openRAM(buffer, len, [](JPEGDRAW *pDraw) {
        //!! tft.pushImage(pDraw->x, pDraw->y, pDraw->iWidth, pDraw->iHeight, pDraw->pPixels);
        return 1;
      })) {
        jpeg.decode(0, 0, 0);
        jpeg.close();
      }
      free(buffer);
    }
    http.end();*/
  }


void setup()
{
    Serial.begin(115200);

    // Инициализация SD-карты
    SPI.begin(PIN_SCK, PIN_MISO, PIN_MOSI);
    if (!SD.begin(PIN_CS)) {
      Serial.println("SD begin - err");
     // return;
    } else {
      Serial.println("SD - ok");
    }

    WiFi.setAutoReconnect(true);
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
      delay(1000);
      Serial.println("Connecting to WiFi...");
      cntP++;
      if (cntP > 10) {
        WiFi.mode(WIFI_AP);
        WiFi.softAP("Einc", "12345678");
        break;
      }
    }
    Serial.println("Connected to WiFi");
    Serial.println(WiFi.localIP());

    server.on("/", HTTP_GET, handleRoot);
    server.on("/show", HTTP_GET, ShowEpp);
    server.on("/download", HTTP_GET, fetchAndDisplayImage);  

    server.on("/view2", HTTP_GET, ViewEpp2);
    server.on("/erase", HTTP_GET, EraseEpp);
    server.on("/view", HTTP_GET, ViewEpp);
    server.on("/drawtext", HTTP_GET, DrawText);
    server.on("/dimage", HTTP_GET, Dimage);
    server.on("/image", HTTP_GET, Simage);
    server.on("/SaveDump", HTTP_GET, SaveDump);
    server.on("/ip", HTTP_GET, DrawIP);

    server.on("/upload", HTTP_POST, []() {
    server.send(200, "text/plain", "File upload completed"); }, handleFileUpload);
  
    server.begin();
   


    Debug("EPD_13IN3E_test Demo\r\n");
    DEV_Module_Init();

    // for (UBYTE i = 0; i < 255; i++) {

    Debug("e-Paper Init and Clear...\r\n");
    

    EPD_13IN3E_Sleep();
    // free(Image);
    // DEV_Delay_ms(2000);

    // close 5V
    Debug("close 5V, Module enters 0 power consumption ...\r\n");
    DEV_Module_Exit();
}

void loop()
{
    server.handleClient();
    unsigned long currentMillis = millis();
  
    // Проверяем соединение каждые 'interval' миллисекунд
    if (currentMillis - previousMillis >= interval) {
      previousMillis = currentMillis;
      if (Vifl == false) {
        DrawText();
        Vifl = true; 
      }

    }


  }