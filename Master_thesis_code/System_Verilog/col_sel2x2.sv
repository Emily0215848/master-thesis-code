
`include "./parameter.sv"

module col_sel2x2(
	input signed_logic row6 [1:0],
	input signed_logic row1_5q[1:0],
	input signed_logic row2_4q[1:0],
	input signed_logic row3_3q[1:0],
	input signed_logic row4_2q[1:0],
	input signed_logic row5_1q[1:0],
	input min_index2x2,
	input signed_logic H [1:0][1:0],
	
	output signed_logic row2_0[1:0],
	output signed_logic row2_1[1:0],
	output signed_logic row1_6d[1:0],
	output signed_logic row2_5d[1:0],
	output signed_logic row3_4d[1:0],
	output signed_logic row4_3d[1:0],
	output signed_logic row5_2d[1:0],
	output signed_logic row6_1d[1:0]
);                           
	always_comb begin
		row2_0[0] = 'b0;
		row2_0[1] = 'b0;
		row2_1[0] = 'b0;
		row2_1[1] = 'b0;
		row1_6d[0] = 'b0;
		row1_6d[1] = 'b0;
		row2_5d[0] = 'b0;
		row2_5d[1] = 'b0;
		row3_4d[0] = 'b0;
		row3_4d[1] = 'b0;
		row4_3d[0] = 'b0;
		row4_3d[1] = 'b0;
		row5_2d[0] = 'b0;
		row5_2d[1] = 'b0;
		row6_1d[0] = 'b0;
		row6_1d[1] = 'b0;
		case(min_index2x2)
			0:
			begin
				row2_0[0] = H[0][0];
				row2_1[0] = H[1][0];
				row2_0[1] = H[0][1];
				row2_1[1] = H[1][1];
				row6_1d[0] = row6[0];
				row6_1d[1] = row6[1];
				row1_6d[0] = row1_5q[0];
				row1_6d[1] = row1_5q[1];
				row2_5d[0] = row2_4q[0];
				row2_5d[1] = row2_4q[1];
				row3_4d[0] = row3_3q[0];
				row3_4d[1] = row3_3q[1];
				row4_3d[0] = row4_2q[0];
				row4_3d[1] = row4_2q[1];
				row5_2d[0] = row5_1q[0];
				row5_2d[1] = row5_1q[1];
			end
			1:
			begin
				row2_0[0] = H[0][1];
				row2_1[0] = H[1][1];
				row2_0[1] = H[0][0];
				row2_1[1] = H[1][0];
				row6_1d[0] = row6[1];
				row6_1d[1] = row6[0];
				row1_6d[0] = row1_5q[1];
				row1_6d[1] = row1_5q[0];
				row2_5d[0] = row2_4q[1];
				row2_5d[1] = row2_4q[0];
				row3_4d[0] = row3_3q[1];
				row3_4d[1] = row3_3q[0];
				row4_3d[0] = row4_2q[1];
				row4_3d[1] = row4_2q[0];
				row5_2d[0] = row5_1q[1];
				row5_2d[1] = row5_1q[0];
			end
		endcase
	end



endmodule