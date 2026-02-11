`include "./parameter.sv"
module QRdecom_VM2x2(
		input signed_logic row2_0[1:0],
		input signed_logic row2_1[1:0],
		input clk,
		input rst,
		
		col7_angle.VM h7A,
		output signed_logic B_2,
		output signed_logic norm_col1[1:0]
		);
		

		signed_logic B_2_1[0:0];
		JRGR2xN #(.N(2)) JRGR2xN_VM12(
			.clk(clk),
			.rst(rst),
			.A(row2_0),
			.B(row2_1),
			
			.A_out(norm_col1),
			.B_out(B_2_1),//3
			.thetaAB_out(h7A.h77h87_theta_AB)
		);
		
		always_comb begin
			if (B_2_1[0][`sign_bit])
				B_2 = {~B_2_1[0][`sign_bit], B_2_1[0][(`sign_bit-1):0]};
			else
				B_2 = B_2_1[0];
		end
		assign h7A.h88_theta_AB = B_2_1[0][`sign_bit];
endmodule