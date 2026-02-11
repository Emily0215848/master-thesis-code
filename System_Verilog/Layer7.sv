`include "./parameter.sv"
module Layer7(
	input clk,
	input rst,
	input signed_logic y,
	input signed_logic R7[1:0],
	input [3:0] us1,us2,
	input unsigned_logic uPED1,uPED2,
	
	output logic [3:0] s1[1:0],s2[1:0],
	output unsigned_logic PED1,PED2
);

	unsigned_logic R78x1357[3:0];
	LS1357 LS1357_1(
		.clk(clk),
		.rst(rst),
		.Rii(R7[1][(`sign_bit-1):0]),
		
		.Riix1357(R78x1357)
	);
	
	unsigned_logic Riixs[6:0];
	LS LS_1(
		.clk(clk),
		.rst(rst),
		.Rii(R7[0][(`sign_bit-1):0]),

		.Riixs(Riixs)
	);
	
	//-------pipe--------------------
	signed_logic y_q [1:0];
	logic sign_R [1:0];
	logic [3:0] us1_q1 [1:0];
	logic [3:0] us2_q1 [1:0];
	unsigned_logic uPED1_q[1:0];
	unsigned_logic uPED2_q[1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			y_q[0] <= 'b0;
			y_q[1] <= 'b0;
			sign_R[0] <= 'b0;
			sign_R[1] <= 'b0;
			us1_q1[0] <= 'b0;
			us2_q1[0] <= 'b0;
			us1_q1[1] <= 'b0;
			us2_q1[1] <= 'b0;
			uPED1_q[0] <= 'b0;
			uPED1_q[1] <= 'b0;
			uPED2_q[0] <= 'b0;
			uPED2_q[1] <= 'b0;
		end
		else begin
			y_q[0] <= y;
			y_q[1] <= y_q[0];
			sign_R[0] <= R7[1][`sign_bit];
			sign_R[1] <= sign_R[0];
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
	path path_1(
	.clk(clk),
	.rst(rst),
	.y(y_q[1]),
	.us1(us1_q1[1]),
	.uPED(uPED1_q[1]),
	.R78xs(R78x1357),
	.sign_R78(sign_R[1]),
	.R77xs(Riixs),
	
	.s(ps1),
	.PED(pPED1)
	);
	
	logic [3:0] ps2[1:0];
	unsigned_logic pPED2[1:0];
	path path_2(
	.clk(clk),
	.rst(rst),
	.y(y_q[1]),
	.us1(us2_q1[1]),
	.uPED(uPED2_q[1]),
	.R78xs(R78x1357),
	.sign_R78(sign_R[1]),
	.R77xs(Riixs),
	
	.s(ps2),
	.PED(pPED2)
	);
	
	//-----------pipe----------------
	logic [3:0] us1_q[3:0];
	logic [3:0] us2_q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<4;i++)begin
				us1_q[i] <= 'b0;
				us2_q[i] <= 'b0;
			end
		end
		else begin
			us1_q[0] <= us1_q1[1];
			us2_q[0] <= us2_q1[1];
			for(int i=0;i<3;i++)begin
				us1_q[i+1] <= us1_q[i];
				us2_q[i+1] <= us2_q[i];
			end
		end
	end
	//-----------------------------------
	logic [3:0] s1p[1:0],s2p[1:0];
	unsigned_logic PED1p,PED2p;
	always_comb begin
		case(pPED1[0]>pPED2[0])
			0:begin
				PED1p = pPED1[0];
				s1p[0] = ps1[0];
				s1p[1] = us1_q[3];
				case(pPED1[1]>pPED2[0])
					0:begin
						PED2p = pPED1[1];
						s2p[0] = ps1[1];
						s2p[1] = us1_q[3];
					end
					1:begin
						PED2p = pPED2[0];
						s2p[0] = ps2[0];
						s2p[1] = us2_q[3];
					end
				endcase
			end
			1:begin
				PED1p = pPED2[0];
				s1p[0] = ps2[0];
				s1p[1] = us2_q[3];
				case(pPED1[0]>pPED2[1])
					0:begin
						PED2p = pPED1[0];
						s2p[0] = ps1[0];
						s2p[1] = us1_q[3];
					end
					1:begin
						PED2p = pPED2[1];
						s2p[0] = ps2[1];
						s2p[1] = us2_q[3];
					end
				endcase
			end
		endcase
	end
	
	always_ff@(posedge clk)begin
		if(rst)begin
			s1[0] <= 'b0;
			s1[1] <= 'b0;
			s2[0] <= 'b0;
			s2[1] <= 'b0;
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