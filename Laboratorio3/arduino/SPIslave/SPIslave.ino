#include <SPI.h>

volatile bool transfer_complete = false;  // Flag to indicate full 9-bit transfer complete
volatile uint16_t received_data = 0;      // Variable to store the received 9-bit data
volatile uint8_t send_data[2] = {0b00000001, 0b00000001}; // Data to send back (9 bits)

void setup() {
  // Initialize SPI as slave
  pinMode(MISO, OUTPUT);  // MISO is the Arduino output (to FPGA or master)
  SPCR |= _BV(SPE);       // Enable SPI in slave mode
  
  // Enable SPI interrupt
  SPI.attachInterrupt();
  //SPI.setClockDivider(SPI_CLOCK_DIV16);

  // Initialize serial communication for debugging
  Serial.begin(9600);
  Serial.println("Arduino SPI Slave Ready");
}

ISR(SPI_STC_vect) {
  static uint8_t bit_count = 0;  // To count bits received
  static uint16_t temp_data = 0; // Temporary storage for the received data
  
  if (bit_count < 8) {
    // Receiving the first 8 bits
    temp_data = (temp_data << 8) | SPDR;  // Shift previous bits and add new byte
  } else {
    // Receiving the 9th bit
    temp_data = (temp_data << 1) | (SPDR & 0x01);  // Shift and store only the LSB (9th bit)
    received_data = temp_data;                     // Store complete 9-bit data
    transfer_complete = true;                      // Mark transfer as complete
    temp_data = 0;                                 // Reset temporary data for the next transfer
  }
  
  bit_count++;
  if (bit_count >= 9) {
    bit_count = 0;  // Reset bit count after receiving 9 bits
  }
  
  // Send the next 8 or 1 bit back to master
  if (bit_count < 8) {
    SPDR = send_data[0];  // Send the first 8 bits
  } else {
    SPDR = send_data[1] & 0x01;  // Send the 9th bit
  }
}

uint16_t setRandomZeroBitToOne(uint16_t value) {
  // Ensure only 9 bits are considered (masking with 0x1FF, which is 9 bits of 1s)

 

  value &= 0x1FF;

  // Find positions where bits are 0
  uint8_t zeroBitPositions[9];
  int count = 0;

  for (int i = 0; i < 9; i++) {
    if ((value & (1 << i)) == 0) {  // If bit is 0
      zeroBitPositions[count++] = i;  // Store the position
    }
  }

  // If there are no zero bits, return the original value
  if (count == 0) {
    return value;
  }

  // Choose a random zero bit position and set it to 1
  int randomIndex = random(0, count);
  int bitToSet = zeroBitPositions[randomIndex];
  value |= (1 << bitToSet);  // Set the chosen bit to 1

  
  return value;
}



void loop() {
  // Check if a 9-bit transfer has been completed
  if (transfer_complete) {
    Serial.print("Received 9-bit data: ");
    Serial.println(received_data, BIN);  // Print the 9-bit data in binary format

    uint16_t sendDataTemp = setRandomZeroBitToOne(received_data);
    received_data = 0;
    Serial.print("modified matrix");
  Serial.println(sendDataTemp,BIN);
    // Example: Update data to send back
    send_data[0] = (sendDataTemp >> 1) & 0xFF;  // First 8 bits of response
    send_data[1] = sendDataTemp & 0x01;         // 9th bit of response

    transfer_complete = false;  // Reset transfer flag
  }
}
