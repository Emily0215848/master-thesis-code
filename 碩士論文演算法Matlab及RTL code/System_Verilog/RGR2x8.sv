`include "./parameter.sv"
module RGR2x8(
	input signed_logic A1[7:0],
	input signed_logic B1[7:0],
	
	input clk,
	input rst,
	
	output angle_logic thetaAB_out,
	output signed_logic A_out[7:0],
	output signed_logic B_out[6:0]	
);

		
	VM2x8_micro_rotation VM_1(
		.A_in	  (A1),  
		.B_in	  (B1),   
		.clk 	  (clk 	  ),
		.rst	  (rst	  ),
		
		.angle_out(thetaAB_out),
		.A_out    (A_out    ),
		.B_out    (B_out    )
	);
	
endmodule