module mux_gate_level( select, d, q );
 
 input logic [1:0] select;
 input logic [3:0] d;
 output logic q;

 wire q1, q2, q3, q4;
 wire [1:0] SelectBar;

 not n1( SelectBar[0], select[0] );
 not n2( SelectBar[1], select[1] );

 and a1( q1, SelectBar[0], SelectBar[1], d[0] );
 and a2( q2, select[0] , SelectBar[1], d[1] );
 and a3( q3, SelectBar[0], select[1]   , d[2] );
 and a4( q4, select[0] , select[1]   , d[3] );

 or o1( q, q1, q2, q3, q4 );

endmodule