//QRdecom_VM8x8.sv
`include "./parameter.sv"


`include "./parameter.sv"
module QRdecom_VM7x7(
		input signed_logic row7_0[6:0],
		input signed_logic row7_1[6:0],
		input signed_logic row7_2[6:0],
		input signed_logic row7_3[6:0],
		input signed_logic row7_4[6:0],
		input signed_logic row7_5[6:0],
		input signed_logic row7_6[6:0],
		input clk,
		input rst,
		
		col2_angle.VM h2A,
		output signed_logic B_2[5:0],
		output signed_logic B_4[5:0],
		output signed_logic B_6[5:0],
		output signed_logic B_3[5:0],
		output signed_logic B_7[5:0],
		output signed_logic B_5[5:0],
		output signed_logic norm_col1[6:0]
		);
		
		signed_logic A_12[6:0];
		JRGR2xN #(.N(7)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row7_0),
			.B(row7_1),
			
			.A_out(A_12),
			.B_out(B_2),//3
			.thetaAB_out(h2A.h22h32_theta_AB)
		);
		
		signed_logic A_34[6:0];
		JRGR2xN #(.N(7)) JRGR2xN_VM34(
			.clk(clk),
			.rst(rst),
			.A(row7_2),
			.B(row7_3),
			
			.A_out(A_34),
			.B_out(B_4),//5
			.thetaAB_out(h2A.h42h52_theta_AB)
		);
		
		signed_logic A_56[6:0];
		JRGR2xN #(.N(7)) JRGR2xN_VM56(
			.clk(clk),
			.rst(rst),
			.A(row7_4),
			.B(row7_5),
			
			.A_out(A_56),
			.B_out(B_6),//7
			.thetaAB_out(h2A.h62h72_theta_AB)
		);
		
		signed_logic A_13[6:0];
		RGR2xN #(.N(7)) RGR2xN_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(A_34),
			
			.A_out(A_13),
			.B_out(B_3),//4
			.thetaAB_out(h2A.h22h42_theta_AB)
		);
		
		signed_logic A_57[6:0];
		RGR2xN #(.N(7)) RGR2xN_VM57(
			.clk(clk),
			.rst(rst),
			.A1(A_56),
			.B1(row7_6),
			
			.A_out(A_57),
			.B_out(B_7),//8
			.thetaAB_out(h2A.h62h82_theta_AB)
		);
		
		
		RGR2xN #(.N(7)) RGR2xN_VM15(
			.clk(clk),
			.rst(rst),
			.A1(A_13),
			.B1(A_57),
			
			.A_out(norm_col1),
			.B_out(B_5),//6
			.thetaAB_out(h2A.h22h62_theta_AB)
		);
		

		

endmodule