
`include "./parameter.sv"

module col_sel4x4(
	input signed_logic row4 [3:0],
	input signed_logic row1_3q[3:0],
	input signed_logic row2_2q[3:0],
	input signed_logic row3_1q[3:0],
	input [1:0] min_index4x4,
	input signed_logic H [3:0][3:0],
	
	output signed_logic row4_0[3:0],
	output signed_logic row4_1[3:0],
	output signed_logic row4_2[3:0],
	output signed_logic row4_3[3:0],
	output signed_logic row1_4d[3:0],
	output signed_logic row2_3d[3:0],
	output signed_logic row3_2d[3:0],
	output signed_logic row4_1d[3:0]
);                           
	always_comb begin
		row4_0[0] = 'b0;
		row4_0[1] = 'b0;
		row4_0[2] = 'b0;
		row4_0[3] = 'b0;	
		row4_1[0] = 'b0;
		row4_1[1] = 'b0;
		row4_1[2] = 'b0;
		row4_1[3] = 'b0;	
		row4_2[0] = 'b0;
		row4_2[1] = 'b0;
		row4_2[2] = 'b0;
		row4_2[3] = 'b0;	
		row4_3[0] = 'b0;
		row4_3[1] = 'b0;
		row4_3[2] = 'b0;
		row4_3[3] = 'b0;
		row1_4d[0] = 'b0;
		row1_4d[1] = 'b0;
		row1_4d[2] = 'b0;
		row1_4d[3] = 'b0;
		row2_3d[0] = 'b0;
		row2_3d[1] = 'b0;
		row2_3d[2] = 'b0;
		row2_3d[3] = 'b0;
		row3_2d[0] = 'b0;
		row3_2d[1] = 'b0;
		row3_2d[2] = 'b0;
		row3_2d[3] = 'b0;
		row4_1d[0] = 'b0;
		row4_1d[1] = 'b0;
		row4_1d[2] = 'b0;
		row4_1d[3] = 'b0;
		case(min_index4x4)
			0:
			begin
				row4_0[0] = H[0][0];
				row4_1[0] = H[1][0];
				row4_2[0] = H[2][0];
				row4_3[0] = H[3][0];
				row4_0[1] = H[0][1];
				row4_1[1] = H[1][1];
				row4_2[1] = H[2][1];
				row4_3[1] = H[3][1];		
				row4_0[2] = H[0][2];
				row4_1[2] = H[1][2];
				row4_2[2] = H[2][2];
				row4_3[2] = H[3][2];				
				row4_0[3] = H[0][3];
				row4_1[3] = H[1][3];
				row4_2[3] = H[2][3];
				row4_3[3] = H[3][3];
				row4_1d[0] = row4[0];
				row4_1d[1] = row4[1];
				row4_1d[2] = row4[2];
				row4_1d[3] = row4[3];
				row1_4d[0] = row1_3q[0];
				row1_4d[1] = row1_3q[1];
				row1_4d[2] = row1_3q[2];
				row1_4d[3] = row1_3q[3];
				row2_3d[0] = row2_2q[0];
				row2_3d[1] = row2_2q[1];
				row2_3d[2] = row2_2q[2];
				row2_3d[3] = row2_2q[3];
				row3_2d[0] = row3_1q[0];
				row3_2d[1] = row3_1q[1];
				row3_2d[2] = row3_1q[2];
				row3_2d[3] = row3_1q[3];
			end
			1:
			begin
				row4_0[0] = H[0][1];
				row4_1[0] = H[1][1];
				row4_2[0] = H[2][1];
				row4_3[0] = H[3][1];
				row4_0[1] = H[0][0];
				row4_1[1] = H[1][0];
				row4_2[1] = H[2][0];
				row4_3[1] = H[3][0];		
				row4_0[2] = H[0][2];
				row4_1[2] = H[1][2];
				row4_2[2] = H[2][2];
				row4_3[2] = H[3][2];				
				row4_0[3] = H[0][3];
				row4_1[3] = H[1][3];
				row4_2[3] = H[2][3];
				row4_3[3] = H[3][3];
				row4_1d[0] = row4[1];
				row4_1d[1] = row4[0];
				row4_1d[2] = row4[2];
				row4_1d[3] = row4[3];
				row1_4d[0] = row1_3q[1];
				row1_4d[1] = row1_3q[0];
				row1_4d[2] = row1_3q[2];
				row1_4d[3] = row1_3q[3];
				row2_3d[0] = row2_2q[1];
				row2_3d[1] = row2_2q[0];
				row2_3d[2] = row2_2q[2];
				row2_3d[3] = row2_2q[3];
				row3_2d[0] = row3_1q[1];
				row3_2d[1] = row3_1q[0];
				row3_2d[2] = row3_1q[2];
				row3_2d[3] = row3_1q[3];
			end
			2:
			begin
				row4_0[0] = H[0][2];
				row4_1[0] = H[1][2];
				row4_2[0] = H[2][2];
				row4_3[0] = H[3][2];
				row4_0[1] = H[0][1];
				row4_1[1] = H[1][1];
				row4_2[1] = H[2][1];
				row4_3[1] = H[3][1];		
				row4_0[2] = H[0][0];
				row4_1[2] = H[1][0];
				row4_2[2] = H[2][0];
				row4_3[2] = H[3][0];				
				row4_0[3] = H[0][3];
				row4_1[3] = H[1][3];
				row4_2[3] = H[2][3];
				row4_3[3] = H[3][3];
				row4_1d[0] = row4[2];
				row4_1d[1] = row4[1];
				row4_1d[2] = row4[0];
				row4_1d[3] = row4[3];
				row1_4d[0] = row1_3q[2];
				row1_4d[1] = row1_3q[1];
				row1_4d[2] = row1_3q[0];
				row1_4d[3] = row1_3q[3];
				row2_3d[0] = row2_2q[2];
				row2_3d[1] = row2_2q[1];
				row2_3d[2] = row2_2q[0];
				row2_3d[3] = row2_2q[3];
				row3_2d[0] = row3_1q[2];
				row3_2d[1] = row3_1q[1];
				row3_2d[2] = row3_1q[0];
				row3_2d[3] = row3_1q[3];
			end
			3:
			begin
				row4_0[0] = H[0][3];
				row4_1[0] = H[1][3];
				row4_2[0] = H[2][3];
				row4_3[0] = H[3][3];
				row4_0[1] = H[0][1];
				row4_1[1] = H[1][1];
				row4_2[1] = H[2][1];
				row4_3[1] = H[3][1];		
				row4_0[2] = H[0][2];
				row4_1[2] = H[1][2];
				row4_2[2] = H[2][2];
				row4_3[2] = H[3][2];				
				row4_0[3] = H[0][0];
				row4_1[3] = H[1][0];
				row4_2[3] = H[2][0];
				row4_3[3] = H[3][0];
				row4_1d[0] = row4[3];
				row4_1d[1] = row4[1];
				row4_1d[2] = row4[2];
				row4_1d[3] = row4[0];
				row1_4d[0] = row1_3q[3];
				row1_4d[1] = row1_3q[1];
				row1_4d[2] = row1_3q[2];
				row1_4d[3] = row1_3q[0];
				row2_3d[0] = row2_2q[3];
				row2_3d[1] = row2_2q[1];
				row2_3d[2] = row2_2q[2];
				row2_3d[3] = row2_2q[0];
				row3_2d[0] = row3_1q[3];
				row3_2d[1] = row3_1q[1];
				row3_2d[2] = row3_1q[2];
				row3_2d[3] = row3_1q[0];
			end
		endcase
	end



endmodule