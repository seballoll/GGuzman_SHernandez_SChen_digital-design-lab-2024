module ALU_measure #(parameter Nbit=4)(
    input logic clk,              // Clock signal
    input logic reset,            // Reset signal
    input logic [Nbit-1:0] A, B,  // Operand A and B
    input logic [3:0] OperationIn,// Operation code
    output logic [Nbit-1:0] Out,  // Output data
    output logic N, Z, C, V       // Flags
);

    // Internal signals
    logic [Nbit-1:0] reg_A, reg_B, reg_out, alu_result;

    // Registers for inputs A and B
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_A <= {Nbit{1'b0}};
            reg_B <= {Nbit{1'b0}};
            reg_out <= {Nbit{1'b0}};
        end else begin
				
            reg_A <= A;        // Load input A to reg_A
            reg_B <= B;        // Load input B to reg_B
            reg_out <= alu_result; // Load ALU result to reg_out
				//$display("alu_result: %b",alu_result);
				//$display("regOut: %b",reg_out);
        end
    end

    // Instantiate ALU
    ALU_module #(.Nbit(Nbit)) ALU_inst (
        .A(reg_A),               // Use reg_A as operand A
        .B(reg_B),               // Use reg_B as operand B
        .Operation(OperationIn),
        .Result(alu_result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V),
        .seg1(),                 // Not needed for measurement
        .seg2()                  // Not needed for measurement
    );

    // Output result from the final register
	 //$display("alu_result: %b",alu_result);
    assign Out = reg_out;
	 

endmodule




module ALU_measure_tb;

    // Parameters
    parameter Nbit = 4;

    // Testbench signals
    logic clk;
    logic reset;
    logic [Nbit-1:0] A, B;
    logic [3:0] OperationIntb;
    logic [Nbit-1:0] out;
    logic N, Z, C, V;
	 
	 
	 
	 
	 
	 
	 
	 
	 

    // Instantiate the DUT (Device Under Test) ALU_measure
    ALU_measure #(.Nbit(Nbit)) ALU_inst (
        .clk(clk),
        .reset(reset),
        .A(A),
        .B(B),
        .OperationIn(OperationIntb),
        .Out(out),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
    );

    // Clock generation
    always #5 clk = ~clk;  // Clock period = 10 time units (50 MHz)

    // Test procedure
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        A = 0;
        B = 0;
        OperationIntb = 4'b0000;

        // Apply reset
        #20 reset = 0;
		  
		  
		  

        // Test 1: Addition (Operation = 0000)
		 
		  //$display("before Operation: %b",out);
        A = 4'b0011;  // A = 3
        B = 4'b0101;  // B = 5
        OperationIntb = 4'b0000;  // Addition
		  //$display("after operationIntb: %b",out);
        #20 ;
		  
        $display("Addition: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);
		  
        // Test 2: Subtraction (Operation = 0001)
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1001;  // A = 9
        B = 4'b0011;  // B = 3
        OperationIntb = 4'b0001;  // Subtraction
        #20;
        $display("Subtraction: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);
		  
		  // Test case 3: Multiplication
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b0011; // 3 in decimal
        B = 4'b0010; // 2 in decimal
        OperationIntb = 4'b0010; // Multiplication
        #20;
        $display("Test Multiplication: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);
			
        // Test 3: AND (Operation = 0101)
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1010;  // A = 10
        B = 4'b1100;  // B = 12
        OperationIntb = 4'b0101;  // AND
        #20;
        $display("AND: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);
			
        // Test 4: OR (Operation = 0110)
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1010;  // A = 10
        B = 4'b0101;  // B = 5
        OperationIntb = 4'b0110;  // OR
        #20;
        $display("OR: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);

		  
		  
        // Test 5: XOR (Operation = 0111)
		   reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1100;  // A = 12
        B = 4'b0110;  // B = 6
        OperationIntb = 4'b0111;  // XOR
        #20;
        $display("XOR: A = %b, B = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);

		 
        // Test 6: Shift Left (Operation = 1000)
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b0011;  // A = 3
        B = 4'b0000;  // B = don't care for shift operation
        OperationIntb = 4'b1000;  // Shift Left
        #20;
        $display("Shift Left: A = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, out, N, Z, C, V);

		  
        // Test 7: Shift Right (Operation = 1001)
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1100;  // A = 12
        B = 4'b0000;  // B = don't care for shift operation
        OperationIntb = 4'b1001;  // Shift Right
        #20;
        $display("Shift Right: A = %b, Result = %b, N = %b, Z = %b, C = %b, V = %b", A, out, N, Z, C, V);

		    // Test case 10: carry add
			 reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1111; // 15 in decimal
        B = 4'b0001; // 1 in decimal
        OperationIntb = 4'b0000; // Shift Right
        #20;
        $display("Test Carry flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, out, N, Z, C, V);
		  
		  
		  
		  // Test case 11: negative sub
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b0000; // 0 in decimal
        B = 4'b0010; // 2 in decimal
        OperationIntb = 4'b0001; // Shift Right
        #20;
        $display("Test negative flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, out, N, Z, C, V);

		  // Test case 12: Multiplication
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b1000; // 3 in decimal
        B = 4'b0010; // 2 in decimal
        OperationIntb = 4'b0010; // Multiplication
        #20;
        $display("Test overflow flag: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, out, N, Z, C, V);
		  

		  // Test case 13: cero
		  reset = 1;
		  #10 ;
		  reset = 0;
        A = 4'b0001; // 0 in decimal
        B = 4'b0001; // 2 in decimal
        OperationIntb = 4'b0001; // Shift Right
        #20;
        $display("Test cero flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, out, N, Z, C, V);
		  
		  
        // Finish simulation
$finish;
    end

endmodule
