module matrixRegister (
    input logic clk,            // Clock signal
    input logic rst_n,          // Active low reset signal
    input logic [17:0] data_in, // 18-bit input to load the matrix
    input logic load,           // Control signal to load new data
    output logic [17:0] matrix  // 18-bit register representing the matrix
);

    // 18-bit register to store the matrix
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            matrix <= 18'b0;  // Reset the matrix to 0 when rst_n is active low
        end
        else if (load) begin
            matrix <= data_in;  // Load new data when load signal is high
        end
    end
endmodule