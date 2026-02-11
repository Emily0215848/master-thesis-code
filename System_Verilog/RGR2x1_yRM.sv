`include "./parameter.sv"
module RGR2x1_yRM (
	input signed_logic A, B,
	input clk,
	input rst,
	input angle_logic thetaAB_in,
	
	output signed_logic A_out,
	output signed_logic B_out
);


	RM_microRotation RM_microRotation_1(
	.A_in  (A), 
	.B_in  (B),	
	.p1_in(thetaAB_in[6]),
	.p2_in(thetaAB_in[5]),
	.p3_in(thetaAB_in[4]),
	.p4_in(thetaAB_in[3]),
	.p5_in(thetaAB_in[2]),
    .p6_in(thetaAB_in[1]),
	.p7_in(thetaAB_in[0]),
	.clk	(clk),
	.rst	(rst),
	
	.A_out(A_out),
	.B_out(B_out)
	);
	
endmodule