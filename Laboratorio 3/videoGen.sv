module videoGen(input logic [9:0] x, y, 
					output logic [7:0] r, g, b);

logic pixel, rect;
logic [10:0] topS = 10'd360;
logic [10:0] botS = 10'd411;
logic [10:0] leftS = 10'd76;
logic [10:0] rightS = 10'd126;

rectgen rectgen1(x, y, 10'd20, 10'd279, 10'd76, 10'd336, rect);

assign b = (rect) ? 8'hFF:8'h00;

end

endmodule
