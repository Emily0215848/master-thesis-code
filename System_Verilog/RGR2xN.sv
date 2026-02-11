`include "./parameter.sv"
module RGR2xN #(parameter N = 8) (
	input signed_logic A1[(N-1):0],
	input signed_logic B1[(N-1):0],
	
	input clk,
	input rst,
	
	output angle_logic thetaAB_out,
	output signed_logic A_out[(N-1):0],
	output signed_logic B_out[(N-2):0]	
);

		
	VM2xN_micro_rotation #(.N(N-1)) VM_1(
		.A_in	  (A1),  
		.B_in	  (B1),   
		.clk 	  (clk 	  ),
		.rst	  (rst	  ),
		
		.angle_out(thetaAB_out),
		.A_out    (A_out    ),
		.B_out    (B_out    )
	);
	
endmodule