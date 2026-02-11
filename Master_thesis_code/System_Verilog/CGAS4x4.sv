
`include "./parameter.sv"
module CGAS4x4(
	input clk,
	input rst,
	input signed_logic H [3:0][3:0],
	
	output logic [1:0] min_index//0~3
);	
	unsigned_logic level1 [1:0][3:0];//2個加法器，有4行
	//unsigned_logic level2 [4:0];//1個加法器，有5行
	unsigned_logic level3 [3:0];//1個加法器，有4行
	
	//-------pipe--------------------------
	unsigned_logic level1q [1:0][3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int k=0;k<2;k++)begin
				for(int L=0;L<4;L++)begin
					level1q[k][L] <= 'b0;
				end
			end
		end
		else begin
			level1q <= level1;
		end
	end
	//----------------------------------------
	genvar i, j, i_3;
	generate
		for(i=0; i<4; i++)//有4行
		begin
			for(j=0; j<2; j++)//2個加法器
			begin
				assign level1[j][i] = H[j*2][i][`sign_bit-1:0] + H[j*2+1][i][`sign_bit-1:0];
			end
		end
		
		for(i_3=0; i_3<4; i_3++)//有4行
		begin
			assign level3[i_3] = level1q[0][i_3] + level1q[1][i_3];
		end
	endgenerate
	//-----------pipe----------------
	unsigned_logic level3q [3:0];//16
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<4;i++)begin
				level3q[i] <= 'b0;
			end
		end
		else begin
			level3q <= level3;
		end
	end
	//---------------------------------
	unsigned_logic min [1:0];
	logic [1:0] index [1:0];
	
	unsigned_cmp #(.W(2), .N(0)) cmp12(level3q[0], level3q[1], min[0], index [0]);
	unsigned_cmp #(.W(2), .N(2)) cmp34(level3q[2], level3q[3], min[1], index [1]);
	//unsigned_cmp #(.W(3), .N(4)) cmp56(level3[4], level3[5], min[2], index [2]);
	
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