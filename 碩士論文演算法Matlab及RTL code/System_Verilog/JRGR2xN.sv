`include "./parameter.sv"
module JRGR2xN #(parameter N = 8) (
	input signed_logic A[(N-1):0], B[(N-1):0],
	input clk,
	input rst,
	
	output angleWithSign_logic thetaAB_out,
	output signed_logic A_out[(N-1):0],
	output signed_logic B_out[(N-2):0]	
);
	signed_logic A1[(N-1):0], B1[(N-1):0];
	angle_logic angle_out;
//要先判斷象限(theta_A)
	always_comb begin
		for (int i = 0; i < N; i++) begin
			B1[i] = B[i];
			if (A[0][`sign_bit])
				A1[i] = {~A[i][`sign_bit], A[i][(`sign_bit-1):0]};
			else
				A1[i] = A[i];
		end
		
	end
	
	VM2xN_micro_rotation #(.N(N-1)) VM_1(
		.A_in	  (A1),  
		.B_in	  (B1),   
		.clk 	  (clk 	  ),
		.rst	  (rst	  ),
		
		.angle_out(angle_out),
		.A_out    (A_out    ),
		.B_out    (B_out    )
	);
	assign thetaAB_out={A[0][`sign_bit],angle_out};//最後角度是{p0,p1,p2,.....,p5},p0象限最左邊
endmodule