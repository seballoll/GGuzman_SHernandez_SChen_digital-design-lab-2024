module videoGen (
    input logic [9:0] x, y,
    input logic clk,                      // Reloj VGA
    output logic [7:0] r, g, b
);

    // Dirección para acceder a cada ROM con 17 bits (suficiente para 120000 direcciones)
    logic [16:0] addr_r, addr_g, addr_b;
    logic [7:0] r_data, g_data, b_data;   // Datos de cada canal

    // Instancias de ROM independientes para cada canal
    rombit rom_r_inst (
        .address(addr_r),
        .clock(clk),
        .q(r_data)
    );

    rombit rom_g_inst (
        .address(addr_g),
        .clock(clk),
        .q(g_data)
    );

    rombit rom_b_inst (
        .address(addr_b),
        .clock(clk),
        .q(b_data)
    );

    // Calcular las direcciones para cada canal basado en la posición centrada
    always_comb begin
        if (x >= 220 && x < 420 &&
            y >= 140 && y < 340) begin
            addr_r = (y - 140) * 200 + (x - 220);       // Dirección del canal Rojo
            addr_g = addr_r + 40000;                    // Dirección del canal Verde
            addr_b = addr_r + 80000;                    // Dirección del canal Azul
        end else begin
            addr_r = 17'h0;
            addr_g = 17'h0;
            addr_b = 17'h0;
        end
    end

    // Asignar los valores RGB sincronizados con el reloj
    always_ff @(posedge clk) begin
        if (x >= 220 && x < 420 &&
            y >= 140 && y < 340) begin
            r <= r_data;   // Canal Rojo
            g <= g_data;   // Canal Verde
            b <= b_data;   // Canal Azul
        end else begin
            r <= 8'h00;
            g <= 8'h00;
            b <= 8'h00;
        end
    end

endmodule




