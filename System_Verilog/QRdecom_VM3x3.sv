`include "./parameter.sv"
module QRdecom_VM3x3(
		input signed_logic row3_0[2:0],
		input signed_logic row3_1[2:0],
		input signed_logic row3_2[2:0],
		input clk,
		input rst,
		
		col6_angle.VM h6A,
		output signed_logic B_2[1:0],
		output signed_logic B_3[1:0],
		output signed_logic norm_col1[2:0]
		);
		
		signed_logic A_12[2:0];
		JRGR2xN #(.N(3)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row3_0),
			.B(row3_1),
			
			.A_out(A_12),
			.B_out(B_2),//3
			.thetaAB_out(h6A.h66h76_theta_AB)
		);
		
		RGR2xN #(.N(3)) RGR2xN_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(row3_2),
			
			.A_out(norm_col1),
			.B_out(B_3),//4
			.thetaAB_out(h6A.h66h86_theta_AB)
		);
		
		
		

		

endmodule