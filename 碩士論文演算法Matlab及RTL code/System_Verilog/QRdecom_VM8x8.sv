//QRdecom_VM8x8.sv
`include "./parameter.sv"


`include "./parameter.sv"
module QRdecom_VM8x8(
		col.in col8_0,
			   col8_1, 
			   col8_2,
			   col8_3,
			   col8_4,
			   col8_5,
			   col8_6, 
			   col8_7,
		input clk,
		input rst,
		
		col1_angle.VM h1A,
		output signed_logic B_2[6:0],
		output signed_logic B_4[6:0],
		output signed_logic B_6[6:0],
		output signed_logic B_8[6:0],
		output signed_logic B_3[6:0],
		output signed_logic B_7[6:0],
		output signed_logic B_5[6:0],
		output signed_logic norm_col1[7:0]
		);
		
		signed_logic A_12[7:0];
		JRGR2x8 JRGR2x8_VM12(
			.clk(clk),
			.rst(rst),
			.col8_0(col8_0.c[1:0]),
			.col8_1(col8_1.c[1:0]),
			.col8_2(col8_2.c[1:0]),
			.col8_3(col8_3.c[1:0]),
			.col8_4(col8_4.c[1:0]),
			.col8_5(col8_5.c[1:0]),
			.col8_6(col8_6.c[1:0]),
			.col8_7(col8_7.c[1:0]),
			
			.A_out(A_12),
			.B_out(B_2),
			.thetaAB_out(h1A.h11h21_theta_AB)
		);
		
		signed_logic A_34[7:0];
		JRGR2x8 JRGR2x8_VM34(
			.clk(clk),
			.rst(rst),
			.col8_0(col8_0.c[3:2]),
			.col8_1(col8_1.c[3:2]),
			.col8_2(col8_2.c[3:2]),
			.col8_3(col8_3.c[3:2]),
			.col8_4(col8_4.c[3:2]),
			.col8_5(col8_5.c[3:2]),
			.col8_6(col8_6.c[3:2]),
			.col8_7(col8_7.c[3:2]),
			
			.A_out(A_34),
			.B_out(B_4),
			.thetaAB_out(h1A.h31h41_theta_AB)
		);
		
		signed_logic A_56[7:0];
		JRGR2x8 JRGR2x8_VM56(
			.clk(clk),
			.rst(rst),
			.col8_0(col8_0.c[5:4]),
			.col8_1(col8_1.c[5:4]),
			.col8_2(col8_2.c[5:4]),
			.col8_3(col8_3.c[5:4]),
			.col8_4(col8_4.c[5:4]),
			.col8_5(col8_5.c[5:4]),
			.col8_6(col8_6.c[5:4]),
			.col8_7(col8_7.c[5:4]),
			
			.A_out(A_56),
			.B_out(B_6),
			.thetaAB_out(h1A.h51h61_theta_AB)
		);
		
		signed_logic A_78[7:0];
		JRGR2x8 JRGR2x8_VM78(
			.clk(clk),
			.rst(rst),
			.col8_0(col8_0.c[7:6]),
			.col8_1(col8_1.c[7:6]),
			.col8_2(col8_2.c[7:6]),
			.col8_3(col8_3.c[7:6]),
			.col8_4(col8_4.c[7:6]),
			.col8_5(col8_5.c[7:6]),
			.col8_6(col8_6.c[7:6]),
			.col8_7(col8_7.c[7:6]),
			
			.A_out(A_78),
			.B_out(B_8),
			.thetaAB_out(h1A.h71h81_theta_AB)
		);
		
		signed_logic A_13[7:0];
		RGR2x8 RGR2x8_VM13(
			.clk(clk),
			.rst(rst),
			.A1(A_12),
			.B1(A_34),
			
			.A_out(A_13),
			.B_out(B_3),
			.thetaAB_out(h1A.h11h31_theta_AB)
		);
		
		signed_logic A_57[7:0];
		RGR2x8 RGR2x8_VM57(
			.clk(clk),
			.rst(rst),
			.A1(A_56),
			.B1(A_78),
			
			.A_out(A_57),
			.B_out(B_7),
			.thetaAB_out(h1A.h51h71_theta_AB)
		);
		
		
		RGR2x8 RGR2x8_VM15(
			.clk(clk),
			.rst(rst),
			.A1(A_13),
			.B1(A_57),
			
			.A_out(norm_col1),
			.B_out(B_5),
			.thetaAB_out(h1A.h11h51_theta_AB)
		);
		

		

endmodule