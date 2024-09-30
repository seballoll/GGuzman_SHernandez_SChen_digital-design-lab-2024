module Pantalla_Gano_J2 (
    input logic [9:0] x, y,            // Coordenadas actuales de píxel
    output logic [7:0] r, g, b         // Salida de color RGB
); 

    // Variables para las letras
    logic letter_G, letter_A, letter_N, letter_O, letter_J, letter_2;

    // Coordenadas y tamaños de las letras en píxeles
    logic [10:0] letter_width, letter_height;
    logic [10:0] G_left, G_right, A_left, A_right, N_left, N_right, O_left, O_right, J_left, J_right, two_left, two_right;
    logic [10:0] letter_top, letter_bottom;

    // Asignación constante de tamaños y posiciones
    initial begin
        letter_width = 10'd40;
        letter_height = 10'd80;

        // Posiciones iniciales de las letras
        G_left = 10'd50;
        A_left = G_left + letter_width + 10;
        N_left = A_left + letter_width + 10;
        O_left = N_left + letter_width + 10;
        J_left = O_left + letter_width + 40;  // Espacio adicional antes de "J"
        two_left = J_left + letter_width + 10;

        // Asignar top y bottom para las letras
        letter_top = 10'd100;
        letter_bottom = letter_top + letter_height;
    end

    // Asignación de posiciones derivadas
    always_comb begin
        G_right = G_left + letter_width;
        A_right = A_left + letter_width;
        N_right = N_left + letter_width;
        O_right = O_left + letter_width;
        J_right = J_left + letter_width;
        two_right = two_left + letter_width;
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

        // Letra N
        letter_N = ((x >= N_left && x <= N_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == N_left || x == N_right) || // Bordes laterales de la N
                    (y <= letter_top + 30 && x == N_left + (y - letter_top)) // Diagonal de la N
                   );

        // Letra O
        letter_O = ((x >= O_left && x <= O_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == O_left || x == O_right) || // Bordes laterales de la O
                    (y == letter_top || y == letter_bottom) // Bordes superior e inferior
                   );

        // Letra J
        letter_J = ((x >= J_left && x <= J_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) ||  // Borde superior de la J
                    (x == J_left + 5 && y >= letter_top + 10) || // Línea vertical de la J
                    (y == letter_bottom && x >= J_left && x <= J_left + letter_width / 2) // Borde inferior curvo de la J
                   );

        // Número 2
        letter_2 = ((x >= two_left && x <= two_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top || y == letter_bottom) || // Bordes superior e inferior
                    (x == two_left + letter_width && y <= letter_top + 30) || // Borde derecho de la parte superior
                    (x == two_left && y > letter_top + 30) // Borde izquierdo de la parte inferior
                   );
    end

    // Asignar el color a las letras
    assign r = (letter_G || letter_A || letter_N || letter_O || letter_J || letter_2) ? 8'hFF : 8'h00;
    assign g = (letter_G || letter_A || letter_N || letter_O || letter_J || letter_2) ? 8'h00 : 8'h00;
    assign b = (letter_G || letter_A || letter_N || letter_O || letter_J || letter_2) ? 8'h00 : 8'h00;

endmodule
