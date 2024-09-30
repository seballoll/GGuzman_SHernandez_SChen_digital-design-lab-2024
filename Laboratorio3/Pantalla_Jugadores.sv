module Pantalla_Jugadores (
    input logic [9:0] x, y,            // Coordenadas actuales de píxel
    output logic [7:0] r, g, b         // Salida de color RGB
); 

    // Variables para las letras
    logic letter_M, letter_U, letter_L, letter_T, letter_I, letter_J, letter_A, letter_D, letter_O, letter_R, letter_G;

    // Coordenadas y tamaños de las letras en píxeles
    logic [10:0] letter_width, letter_height;
    logic [10:0] M_left, M_right, U_left, U_right, L_left, L_right, T_left, T_right, I_left, I_right, J_left, J_right;
    logic [10:0] A_left, A_right, D_left, D_right, O_left, O_right, R_left, R_right, G_left, G_right;
    logic [10:0] letter_top, letter_bottom;

    // Asignación constante de tamaños y posiciones
    initial begin
        letter_width = 10'd40;
        letter_height = 10'd80;

        // Posiciones iniciales de las letras
        M_left = 10'd50;
        U_left = M_left + letter_width + 10;
        L_left = U_left + letter_width + 10;
        T_left = L_left + letter_width + 10;
        I_left = T_left + letter_width + 10;
        J_left = I_left + letter_width + 10;
        G_left = J_left + letter_width + 10;
        A_left = G_left + letter_width + 10;
        D_left = A_left + letter_width + 10;
        O_left = D_left + letter_width + 10;
        R_left = O_left + letter_width + 10;

        // Asignar top y bottom para las letras
        letter_top = 10'd100;
        letter_bottom = letter_top + letter_height;
    end

    // Asignación de posiciones derivadas
    always_comb begin
        M_right = M_left + letter_width;
        U_right = U_left + letter_width;
        L_right = L_left + letter_width;
        T_right = T_left + letter_width;
        I_right = I_left + letter_width;
        J_right = J_left + letter_width;
        G_right = G_left + letter_width;
        A_right = A_left + letter_width;
        D_right = D_left + letter_width;
        O_right = O_left + letter_width;
        R_right = R_left + letter_width;
    end

    // Funciones para definir cada letra
    always_comb begin
        // Letra M
        letter_M = ((x >= M_left && x <= M_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == M_left || x == M_right) || // Bordes laterales de la M
                    (y <= letter_top + 30 && x == M_left + (y - letter_top)) || // Diagonal izquierda
                    (y <= letter_top + 30 && x == M_right - (y - letter_top))  // Diagonal derecha
                   );

        // Letra U
        letter_U = ((x >= U_left && x <= U_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == U_left || x == U_right) || // Bordes laterales de la U
                    (y == letter_bottom) // Borde inferior curvo de la U
                   );

        // Letra L
        letter_L = ((x >= L_left && x <= L_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == L_left) || // Borde izquierdo de la L
                    (y == letter_bottom) // Borde inferior de la L
                   );

        // Letra T
        letter_T = ((x >= T_left && x <= T_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) || // Borde superior de la T
                    (x == T_left + letter_width / 2) // Línea vertical de la T
                   );

        // Letra I
        letter_I = ((x >= I_left && x <= I_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == I_left + letter_width / 2) // Línea vertical de la I
                   );

        // Letra J
        letter_J = ((x >= J_left && x <= J_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) ||  // Borde superior de la J
                    (x == J_left + 5 && y >= letter_top + 10) || // Línea vertical de la J
                    (y == letter_bottom && x >= J_left && x <= J_left + letter_width / 2) // Borde inferior curvo de la J
                   );

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

        // Letra D
        letter_D = ((x >= D_left && x <= D_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == D_left) || // Borde izquierdo de la D
                    (x == D_right && y >= letter_top && y <= letter_bottom) || // Borde derecho curvado
                    (y == letter_top) || // Borde superior
                    (y == letter_bottom) // Borde inferior
                   );

        // Letra O
        letter_O = ((x >= O_left && x <= O_right) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == O_left || x == O_right) || // Bordes laterales de la O
                    (y == letter_top || y == letter_bottom) // Bordes superior e inferior
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
    end

    // Asignar el color a las letras
    assign r = (letter_M || letter_U || letter_L || letter_T || letter_I || letter_J || letter_G || letter_A || letter_D || letter_O || letter_R) ? 8'hFF : 8'h00;
    assign g = (letter_M || letter_U || letter_L || letter_T || letter_I || letter_J || letter_G || letter_A || letter_D || letter_O || letter_R) ? 8'h00 : 8'h00;
    assign b = (letter_M || letter_U || letter_L || letter_T || letter_I || letter_J || letter_G || letter_A || letter_D || letter_O || letter_R) ? 8'h00 : 8'h00;

endmodule

