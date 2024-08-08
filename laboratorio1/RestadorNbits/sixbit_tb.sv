module sixbit_tb;
    parameter N = 6; // Define el número de bits que quieres usar
    
    logic rst, dec;
    logic [N-1:0] num;
    logic [6:0] segA, segB;
    
    // Instancia del módulo Problema3 con N bits
    Problema3 #(N) problema3 (
        .rst(rst),
        .dec(dec),
        .num(num),
        .segA(segA),
        .segB(segB)
    );
    
    initial begin
        rst = 1;
        dec = 1;
        num = 'd63; // Ajusta según el valor máximo para N bits
        #40
        rst = 0;
        #40
        rst = 1;
        dec = 0;
        #40
        dec = 1; 
        #40
        dec = 0;
        #40
        dec = 1;
    end
endmodule
