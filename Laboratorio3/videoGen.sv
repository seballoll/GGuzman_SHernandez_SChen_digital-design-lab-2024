module videoGen (
    input logic clk,           // Señal de reloj
    input logic rst_n,         // Señal de reset activo bajo
    input logic [9:0] x, y,    // Coordenadas de píxeles
    input logic [17:0] matrix,  // Matriz que representa el estado de las casillas
	 input logic [1:0] Id,
    output logic [7:0] r, g, b // Salida RGB
);

    // Variables para las líneas del tablero
    logic verticalLine1, verticalLine2, horizontalLine1, horizontalLine2;
    logic [10:0] squareSize = 10'd40;
    logic [10:0] spacing = 10'd10;
    logic [10:0] topOffset = 10'd150;  // Desplazamiento vertical
    logic [10:0] leftOffset = 10'd230; // Desplazamiento horizontal
    logic line; // Variable para combinar las líneas

    // Variables para representar los círculos en cada casilla
    logic [8:0] drawCircle;
	 logic [8:0] drawX;
    logic [10:0] circleRadius = 10'd15; // Radio del círculo

    // Generamos las líneas del tablero de Tic-Tac-Toe (3x3)
    assign verticalLine1 = (x >= leftOffset + squareSize + spacing && x <= leftOffset + squareSize + spacing + 2 && 
                            y >= topOffset && y <= topOffset + 3 * squareSize + 2 * spacing);
    assign verticalLine2 = (x >= leftOffset + 2 * (squareSize + spacing) && x <= leftOffset + 2 * (squareSize + spacing) + 2 && 
                            y >= topOffset && y <= topOffset + 3 * squareSize + 2 * spacing);

    assign horizontalLine1 = (y >= topOffset + squareSize + spacing && y <= topOffset + squareSize + spacing + 2 && 
                              x >= leftOffset && x <= leftOffset + 3 * squareSize + 2 * spacing);
    assign horizontalLine2 = (y >= topOffset + 2 * (squareSize + spacing) && y <= topOffset + 2 * (squareSize + spacing) + 2 && 
                              x >= leftOffset && x <= leftOffset + 3 * squareSize + 2 * spacing);

    // Dibujar los círculos en las casillas donde el bit correspondiente en la matriz es 1
    assign drawCircle[0] = (matrix[1] == 1'b1) && 
                           ((x - (leftOffset + squareSize / 2)) * (x - (leftOffset + squareSize / 2)) + 
                           (y - (topOffset + squareSize / 2)) * (y - (topOffset + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[1] = (matrix[3] == 1'b1) && 
                           ((x - (leftOffset + squareSize + spacing + squareSize / 2)) * (x - (leftOffset + squareSize + spacing + squareSize / 2)) + 
                           (y - (topOffset + squareSize / 2)) * (y - (topOffset + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[2] = (matrix[5] == 1'b1) && 
                           ((x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) + 
                           (y - (topOffset + squareSize / 2)) * (y - (topOffset + squareSize / 2)) <= circleRadius * circleRadius);

    assign drawCircle[3] = (matrix[7] == 1'b1) && 
                           ((x - (leftOffset + squareSize / 2)) * (x - (leftOffset + squareSize / 2)) + 
                           (y - (topOffset + squareSize + spacing + squareSize / 2)) * (y - (topOffset + squareSize + spacing + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[4] = (matrix[9] == 1'b1) && 
                           ((x - (leftOffset + squareSize + spacing + squareSize / 2)) * (x - (leftOffset + squareSize + spacing + squareSize / 2)) + 
                           (y - (topOffset + squareSize + spacing + squareSize / 2)) * (y - (topOffset + squareSize + spacing + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[5] = (matrix[11] == 1'b1) && 
                           ((x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) + 
                           (y - (topOffset + squareSize + spacing + squareSize / 2)) * (y - (topOffset + squareSize + spacing + squareSize / 2)) <= circleRadius * circleRadius);

    assign drawCircle[6] = (matrix[13] == 1'b1) && 
                           ((x - (leftOffset + squareSize / 2)) * (x - (leftOffset + squareSize / 2)) + 
                           (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[7] = (matrix[15] == 1'b1) && 
                           ((x - (leftOffset + squareSize + spacing + squareSize / 2)) * (x - (leftOffset + squareSize + spacing + squareSize / 2)) + 
                           (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) <= circleRadius * circleRadius);
    assign drawCircle[8] = (matrix[17] == 1'b1) && 
                           ((x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (x - (leftOffset + 2 * (squareSize + spacing) + squareSize / 2)) + 
                           (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) * (y - (topOffset + 2 * (squareSize + spacing) + squareSize / 2)) <= circleRadius * circleRadius);
									
	 assign drawX[0] = (matrix[0] == 1'b1) && (x >= leftOffset && x < leftOffset + squareSize) && 
                      (y >= topOffset && y < topOffset + squareSize);
    assign drawX[1] = (matrix[2] == 1'b1) && (x >= leftOffset + squareSize + spacing && x < leftOffset + 2 * squareSize + spacing) &&
                      (y >= topOffset && y < topOffset + squareSize);
    assign drawX[2] = (matrix[4] == 1'b1) && (x >= leftOffset + 2 * (squareSize + spacing) && x < leftOffset + 3 * squareSize + 2 * spacing) &&
                      (y >= topOffset && y < topOffset + squareSize);
    assign drawX[3] = (matrix[6] == 1'b1) && (x >= leftOffset && x < leftOffset + squareSize) && 
                      (y >= topOffset + squareSize + spacing && y < topOffset + 2 * squareSize + spacing);
    assign drawX[4] = (matrix[8] == 1'b1) && (x >= leftOffset + squareSize + spacing && x < leftOffset + 2 * squareSize + spacing) &&
                      (y >= topOffset + squareSize + spacing && y < topOffset + 2 * squareSize + spacing);
    assign drawX[5] = (matrix[10] == 1'b1) && (x >= leftOffset + 2 * (squareSize + spacing) && x < leftOffset + 3 * squareSize + 2 * spacing) &&
                      (y >= topOffset + squareSize + spacing && y < topOffset + 2 * squareSize + spacing);	
	 assign drawX[6] = (matrix[12] == 1'b1) && (x >= leftOffset && x < leftOffset + squareSize) && 
                      (y >= topOffset + 2 * (squareSize + spacing) && y < topOffset + 3 * squareSize + 2 * spacing);
    assign drawX[7] = (matrix[14] == 1'b1) && (x >= leftOffset + squareSize + spacing && x < leftOffset + 2 * squareSize + spacing) &&
                      (y >= topOffset + 2 * (squareSize + spacing) && y < topOffset + 3 * squareSize + 2 * spacing);
    assign drawX[8] = (matrix[16] == 1'b1) && (x >= leftOffset + 2 * (squareSize + spacing) && x < leftOffset + 3 * squareSize + 2 * spacing) &&
                      (y >= topOffset + 2 * (squareSize + spacing) && y < topOffset + 3 * squareSize + 2 * spacing);                          
						 

//    // Combinamos todas las líneas y formas para determinar si debemos dibujar un píxel
    assign line = verticalLine1 | verticalLine2 | horizontalLine1 | horizontalLine2;
    assign r = (|drawCircle) ? 8'hFF : 8'h00;  // Si hay un círculo, color rojo
    assign g = (|drawX) ? 8'hFF : 8'h00;
    assign b = (line) ? 8'hFF : 8'h00;    // Las líneas del tablero en azul
   


	 
endmodule





