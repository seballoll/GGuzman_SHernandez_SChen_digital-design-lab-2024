

module fullAdderModuleOneBit_tb;

    // Testbench signals
    reg A;
    reg B;
    reg Cin;
    wire S;
    wire Cout;

    // Instantiate the Device Under Test (DUT)
    fullAdderModuleOneBit dut (
        .A(A),
        .B(B),
        .Cin(Cin),
        .S(S),
        .Cout(Cout)
    );

    // Testbench process
    initial begin
        // Display the header
        $display("A B Cin | S Cout | Expected S Expected Cout");

        // Apply test vectors
        A = 0; B = 0; Cin = 0; #10;
        $display("%b %b  %b   | %b   %b   |    0          0", A, B, Cin, S, Cout);

        A = 0; B = 0; Cin = 1; #10;
        $display("%b %b  %b   | %b   %b   |    1          0", A, B, Cin, S, Cout);

        A = 0; B = 1; Cin = 0; #10;
        $display("%b %b  %b   | %b   %b   |    1          0", A, B, Cin, S, Cout);

        A = 0; B = 1; Cin = 1; #10;
        $display("%b %b  %b   | %b   %b   |    0          1", A, B, Cin, S, Cout);

        A = 1; B = 0; Cin = 0; #10;
        $display("%b %b  %b   | %b   %b   |    1          0", A, B, Cin, S, Cout);

        A = 1; B = 0; Cin = 1; #10;
        $display("%b %b  %b   | %b   %b   |    0          1", A, B, Cin, S, Cout);

        A = 1; B = 1; Cin = 0; #10;
        $display("%b %b  %b   | %b   %b   |    0          1", A, B, Cin, S, Cout);

        A = 1; B = 1; Cin = 1; #10;
        $display("%b %b  %b   | %b   %b   |    1          1", A, B, Cin, S, Cout);

        // Finish the simulation
        $finish;
    end

endmodule
