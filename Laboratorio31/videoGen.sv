module videoGen(input logic [9:0] x, y, 
                output logic [7:0] r, g, b);

logic verticalLine1, verticalLine2, horizontalLine1, horizontalLine2;
logic [10:0] squareSize = 10'd40;
logic [10:0] spacing = 10'd10;
logic [10:0] topOffset = 10'd150;  // Desplazamiento vertical
logic [10:0] leftOffset = 10'd230; // Desplazamiento horizontal
logic line; // Variable para combinar las líneas

// Generamos las líneas verticales del tablero de Tic-Tac-Toe con longitud limitada
assign verticalLine1 = (x >= leftOffset + squareSize + spacing && x <= leftOffset + squareSize + spacing + 2 && 
                        y >= topOffset && y <= topOffset + 3 * squareSize + 2 * spacing);
assign verticalLine2 = (x >= leftOffset + 2 * (squareSize + spacing) && x <= leftOffset + 2 * (squareSize + spacing) + 2 && 
                        y >= topOffset && y <= topOffset + 3 * squareSize + 2 * spacing);

// Generamos las líneas horizontales del tablero de Tic-Tac-Toe con longitud limitada
assign horizontalLine1 = (y >= topOffset + squareSize + spacing && y <= topOffset + squareSize + spacing + 2 && 
                          x >= leftOffset && x <= leftOffset + 3 * squareSize + 2 * spacing);
assign horizontalLine2 = (y >= topOffset + 2 * (squareSize + spacing) && y <= topOffset + 2 * (squareSize + spacing) + 2 && 
                          x >= leftOffset && x <= leftOffset + 3 * squareSize + 2 * spacing);

// Combinamos todas las líneas para determinar si debemos dibujar un píxel
assign line = verticalLine1 | verticalLine2 | horizontalLine1 | horizontalLine2;

// Asignamos color azul a las líneas del tablero
assign r = 8'h00;
assign g = 8'h00;
assign b = (line) ? 8'hFF : 8'h00;

endmodule