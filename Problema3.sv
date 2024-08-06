module Problema3 #(parameter N = 6)(
	input logic rst, dec,
	input logic [N-1:0] num,
	output logic [6:0] segA, segB);

	logic [N-1:0] contador = 0;
	
	always_ff @(negedge rst or negedge dec) begin
		if (!rst)
			contador <= num;  
		else
			contador <= contador - 1;  
	end
	
	always_comb begin
		case (contador)
            0 : begin 
					segA = 7'b0000001;
					segB = 7'b0000001;
					end
				1 : begin 
					segA = 7'b1001111;
					segB = 7'b0000001;	
					end
				2 : begin 
					segA = 7'b0010010;
					segB = 7'b0000001;
					end
				3 : begin 
					segA = 7'b0000110; 
					segB = 7'b0000001;
					end
				4 : begin 
					segA = 7'b1001100; 
					segB = 7'b0000001;
					end
				5 : begin 
					segA = 7'b0100100; 
					segB = 7'b0000001;
					end
				6 : begin 
					segA = 7'b0100000; 
					segB = 7'b0000001;
					end
				7 : begin 
					segA = 7'b0001111; 
					segB = 7'b0000001;
					end
				8 : begin 
					segA = 7'b0000000; 
					segB = 7'b0000001;
					end
				9 : begin 
					segA = 7'b0000100; 
					segB = 7'b0000001;
					end
				10 : begin 
					segA = 7'b0001000; 
					segB = 7'b0000001;
					end
				11 : begin 
					segA = 7'b1100000; 
					segB = 7'b0000001;
					end
				12 : begin 
					segA = 7'b0110001; 
					segB = 7'b0000001;
					end
				13 : begin 
					segA = 7'b1000010; 
					segB = 7'b0000001;
					end
				14 : begin 
					segA = 7'b0110000; 
					segB = 7'b0000001;
					end
				15 : begin 
					segA = 7'b0111000; 
					segB = 7'b0000001;
					end
				16 : begin 
					segA = 7'b0000001;
					segB = 7'b1001111;
					end
				17 : begin 
					segA = 7'b1001111;
					segB = 7'b1001111;
					end
				18 : begin 
					segA = 7'b0010010;
					segB = 7'b1001111;
					end
				19 : begin 
					segA = 7'b0000110;
					segB = 7'b1001111;
					end
				20 : begin 
					segA = 7'b1001100;
					segB = 7'b1001111;
					end
				21 : begin 
					segA = 7'b0100100;
					segB = 7'b1001111;
					end
				22 : begin 
					segA = 7'b0100000;
					segB = 7'b1001111;
					end
				23 : begin 
					segA = 7'b0001111;
					segB = 7'b1001111;
					end
				24 : begin 
					segA = 7'b0000000;
					segB = 7'b1001111;
					end
				25 : begin 
					segA = 7'b0000100;
					segB = 7'b1001111;
					end
				26 : begin 
					segA = 7'b0001000;
					segB = 7'b1001111;
					end
				27 : begin 
					segA = 7'b1100000;
					segB = 7'b1001111;
					end
				28 : begin 
					segA = 7'b0110001;
					segB = 7'b1001111;
					end
				29 : begin 
					segA = 7'b1000010;
					segB = 7'b1001111;
					end
				30 : begin 
					segA = 7'b0110000;
					segB = 7'b1001111;
					end
				31 : begin 
					segA = 7'b0111000;
					segB = 7'b1001111;
					end

				32 : begin 
					segA = 7'b0000001;
					segB = 7'b0010010;
					end
				33 : begin 
					segA = 7'b1001111;
					segB = 7'b0010010;
					end
				34 : begin 
					segA = 7'b0010010;
					segB = 7'b0010010;
					end
				35 : begin 
					segA = 7'b0000110;
					segB = 7'b0010010;
					end
				36 : begin 
					segA = 7'b1001100;
					segB = 7'b0010010;
					end
				37 : begin 
					segA = 7'b0100100;
					segB = 7'b0010010;
					end
				38 : begin 
					segA = 7'b0100000;
					segB = 7'b0010010;
					end
				39 : begin 
					segA = 7'b0001111; 
					segB = 7'b0010010;
					end
				40 : begin 
					segA = 7'b0000000;
					segB = 7'b0010010;
					end
				41 : begin 
					segA = 7'b0000100; 
					segB = 7'b0010010;
					end
				42 : begin 
					segA = 7'b0001000;
					segB = 7'b0010010;
					end
				43 : begin 
					segA = 7'b1100000;
					segB = 7'b0010010;
					end
				44 : begin 
					segA = 7'b0110001;
					segB = 7'b0010010;
					end
				45 : begin 
					segA = 7'b1000010;
					segB = 7'b0010010;
					end
				46 : begin 
					segA = 7'b0110000;
					segB = 7'b0010010;
					end
				47 : begin 
					segA = 7'b0111000;
					segB = 7'b0010010;
					end

				48 : begin 
					segA = 7'b0000001; 
					segB = 7'b0000110;
					end
				49 : begin 
					segA = 7'b1001111;
					segB = 7'b0000110;
					end
				50 : begin 
					segA = 7'b0010010; 
					segB = 7'b0000110;
					end
				51 : begin 
					segA = 7'b0000110;
					segB = 7'b0000110;
					end
				52 : begin 
					segA = 7'b1001100; 
					segB = 7'b0000110;
					end
				53 : begin 
					segA = 7'b0100100;
					segB = 7'b0000110;
					end
				54 : begin 
					segA = 7'b0100000;
					segB = 7'b0000110;
					end
				55 : begin 
					segA = 7'b0001111;
					segB = 7'b0000110;
					end
				56 : begin 
					segA = 7'b0000000;
					segB = 7'b0000110;
					end
				57 : begin 
					segA = 7'b0000100;
					segB = 7'b0000110;
					end
				58 : begin 
					segA = 7'b0001000;
					segB = 7'b0000110;
					end
				59 : begin 
					segA = 7'b1100000;
					segB = 7'b0000110;
					end
				60 : begin 
					segA = 7'b0110001;
					segB = 7'b0000110;
					end
				61 : begin 
					segA = 7'b1000010;
					segB = 7'b0000110;
					end
				62 : begin 
					segA = 7'b0110000;
					segB = 7'b0000110;
					end
				63 : begin 
					segA = 7'b0111000;
					segB = 7'b0000110;
				end
				default: begin
					segA = 7'b1111111;
					segB = 7'b0000001;
					end
		endcase
	end
	
endmodule
