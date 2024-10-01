//module matrixControl_tb;
//
//    // Inputs
//    logic clk;
//    logic rst_n;
//    logic I;
//    logic W;
//    logic finished;
//    logic B;
//    logic Z;
//    logic [17:0] matrix_in;
//    logic [3:0] current_state;
//
//    // Outputs
//    logic [17:0] matrix_out;
//    logic load;
//    logic [5:0] indexOut;
//
//    // Instantiate the Unit Under Test (UUT)
//    matrixControl uut (
//        .clk(clk),
//        .rst_n(rst_n),
//        .I(I),
//        .W(W),
//        .finished(finished),
//        .B(B),
//        .Z(Z),
//        .matrix_in(matrix_in),
//        .current_state(current_state),
//        .matrix_out(matrix_out),
//        .load(load),
//        .indexOut(indexOut)
//    );
//
//    // Clock generation
//    initial begin
//        clk = 0;
//        forever #5 clk = ~clk;  // Clock period is 10 units of time
//    end
//
//    // Test sequence
//    initial begin
//        // Initialize Inputs
//        rst_n = 0;  // Active low reset
//        I = 0;
//        W = 0;
//        finished = 0;
//        B = 0;
//        Z = 0;
//        matrix_in = 18'b0;
//        current_state = 4'b0000;
//
//        // Wait for reset to complete
//        #10;
//        rst_n = 1;
//
//        // Test case 1: Apply input and simulate normal operation
//        #10;
//        I = 0; W = 1; B = 1; Z = 1; matrix_in = 18'b000000000000000001; current_state = 4'b0001;
//
//        // Check the load signal and matrix_out after some clock cycles
//        #20;
//        $display("Matrix Output: %b", matrix_out);
//        $display("Load Signal: %b", load);
//
//        // Test case 2: Move to a different state and modify the matrix
//        #10;
//        I = 1; W = 0; B = 0; Z = 0; matrix_in = 18'b000000000000000000; current_state = 4'b0110;
//
//        #20;
//        $display("Matrix Output: %b", matrix_out);
//        $display("Load Signal: %b", load);
//
//        // Test case 3: Another state change, check the matrix modification
//        #10;
//        I = 0; W = 1; B = 0; Z = 1; matrix_in = 18'b111111111111111111; current_state = 4'b0111;
//
//        #20;
//        $display("Matrix Output: %b", matrix_out);
//        $display("Load Signal: %b", load);
//
//        // Finish the simulation
//        #100;
//        $finish;
//    end
//
//endmodule