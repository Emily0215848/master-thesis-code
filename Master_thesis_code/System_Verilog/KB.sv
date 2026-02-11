`include "./parameter.sv"
module KB(
	input clk,
	input rst,
	input signed_logic y_tilde [7:0],
	input signed_logic R1[7:0],
	input signed_logic R2[6:0],
	input signed_logic R3[5:0],
	input signed_logic R4[4:0],
	input signed_logic R5[3:0],
	input signed_logic R6[2:0],
	input signed_logic R7[1:0],
	input signed_logic R8,

	output logic [3:0] s1_1[7:0]
);
	logic [3:0] s8_1,s8_2;
	unsigned_logic PED8_1,PED8_2;
	Layer8 Layer8_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y_tilde[7]),
		.Rii	(R8),
		
		.s1		(s8_1),
		.s2		(s8_2),
		.PED1	(PED8_1),
		.PED2	(PED8_2)
	);
	//--------pipe-----------
	signed_logic y6_q1[4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<5;i++)begin
				y6_q1[i] <= 'b0;
			end
		end
		else begin
			y6_q1[0] <= y_tilde[6];
			for(int i=0;i<4;i++)begin
				y6_q1[i+1] <= y6_q1[i];
			end
		end
	end
	//-----------------------
	logic [3:0] s7_1[1:0],s7_2[1:0];
	unsigned_logic PED7_1,PED7_2;
	Layer7 Layer7_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y6_q1[4]),
		.R7		(R7),
		.us1	(s8_1),
		.us2	(s8_2),
		.uPED1	(PED8_1),
		.uPED2	(PED8_2),
		
		.s1		(s7_1),
		.s2		(s7_2),
		.PED1	(PED7_1),
		.PED2	(PED7_2)
	);
	//--------pipe-----------
	signed_logic y5_q1[11:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<12;i++)begin
				y5_q1[i] <= 'b0;
			end
		end
		else begin
			y5_q1[0] <= y_tilde[5];
			for(int i=0;i<11;i++)begin
				y5_q1[i+1] <= y5_q1[i];
			end
		end
	end
	//-----------------------
	logic [3:0] s6_1[2:0],s6_2[2:0];
	unsigned_logic PED6_1,PED6_2;
	Layer6 Layer6_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y5_q1[11]),
		.R6		(R6),
		.us1	(s7_1),
		.us2	(s7_2),
		.uPED1	(PED7_1),
		.uPED2	(PED7_2),
		
		.s1		(s6_1),
		.s2		(s6_2),
		.PED1	(PED6_1),
		.PED2	(PED6_2)
	);
	//--------pipe-----------
	signed_logic y4_q1[19:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<20;i++)begin
				y4_q1[i] <= 'b0;
			end
		end
		else begin
			y4_q1[0] <= y_tilde[4];
			for(int i=0;i<19;i++)begin
				y4_q1[i+1] <= y4_q1[i];
			end
		end
	end
	//-----------------------
	logic [3:0] s5_1[3:0],s5_2[3:0];
	unsigned_logic PED5_1,PED5_2;
	Layer5 Layer5_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y4_q1[19]),
		.R5		(R5),
		.us1	(s6_1),
		.us2	(s6_2),
		.uPED1	(PED6_1),
		.uPED2	(PED6_2),
		
		.s1		(s5_1),
		.s2		(s5_2),
		.PED1	(PED5_1),
		.PED2	(PED5_2)
	);
	//--------pipe-----------
	signed_logic y3_q1[27:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<28;i++)begin
				y3_q1[i] <= 'b0;
			end
		end
		else begin
			y3_q1[0] <= y_tilde[3];
			for(int i=0;i<27;i++)begin
				y3_q1[i+1] <= y3_q1[i];          
			end
		end
	end
	//-----------------------
	logic [3:0] s4_1[4:0],s4_2[4:0];
	unsigned_logic PED4_1,PED4_2;
	Layer4 Layer4_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y3_q1[27]),
		.R4		(R4),
		.us1	(s5_1),
		.us2	(s5_2),
		.uPED1	(PED5_1),
		.uPED2	(PED5_2),
		
		.s1		(s4_1),
		.s2		(s4_2),
		.PED1	(PED4_1),
		.PED2	(PED4_2)
	);
	//--------pipe-----------
	signed_logic y2_q1[36:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<37;i++)begin
				y2_q1[i] <= 'b0;
			end
		end
		else begin
			y2_q1[0] <= y_tilde[2];
			for(int i=0;i<36;i++)begin
				y2_q1[i+1] <= y2_q1[i];          
			end
		end
	end
	//-----------------------
	logic [3:0] s3_1[5:0];
	Layer3 Layer3_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y2_q1[36]),
		.R3		(R3),
		.us1	(s4_1),
		.us2	(s4_2),
		.uPED1	(PED4_1),
		.uPED2	(PED4_2),
		
		.s1		(s3_1)
	);
	//--------pipe-----------
	signed_logic y1_q1[44:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<45;i++)begin
				y1_q1[i] <= 'b0;
			end
		end
		else begin
			y1_q1[0] <= y_tilde[1];
			for(int i=0;i<44;i++)begin
				y1_q1[i+1] <= y1_q1[i];          
			end
		end
	end
	//-----------------------
	logic [3:0] s2_1[6:0];
	Layer2 Layer2_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y1_q1[44]),
		.R2		(R2),
		.us1	(s3_1),
		
		.s1		(s2_1)
	);
	//--------pipe-----------
	signed_logic y0_q1[50:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<51;i++)begin
				y0_q1[i] <= 'b0;
			end
		end
		else begin
			y0_q1[0] <= y_tilde[0];
			for(int i=0;i<50;i++)begin
				y0_q1[i+1] <= y0_q1[i];          
			end
		end
	end
	//-----------------------
	Layer1 Layer1_1(
		.clk	(clk),
		.rst	(rst),
		.y		(y0_q1[50]),
		.R1		(R1),
		.us1	(s2_1),
		
		.s1		(s1_1)
	);
	
	
endmodule
	