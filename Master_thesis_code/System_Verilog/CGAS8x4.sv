//CGAS8x4.sv
`include "./parameter.sv"
module CGAS8x4#(parameter W = 8, C = 4)(
	input clk,
	input rst,
	input signed_logic H [7:0][7:0],
	
	output logic [1:0] min_index
);	
	unsigned_logic level1 [W/2-1:0][C-1:0];//16
	unsigned_logic level2 [W/2/2-1:0][C-1:0];//16
	unsigned_logic level3 [C-1:0];//16
	
	//-------pipe--------------------------
	unsigned_logic level1q [W/2-1:0][C-1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int k=0;k<4;k++)begin
				for(int L=0;L<4;L++)begin
					level1q[k][L] <= 'b0;
				end
			end
		end
		else begin
			level1q <= level1;
		end
	end
	
	unsigned_logic level2q [W/2/2-1:0][C-1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int k=0;k<2;k++)begin
				for(int L=0;L<4;L++)begin
					level2q[k][L] <= 'b0;
				end
			end
		end
		else begin
			level2q <= level2;
		end
	end
	//----------------------------------------
	
	genvar i, j, i_2, j_2, i_3;
	generate
		for(i=0; i<C; i++)
		begin
			for(j=0; j<(W/2); j++)
			begin
				assign level1[j][i] = H[j*2][i][`sign_bit-1:0] + H[j*2+1][i][`sign_bit-1:0];
			end
		end
		for(i_2=0; i_2<C; i_2++)
		begin
			for(j_2=0; j_2<(W/2/2); j_2++)
			begin
				assign level2[j_2][i_2] = level1q[j_2*2][i_2] + level1q[j_2*2+1][i_2];
			end
		end
		for(i_3=0; i_3<C; i_3++)
		begin
			assign level3[i_3] = level2q[0][i_3] + level2q[1][i_3];
		end
	endgenerate

	unsigned_logic level3q [C-1:0];//16
	always_ff@(posedge clk)begin
		if(rst)begin
			level3q[0] <= 'b0;
			level3q[1] <= 'b0;
			level3q[2] <= 'b0;
			level3q[3] <= 'b0;
		end
		else begin
			level3q[0] <= level3[0];
			level3q[1] <= level3[1];
			level3q[2] <= level3[2];
			level3q[3] <= level3[3];
		end
	end
	
	unsigned_logic min [1:0];
	logic [1:0] index [1:0];
	
	unsigned_cmp #(.W(2), .N(0)) cmp12(level3q[0], level3q[1], min[0], index [0]);
	unsigned_cmp #(.W(2), .N(2)) cmp34(level3q[2], level3q[3], min[1], index [1]);
	always_comb
	begin
		case(min[0]>min[1])
			0: begin
				min_index = index [0];
			end
			1: begin
				min_index = index [1];
			end
		endcase
	end
	
	

endmodule
	//adder_16bit h11addh21(H[0][0],H[1][0],s1121);
	//adder_16bit h31addh41(H[2][0],H[3][0],s3141);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);