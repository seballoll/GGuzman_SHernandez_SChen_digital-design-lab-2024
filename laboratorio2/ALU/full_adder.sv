// Módulo del Full_adder
module full_adder (
    input logic a, b, cin,
    output logic Sum, cout
);
    assign Sum = (a ^ b) ^ cin;
    assign cout = (cin & (a ^ b)) | (a & b);
endmodule


//Basado de https://circuitfever.com/full-adder-verilog-code