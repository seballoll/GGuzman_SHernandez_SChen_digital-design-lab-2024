module twobit_tb;
	logic rst, dec;
	logic [1:0] num;
	logic [6:0] segA, segB;
	
	Problema3 #2 problema3(rst, dec, num, segA, segB);
	
	initial begin
		rst = 1;
		dec = 1;
		num = 3;
		#40
		rst = 0;
		#40
		rst = 1;
		dec = 0;
		#40
		dec =1; 
		#40
		dec = 0;
		#40
		dec = 1;
	end

endmodule
