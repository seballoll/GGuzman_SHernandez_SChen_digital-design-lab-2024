module spiMaster (
    input wire clk,               // Reloj del sistema
    input wire rst_n,             // Reset activo en bajo
    input wire start,             // Señal para iniciar la transferencia
    input wire [4:0] move_index,  // Índice de la jugada (0-31)
    output reg done,              // Señal de finalización
    output reg [7:0] received_data // Dato recibido del Arduino
);

    // Señales SPI internas
    reg mosi;                     // Master Out, Slave In
    reg miso;                     // Master In, Slave Out
    reg sclk;                     // Reloj SPI
    reg ss;                       // Selección de esclavo (activo en bajo)

    reg [7:0] spi_data;           // Byte de datos para transmitir
    reg [2:0] bit_cnt;            // Contador de bits (0-7)
    reg [7:0] recv_data;          // Registro para almacenar el byte recibido
    reg spi_active;               // Bandera para actividad SPI

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            ss <= 1;              // Desactivar esclavo
            sclk <= 0;            // Reloj en bajo
            done <= 0;
            bit_cnt <= 0;
            spi_active <= 0;
            received_data <= 0;
        end else begin
            if (!spi_active && start) begin
                // Preparar el byte de datos: [7-3] Índice de jugada (5 bits), [2] Confirmar, [1] FPGA, [0] Info lista
                spi_data <= {move_index, 1'b1, 1'b1, 1'b1}; // Jugada de la FPGA con índice de 5 bits
                ss <= 0;           // Seleccionar esclavo
                bit_cnt <= 0;
                spi_active <= 1;
                done <= 0;
            end

            // Ciclo de transferencia de bits SPI
            if (spi_active) begin
                sclk <= ~sclk;     // Alternar el reloj SPI
                if (sclk == 0) begin
                    mosi <= spi_data[7 - bit_cnt];  // Enviar bit más significativo primero
                    recv_data[7 - bit_cnt] <= miso; // Leer bit desde el Arduino
                    bit_cnt <= bit_cnt + 1;

                    if (bit_cnt == 7) begin
                        ss <= 1;                  // Desactivar esclavo
                        spi_active <= 0;          // Finalizar la transferencia
                        received_data <= recv_data; // Almacenar el byte recibido
                        done <= 1;                // Transferencia completada
                    end
                end
            end
        end
    end
endmodule

/*
spiMaster spi_master_inst (
        .clk(clk),                 // Conectado al reloj del sistema
        .rst_n(rst_n),             // Reset activo en bajo
        .start(start_transfer),    // Señal para iniciar la transferencia
        .move_index(move_index),   // Índice de jugada de 5 bits
        .done(done),               // Señal de finalización de transferencia
        .received_data(received_data) // Dato recibido del Arduino
    );*/