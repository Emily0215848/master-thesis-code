`include "./parameter.sv"
module Layer6(
	input clk,
	input rst,
	input signed_logic y,
	input signed_logic R6[2:0],
	input [3:0] us1[1:0],us2[1:0],
	input unsigned_logic uPED1,uPED2,
	
	output logic [3:0] s1[2:0],s2[2:0],
	output unsigned_logic PED1,PED2
);
	unsigned_logic R68x1357[3:0];
	LS1357 LS1357_2(
		.clk(clk),
		.rst(rst),
		.Rii(R6[2][(`sign_bit-1):0]),
		
		.Riix1357(R68x1357)
	);
	
	unsigned_logic R67x1357[3:0];
	LS1357 LS1357_1(
		.clk(clk),
		.rst(rst),
		.Rii(R6[1][(`sign_bit-1):0]),
		
		.Riix1357(R67x1357)
	);
	
	unsigned_logic Riixs[6:0];
	LS LS_1(
		.clk(clk),
		.rst(rst),
		.Rii(R6[0][(`sign_bit-1):0]),

		.Riixs(Riixs)
	);
	//-------pipe--------------------
	signed_logic y_q [1:0];
	logic sign_R1 [1:0];
	logic sign_R2 [1:0];
	logic [3:0] us1_q1 [1:0][1:0];
	logic [3:0] us2_q1 [1:0][1:0];
	unsigned_logic uPED1_q[1:0];
	unsigned_logic uPED2_q[1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<2;i++)begin
				y_q[i] <= 'b0;
				sign_R1[i] <= 'b0;
				sign_R2[i] <= 'b0;
				for(int j=0;j<2;j++)begin
					us1_q1[i][j] <= 'b0;
					us2_q1[i][j] <= 'b0;
				end
				uPED1_q[i] <= 'b0;
				uPED2_q[i] <= 'b0;
			end
		end
		else begin
			y_q[0] <= y;
			y_q[1] <= y_q[0];
			sign_R1[0] <= R6[1][`sign_bit];
			sign_R1[1] <= sign_R1[0];
			sign_R2[0] <= R6[2][`sign_bit];
			sign_R2[1] <= sign_R2[0];
			us1_q1[0] <= us1;
			us2_q1[0] <= us2;
			us1_q1[1] <= us1_q1[0];
			us2_q1[1] <= us2_q1[0];
			uPED1_q[0] <= uPED1;
			uPED1_q[1] <= uPED1_q[0];
			uPED2_q[0] <= uPED2;
			uPED2_q[1] <= uPED2_q[0];
		end
	end
	//-------------------------------
	logic [3:0] ps1[1:0];
	unsigned_logic pPED1[1:0];
	path6 path_1(
	.clk(clk),
	.rst(rst),
	.y(y_q[1]),
	.us1(us1_q1[1]),
	.uPED(uPED1_q[1]),
	.R78xs(R67x1357),//第7行
	.R68xs(R68x1357),//第8行
	.sign_R78(sign_R1[1]),
	.sign_R68(sign_R2[1]),
	.R77xs(Riixs),//第layer行
	
	.s(ps1),
	.PED(pPED1)
	);
	
	logic [3:0] ps2[1:0];
	unsigned_logic pPED2[1:0];
	path6 path_2(
	.clk(clk),
	.rst(rst),
	.y(y_q[1]),
	.us1(us2_q1[1]),
	.uPED(uPED2_q[1]),
	.R78xs(R67x1357),//第7行
	.R68xs(R68x1357),//第8行
	.sign_R78(sign_R1[1]),
	.sign_R68(sign_R2[1]),
	.R77xs(Riixs),
	
	.s(ps2),
	.PED(pPED2)
	);
	//
	
	//-----------pipe----------------
	logic [3:0] us1_q[4:0][1:0];
	logic [3:0] us2_q[4:0][1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<5;i++)begin
				for(int j=0;j<2;j++)begin
					us1_q[i][j] <= 'b0;
					us2_q[i][j] <= 'b0;
				end
			end
		end
		else begin
			us1_q[0] <= us1_q1[1];
			us2_q[0] <= us2_q1[1];
			for(int j=0;j<4;j++)begin
				us1_q[j+1] <= us1_q[j];
				us2_q[j+1] <= us2_q[j];
			end
		end
	end
	//-----------------------------------
	logic [3:0] s1p[2:0],s2p[2:0];
	unsigned_logic PED1p,PED2p;
	always_comb begin
		case(pPED1[0]>pPED2[0])
			0:begin
				PED1p = pPED1[0];
				s1p[0] = ps1[0];
				s1p[2:1] = us1_q[4];
				case(pPED1[1]>pPED2[0])
					0:begin
						PED2p = pPED1[1];
						s2p[0] = ps1[1];
						s2p[2:1] = us1_q[4];
					end
					1:begin
						PED2p = pPED2[0];
						s2p[0] = ps2[0];
						s2p[2:1] = us2_q[4];
					end
				endcase
			end
			1:begin
				PED1p = pPED2[0];
				s1p[0] = ps2[0];
				s1p[2:1] = us2_q[4];
				case(pPED1[0]>pPED2[1])
					0:begin
						PED2p = pPED1[0];
						s2p[0] = ps1[0];
						s2p[2:1] = us1_q[4];
					end
					1:begin
						PED2p = pPED2[1];
						s2p[0] = ps2[1];
						s2p[2:1] = us2_q[4];
					end
				endcase
			end
		endcase
	end
	
	always_ff@(posedge clk)begin
		if(rst)begin
			s1[0] <= 'b0;
			s1[1] <= 'b0;
			s1[2] <= 'b0;
			s2[0] <= 'b0;
			s2[1] <= 'b0;
			s2[2] <= 'b0;
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