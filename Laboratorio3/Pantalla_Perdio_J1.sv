module Pantalla_Perdio_J1 (
    input logic [9:0] x, y,            // Coordenadas actuales de píxel
    output logic [7:0] r, g, b         // Salida de color RGB
); 

    // Variables para las letras
    logic letter_P, letter_E, letter_R, letter_D, letter_I, letter_O, letter_J, letter_1;

    // Coordenadas y tamaños de las letras en píxeles
    logic [10:0] letter_width, letter_height;
    logic [10:0] P_left, P_right, E_left, E_right, R_left, R_right, D_left, D_right, I_left, I_right, O_left, O_right;
    logic [10:0] J_left, J_right, one_left, one_right;
    logic [10:0] letter_top, letter_bottom;

    // Asignación constante de tamaños y posiciones
    initial begin
        letter_width = 10'd40;
        letter_height = 10'd80;

        // Posiciones iniciales de las letras
        P_left = 10'd50;
        E_left = P_left + letter_width + 10;
        R_left = E_left + letter_width + 10;
        D_left = R_left + letter_width + 10;
        I_left = D_left + letter_width + 10;
        O_left = I_left + letter_width + 10;
        J_left = O_left + letter_width + 40;  // Espacio adicional antes de "J"
        one_left = J_left + letter_width + 10;

        // Asignar top y bottom para las letras
        letter_top = 10'd100;
        letter_bottom = letter_top + letter_height;
    end

    // Asignación de posiciones derivadas
    always_comb begin
        P_right = P_left + letter_width;
        E_right = E_left + letter_width;
        R_right = R_left + letter_width;
        D_right = D_left + letter_width;
        I_right = I_left + letter_width;
        O_right = O_left + letter_width;
        J_right = J_left + letter_width;
        one_right = one_left + letter_width;
    end

    // Funciones para definir cada letra
    always_comb begin
        // Letra P
        letter_P = ((x >= P_left && x <= P_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == P_left) || // Borde izquierdo de la P
                    (y == letter_top) || // Borde superior de la P
                    (x == P_right && y <= letter_top + 40) || // Borde derecho curvado
                    (y == letter_top + 40) // Línea horizontal en la mitad
                   );

        // Letra E
        letter_E = ((x >= E_left && x <= E_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == E_left) || // Borde izquierdo de la E
                    (y == letter_top || y == letter_bottom || y == letter_top + 40) // Bordes horizontales
                   );

        // Letra R
        letter_R = ((x >= R_left && x <= R_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == R_left) || // Borde izquierdo de la R
                    (y == letter_top) || // Borde superior de la R
                    (x == R_right && y <= letter_top + 30) || // Borde derecho de la parte superior de la R
                    (y == letter_top + 30 && x >= R_left && x <= R_right - 10) || // Línea horizontal en el centro
                    (x == R_left + 20 && y > letter_top + 30) // Diagonal para la pierna de la R
                   );

        // Letra D
        letter_D = ((x >= D_left && x <= D_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == D_left) || // Borde izquierdo de la D
                    (x == D_right && y >= letter_top && y <= letter_bottom) || // Borde derecho curvado
                    (y == letter_top) || // Borde superior
                    (y == letter_bottom) // Borde inferior
                   );

        // Letra I
        letter_I = ((x >= I_left && x <= I_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == I_left + letter_width / 2) // Línea vertical de la I
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

        // Número 1
        letter_1 = ((x >= one_left && x <= one_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == one_left + letter_width / 2) // Línea vertical en el centro del "1"
                   );
    end

    // Asignar el color a las letras
    assign r = (letter_P || letter_E || letter_R || letter_D || letter_I || letter_O || letter_J || letter_1) ? 8'hFF : 8'h00;
    assign g = (letter_P || letter_E || letter_R || letter_D || letter_I || letter_O || letter_J || letter_1) ? 8'h00 : 8'h00;
    assign b = (letter_P || letter_E || letter_R || letter_D || letter_I || letter_O || letter_J || letter_1) ? 8'h00 : 8'h00;

endmodule
