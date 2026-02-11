`include "./parameter.sv"
module Layer1(
	input clk,
	input rst,
	input signed_logic y,
	input signed_logic R1[7:0],
	input [3:0] us1[6:0],
	
	output logic [3:0] s1[7:0]
);
	
	unsigned_logic R18x1357[3:0];
	LS1357 LS1357_7(
		.clk(clk),
		.rst(rst),
		.Rii(R1[7][(`sign_bit-1):0]),
		
		.Riix1357(R18x1357)
	);
	
	unsigned_logic R28x1357[3:0];
	LS1357 LS1357_6(
		.clk(clk),
		.rst(rst),
		.Rii(R1[6][(`sign_bit-1):0]),
		
		.Riix1357(R28x1357)
	);
	
	unsigned_logic R38x1357[3:0];
	LS1357 LS1357_5(
		.clk(clk),
		.rst(rst),
		.Rii(R1[5][(`sign_bit-1):0]),
		
		.Riix1357(R38x1357)
	);
	
	unsigned_logic R48x1357[3:0];
	LS1357 LS1357_4(
		.clk(clk),
		.rst(rst),
		.Rii(R1[4][(`sign_bit-1):0]),
		
		.Riix1357(R48x1357)
	);
	
	unsigned_logic R58x1357[3:0];
	LS1357 LS1357_3(
		.clk(clk),
		.rst(rst),
		.Rii(R1[3][(`sign_bit-1):0]),
		
		.Riix1357(R58x1357)
	);
	
	unsigned_logic R68x1357[3:0];
	LS1357 LS1357_2(
		.clk(clk),
		.rst(rst),
		.Rii(R1[2][(`sign_bit-1):0]),
		
		.Riix1357(R68x1357)
	);
	
	unsigned_logic R67x1357[3:0];
	LS1357 LS1357_1(
		.clk(clk),
		.rst(rst),
		.Rii(R1[1][(`sign_bit-1):0]),
		
		.Riix1357(R67x1357)
	);
	
	unsigned_logic Riixs[6:0];
	LS LS_1(
		.clk(clk),
		.rst(rst),
		.Rii(R1[0][(`sign_bit-1):0]),

		.Riixs(Riixs)
	);
	//-------pipe--------------------
	signed_logic y_q [1:0];
	logic sign_R1 [1:0];
	logic sign_R2 [1:0];
	logic sign_R3 [1:0];
	logic sign_R4 [1:0];
	logic sign_R5 [1:0];
	logic sign_R6 [1:0];
	logic sign_R7 [1:0];
	logic [3:0] us1_q1 [1:0][6:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<2;i++)begin
				y_q[i] <= 'b0;
				sign_R1[i] <= 'b0;
				sign_R2[i] <= 'b0;
				sign_R3[i] <= 'b0;
				sign_R4[i] <= 'b0;
				sign_R5[i] <= 'b0;
				sign_R6[i] <= 'b0;
				sign_R7[i] <= 'b0;
				for(int j=0;j<7;j++)begin
					us1_q1[i][j] <= 'b0;
				end
			end
		end
		else begin
			y_q[0] <= y;
			y_q[1] <= y_q[0];
			sign_R1[0] <= R1[1][`sign_bit];
			sign_R1[1] <= sign_R1[0];
			sign_R2[0] <= R1[2][`sign_bit];
			sign_R2[1] <= sign_R2[0];
			sign_R3[0] <= R1[3][`sign_bit];
			sign_R3[1] <= sign_R3[0];
			sign_R4[0] <= R1[4][`sign_bit];
			sign_R4[1] <= sign_R4[0];
			sign_R5[0] <= R1[5][`sign_bit];
			sign_R5[1] <= sign_R5[0];
			sign_R6[0] <= R1[6][`sign_bit];
			sign_R6[1] <= sign_R6[0];
			sign_R7[0] <= R1[7][`sign_bit];
			sign_R7[1] <= sign_R7[0];
			us1_q1[0] <= us1;
			us1_q1[1] <= us1_q1[0];
		end
	end
	logic [3:0] s1p[7:0];
	path1 path_1(
	.clk(clk),
	.rst(rst),
	.y(y_q[1]),
	.us1(us1_q1[1]),
	.R78xs(R67x1357),//第2行
	.R68xs(R68x1357),//第3行
	.R58xs(R58x1357),//第4行
	.R48xs(R48x1357),//第5行
	.R38xs(R38x1357),//第6行
	.R28xs(R28x1357),//第7行
	.R18xs(R18x1357),//第8行
	.sign_R78(sign_R1[1]),
	.sign_R68(sign_R2[1]),
	.sign_R58(sign_R3[1]),
	.sign_R48(sign_R4[1]),
	.sign_R38(sign_R5[1]),
	.sign_R28(sign_R6[1]),
	.sign_R18(sign_R7[1]),
	.R77xs(Riixs),//第layer行
	
	.s(s1p[0])
	);
	//-----------pipe----------------
	logic [3:0] us1_q[2:0][6:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<3;i++)begin
				for(int j=0;j<7;j++)begin
					us1_q[i][j] <= 'b0;
				end
			end
		end
		else begin
			us1_q[0] <= us1_q1[1];
			for(int j=0;j<2;j++)begin
				us1_q[j+1] <= us1_q[j];
			end
		end
	end
	//-----------------------------------
	assign s1p[7:1] = us1_q[2];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<8;i++)begin
				s1[i] <= 'b0;
			end
		end
		else begin
			s1 <= s1p;
		end
	end
endmodule