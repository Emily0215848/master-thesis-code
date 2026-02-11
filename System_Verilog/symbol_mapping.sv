`include "./parameter.sv"
module symbol_mapping(
	input clk,
	input rst,
	input [3:0] symbol[7:0],
	input [1:0] min_index8x4,
	input [2:0] min_index7x7,
	input [2:0] min_index6x6,
	input [2:0] min_index5x5,
	input [1:0] min_index4x4,
	input [1:0] min_index3x3,
	input  min_index2x2,
	
	output logic [23:0] result_bitstream
);
	
	logic [2:0] order8x4[3:0];
	always_comb begin
		case(min_index8x4)
			0:begin
				for(int i=0;i<4;i++)begin
					order8x4[i]=i;
				end
			end
			1:begin
				order8x4[0]=1;
				order8x4[1]=0;
				for(int i=2;i<4;i++)begin
					order8x4[i]=i;
				end
			end
			2:begin
				order8x4[0]=2;
				order8x4[2]=0;
				order8x4[1]=1;
				order8x4[3]=3;
			end
			3:begin
				order8x4[0]=3;
				order8x4[2]=2;
				order8x4[1]=1;
				order8x4[3]=0;
			end
		endcase
	end
	
	logic [2:0] order8x4q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<4;i++)begin
				order8x4q[i]<=0;
			end
		end
		else
			order8x4q <= order8x4;
	end
	
	logic [2:0] order7x7[6:0];
	always_comb begin
	order7x7[0] = 'b0;
	order7x7[1] = 'b0;
	order7x7[2] = 'b0;
	order7x7[6] = 'b0;
	order7x7[3] = 'b0;
	order7x7[4] = 'b0;
	order7x7[5] = 'b0;
		case(min_index7x7)
			0:begin
				for(int i=0;i<3;i++)begin
					order7x7[i]=order8x4q[i+1];
				end
				for(int i=3;i<7;i++)begin
					order7x7[i]=i+1;
				end
			end
			1:begin
				order7x7[0]=order8x4q[2];
				order7x7[1]=order8x4q[1];
				order7x7[2]=order8x4q[3];
				for(int i=3;i<7;i++)begin
					order7x7[i]=i+1;
				end
			end
			2:begin
				order7x7[0]=order8x4q[3];
				order7x7[1]=order8x4q[2];
				order7x7[2]=order8x4q[1];
				for(int i=3;i<7;i++)begin
					order7x7[i]=i+1;
				end
			end
			3:begin
				order7x7[0]=4;
				order7x7[1]=order8x4q[2];
				order7x7[2]=order8x4q[3];
				order7x7[3]=order8x4q[1];
				for(int i=4;i<7;i++)begin
					order7x7[i]=i+1;
				end
			end
			4:begin
				order7x7[0]=5;
				order7x7[1]=order8x4q[2];
				order7x7[2]=order8x4q[3];
				order7x7[4]=order8x4q[1];
				order7x7[3]=4;
				for(int i=5;i<7;i++)begin
					order7x7[i]=i+1;
				end
			end
			5:begin
				order7x7[0]=6;
				order7x7[1]=order8x4q[2];
				order7x7[2]=order8x4q[3];
				order7x7[5]=order8x4q[1];
				order7x7[3]=4;
				order7x7[4]=5;
				order7x7[6]=7;
			end
			6:begin
				order7x7[0]=7;
				order7x7[1]=order8x4q[2];
				order7x7[2]=order8x4q[3];
				order7x7[6]=order8x4q[1];
				order7x7[3]=4;
				order7x7[4]=5;
				order7x7[5]=6;
			end
		endcase
	end
	
	logic [2:0] order7x7q[6:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<7;i++)begin
				order7x7q[i]<=0;
			end
		end
		else
			order7x7q <= order7x7;
	end
	
	logic [2:0] order6x6[5:0];
	always_comb begin
	order6x6[0]= 'b0;
	order6x6[1]= 'b0;
	order6x6[2]= 'b0;
	order6x6[3]= 'b0;
	order6x6[4]= 'b0;
	order6x6[5]= 'b0;
		case(min_index6x6)
			0:begin
				for(int i=0;i<6;i++)begin
					order6x6[i]=order7x7q[i+1];
				end
			end
			1:begin
				order6x6[0]=order7x7q[2];
				order6x6[1]=order7x7q[1];
				for(int i=2;i<6;i++)begin
					order6x6[i]=order7x7q[i+1];
				end
			end
			2:begin
				order6x6[0]=order7x7q[3];
				order6x6[1]=order7x7q[2];
				order6x6[2]=order7x7q[1];
				for(int i=3;i<6;i++)begin
					order6x6[i]=order7x7q[i+1];
				end
			end
			3:begin
				order6x6[0]=order7x7q[4];
				order6x6[1]=order7x7q[2];
				order6x6[2]=order7x7q[3];
				order6x6[3]=order7x7q[1];
				for(int i=4;i<6;i++)begin
					order6x6[i]=order7x7q[i+1];
				end
			end
			4:begin
				order6x6[0]=order7x7q[5];
				order6x6[1]=order7x7q[2];
				order6x6[2]=order7x7q[3];
				order6x6[3]=order7x7q[4];
				order6x6[4]=order7x7q[1];
				order6x6[5]=order7x7q[6];
			end
			5:begin
				order6x6[0]=order7x7q[6];
				order6x6[1]=order7x7q[2];
				order6x6[2]=order7x7q[3];
				order6x6[3]=order7x7q[4];
				order6x6[4]=order7x7q[5];
				order6x6[5]=order7x7q[1];
			end
		endcase
	end
	
	logic [2:0] order6x6q[5:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<6;i++)begin
				order6x6q[i]<=0;
			end
		end
		else
			order6x6q <= order6x6;
	end
	
	logic [2:0] order5x5[4:0];
	always_comb begin
	order5x5[0]= 'b0;
	order5x5[1]= 'b0;
	order5x5[2]= 'b0;
	order5x5[3]= 'b0;
	order5x5[4]= 'b0;
		case(min_index5x5)
			0:begin
				for(int i=0;i<5;i++)begin
					order5x5[i]=order6x6q[i+1];
				end
			end
			1:begin
				order5x5[0]=order6x6q[2];
				order5x5[1]=order6x6q[1];
				for(int i=2;i<5;i++)begin
					order5x5[i]=order6x6q[i+1];
				end
			end
			2:begin
				order5x5[0]=order6x6q[3];
				order5x5[1]=order6x6q[2];
				order5x5[2]=order6x6q[1];
				for(int i=3;i<5;i++)begin
					order5x5[i]=order6x6q[i+1];
				end
			end
			3:begin
				order5x5[0]=order6x6q[4];
				order5x5[1]=order6x6q[2];
				order5x5[2]=order6x6q[3];
				order5x5[3]=order6x6q[1];
				for(int i=4;i<5;i++)begin
					order5x5[i]=order6x6q[i+1];
				end
			end
			4:begin
				order5x5[0]=order6x6q[5];
				order5x5[1]=order6x6q[2];
				order5x5[2]=order6x6q[3];
				order5x5[3]=order6x6q[4];
				order5x5[4]=order6x6q[1];
			end
		endcase
	end
	
	logic [2:0] order5x5q[4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<5;i++)begin
				order5x5q[i]<=0;
			end
		end
		else
			order5x5q <= order5x5;
	end
	
	logic [2:0] order4x4[3:0];
	always_comb begin
	order4x4[0]= 'b0;
	order4x4[1]= 'b0;
	order4x4[2]= 'b0;
	order4x4[3]= 'b0;
		case(min_index4x4)
			0:begin
				for(int i=0;i<4;i++)begin
					order4x4[i]=order5x5q[i+1];
				end
			end
			1:begin
				order4x4[0]=order5x5q[2];
				order4x4[1]=order5x5q[1];
				for(int i=2;i<4;i++)begin
					order4x4[i]=order5x5q[i+1];
				end
			end
			2:begin
				order4x4[0]=order5x5q[3];
				order4x4[1]=order5x5q[2];
				order4x4[2]=order5x5q[1];
				for(int i=3;i<4;i++)begin
					order4x4[i]=order5x5q[i+1];
				end
			end
			3:begin
				order4x4[0]=order5x5q[4];
				order4x4[1]=order5x5q[2];
				order4x4[2]=order5x5q[3];
				order4x4[3]=order5x5q[1];
			end
		endcase
	end
	
	logic [2:0] order4x4q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<4;i++)begin
				order4x4q[i]<=0;
			end
		end
		else
			order4x4q <= order4x4;
	end
	
	logic [2:0] order3x3[2:0];
	always_comb begin
	order3x3[0]= 'b0;
	order3x3[1]= 'b0;
	order3x3[2]= 'b0;
		case(min_index3x3)
			0:begin
				for(int i=0;i<3;i++)begin
					order3x3[i]=order4x4q[i+1];
				end
			end
			1:begin
				order3x3[0]=order4x4q[2];
				order3x3[1]=order4x4q[1];
				for(int i=2;i<3;i++)begin
					order3x3[i]=order4x4q[i+1];
				end
			end
			2:begin
				order3x3[0]=order4x4q[3];
				order3x3[1]=order4x4q[2];
				order3x3[2]=order4x4q[1];
			end
		endcase
	end
	
	logic [2:0] order3x3q[2:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<3;i++)begin
				order3x3q[i]<=0;
			end
		end
		else
			order3x3q <= order3x3;
	end
	
	logic [2:0] order2x2[1:0];
	always_comb begin
	order2x2[0]= 'b0;
	order2x2[1]= 'b0;
		case(min_index2x2)
			0:begin
				for(int i=0;i<2;i++)begin
					order2x2[i]=order3x3q[i+1];
				end
			end
			1:begin
				order2x2[0]=order3x3q[2];
				order2x2[1]=order3x3q[1];
			end
		endcase
	end
	
	logic [2:0] order2x2q[1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<2;i++)begin
				order2x2q[i]<=0;
			end
		end
		else
			order2x2q <= order2x2;
	end
	
	logic [2:0] final_order [7:0];
 	assign final_order[0]=order8x4q[0];
	assign final_order[1]=order7x7q[0];
	assign final_order[2]=order6x6q[0];
	assign final_order[3]=order5x5q[0];
	assign final_order[4]=order4x4q[0];
	assign final_order[5]=order3x3q[0];
	assign final_order[6]=order2x2q[0];
	assign final_order[7]=order2x2q[1];
	
	logic [2:0] symbol_bit [7:0];
	always_comb begin
		for(int i=0;i<8;i++)begin
			symbol_bit[final_order[i]][2]=symbol[i][3];
			case(symbol[i][2:1])
				2'b00:begin
					symbol_bit[final_order[i]][1:0] = 2'b10;
				end
				2'b01:begin
					symbol_bit[final_order[i]][1:0] = 2'b11;
				end
				2'b10:begin
					symbol_bit[final_order[i]][1:0] = 2'b01;
				end
				2'b11:begin
					symbol_bit[final_order[i]][1:0] = 2'b00;
				end
			endcase
		end
	end
	
	logic [23:0] result_bitstream_p;
	assign result_bitstream_p = {symbol_bit[0],symbol_bit[4],symbol_bit[1],symbol_bit[5]
							,symbol_bit[2],symbol_bit[6],symbol_bit[3],symbol_bit[7]};
	always_ff@(posedge clk)begin
		if(rst)begin
			result_bitstream <= 'b0;
		end
		else begin
			result_bitstream <= result_bitstream_p;
		end
	end
endmodule