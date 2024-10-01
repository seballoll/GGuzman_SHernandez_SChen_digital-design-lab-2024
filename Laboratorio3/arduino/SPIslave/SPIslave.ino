#include <SPI.h>

volatile bool data_ready = false;  // Flag to indicate full 9-bit transfer complete
volatile uint8_t received_byte = 0;
volatile uint8_t send_byte = 0;


#define indexButton 6
#define confirmButton 7

volatile uint8_t index;
volatile uint8_t indexPlayer;
int confirmation;

int Matrix[18] ;

void setup() {
  // Initialize SPI as slave
  pinMode(MISO, OUTPUT);  // MISO is the Arduino output (to FPGA or master)
  SPCR |= _BV(SPE);       // Enable SPI in slave mode
  
  // Enable SPI interrupt
  SPI.attachInterrupt();
  
  initializeMatrixToZero();
  confirmation = 0;

  pinMode(indexButton, INPUT);
  pinMode(confirmButton, INPUT);

  // Initialize serial communication for debugging
  Serial.begin(9600);
  Serial.println("Arduino SPI Slave Ready");
}

ISR(SPI_STC_vect) {
   received_byte = SPDR;
  //static uint8_t bit_count = 0;  // To count bits received
  //static uint16_t temp_data = 0; // Temporary storage for the received data
  
        // Ejemplo: índice de la jugada del Arduino
        // Confirmar que la jugada es válida
  index = 0x1F;
  // 00000 0 0 0
  send_byte = (index << 5) | ( 0 << 2) | (1 << 1) | (confirmation << 0);  // Jugada del Arduino

  // Enviar el byte en la siguiente transferencia
  //SPDR = send_byte;
  //Serial.print("Package sent> ");
  //Serial.println(send_byte);

  confirmation = 0;
  
  data_ready = true;  // Marcar que los datos están listos para ser procesados
}


void initializeMatrixToZero() {
    for (int i = 0; i < 18; i++) {
        Matrix[i] = 0;  // Colocar el valor en 0
    }
}


void printMatrix() {
    for (int i = 0; i < 18; i++) {
        Serial.print(Matrix[i]) ;  // Colocar el valor en 0
    }

    Serial.println();
}


void selectRandomEvenIndex( ) {
    // Inicializar la semilla para números aleatorios
    

    // Contador para verificar cuántas posiciones pares no son 1
    int valid_positions[9];  // Máximo 9 posiciones pares en la matriz de 18 elementos
    int count = 0;

    // Buscar posiciones pares que no sean iguales a 1
    for (int i = 0; i < 18; i += 2) {
        if (Matrix[i] != 1) {
            valid_positions[count] = i;  // Guardar el índice válido
            count++;
        }
    }

    int random_index_pos = random(0, 9);
    if (count > 0) { 
      int ready = 1;  
       while(ready){
          if(Matrix[valid_positions[random_index_pos]] != 1 && Matrix[valid_positions[random_index_pos]+1] != 1){
            index = valid_positions[random_index_pos];   // Guardar el índice en 5 bits (0-31)
            Matrix[index] = 1;
            ready = 0;
            confirmation = 1;
          }
          else{
            random_index_pos = random(0, 9);
          }
          
       }
        
      
    }else {
      index = -1;
    }

}



void loop() {
  // Check if a 9-bit transfer has been completed

  static bool indexButtonPressed = false; // Estado del botón (presionado o no)
  static bool confirmButtonPressed = false; // Estado del botón (presionado o no)
  
  // Lee el estado del botón (HIGH significa presionado, LOW significa no presionado)
  int indexButtonState = digitalRead(indexButton);
  int confirmButtonState = digitalRead(confirmButton);

  // Si el botón se presiona (estado HIGH) y no estaba previamente presionado
  if (indexButtonState == HIGH && !indexButtonPressed) {
    indexButtonPressed = true;  // Marca el botón como presionado
  }
  if (confirmButtonState == HIGH && !confirmButtonPressed) {
    confirmButtonPressed = true;  // Marca el botón como presionado
  }

  // Si el botón se suelta (estado LOW) y estaba previamente presionado
  if (indexButtonState == LOW && indexButtonPressed) {
    indexButtonPressed = false; // Marca el botón como no presionado

    // Incrementa el índice
    index = index + 2;
    if(index > 15){
      index = 0;
    }
    index &= 0x1F;  // Asegura que el índice no exceda 5 bits (0-31)

    // Imprime el valor del índice para depuración
    Serial.print("Index incremented: ");
    Serial.println(index);
  }


// Si el botón se suelta (estado LOW) y estaba previamente presionado
  if (confirmButtonState == LOW && confirmButtonPressed) {
    confirmButtonPressed = false; // Marca el botón como no presionado

    
  }


   if (data_ready) {
    // Procesar el byte recibido de la FPGA
     indexPlayer = (received_byte >> 5) & 0x1F;  // Extraer los 4 bits del índice
    bool move_valid = (received_byte >> 2) & 0x01;     // Extraer bit de confirmación
    bool move_from_fpga = (received_byte >> 1) & 0x00; // Bit: jugada de la FPGA
     // Bit: jugada de Arduino
    bool info_ready = received_byte & 0x01;            // Bit: datos listos

    // Mostrar datos recibidos en el monitor serial
    Serial.print("Received byte: ");
    Serial.println(received_byte, BIN);
    Serial.print("Move index: ");
    Serial.println(indexPlayer, BIN);
    Serial.print("Move valid: ");
    Serial.println(move_valid);
    Serial.print("Move from FPGA: ");
    Serial.println(move_from_fpga);
    Serial.print("Info ready: ");
    Serial.println(info_ready);
    
    data_ready = false;  // Resetear bandera
  }
/*
  selectRandomEvenIndex( );
  Serial.print("Matrix: ");
  printMatrix();
  Serial.print("Index: ");
  Serial.println(index);
  delay(5000);*/

}
