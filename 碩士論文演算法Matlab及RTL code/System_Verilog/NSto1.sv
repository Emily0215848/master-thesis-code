//NodeSelector
`include "./parameter.sv"
module NSto1(
	input clk,
	input rst,
	input signed_logic y,
	input unsigned_logic Riixs[6:0],//7654321
	input unsigned_logic uPED,
	
	output logic [3:0] s,
	output unsigned_logic PED
);

	unsigned_logic c2,a1,a2,Rs1;
	logic c1,c3;
	logic [2:0] x1;
	assign c1 = (y[(`sign_bit-1):0]>Riixs[3])?1:0;
	always_comb begin
		case(c1)
			0:begin
				c2 = Riixs[1];
				a1 = Riixs[0];
				a2 = Riixs[2];
			end
			1:begin
				c2 = Riixs[5];
				a1 = Riixs[4];
				a2 = Riixs[6];
			end
		endcase
	end
	assign c3 = (y[(`sign_bit-1):0]>c2)?1:0;
	always_comb begin
		case(c3)
			0:begin
				Rs1 = a1;
			end
			1:begin
				Rs1 = a2;
			end
		endcase
	end
	
	assign x1 = {c1,c3,1'b1};
	//-------pipe--------------------
	unsigned_logic Rs1_q1;
	signed_logic y_q1;
	logic [2:0] x1_d1;
	unsigned_logic uPED_d;
	always_ff@(posedge clk)begin
		if(rst)begin
			Rs1_q1 		<= 'b0;
			y_q1 		<= 'b0;
			x1_d1 		<= 'b0;
			uPED_d 		<= 'b0;
		end
		else begin
			Rs1_q1 		<= Rs1;
			y_q1 		<= y;
			x1_d1 		<= x1;
			uPED_d 		<= uPED;
		end
	end
	//-------------------------------------
	unsigned_logic eta1;
	always_comb begin
		if(y_q1[(`sign_bit-1):0]>=Rs1_q1)//abs(y)-Rii*s，兩個都是正數必為同號
		begin
			eta1 = y_q1[(`sign_bit-1):0]-Rs1_q1;
		end
		else
		begin
			eta1 = Rs1_q1-y_q1[(`sign_bit-1):0];
		end
	end
	//--------pipe---------------------------
	signed_logic eta1_q;
	logic [2:0] x1_q;
	logic sign_y;
	unsigned_logic uPED_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			eta1_q <= 'b0;
			x1_q <= 'b0;
			sign_y <= 'b0;
			uPED_q <= 'b0;
		end
		else begin
			eta1_q <= eta1;
			x1_q <= x1_d1;
			sign_y <= y_q1[`sign_bit];
			uPED_q <= uPED_d;
		end
	end
	//-----------------------------------------
	
	assign PED = eta1_q + uPED_q;
	assign s = {sign_y,x1_q};
endmodule