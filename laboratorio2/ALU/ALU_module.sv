module ALU_module #(parameter M=4)(
	input A,B,Cin,
	output Sum,Cout

);

FullAdderModule #(.N(M)) adder(A,B,Cin,Sum,Cout);

//DisplayConverter converter1(ALU_Out[3:0], display1);

endmodule