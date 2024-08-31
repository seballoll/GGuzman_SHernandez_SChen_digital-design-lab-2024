module ALU_measure #(parameter Nbit=4)(
    input logic clk,              // Clock signal
    input logic reset,            // Reset signal
    input logic [Nbit-1:0] A, B,  // Operand A and B
    input logic [3:0] OperationIn,// Operation code
    output logic [Nbit-1:0] out,  // Output data
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
        end
    end

    // Instantiate ALU
    ALU_module #(.Nbit(Nbit)) ALU_inst (
        .A(reg_A),               // Use reg_A as operand A
        .B(reg_B),               // Use reg_B as operand B
        .OperationIn(OperationIn),
        .Result(alu_result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V),
        .seg1(),                 // Not needed for measurement
        .seg2()                  // Not needed for measurement
    );

    // Output result from the final register
    assign out = reg_out;

endmodule