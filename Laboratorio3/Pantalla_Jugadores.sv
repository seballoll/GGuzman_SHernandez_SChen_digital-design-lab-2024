module Pantalla_Jugadores (
    input logic [9:0] x, y,           // Coordenadas actuales de píxel
    output logic [7:0] r, g, b        // Salida de color RGB
);

    // Variables para las letras
    logic letter_J, letter_U, letter_G, letter_A, letter_D, letter_E, letter_R, number_1, number_2;
    logic letter_V, letter_S, question_mark;

    // Coordenadas y tamaños de las letras en píxeles
    logic [10:0] letter_width, letter_height;
    logic [10:0] J_left, U_left, G_left, A_left, D_left, E_left, R_left, vs_left, question_left;
    logic [10:0] letter_top, letter_bottom;
    logic [10:0] number_1_left, number_2_left;

    // Asignación constante de tamaños y posiciones
    initial begin
        letter_width = 10'd40;     // Ancho de cada letra
        letter_height = 10'd60;    // Altura de cada letra

        // Posiciones iniciales de las letras (izquierda)
        J_left = 10'd50;           // "Jugador" comienza en x = 50
        U_left = J_left + letter_width;
        G_left = U_left + letter_width;
        A_left = G_left + letter_width;
        D_left = A_left + letter_width;
        E_left = D_left + letter_width;
        R_left = E_left + letter_width;
        number_1_left = R_left + letter_width + 20;  // Un pequeño espacio extra antes del "1"
        
        vs_left = number_1_left + letter_width + 20; // Espacio extra para "vs"
        number_2_left = vs_left + letter_width + 20; // Un espacio extra antes del "2"
        question_left = number_2_left + letter_width + 20; // Posición de "?"

        // Asignar top y bottom para las letras
        letter_top = 10'd100;      // Parte superior de las letras
        letter_bottom = letter_top + letter_height;  // Parte inferior de las letras
    end

    // Funciones para definir cada letra
    always_comb begin
        // Letra J
        letter_J = ((x >= J_left && x <= J_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) ||  // Borde superior de la J
                    (x == J_left + 5 && y >= letter_top + 10) || // Línea vertical de la J
                    (y == letter_bottom && x >= J_left && x <= J_left + letter_width / 2) // Borde inferior curvo de la J
                   );

        // Letra U
        letter_U = ((x >= U_left && x <= U_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == U_left || x == U_left + letter_width) || // Bordes laterales de la U
                    (y == letter_bottom && x > U_left + 10 && x < U_left + letter_width - 10) // Borde inferior curvo de la U
                   );

        // Letra G
        letter_G = ((x >= G_left && x <= G_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) || // Borde superior de la G
                    (y == letter_bottom) || // Borde inferior de la G
                    (x == G_left) || // Borde izquierdo de la G
                    (x == G_left + letter_width && y >= letter_top + 30) || // Borde derecho de la G en la mitad inferior
                    (y == letter_top + 30 && x >= G_left + 20) // Parte interna de la G
                   );

        // Letra A
        letter_A = ((x >= A_left && x <= A_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top) || // Borde superior de la A
                    (x == A_left || x == A_left + letter_width) || // Bordes laterales de la A
                    (y == letter_top + 30 && x >= A_left + 10 && x <= A_left + letter_width - 10) // Línea horizontal en el centro
                   );

        // Letra D
        letter_D = ((x >= D_left && x <= D_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == D_left) || // Borde izquierdo de la D
                    (x == D_left + letter_width && y >= letter_top && y <= letter_bottom) || // Borde derecho curvado
                    (y == letter_top) || // Borde superior
                    (y == letter_bottom) // Borde inferior
                   );

        // Letra E
        letter_E = ((x >= E_left && x <= E_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == E_left) || // Borde izquierdo de la E
                    (y == letter_top || y == letter_bottom || y == letter_top + 30) // Bordes horizontales
                   );

        // Letra R
        letter_R = ((x >= R_left && x <= R_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == R_left) || // Borde izquierdo de la R
                    (y == letter_top) || // Borde superior de la R
                    (x == R_left + letter_width && y <= letter_top + 30) || // Borde derecho de la parte superior de la R
                    (y == letter_top + 30 && x >= R_left && x <= R_left + letter_width - 10) || // Línea horizontal en el centro
                    (x == R_left + 20 && y > letter_top + 30) // Diagonal para la pierna de la R
                   );

        // Número 1
        number_1 = ((x >= number_1_left && x <= number_1_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == number_1_left + letter_width / 2) // Línea vertical en el centro
                   );

        // Número 2
        number_2 = ((x >= number_2_left && x <= number_2_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top || y == letter_bottom) || // Bordes superior e inferior
                    (x == number_2_left + letter_width && y <= letter_top + 30) || // Borde derecho de la parte superior
                    (x == number_2_left && y > letter_top + 30) // Borde izquierdo de la parte inferior
                   );

        // Letras V y S para "vs"
        letter_V = ((x >= vs_left && x <= vs_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (x == vs_left + y - letter_top || x == vs_left + letter_width - (y - letter_top)); // Diagonal de la V

        letter_S = ((x >= vs_left + letter_width + 10 && x <= vs_left + letter_width + 10 + letter_width) && 
                    (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top || y == letter_bottom || y == letter_top + 30) || // Bordes horizontales
                    (x == vs_left + letter_width + 10 && y <= letter_top + 30) || // Borde izquierdo de la parte superior
                    (x == vs_left + letter_width + 10 + letter_width && y > letter_top + 30) // Borde derecho de la parte inferior
                   );

        // Signo de interrogación
        question_mark = ((x >= question_left && x <= question_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                        (
                         (y == letter_top) || // Borde superior del signo
                         (x == question_left + letter_width / 2 && y > letter_top + 10 && y <= letter_top + 30) || // Parte media del signo
                         (y == letter_top + 40 && x >= question_left + 10 && x <= question_left + 30) || // Curva inferior
                         (x == question_left + letter_width / 2 && y > letter_top + 50) // Punto del signo de interrogación
                        );
    end

    // Variable auxiliar para saber si el píxel pertenece a una letra
    logic draw_letter;
    always_comb begin
        draw_letter = letter_J || letter_U || letter_G || letter_A || letter_D || letter_E || letter_R || number_1 || 
                      letter_V || letter_S || number_2 || question_mark;
    end

    // Asignar el color a las letras
    assign r = draw_letter ? 8'hFF : 8'h00; // Letras en rojo
    assign g = 8'h00;  // Sin componente verde
    assign b = 8'h00;  // Sin componente azul

endmodule
