module ALU_module #(parameter Nbit=4)(
	 input logic [Nbit-1:0] A, B,      // Operand A and B
    input logic [3:0] Operation,       // 4-bit operation code
    output logic [Nbit-1:0] Result,   // Result
	 output N, Z, C, V,
	 output logic [6:0] seg1, seg2
);


	//wire [3:0] Operation ;
	wire [Nbit-1:0] Sum;
	wire [Nbit-1:0] Sub;
	wire [Nbit-1:0] Mult;
	wire [Nbit-1:0] Left;
	wire [Nbit-1:0] Right;
	
	wire Cout;
	wire Bout;
	wire Mult_Overflow;

	
	//assign Operation = ~OperationIn;
	//instantiating modules

// Instantiate Adder Substractor N bits
	adderSubstractorModule #(.N(Nbit)) adderSubstractor(
			.A(A),
			.B(B),
			.Cin(0),
			.Bin(0),
			.Sum(Sum),
			.Cout(Cout),
			.Sub(Sub),
			.Bout(Bout)
);

// Instantiate shift_left_right for shift left
	shift_left_right #(.N(Nbit), .Direction(1'b1)) sl(
       	.Number(A),
       	.Result(Left)
    );
	 
	// Instantiate shift_left_right for shift right 
	shift_left_right #(.N(Nbit), .Direction(1'b0)) sr(
			 .Number(A),
			 .Result(Right)
    );
	 
	 multiplier #(.N(Nbit)) mult (
        .a(A),
        .b(B),
        .result(Mult),
        .overflow(Mult_Overflow)
    );

always @(*) begin
case (Operation)
			4'b0000: Result = Sum;    // Addition from n_bit_adder
			4'b0001: Result = Sub;    // Subtraction from n_bit_adder
			4'b0010: Result = Mult;   // Multiplication from n_bit_multiplier
			4'b0011: begin            // Division
				// Validate division by zero
                if (B != 0) begin
                    Result = A / B;
                end else begin
                    Result = {Nbit{1'b0}}; // Set Result to zero
                end
            end
            4'b0100: Result = A % B;  // Modulus
            4'b0101: Result = A & B;  // AND
            4'b0110: Result = A | B;  // OR
            4'b0111: Result = A ^ B;  // XOR
            4'b1000: Result = Left;   // Shift Left from shift_left_right
            4'b1001: Result = Right;  // Shift Right from shift_left_right
            default: Result = 0;      // Default to zero for undefined operations
        endcase
		end
		  //assign flags
		  
assign N = (Operation == 4'b0001 && Result[Nbit-1] == 1);
assign Z = (Result == 0);
assign C = (Operation== 4'b0000) ? Cout : 0;
assign V = (Operation == 4'b0010) ? Mult_Overflow : (Operation == 4'b0000) ? Cout: 0;
		
logic [7:0] bcd;
		
bin2bcd #(.N(Nbit)) bcd_inst (
        .bin(Result),
        .bcd(bcd)
    );

    // Decodificación BCD a 7 segmentos
    bcd_to_7seg seg1_inst (
        .bcd(bcd[3:0]),
        .seg(seg1)
    );

    bcd_to_7seg seg2_inst (
        .bcd(bcd[7:4]),
        .seg(seg2)
    );
endmodule