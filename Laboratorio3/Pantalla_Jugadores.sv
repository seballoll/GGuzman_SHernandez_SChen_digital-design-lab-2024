module Pantalla_Jugadores (
    input logic [9:0] x, y,           // Coordenadas actuales de píxel
    output logic [7:0] r, g, b        // Salida de color RGB
);

    // Variables para las letras
    logic letter_J1, letter_V, letter_S, letter_J2;

    // Coordenadas y tamaños de las letras en píxeles
    logic [10:0] letter_width, letter_height;
    logic [10:0] J1_left, J2_left, vs_left;
    logic [10:0] letter_top, letter_bottom;

    // Asignación constante de tamaños y posiciones
    initial begin
        letter_width = 10'd40;     // Ancho de cada letra
        letter_height = 10'd60;    // Altura de cada letra

        // Posiciones iniciales de las letras (izquierda)
        J1_left = 10'd50;          // "J1" comienza en x = 50
        vs_left = J1_left + letter_width + 40; // Espacio extra para "vs"
        J2_left = vs_left + letter_width + 40; // Espacio extra antes del "J2"

        // Asignar top y bottom para las letras
        letter_top = 10'd100;      // Parte superior de las letras
        letter_bottom = letter_top + letter_height;  // Parte inferior de las letras
    end

    // Funciones para definir cada letra
    always_comb begin
        // Letra J para "J1"
        letter_J1 = ((x >= J1_left && x <= J1_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                    (
                     (y == letter_top) ||  // Borde superior de la J
                     (x == J1_left + 5 && y >= letter_top + 10) || // Línea vertical de la J
                     (y == letter_bottom && x >= J1_left && x <= J1_left + letter_width / 2) // Borde inferior curvo de la J
                    );

        // Número 1 para "J1"
        letter_J1 = letter_J1 || ((x >= J1_left + letter_width && x <= J1_left + 2*letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (x == J1_left + letter_width + letter_width / 2) // Línea vertical en el centro
                   );

        // Letra V para "vs"
        letter_V = ((x >= vs_left && x <= vs_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (x == vs_left + y - letter_top || x == vs_left + letter_width - (y - letter_top)); // Diagonal de la V

        // Letra S para "vs"
        letter_S = ((x >= vs_left + letter_width + 10 && x <= vs_left + letter_width + 10 + letter_width) && 
                    (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top || y == letter_bottom || y == letter_top + 30) || // Bordes horizontales
                    (x == vs_left + letter_width + 10 && y <= letter_top + 30) || // Borde izquierdo de la parte superior
                    (x == vs_left + letter_width + 10 + letter_width && y > letter_top + 30) // Borde derecho de la parte inferior
                   );

        // Letra J para "J2"
        letter_J2 = ((x >= J2_left && x <= J2_left + letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                    (
                     (y == letter_top) ||  // Borde superior de la J
                     (x == J2_left + 5 && y >= letter_top + 10) || // Línea vertical de la J
                     (y == letter_bottom && x >= J2_left && x <= J2_left + letter_width / 2) // Borde inferior curvo de la J
                    );

        // Número 2 para "J2"
        letter_J2 = letter_J2 || ((x >= J2_left + letter_width && x <= J2_left + 2*letter_width) && (y >= letter_top && y <= letter_bottom)) &&
                   (
                    (y == letter_top || y == letter_bottom) || // Bordes superior e inferior
                    (x == J2_left + letter_width && y <= letter_top + 30) || // Borde derecho de la parte superior
                    (x == J2_left && y > letter_top + 30) // Borde izquierdo de la parte inferior
                   );
    end

    // Variable auxiliar para saber si el píxel pertenece a una letra
    logic draw_letter;
    always_comb begin
        draw_letter = letter_J1 || letter_V || letter_S || letter_J2;
    end

    // Asignar el color a las letras
    assign r = draw_letter ? 8'hFF : 8'h00; // Letras en rojo
    assign g = 8'h00;  // Sin componente verde
    assign b = 8'h00;  // Sin componente azul

endmodule
