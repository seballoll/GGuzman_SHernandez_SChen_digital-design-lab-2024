module spiMaster (
    input logic clk,               // Reloj del sistema
    input logic rst_n,             // Reset activo en bajo
    output logic mosi,              // Master Out, Slave In
    input logic miso,              // Master In, Slave Out
    output logic sclk,              // Reloj SPI
    output logic ss,                // Selección de esclavo (activo en bajo)
    input logic start,             // Señal para iniciar la transferencia
    input logic [5:0] move_index,  // Índice de la jugada (0-31)
    output  logic done,              // Señal de finalización
    output  logic [7:0] received_data, // Dato recibido del Arduino
    output  logic spi_active,          // Señal de actividad SPI
	 output logic test1,
	 output logic test2
);

    reg [7:0] spi_data;           // Byte de datos para transmitir
    reg [2:0] bit_cnt;            // Contador de bits (0-7)
    reg [7:0] recv_data;          // Registro para almacenar el byte recibido
    reg [4:0] clk_div;            // Divisor de reloj para reducir frecuencia de sclk (4 bits suficiente para contar hasta 6)
    reg sclk_reg;                 // Registro para alternar sclk
	 
	 

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ss <= 1;              // Desactivar esclavo
            sclk <= 0;            // Poner reloj SPI en bajo
            done <= 0;
            bit_cnt <= 0;
            spi_active <= 0;
            received_data <= 0;
            mosi <= 0;            // Poner MOSI en bajo por defecto
            clk_div <= 0;         // Inicializar divisor de reloj
        end else begin
            // Control de la frecuencia de sclk usando un divisor de reloj
            clk_div <= clk_div + 1;
            if (clk_div == 15) begin  // 5 ciclos del reloj de 50 MHz para generar 4 MHz
                sclk_reg <= ~sclk_reg; // Alternar sclk cada 6 ciclos de reloj
					 //sclk <= sclk_reg;
                clk_div <= 0;          // Reiniciar contador del divisor
            end

            // Iniciar transmisión si `start` está activo y no hay transmisión en curso
            if (!spi_active && start) begin
                spi_data <= {5'b11111, 3'b111}; // Datos a transmitir (índice y flags)   move_indexmove_index
                ss <= 0;           // Seleccionar esclavo (activo en bajo)
                bit_cnt <= 0;
                spi_active <= 1;   // Activar la señal de actividad SPI
                done <= 0;
            end

            // Manejo de la transmisión SPI
            if (spi_active) begin
                       // Asignar la señal alternada a sclk
                if (sclk_reg == 1) begin  // Enviar y recibir datos cuando sclk baja
                    mosi <= spi_data[7 - bit_cnt];  // Enviar bit más significativo primero
						  sclk <= sclk_reg;
						  test1 <= 1;
                    //recv_data[7 - bit_cnt] <= miso; // Leer bit desde el Arduino
						  
                    bit_cnt <= bit_cnt + 1;
						  test2 <= 1;
						  

                    if (bit_cnt == 7) begin
                        ss <= 1;                  // Desactivar esclavo (fin de transmisión)
                        spi_active <= 0;          // Desactivar señal de actividad SPI
                        received_data <= recv_data; // Almacenar el byte recibido
                        done <= 1;                // Señal de finalización de transferencia
                    end
                end
            end
        end
    end
endmodule
