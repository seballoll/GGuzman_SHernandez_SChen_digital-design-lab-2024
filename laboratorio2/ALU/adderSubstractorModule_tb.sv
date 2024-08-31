`timescale 1ns / 1ps

module adderSubstractorModule_tb;

    // Parameters
    parameter N = 4;

    // Inputs
    logic [N-1:0] A, B;
    logic Cin, Bin;

    // Outputs
    logic [N-1:0] Sum, Sub;
    logic Cout, Bout;

    // Instantiate the Unit Under Test (UUT)
    adderSubstractorModule #(.N(N)) uut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Bin(Bin),
        .Sum(Sum),
        .Cout(Cout),
        .Sub(Sub),
        .Bout(Bout)
    );

    // Testbench logic
    initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        Cin = 0;
        Bin = 0;

        // Wait for global reset
        #10;

        // Test case 1: Simple Addition
        A = 4'b0011; // 3 in decimal
        B = 4'b0101; // 5 in decimal
        Cin = 1'b0;  // No carry-in
        #10;
        $display("Addition Test 1: A = %b, B = %b, Sum = %b, Cout = %b", A, B, Sum, Cout);
        assert(Sum == 4'b1000) else $error("Test 1 Failed: Sum is incorrect");
        assert(Cout == 1'b0) else $error("Test 1 Failed: Cout is incorrect");

        // Test case 2: Addition with Carry
        A = 4'b1111; // 15 in decimal
        B = 4'b0001; // 1 in decimal
        Cin = 1'b0;  // No carry-in
        #10;
        $display("Addition Test 2: A = %b, B = %b, Sum = %b, Cout = %b", A, B, Sum, Cout);
        assert(Sum == 4'b0000) else $error("Test 2 Failed: Sum is incorrect");
        assert(Cout == 1'b1) else $error("Test 2 Failed: Cout is incorrect");

        // Test case 3: Simple Subtraction
        A = 4'b0101; // 5 in decimal
        B = 4'b0011; // 3 in decimal
        Bin = 1'b0;  // No borrow-in
        #10;
        $display("Subtraction Test 1: A = %b, B = %b, Sub = %b, Bout = %b", A, B, Sub, Bout);
        assert(Sub == 4'b0010) else $error("Test 3 Failed: Sub is incorrect");
        assert(Bout == 1'b0) else $error("Test 3 Failed: Bout is incorrect");

        // Test case 4: Subtraction with Borrow
        A = 4'b0100; // 4 in decimal
        B = 4'b0110; // 6 in decimal
        Bin = 1'b0;  // No borrow-in
        #10;
        $display("Subtraction Test 2: A = %b, B = %b, Sub = %b, Bout = %b", A, B, Sub, Bout);
        assert(Sub == 4'b1110) else $error("Test 4 Failed: Sub is incorrect");
        assert(Bout == 1'b1) else $error("Test 4 Failed: Bout is incorrect");

        // Additional test cases can be added similarly

        // Finish the simulation
        $stop;
    end

endmodule
