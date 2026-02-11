`include "./parameter.sv"
module path2 (
	input clk,
	input rst,
	input signed_logic y,
	input [3:0] us1[5:0],
	input unsigned_logic R78xs[3:0],
	input unsigned_logic R68xs[3:0],
	input unsigned_logic R58xs[3:0],
	input unsigned_logic R48xs[3:0],
	input unsigned_logic R38xs[3:0],
	input unsigned_logic R28xs[3:0],
	input sign_R78,
	input sign_R68,
	input sign_R58,
	input sign_R48,
	input sign_R38,
	input sign_R28,
	input unsigned_logic R77xs[6:0],
	
	output logic [3:0] s
);
	logic p1;
	signed_logic Rs;
	always_comb begin
		p1 = us1[0][3]^sign_R78;
		case(us1[0][2:1])
			2'b00:
				Rs = {p1,R78xs[0]};
			2'b01:
				Rs = {p1,R78xs[1]};
			2'b10:
				Rs = {p1,R78xs[2]};
			2'b11:
				Rs = {p1,R78xs[3]};	
		endcase
	end
	
	logic p2;
	signed_logic Rs1;
	always_comb begin
		p2 = us1[1][3]^sign_R68;
		case(us1[1][2:1])
			2'b00:
				Rs1 = {p2,R68xs[0]};
			2'b01:
				Rs1 = {p2,R68xs[1]};
			2'b10:
				Rs1 = {p2,R68xs[2]};
			2'b11:
				Rs1 = {p2,R68xs[3]};	
		endcase
	end
	
	logic p3;
	signed_logic Rs2;
	always_comb begin
		p3 = us1[2][3]^sign_R58;
		case(us1[2][2:1])
			2'b00:
				Rs2 = {p3,R58xs[0]};
			2'b01:
				Rs2 = {p3,R58xs[1]};
			2'b10:
				Rs2 = {p3,R58xs[2]};
			2'b11:
				Rs2 = {p3,R58xs[3]};	
		endcase
	end
	
	logic p4;
	signed_logic Rs3;
	always_comb begin
		p4 = us1[3][3]^sign_R48;
		case(us1[3][2:1])
			2'b00:
				Rs3 = {p4,R48xs[0]};
			2'b01:
				Rs3 = {p4,R48xs[1]};
			2'b10:
				Rs3 = {p4,R48xs[2]};
			2'b11:
				Rs3 = {p4,R48xs[3]};	
		endcase
	end
	
	logic p5;
	signed_logic Rs4;
	always_comb begin
		p5 = us1[4][3]^sign_R38;
		case(us1[4][2:1])
			2'b00:
				Rs4 = {p5,R38xs[0]};
			2'b01:
				Rs4 = {p5,R38xs[1]};
			2'b10:
				Rs4 = {p5,R38xs[2]};
			2'b11:
				Rs4 = {p5,R38xs[3]};	
		endcase
	end
	
	logic p6;
	signed_logic Rs5;
	always_comb begin
		p6 = us1[5][3]^sign_R28;
		case(us1[5][2:1])
			2'b00:
				Rs5 = {p6,R28xs[0]};
			2'b01:
				Rs5 = {p6,R28xs[1]};
			2'b10:
				Rs5 = {p6,R28xs[2]};
			2'b11:
				Rs5 = {p6,R28xs[3]};	
		endcase
	end
	
	signed_logic ydot;
	sub_14bit y_R78s(y,Rs,ydot);
	
	signed_logic ydot1;
	adder_14bit y_R5868s(Rs1,Rs2,ydot1);
	
	signed_logic ydot2;
	adder_14bit y_R3848s(Rs3,Rs4,ydot2);
	
	//--------pipe----------------
	signed_logic ydot_q;
	signed_logic ydot1_q;
	signed_logic ydot2_q;
	unsigned_logic R77xs_q[6:0];
	signed_logic Rs5_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot_q <= 'b0;
			ydot1_q <= 'b0;
			ydot2_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q[i] <= 'b0;
			end
			Rs5_q <= 'b0;
		end
		else begin
			ydot_q <= ydot;
			ydot1_q <= ydot1;
			ydot2_q <= ydot2;
			R77xs_q <= R77xs;
			Rs5_q <= Rs5;
		end
	end
	//--------------------------------
	
	signed_logic ydot3;
	sub_14bit y_R58s(ydot_q,ydot1_q,ydot3);
	
	signed_logic ydot5;
	adder_14bit y_R2848s(ydot2_q,Rs5_q,ydot5);
	//--------pipe----------------
	signed_logic ydot3_q;
	signed_logic ydot5_q;
	unsigned_logic R77xs_d1[6:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot3_q <= 'b0;
			ydot5_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_d1[i] <= 'b0;
			end
		end
		else begin
			ydot3_q <= ydot3;
			ydot5_q <= ydot5;
			R77xs_d1 <= R77xs_q;
		end
	end
	//--------------------------------
	signed_logic ydot4;
	sub_14bit y_R38s(ydot3_q,ydot5_q,ydot4);
	
	//--------pipe----------------
	signed_logic ydot4_q;
	unsigned_logic R77xs_q1[6:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot4_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q1[i] <= 'b0;
			end
		end
		else begin
			ydot4_q <= ydot4;
			R77xs_q1 <= R77xs_d1;
		end
	end
	//--------------------------------
	NSnoPED NSnoPED_1(
		.clk(clk),
		.rst(rst),
		.y(ydot4_q),
		.Riixs(R77xs_q1),
		
		.s(s)
	);
endmodule