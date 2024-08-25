module oneBitSubstractor (
	input logic A,          // Input A
   input logic B, 			// Input B
	input logic Bin,			// Borrow in
	output logic Sub,					// Resultado de resta
	output logic Bout					// Borrow out
);


	assign Sub = A ^ B ^ Bin;
	assign Bout = (~A & Bin) | (~A & B) | (B & Bin);
	

endmodule