`include "./parameter.sv"
module JRGR2x8(
	input signed_logic col8_0 [1:0],
	input signed_logic col8_1 [1:0],
	input signed_logic col8_2 [1:0],
	input signed_logic col8_3 [1:0],
	input signed_logic col8_4 [1:0],
	input signed_logic col8_5 [1:0],
	input signed_logic col8_6 [1:0],
	input signed_logic col8_7 [1:0],
	input clk,
	input rst,
	
	output angleWithSign_logic thetaAB_out,
	output signed_logic A_out[7:0],
	output signed_logic B_out[6:0]	
);
	signed_logic A1[7:0], B1[7:0];
	angle_logic angle_out;
//要先判斷象限(theta_A)
	always_comb  begin
		B1[0]=col8_0[1];		
		B1[1]=col8_1[1];			
		B1[2]=col8_2[1];			
		B1[3]=col8_3[1];			
		B1[4]=col8_4[1];			
		B1[5]=col8_5[1];			
		B1[6]=col8_6[1];			
		B1[7]=col8_7[1];
		
		if(col8_0[0][`sign_bit])
		begin
			A1[0]={~col8_0[0][`sign_bit],col8_0[0][(`sign_bit-1):0]};
			A1[1]={~col8_1[0][`sign_bit],col8_1[0][(`sign_bit-1):0]};
			A1[2]={~col8_2[0][`sign_bit],col8_2[0][(`sign_bit-1):0]};
			A1[3]={~col8_3[0][`sign_bit],col8_3[0][(`sign_bit-1):0]};			
			A1[4]={~col8_4[0][`sign_bit],col8_4[0][(`sign_bit-1):0]};			
			A1[5]={~col8_5[0][`sign_bit],col8_5[0][(`sign_bit-1):0]};			
			A1[6]={~col8_6[0][`sign_bit],col8_6[0][(`sign_bit-1):0]};			
			A1[7]={~col8_7[0][`sign_bit],col8_7[0][(`sign_bit-1):0]};			
		end
		else
		begin
			A1[0]=col8_0[0];		
			A1[1]=col8_1[0];			
			A1[2]=col8_2[0];			
			A1[3]=col8_3[0];			
			A1[4]=col8_4[0];			
			A1[5]=col8_5[0];			
			A1[6]=col8_6[0];			
			A1[7]=col8_7[0];				
		end
	end	
		

	VM2x8_micro_rotation VM_1(
		.A_in	  (A1),  
		.B_in	  (B1),   
		.clk 	  (clk 	  ),
		.rst	  (rst	  ),
		
		.angle_out(angle_out),
		.A_out    (A_out    ),
		.B_out    (B_out    )
	);
	assign thetaAB_out={col8_0[0][`sign_bit],angle_out};//最後角度是{p0,p1,p2,.....,p5},p0象限最左邊
endmodule