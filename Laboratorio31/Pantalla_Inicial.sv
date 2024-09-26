module Pantalla_Inicial(
    input logic [9:0] x, y, 
    output logic [7:0] r, g, b
); 

logic letter_G, letter_A, letter_T, letter_O;

// Coordenadas y tamaños de las letras en píxeles
logic [10:0] letter_width, letter_height;
logic [10:0] G_left, G_right, A_left, A_right, T_left, T_right, O_left, O_right;
logic [10:0] letter_top, letter_bottom;

// Asignación constante de tamaños y posiciones
initial begin
    letter_width = 10'd50;
    letter_height = 10'd80;

    // Posiciones iniciales de las letras
    G_left = 10'd50;
    A_left = 10'd120;
    T_left = 10'd190;
    O_left = 10'd260;

    // Asignar top y bottom para las letras
    letter_top = 10'd100;
    letter_bottom = letter_top + letter_height;
end

// Asignación de posiciones derivadas
always_comb begin
    G_right = G_left + letter_width;
    A_right = A_left + letter_width;
    T_right = T_left + letter_width;
    O_right = O_left + letter_width;
end

// Funciones para definir cada letra
always_comb begin
    // Letra G
    letter_G = ((x >= G_left && x <= G_right) && (y >= letter_top && y <= letter_bottom)) &&
               (
                (y == letter_top) || // Borde superior de la G
                (y == letter_bottom) || // Borde inferior de la G
                (x == G_left) || // Borde izquierdo
                (x == G_right && y >= letter_top + 30) || // Borde derecho en la mitad inferior
                (y == letter_top + 40 && x >= G_left + 20) // Parte interna de la G
               );

    // Letra A
    letter_A = ((x >= A_left && x <= A_right) && (y >= letter_top && y <= letter_bottom)) &&
               (
                (y == letter_top) || // Borde superior de la A
                (x == A_left || x == A_right) || // Bordes laterales de la A
                (y == letter_top + 40 && x >= A_left + 10 && x <= A_right - 10) // Línea horizontal en el centro
               );

    // Letra T
    letter_T = ((x >= T_left && x <= T_right) && (y >= letter_top && y <= letter_bottom)) &&
               (
                (y == letter_top) || // Borde superior de la T
                (x == T_left + 25) // Línea vertical en el centro de la T
               );

    // Letra O
    letter_O = ((x >= O_left && x <= O_right) && (y >= letter_top && y <= letter_bottom)) &&
               (
                (y == letter_top) || // Borde superior de la O
                (y == letter_bottom) || // Borde inferior de la O
                (x == O_left || x == O_right) // Bordes laterales de la O
               );
end

// Asignar el color a las letras
assign r = (letter_G || letter_A || letter_T || letter_O) ? 8'hFF : 8'h00; // Color rojo para las letras
assign g = (letter_G || letter_A || letter_T || letter_O) ? 8'h00 : 8'h00; // Sin verde
assign b = (letter_G || letter_A || letter_T || letter_O) ? 8'h00 : 8'h00; // Sin azul

endmodule

