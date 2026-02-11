`include "./parameter.sv"
module Layer8(
	input clk,
	input rst,
	input signed_logic y,
	input signed_logic Rii,
	
	output logic [3:0] s1,s2,
	output unsigned_logic PED1,PED2
);

	unsigned_logic Riixs[6:0];
	
	LS LS_1(
		.clk(clk),
		.rst(rst),
		.Rii(Rii[(`sign_bit-1):0]),
		
		.Riixs(Riixs)
	);
	
	//-------pipe--------------------
	signed_logic y_q [1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			y_q[0] <= 'b0;
			y_q[1] <= 'b0;
		end
		else begin
			y_q[0] <= y;
			y_q[1] <= y_q[0];
		end
	end
	//-------------------------------
	unsigned_logic c2,a1,a2,Rs1,Rs2;
	logic c1,c3;
	logic [2:0] x1;
	logic [3:0] x2;
	assign c1 = (y_q[1][(`sign_bit-1):0]>Riixs[3])?1:0;
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
	assign c3 = (y_q[1][(`sign_bit-1):0]>c2)?1:0;
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
	always_ff@(posedge clk)begin
		if(rst)begin
			Rs1_q1 		<= 'b0;
			y_q1 		<= 'b0;
			Riix2_d1 	<= 'b0;
			x1_d1 		<= 'b0;
		end
		else begin
			Rs1_q1 		<= Rs1;
			y_q1 		<= y_q[1];
			Riix2_d1 	<= Riixs[1];
			x1_d1 		<= x1;
		end
	end
	//-------------------------------------
	signed_logic eta1_d;
	always_comb begin
		if(y_q1[(`sign_bit-1):0]>=Rs1_q1)//abs(y)-Rii*s，兩個都是正數必為同號
		begin
			eta1_d[`sign_bit] = 1'b0;
			eta1_d[(`sign_bit-1):0] = y_q1[(`sign_bit-1):0]-Rs1_q1;
		end
		else
		begin
			eta1_d[`sign_bit]= 1'b1;
			eta1_d[(`sign_bit-1):0]=Rs1_q1-y_q1[(`sign_bit-1):0];
		end
	end
	//---------pipe--------------------
	signed_logic eta1;
	unsigned_logic Riix2_q1;
	logic [2:0] x1_q1;
	logic sign_y_q1;
	always_ff@(posedge clk)begin
		if(rst)begin
			eta1 		<= 'b0;
			Riix2_q1 	<= 'b0;
			x1_q1 		<= 'b0;
			sign_y_q1 	<= 'b0;
		end
		else begin
			eta1 <= eta1_d;
			Riix2_q1 <= Riix2_d1;
			x1_q1 <= x1_d1;
			sign_y_q1 <= y_q1[`sign_bit];
		end
	end	
	//--------------------------------
	unsigned_logic PED1p,PED2p;
	assign PED1p = eta1[(`sign_bit-1):0];
	always_comb //判斷要+2還是-2
	begin
		case(x1_q1[2]&x1_q1[1])//x1==3'd7
			0:begin
				PED2p = Riix2_q1 - PED1p;
				if(eta1[`sign_bit])		
				begin
					if(x1_q1>=2)
					begin
						x2[3]=1'b0;
						x2[2:0]=x1_q1-2;
					end
					else
					begin
						x2[3]=1'b1;
						x2[2:0]=2-x1_q1;
					end
				end
				else 
				begin
					x2[3]=1'b0;
					x2[2:0]=x1_q1+2;
				end	
			end
			1:begin
				x2=5;
				if(eta1[`sign_bit])		//A,B異號相減同號相加 =1 異號  =0同號 
				begin
					PED2p = Riix2_q1 - PED1p;
				end
				else 
				begin
					PED2p = Riix2_q1 + PED1p;
				end
			end
		endcase
	end
	

	logic [3:0] s2p;
	logic [3:0] s1p;
	assign s1p = {sign_y_q1,x1_q1};
	assign s2p = {sign_y_q1^x2[3],x2[2:0]};
	
	always_ff@(posedge clk)begin
		if(rst)begin
			s1 <= 'b0;
			s2 <= 'b0;
			PED1 <= 'b0;
			PED2 <= 'b0;
		end
		else begin
			s1 <= s1p;
			s2 <= s2p;
			PED1 <= PED1p;
			PED2 <= PED2p;
		end
	end
endmodule