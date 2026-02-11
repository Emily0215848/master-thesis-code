`include "./parameter.sv"
module path4 (
	input clk,
	input rst,
	input signed_logic y,
	input [3:0] us1[3:0],
	input unsigned_logic uPED,
	input unsigned_logic R78xs[3:0],
	input unsigned_logic R68xs[3:0],
	input unsigned_logic R58xs[3:0],
	input unsigned_logic R48xs[3:0],
	input sign_R78,
	input sign_R68,
	input sign_R58,
	input sign_R48,
	input unsigned_logic R77xs[6:0],
	
	output logic [3:0] s[1:0],
	output unsigned_logic PED[1:0]
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
	
	signed_logic ydot;
	sub_14bit y_R78s(y,Rs,ydot);
	
	signed_logic ydot1;
	adder_14bit y_R5868s(Rs1,Rs2,ydot1);
	
	//--------pipe----------------
	signed_logic ydot_q;
	signed_logic ydot1_q;
	unsigned_logic R77xs_q[6:0];
	unsigned_logic uPED_q;
	signed_logic Rs3_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot_q <= 'b0;
			ydot1_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q[i] <= 'b0;
			end
			uPED_q <= 'b0;
			Rs3_q <= 'b0;
		end
		else begin
			ydot_q <= ydot;
			ydot1_q <= ydot1;
			R77xs_q <= R77xs;
			uPED_q <= uPED;
			Rs3_q <= Rs3;
		end
	end
	//--------------------------------
	signed_logic ydot2;
	sub_14bit y_R58s(ydot_q,ydot1_q,ydot2);
	//--------pipe----------------
	signed_logic ydot2_q;
	signed_logic Rs3_q1;
	unsigned_logic R77xs_d1[6:0];
	unsigned_logic uPED_d1;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot2_q <= 'b0;
			Rs3_q1 <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_d1[i] <= 'b0;
			end
			uPED_d1 <= 'b0;
		end
		else begin
			ydot2_q <= ydot2;
			Rs3_q1 <= Rs3_q;
			R77xs_d1 <= R77xs_q;
			uPED_d1 <= uPED_q;
		end
	end
	//--------------------------------
	signed_logic ydot3;
	sub_14bit y_R48s(ydot2_q,Rs3_q1,ydot3);
	
	//--------pipe----------------
	signed_logic ydot3_q;
	unsigned_logic R77xs_q1[6:0];
	unsigned_logic uPED_q1;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot3_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q1[i] <= 'b0;
			end
			uPED_q1 <= 'b0;
		end
		else begin
			ydot3_q <= ydot3;
			R77xs_q1 <= R77xs_d1;
			uPED_q1 <= uPED_d1;
		end
	end
	//--------------------------------
	NS NS_1(
		.clk(clk),
		.rst(rst),
		.y(ydot3_q),
		.Riixs(R77xs_q1),
		.uPED(uPED_q1),
		
		.s(s),
		.PED(PED)
	);
endmodule