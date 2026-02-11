
`include "./parameter.sv"
module CGAS2x2(
	input clk,
	input rst,
	input signed_logic H [1:0][1:0],
	
	output logic min_index//0~1
);	
	unsigned_logic level1 [1:0];//1個加法器，有2行
	//unsigned_logic level2 [4:0];//1個加法器，有5行
	//unsigned_logic level3 [2:0];//1個加法器，有3行
	
	genvar i, j, i_3;
	generate
		for(i=0; i<2; i++)//有2行
		begin
			assign level1[i] = H[0][i][`sign_bit-1:0] + H[1][i][`sign_bit-1:0];
		end
	endgenerate
	
	//unsigned_logic min;
	//logic [1:0] index;
	
	//unsigned_cmp #(.W(2), .N(0)) cmp12(level3[0], level3[1], min, index);
	//unsigned_cmp #(.W(2), .N(2)) cmp34(level3[2], level3[3], min[1], index [1]);
	//unsigned_cmp #(.W(3), .N(4)) cmp56(level3[4], level3[5], min[2], index [2]);
	//-------pipe--------------------------
	unsigned_logic level1q [1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			
				for(int L=0;L<2;L++)begin
					level1q[L] <= 'b0;
				end
			
		end
		else begin
			level1q <= level1;
		end
	end
	//----------------------------------------
	always_comb
	begin
		case(level1q[0]>level1q[1])
			0: begin
				min_index = 0;
			end
			1: begin
				min_index = 1;
			end
		endcase
	end
	
	

endmodule
	//adder_16bit h11addh21(H[0][0],H[1][0],s1121);
	//adder_16bit h31addh41(H[2][0],H[3][0],s3141);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);
	//adder_16bit h51addh61(H[4][0],H[5][0],s5161);