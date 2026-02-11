`include "./parameter.sv"
module JRGR2x1_yRM (
	input signed_logic A, B,
	input clk,
	input rst,
	input angleWithSign_logic thetaAB_in,
	
	output signed_logic A_out,
	output signed_logic B_out
);
	signed_logic A1, B1;
//要先判斷象限(theta_A)
	always_comb begin
		B1 = B;
		if (thetaAB_in[`angleWithSign])
			A1 = {~A[`sign_bit], A[(`sign_bit-1):0]};
		else
			A1 = A;
	end
	
	RM_microRotation RM_microRotation_1(
	.A_in  (A1), 
	.B_in  (B1),	
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