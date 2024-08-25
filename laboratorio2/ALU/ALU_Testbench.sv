`timescale 1ns / 1ps

module ALU_Testbench;

    // Parameters
    parameter Nbit = 4;

    // Inputs
    logic [Nbit-1:0] A, B;
    logic [3:0] Operation;

    // Outputs
    logic [Nbit-1:0] Result;
    logic N, Z, C, V;
    logic [6:0] seg1, seg2;

    // Instantiate the Unit Undwer Twest (UUT)
    ALU_module #(.Nbit(Nbit)) uut (
        .A(A),
        .B(B),
        .Operation(Operation),
        .Result(Result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V),
        .seg1(seg1),
        .seg2(seg2)
    );

    // Testbench logic
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        Operation = 0;

        // Wait for global reset
        #10;
        
        // Test case 1: Addition
        A = 4'b0011; // 3 in decimal
        B = 4'b0101; // 5 in decimal
        Operation = 4'b0000; // Addition
        #10;
        $display("Test Addition: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);
        
        // Test case 2: Subtraction
        A = 4'b1001; // 9 in decimal
        B = 4'b0010; // 2 in decimal
        Operation = 4'b0001; // Subtraction
        #10;
        $display("Test Subtraction: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 3: Multiplication
        A = 4'b0011; // 3 in decimal
        B = 4'b0010; // 2 in decimal
        Operation = 4'b0010; // Multiplication
        #10;
        $display("Test Multiplication: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 4: Division
        A = 4'b1000; // 8 in decimal
        B = 4'b0010; // 2 in decimal
        Operation = 4'b0011; // Division
        #10;
        $display("Test Division: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 5: AND
        A = 4'b1100; // 12 in decimal
        B = 4'b1010; // 10 in decimal
        Operation = 4'b0101; // AND
        #10;
        $display("Test AND: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 6: OR
        A = 4'b1100; // 12 in decimal
        B = 4'b0011; // 3 in decimal
        Operation = 4'b0110; // OR
        #10;
        $display("Test OR: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 7: XOR
        A = 4'b1100; // 12 in decimal
        B = 4'b1010; // 10 in decimal
        Operation = 4'b0111; // XOR
        #10;
        $display("Test XOR: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);

        // Test case 8: Shift Left
        A = 4'b0011; // 3 in decimal
        B = 4'b0000; // B is not used
        Operation = 4'b1000; // Shift Left
        #10;
        $display("Test Shift Left: A = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, Result, N, Z, C, V);

        // Test case 9: Shift Right
        A = 4'b1100; // 12 in decimal
        B = 4'b0000; // B is not used
        Operation = 4'b1001; // Shift Right
        #10;
        $display("Test Shift Right: A = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, Result, N, Z, C, V);

        // Finish the simulation
		  
		  // Test case 10: carry add
        A = 4'b1111; // 15 in decimal
        B = 4'b0001; // 1 in decimal
        Operation = 4'b0000; // Shift Right
        #10;
        $display("Test Carry flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, Result, N, Z, C, V);
		  
		  
		  // Test case 11: negative sub
        A = 4'b0000; // 0 in decimal
        B = 4'b0010; // 2 in decimal
        Operation = 4'b0001; // Shift Right
        #10;
        $display("Test negative flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, Result, N, Z, C, V);
		  
		  // Test case 12: Multiplication
        A = 4'b1000; // 3 in decimal
        B = 4'b0010; // 2 in decimal
        Operation = 4'b0010; // Multiplication
        #10;
        $display("Test overflow flag: A = %d, B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A, B, Result, N, Z, C, V);
		  
		  // Test case 13: cero
        A = 4'b0001; // 0 in decimal
        B = 4'b0001; // 2 in decimal
        Operation = 4'b0001; // Shift Right
        #10;
        $display("Test cero flag: A = %d,B = %d, Result = %d, N = %b, Z = %b, C = %b, V = %b", A,B, Result, N, Z, C, V);

        // Finish the simulation
        
    end

endmodule
