module oneBitSubstractor (
	input logic A,          // Input A
   input logic B, 			// Input B
	input logic Bin,			// Borrow in
	output logic R,					// Resultado de resta
	output logic Bout					// Borrow out
);


		Sub <= A ^ B ^ Bin;
		Bout <= (~A & Bin) | (~A & B) | (B & Bin);
	

endmodule