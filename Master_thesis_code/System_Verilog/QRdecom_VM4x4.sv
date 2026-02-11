`include "./parameter.sv"
module QRdecom_VM4x4(
		input signed_logic row4_0[3:0],
		input signed_logic row4_1[3:0],
		input signed_logic row4_2[3:0],
		input signed_logic row4_3[3:0],
		input clk,
		input rst,
		
		col5_angle.VM h5A,
		output signed_logic B_2[2:0],
		output signed_logic B_4[2:0],
		output signed_logic B_3[2:0],
		output signed_logic norm_col1[3:0]
		);
		
		signed_logic A_12[3:0];
		JRGR2xN #(.N(4)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row4_0),
			.B(row4_1),
	
			.A_out(A_12),
			.B_out(B_2),//3
			.thetaAB_out(h5A.h55h65_theta_AB)
		);
		
		signed_logic A_34[3:0];
		JRGR2xN #(.N(4)) JRGR2xN_VM34(
			.clk(clk),
			.rst(rst),
			.A(row4_2),
			.B(row4_3),
			
			.A_out(A_34),
			.B_out(B_4),//5
			.thetaAB_out(h5A.h75h85_theta_AB)
		);
		
		RGR2xN #(.N(4)) RGR2xN_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(A_34),
			
			.A_out(norm_col1),
			.B_out(B_3),//4
			.thetaAB_out(h5A.h55h75_theta_AB)
		);
		
		
		

		

endmodule