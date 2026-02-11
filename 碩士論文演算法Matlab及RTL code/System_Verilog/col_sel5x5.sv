//col_sel6x6.sv
`include "./parameter.sv"

module col_sel5x5(
	input signed_logic row3 [4:0],
	input signed_logic row1_2q[4:0],
	input signed_logic row2_1q[4:0],
	input [2:0] min_index5x5,
	input signed_logic H [4:0][4:0],
	
	output signed_logic row5_0[4:0],
	output signed_logic row5_1[4:0],
	output signed_logic row5_2[4:0],
	output signed_logic row5_3[4:0],
	output signed_logic row5_4[4:0],
	output signed_logic row1_3d[4:0],
	output signed_logic row2_2d[4:0],
	output signed_logic row3_1d[4:0]
);                           
	always_comb begin
		row5_0[0] = 'b0;
		row5_0[1] = 'b0;
		row5_0[2] = 'b0;
		row5_0[3] = 'b0;
		row5_0[4] = 'b0;		
		row5_1[0] = 'b0;
		row5_1[1] = 'b0;
		row5_1[2] = 'b0;
		row5_1[3] = 'b0;
		row5_1[4] = 'b0;		
		row5_2[0] = 'b0;
		row5_2[1] = 'b0;
		row5_2[2] = 'b0;
		row5_2[3] = 'b0;
		row5_2[4] = 'b0;		
		row5_3[0] = 'b0;
		row5_3[1] = 'b0;
		row5_3[2] = 'b0;
		row5_3[3] = 'b0;
		row5_3[4] = 'b0;
		row5_4[0] = 'b0;
		row5_4[1] = 'b0;
		row5_4[2] = 'b0;
		row5_4[3] = 'b0;
		row5_4[4] = 'b0;
		row1_3d[0] = 'b0;
		row1_3d[1] = 'b0;
		row1_3d[2] = 'b0;
		row1_3d[3] = 'b0;
		row1_3d[4] = 'b0;		
		row2_2d[0] = 'b0;
		row2_2d[1] = 'b0;
		row2_2d[2] = 'b0;
		row2_2d[3] = 'b0;
		row2_2d[4] = 'b0;
		row3_1d[0] = 'b0;
		row3_1d[1] = 'b0;
		row3_1d[2] = 'b0;
		row3_1d[3] = 'b0;
		row3_1d[4] = 'b0;
		case(min_index5x5)
			0:
			begin
				row5_0[0] = H[0][0];
				row5_1[0] = H[1][0];
				row5_2[0] = H[2][0];
				row5_3[0] = H[3][0];
				row5_4[0] = H[4][0];	
				row5_0[1] = H[0][1];
				row5_1[1] = H[1][1];
				row5_2[1] = H[2][1];
				row5_3[1] = H[3][1];
				row5_4[1] = H[4][1];				
				row5_0[2] = H[0][2];
				row5_1[2] = H[1][2];
				row5_2[2] = H[2][2];
				row5_3[2] = H[3][2];
				row5_4[2] = H[4][2];						
				row5_0[3] = H[0][3];
				row5_1[3] = H[1][3];
				row5_2[3] = H[2][3];
				row5_3[3] = H[3][3];
				row5_4[3] = H[4][3];							
				row5_0[4] = H[0][4];
				row5_1[4] = H[1][4];
				row5_2[4] = H[2][4];
				row5_3[4] = H[3][4];
				row5_4[4] = H[4][4];
				row3_1d[0] = row3[0];
				row3_1d[1] = row3[1];
				row3_1d[2] = row3[2];
				row3_1d[3] = row3[3];
				row3_1d[4] = row3[4];
				row1_3d[0] = row1_2q[0];
				row1_3d[1] = row1_2q[1];
				row1_3d[2] = row1_2q[2];
				row1_3d[3] = row1_2q[3];
				row1_3d[4] = row1_2q[4];
				row2_2d[0] = row2_1q[0];
				row2_2d[1] = row2_1q[1];
				row2_2d[2] = row2_1q[2];
				row2_2d[3] = row2_1q[3];
				row2_2d[4] = row2_1q[4];
			end
			1:
			begin
				row5_0[0] = H[0][1];
				row5_1[0] = H[1][1];
				row5_2[0] = H[2][1];
				row5_3[0] = H[3][1];
				row5_4[0] = H[4][1];	
				row5_0[1] = H[0][0];
				row5_1[1] = H[1][0];
				row5_2[1] = H[2][0];
				row5_3[1] = H[3][0];
				row5_4[1] = H[4][0];				
				row5_0[2] = H[0][2];
				row5_1[2] = H[1][2];
				row5_2[2] = H[2][2];
				row5_3[2] = H[3][2];
				row5_4[2] = H[4][2];						
				row5_0[3] = H[0][3];
				row5_1[3] = H[1][3];
				row5_2[3] = H[2][3];
				row5_3[3] = H[3][3];
				row5_4[3] = H[4][3];							
				row5_0[4] = H[0][4];
				row5_1[4] = H[1][4];
				row5_2[4] = H[2][4];
				row5_3[4] = H[3][4];
				row5_4[4] = H[4][4];
				row3_1d[0] = row3[1];
				row3_1d[1] = row3[0];
				row3_1d[2] = row3[2];
				row3_1d[3] = row3[3];
				row3_1d[4] = row3[4];
				row1_3d[0] = row1_2q[1];
				row1_3d[1] = row1_2q[0];
				row1_3d[2] = row1_2q[2];
				row1_3d[3] = row1_2q[3];
				row1_3d[4] = row1_2q[4];
				row2_2d[0] = row2_1q[1];
				row2_2d[1] = row2_1q[0];
				row2_2d[2] = row2_1q[2];
				row2_2d[3] = row2_1q[3];
				row2_2d[4] = row2_1q[4];
			end
			2:
			begin
				row5_0[0] = H[0][2];
				row5_1[0] = H[1][2];
				row5_2[0] = H[2][2];
				row5_3[0] = H[3][2];
				row5_4[0] = H[4][2];	
				row5_0[1] = H[0][1];
				row5_1[1] = H[1][1];
				row5_2[1] = H[2][1];
				row5_3[1] = H[3][1];
				row5_4[1] = H[4][1];				
				row5_0[2] = H[0][0];
				row5_1[2] = H[1][0];
				row5_2[2] = H[2][0];
				row5_3[2] = H[3][0];
				row5_4[2] = H[4][0];						
				row5_0[3] = H[0][3];
				row5_1[3] = H[1][3];
				row5_2[3] = H[2][3];
				row5_3[3] = H[3][3];
				row5_4[3] = H[4][3];							
				row5_0[4] = H[0][4];
				row5_1[4] = H[1][4];
				row5_2[4] = H[2][4];
				row5_3[4] = H[3][4];
				row5_4[4] = H[4][4];
				row3_1d[0] = row3[2];
				row3_1d[1] = row3[1];
				row3_1d[2] = row3[0];
				row3_1d[3] = row3[3];
				row3_1d[4] = row3[4];
				row1_3d[0] = row1_2q[2];
				row1_3d[1] = row1_2q[1];
				row1_3d[2] = row1_2q[0];
				row1_3d[3] = row1_2q[3];
				row1_3d[4] = row1_2q[4];
				row2_2d[0] = row2_1q[2];
				row2_2d[1] = row2_1q[1];
				row2_2d[2] = row2_1q[0];
				row2_2d[3] = row2_1q[3];
				row2_2d[4] = row2_1q[4];
			end
			3:
			begin
				row5_0[0] = H[0][3];
				row5_1[0] = H[1][3];
				row5_2[0] = H[2][3];
				row5_3[0] = H[3][3];
				row5_4[0] = H[4][3];	
				row5_0[1] = H[0][1];
				row5_1[1] = H[1][1];
				row5_2[1] = H[2][1];
				row5_3[1] = H[3][1];
				row5_4[1] = H[4][1];				
				row5_0[2] = H[0][2];
				row5_1[2] = H[1][2];
				row5_2[2] = H[2][2];
				row5_3[2] = H[3][2];
				row5_4[2] = H[4][2];						
				row5_0[3] = H[0][0];
				row5_1[3] = H[1][0];
				row5_2[3] = H[2][0];
				row5_3[3] = H[3][0];
				row5_4[3] = H[4][0];							
				row5_0[4] = H[0][4];
				row5_1[4] = H[1][4];
				row5_2[4] = H[2][4];
				row5_3[4] = H[3][4];
				row5_4[4] = H[4][4];
				row3_1d[0] = row3[3];
				row3_1d[1] = row3[1];
				row3_1d[2] = row3[2];
				row3_1d[3] = row3[0];
				row3_1d[4] = row3[4];
				row1_3d[0] = row1_2q[3];
				row1_3d[1] = row1_2q[1];
				row1_3d[2] = row1_2q[2];
				row1_3d[3] = row1_2q[0];
				row1_3d[4] = row1_2q[4];
				row2_2d[0] = row2_1q[3];
				row2_2d[1] = row2_1q[1];
				row2_2d[2] = row2_1q[2];
				row2_2d[3] = row2_1q[0];
				row2_2d[4] = row2_1q[4];
			end
			4:
			begin
				row5_0[0] = H[0][4];
				row5_1[0] = H[1][4];
				row5_2[0] = H[2][4];
				row5_3[0] = H[3][4];
				row5_4[0] = H[4][4];	
				row5_0[1] = H[0][1];
				row5_1[1] = H[1][1];
				row5_2[1] = H[2][1];
				row5_3[1] = H[3][1];
				row5_4[1] = H[4][1];				
				row5_0[2] = H[0][2];
				row5_1[2] = H[1][2];
				row5_2[2] = H[2][2];
				row5_3[2] = H[3][2];
				row5_4[2] = H[4][2];						
				row5_0[3] = H[0][3];
				row5_1[3] = H[1][3];
				row5_2[3] = H[2][3];
				row5_3[3] = H[3][3];
				row5_4[3] = H[4][3];							
				row5_0[4] = H[0][0];
				row5_1[4] = H[1][0];
				row5_2[4] = H[2][0];
				row5_3[4] = H[3][0];
				row5_4[4] = H[4][0];
				row3_1d[0] = row3[4];
				row3_1d[1] = row3[1];
				row3_1d[2] = row3[2];
				row3_1d[3] = row3[3];
				row3_1d[4] = row3[0];
				row1_3d[0] = row1_2q[4];
				row1_3d[1] = row1_2q[1];
				row1_3d[2] = row1_2q[2];
				row1_3d[3] = row1_2q[3];
				row1_3d[4] = row1_2q[0];
				row2_2d[0] = row2_1q[4];
				row2_2d[1] = row2_1q[1];
				row2_2d[2] = row2_1q[2];
				row2_2d[3] = row2_1q[3];
				row2_2d[4] = row2_1q[0];
			end
		endcase
	end



endmodule