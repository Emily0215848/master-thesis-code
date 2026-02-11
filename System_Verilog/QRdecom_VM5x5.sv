`include "./parameter.sv"
module QRdecom_VM5x5(
		input signed_logic row5_0[4:0],
		input signed_logic row5_1[4:0],
		input signed_logic row5_2[4:0],
		input signed_logic row5_3[4:0],
		input signed_logic row5_4[4:0],
		input clk,
		input rst,
		
		col4_angle.VM h4A,
		output signed_logic B_2[3:0],
		output signed_logic B_4[3:0],
		output signed_logic B_3[3:0],
		output signed_logic B_5[3:0],
		output signed_logic norm_col1[4:0]
		);
		
		signed_logic A_12[4:0];
		JRGR2xN #(.N(5)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row5_0),
			.B(row5_1),
			
			.A_out(A_12),
			.B_out(B_2),//3
			.thetaAB_out(h4A.h44h54_theta_AB)
		);
		
		signed_logic A_34[4:0];
		JRGR2xN #(.N(5)) JRGR2xN_VM34(
			.clk(clk),
			.rst(rst),
			.A(row5_2),
			.B(row5_3),
			
			.A_out(A_34),
			.B_out(B_4),//5
			.thetaAB_out(h4A.h64h74_theta_AB)
		);
		
		signed_logic A_13[4:0];
		RGR2xN #(.N(5)) RGR2xN_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(A_34),
			
			.A_out(A_13),
			.B_out(B_3),//4
			.thetaAB_out(h4A.h44h64_theta_AB)
		);
		
		RGR2xN #(.N(5)) RGR2xN_VM15(
			.clk(clk),
			.rst(rst),
			.A1(A_13),
			.B1(row5_4),
			
			.A_out(norm_col1),
			.B_out(B_5),//6
			.thetaAB_out(h4A.h44h84_theta_AB)
		);
		

		

endmodule