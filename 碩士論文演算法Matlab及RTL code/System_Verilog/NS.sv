//NodeSelector
`include "./parameter.sv"
module NS(
	input clk,
	input rst,
	input signed_logic y,
	input unsigned_logic Riixs[6:0],//7654321
	input unsigned_logic uPED,
	
	output logic [3:0] s[1:0],
	output unsigned_logic PED[1:0]
);

	unsigned_logic c2,a1,a2,Rs1;
	logic c1,c3;
	logic [2:0] x1;
	logic [3:0] x2;
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
	unsigned_logic Riix2_d1;
	logic [2:0] x1_d1;
	unsigned_logic uPED_d;
	always_ff@(posedge clk)begin
		if(rst)begin
			Rs1_q1 		<= 'b0;
			y_q1 		<= 'b0;
			Riix2_d1 	<= 'b0;
			x1_d1 		<= 'b0;
			uPED_d 		<= 'b0;
		end
		else begin
			Rs1_q1 		<= Rs1;
			y_q1 		<= y;
			Riix2_d1 	<= Riixs[1];
			x1_d1 		<= x1;
			uPED_d 		<= uPED;
		end
	end
	//-------------------------------------
	signed_logic eta1;
	always_comb begin
		if(y_q1[(`sign_bit-1):0]>=Rs1_q1)//abs(y)-Rii*s，兩個都是正數必為同號
		begin
			eta1[`sign_bit] = 1'b0;
			eta1[(`sign_bit-1):0] = y_q1[(`sign_bit-1):0]-Rs1_q1;
		end
		else
		begin
			eta1[`sign_bit]= 1'b1;
			eta1[(`sign_bit-1):0]=Rs1_q1-y_q1[(`sign_bit-1):0];
		end
	end
	
	//--------pipe---------------------------
	signed_logic eta1_q;
	logic [2:0] x1_q;
	logic sign_y;
	unsigned_logic Riix2;
	unsigned_logic uPED_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			eta1_q <= 'b0;
			x1_q <= 'b0;
			sign_y <= 'b0;
			Riix2 <= 'b0;
			uPED_q <= 'b0;
		end
		else begin
			eta1_q <= eta1;
			x1_q <= x1_d1;
			sign_y <= y_q1[`sign_bit];
			Riix2 <= Riix2_d1;
			uPED_q <= uPED_d;
		end
	end
	//-----------------------------------------
	unsigned_logic PED1,PED2;
	assign PED1 = eta1_q[(`sign_bit-1):0];
	always_comb //判斷要+2還是-2
	begin
		case(x1_q[2]&x1_q[1])//x1_q==3'd7
			0:begin
				PED2 = Riix2 - PED1;
				if(eta1_q[`sign_bit])		
				begin
					if(x1_q>=2)
					begin
						x2[3]=1'b0;
						x2[2:0]=x1_q-2;
					end
					else
					begin
						x2[3]=1'b1;
						x2[2:0]=2-x1_q;
					end
				end
				else 
				begin
					x2[3]=1'b0;
					x2[2:0]=x1_q+2;
				end	
			end
			1:begin
				x2=5;
				if(eta1_q[`sign_bit])		//A,B異號相減同號相加 =1 異號  =0同號 
				begin
					PED2 = Riix2 - PED1;
				end
				else 
				begin
					PED2 = Riix2 + PED1;
				end
			end
		endcase
	end
	
	logic [3:0] s_d[1:0];
	assign s_d[0] = {sign_y,x1_q};
	assign s_d[1] = {sign_y^x2[3],x2[2:0]};
	//--------pipe---------------------------
	unsigned_logic PED1_q, PED2_q, uPED_q1;
	always_ff@(posedge clk)begin
		if(rst)begin
			PED1_q <= 'b0;
			PED2_q <= 'b0;
			uPED_q1 <= 'b0;
			for(int i=0;i<2;i++)begin
				s[i] <= 'b0;
			end			
		end
		else begin
			PED1_q <= PED1;
			PED2_q <= PED2;
			uPED_q1 <= uPED_q;
			s <= s_d;
		end
	end
	//-----------------------------------------
	
	assign PED[0] = PED1_q + uPED_q1;
	assign PED[1] = PED2_q + uPED_q1;
	
endmodule