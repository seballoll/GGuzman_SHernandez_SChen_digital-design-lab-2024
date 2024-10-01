//module testbench;
//
//    // Inputs
//    logic clk;
//    logic rst;
//    logic T, I, B, A, J1, J2, C;
//    logic finished;
//    logic G1, G2;
//
//    // Outputs
//    logic [3:0] estado;
//    logic [3:0] next_state;
//
//    // Instantiate the MEF module
//    MEF uut (
//        .clk(clk),
//        .rst(rst),
//        .T(T),
//        .I(I),
//        .B(B),
//        .A(A),
//        .J1(J1),
//        .J2(J2),
//        .C(C),
//        .finished(finished),
//        .G1(G1),
//        .G2(G2),
//        .estado(estado),
//        .next_state(next_state)
//    );
//
//    // Clock generation
//    always #5 clk = ~clk;  // 10ns period
//
//    // Test sequence
//    initial begin
//        // Initialize inputs
//        clk = 0;
//        rst = 0;
//        T = 0;
//        I = 1;
//        B = 1;
//        A = 0;
//        J1 = 0;
//        J2 = 0;
//        C = 0;
//        finished = 0;
//        G1 = 0;
//        G2 = 0;
//
//        // Reset the state machine
//        rst = 1;
//        #10;
//        rst = 0;
//        #10;
//
//        // Test transition from S0 to S1
//        T = 1;  // Set T high to trigger transition to S1
//        #10;
//        T = 0;
//        #10;
//
//        // Test transition from S1 to S2
//        I = 0;  // Set I low to trigger transition to S2
//        #10;
//        I = 1;
//        #10;
//
//        // Test transition from S2 to S1
//        C = 1;  // Set C high to return to S1
//        #10;
//        C = 0;
//        #10;
//
//        // Test transition from S2 to S4 using G2
//        G2 = 1;  // Set G2 high to transition to S4
//        #10;
//        G2 = 0;
//        #10;
//
//        // Test transition from S1 to S3 using G1
//        G1 = 1;  // Set G1 high to transition to S3
//        #10;
//        G1 = 0;
//        #10;
//
//        // Test transition from S3 to S0 using A
//        A = 1;  // Set A high to return to S0
//        #10;
//        A = 0;
//        #10;
//
//        // Test transition from S0 to S5 using A
//        A = 1;  // Set A high to transition to S5
//        #10;
//        A = 0;
//        #10;
//
//        // Test transition from S5 to S6 using J1
//        J1 = 1;  // Set J1 high to transition to S6
//        #10;
//        J1 = 0;
//        #10;
//
//        // Test transition from S5 to S7 using J2
//        J2 = 1;  // Set J2 high to transition to S7
//        #10;
//        J2 = 0;
//        #10;
//
//        // Test transition from S6 to S7 using !I
//        I = 0;  // Set I low to transition to S7
//        #10;
//        I = 1;
//        #10;
//
//        // Test transition from S6 to S3 using G1
//        G1 = 1;  // Set G1 high to transition to S3
//        #10;
//        G1 = 0;
//        #10;
//
//        // Test transition from S6 to S7 using finished
//        finished = 1;  // Set finished high to transition to S7
//        #10;
//        finished = 0;
//        #10;
//
//        // Test transition from S7 to S9 using G2
//        G2 = 1;  // Set G2 high to transition to S9
//        #10;
//        G2 = 0;
//        #10;
//
//        // Test transition from S7 to S6 using !B
//        B = 0;  // Set B low to transition to S6
//        #10;
//        B = 1;
//        #10;
//
//        // Test transition from S9 to S0 using A
//        A = 1;  // Set A high to return to S0
//        #10;
//        A = 0;
//        #10;
//
//        // End the simulation
//        $finish;
//    end
//
//    // Monitor output changes and print states and inputs
//    initial begin
//        $monitor("Time: %0d | clk: %b | rst: %b | T: %b | I: %b | B: %b | A: %b | J1: %b | J2: %b | C: %b | finished: %b | G1: %b | G2: %b | estado: %b | next_state: %b", 
//                 $time, clk, rst, T, I, B, A, J1, J2, C, finished, G1, G2, estado, next_state);
//    end
//endmodule