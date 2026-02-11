`include "./parameter.sv"
module QRdecom_VM6x6(
		input signed_logic row6_0[5:0],
		input signed_logic row6_1[5:0],
		input signed_logic row6_2[5:0],
		input signed_logic row6_3[5:0],
		input signed_logic row6_4[5:0],
		input signed_logic row6_5[5:0],
		input clk,
		input rst,
		
		col3_angle.VM h3A,
		output signed_logic B_2[4:0],
		output signed_logic B_4[4:0],
		output signed_logic B_6[4:0],
		output signed_logic B_3[4:0],
		output signed_logic B_5[4:0],
		output signed_logic norm_col1[5:0]
		);
		
		signed_logic A_12[5:0];
		JRGR2xN #(.N(6)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row6_0),
			.B(row6_1),
			
			.A_out(A_12),
			.B_out(B_2),//3
			.thetaAB_out(h3A.h33h43_theta_AB)
		);
		
		signed_logic A_34[5:0];
		JRGR2xN #(.N(6)) JRGR2xN_VM34(
			.clk(clk),
			.rst(rst),
			.A(row6_2),
			.B(row6_3),
			
			.A_out(A_34),
			.B_out(B_4),//5
			.thetaAB_out(h3A.h53h63_theta_AB)
		);
		
		signed_logic A_56[5:0];
		JRGR2xN #(.N(6)) JRGR2xN_VM56(
			.clk(clk),
			.rst(rst),
			.A(row6_4),
			.B(row6_5),
			
			.A_out(A_56),
			.B_out(B_6),//7
			.thetaAB_out(h3A.h73h83_theta_AB)
		);
		
		signed_logic A_13[5:0];
		RGR2xN #(.N(6)) RGR2xN_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(A_34),
			
			.A_out(A_13),
			.B_out(B_3),//4
			.thetaAB_out(h3A.h33h53_theta_AB)
		);
		
		RGR2xN #(.N(6)) RGR2xN_VM15(
			.clk(clk),
			.rst(rst),
			.A1(A_13),
			.B1(A_56),
			
			.A_out(norm_col1),
			.B_out(B_5),//6
			.thetaAB_out(h3A.h33h73_theta_AB)
		);
		

		

endmodule