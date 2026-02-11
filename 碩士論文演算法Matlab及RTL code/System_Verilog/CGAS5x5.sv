
`include "./parameter.sv"
module CGAS5x5(
	input clk,
	input rst,
	input signed_logic H [4:0][4:0],
	
	output logic [2:0] min_index//0~4
);	
	unsigned_logic level1 [1:0][4:0];//2個加法器，有5行
	unsigned_logic level2 [4:0];//1個加法器，有5行
	unsigned_logic level3 [4:0];//1個加法器，有5行
	
	//-------pipe--------------------------
	unsigned_logic level1q [1:0][4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int k=0;k<2;k++)begin
				for(int L=0;L<5;L++)begin
					level1q[k][L] <= 'b0;
				end
			end
		end
		else begin
			level1q <= level1;
		end
	end
	
	unsigned_logic level2q [4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			
				for(int L=0;L<5;L++)begin
					level2q[L] <= 'b0;
				end
			
		end
		else begin
			level2q <= level2;
		end
	end
	//----------------------------------------
	genvar i, j, i_2, j_2, i_3;
	generate
		for(i=0; i<5; i++)//有5行
		begin
			for(j=0; j<2; j++)//2個加法器
			begin
				assign level1[j][i] = H[j*2][i][`sign_bit-1:0] + H[j*2+1][i][`sign_bit-1:0];
			end
		end
		for(i_2=0; i_2<5; i_2++)//有5行
		begin
			assign level2[i_2] = level1q[0][i_2] + level1q[1][i_2];
		end
		for(i_3=0; i_3<5; i_3++)//有5行
		begin
			assign level3[i_3] = level2q[i_3] + H[4][i_3][`sign_bit-1:0];
		end
	endgenerate
	//-----------pipe----------------
	unsigned_logic level3q [4:0];//16
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<5;i++)begin
				level3q[i] <= 'b0;
			end
		end
		else begin
			level3q <= level3;
		end
	end
	//---------------------------------
	unsigned_logic min [1:0];
	logic [2:0] index [1:0];
	
	unsigned_cmp #(.W(3), .N(0)) cmp12(level3q[0], level3q[1], min[0], index [0]);
	unsigned_cmp #(.W(3), .N(2)) cmp34(level3q[2], level3q[3], min[1], index [1]);
	//unsigned_cmp #(.W(3), .N(4)) cmp56(level3[4], level3[5], min[2], index [2]);
	
	unsigned_logic min_1 ;
	logic [2:0] index_1 ;
	always_comb//cmp13
	begin
		case(min[0]>min[1])
			0: begin
				min_1 = min[0];
				index_1 = index [0];
			end
			1: begin
				min_1 = min[1];
				index_1 = index [1];
			end
		endcase
	end
	
	always_comb//cmp15
	begin
		case(min_1>level3[4])
			0: begin
				min_index = index_1;
			end
			1: begin
				min_index = 4;
			end
		endcase
	end
	
	

endmodule
	//adder_16bit h11addh21(H[0][0],H[1][0],s1121);
	//adder_16bit h31addh41(H[2][0],H[3][0],s3141);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);