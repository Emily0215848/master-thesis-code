
`include "./parameter.sv"

module col_sel3x3(
	input signed_logic row5 [2:0],
	input signed_logic row1_4q[2:0],
	input signed_logic row2_3q[2:0],
	input signed_logic row3_2q[2:0],
	input signed_logic row4_1q[2:0],
	input [1:0] min_index3x3,
	input signed_logic H [2:0][2:0],
	
	output signed_logic row3_0[2:0],
	output signed_logic row3_1[2:0],
	output signed_logic row3_2[2:0],
	output signed_logic row1_5d[2:0],
	output signed_logic row2_4d[2:0],
	output signed_logic row3_3d[2:0],
	output signed_logic row4_2d[2:0],
	output signed_logic row5_1d[2:0]
);                           
	always_comb begin
		row3_0[0] = 'b0;
		row3_0[1] = 'b0;
		row3_0[2] = 'b0;
		row3_1[0] = 'b0;
		row3_1[1] = 'b0;
		row3_1[2] = 'b0;
		row3_2[0] = 'b0;
		row3_2[1] = 'b0;
		row3_2[2] = 'b0;
		row1_5d[0] = 'b0;
		row1_5d[1] = 'b0;
		row1_5d[2] = 'b0;
		row2_4d[0] = 'b0;
		row2_4d[1] = 'b0;
		row2_4d[2] = 'b0;
		row3_3d[0] = 'b0;
		row3_3d[1] = 'b0;
		row3_3d[2] = 'b0;
		row4_2d[0] = 'b0;
		row4_2d[1] = 'b0;
		row4_2d[2] = 'b0;
		row5_1d[0] = 'b0;
		row5_1d[1] = 'b0;
		row5_1d[2] = 'b0;
		
		case(min_index3x3)
			0:
			begin
				row3_0[0] = H[0][0];
				row3_1[0] = H[1][0];
				row3_2[0] = H[2][0];
				row3_0[1] = H[0][1];
				row3_1[1] = H[1][1];
				row3_2[1] = H[2][1];
				row3_0[2] = H[0][2];
				row3_1[2] = H[1][2];
				row3_2[2] = H[2][2];
				row5_1d[0] = row5[0];
				row5_1d[1] = row5[1];
				row5_1d[2] = row5[2];
				row1_5d[0] = row1_4q[0];
				row1_5d[1] = row1_4q[1];
				row1_5d[2] = row1_4q[2];
				row2_4d[0] = row2_3q[0];
				row2_4d[1] = row2_3q[1];
				row2_4d[2] = row2_3q[2];
				row3_3d[0] = row3_2q[0];
				row3_3d[1] = row3_2q[1];
				row3_3d[2] = row3_2q[2];
				row4_2d[0] = row4_1q[0];
				row4_2d[1] = row4_1q[1];
				row4_2d[2] = row4_1q[2];
			end
			1:
			begin
				row3_0[0] = H[0][1];
				row3_1[0] = H[1][1];
				row3_2[0] = H[2][1];
				row3_0[1] = H[0][0];
				row3_1[1] = H[1][0];
				row3_2[1] = H[2][0];
				row3_0[2] = H[0][2];
				row3_1[2] = H[1][2];
				row3_2[2] = H[2][2];
				row5_1d[0] = row5[1];
				row5_1d[1] = row5[0];
				row5_1d[2] = row5[2];
				row1_5d[0] = row1_4q[1];
				row1_5d[1] = row1_4q[0];
				row1_5d[2] = row1_4q[2];
				row2_4d[0] = row2_3q[1];
				row2_4d[1] = row2_3q[0];
				row2_4d[2] = row2_3q[2];
				row3_3d[0] = row3_2q[1];
				row3_3d[1] = row3_2q[0];
				row3_3d[2] = row3_2q[2];
				row4_2d[0] = row4_1q[1];
				row4_2d[1] = row4_1q[0];
				row4_2d[2] = row4_1q[2];
			end
			2:
			begin
				row3_0[0] = H[0][2];
				row3_1[0] = H[1][2];
				row3_2[0] = H[2][2];
				row3_0[1] = H[0][1];
				row3_1[1] = H[1][1];
				row3_2[1] = H[2][1];
				row3_0[2] = H[0][0];
				row3_1[2] = H[1][0];
				row3_2[2] = H[2][0];
				row5_1d[0] = row5[2];
				row5_1d[1] = row5[1];
				row5_1d[2] = row5[0];
				row1_5d[0] = row1_4q[2];
				row1_5d[1] = row1_4q[1];
				row1_5d[2] = row1_4q[0];
				row2_4d[0] = row2_3q[2];
				row2_4d[1] = row2_3q[1];
				row2_4d[2] = row2_3q[0];
				row3_3d[0] = row3_2q[2];
				row3_3d[1] = row3_2q[1];
				row3_3d[2] = row3_2q[0];
				row4_2d[0] = row4_1q[2];
				row4_2d[1] = row4_1q[1];
				row4_2d[2] = row4_1q[0];
			end
		endcase
	end



endmodule