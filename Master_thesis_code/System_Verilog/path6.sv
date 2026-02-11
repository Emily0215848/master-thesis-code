`include "./parameter.sv"
module path6 (
	input clk,
	input rst,
	input signed_logic y,
	input [3:0] us1[1:0],
	input unsigned_logic uPED,
	input unsigned_logic R78xs[3:0],
	input unsigned_logic R68xs[3:0],
	input sign_R78,
	input sign_R68,
	input unsigned_logic R77xs[6:0],
	
	output logic [3:0] s[1:0],
	output unsigned_logic PED[1:0]
);
	logic p1;
	signed_logic Rs;
	always_comb begin//us1[0]和us1[1]同時做
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
	always_comb begin//us1[0]和us1[1]同時做
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
	
	signed_logic ydot;
	sub_14bit y_R78s(y,Rs,ydot);
	//--------pipe----------------
	signed_logic ydot_q;
	signed_logic Rs1_q;
	unsigned_logic R77xs_q[6:0];
	unsigned_logic uPED_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot_q <= 'b0;
			Rs1_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q[i] <= 'b0;
			end
			uPED_q <= 'b0;
		end
		else begin
			ydot_q <= ydot;
			Rs1_q <= Rs1;
			R77xs_q <= R77xs;
			uPED_q <= uPED;
		end
	end
	//--------------------------------
	signed_logic ydot1;
	sub_14bit y_R68s(ydot_q,Rs1_q,ydot1);
	//--------pipe----------------
	signed_logic ydot1_q;
	unsigned_logic R77xs_q1[6:0];
	unsigned_logic uPED_q1;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot1_q <= 'b0;
			for(int i=0;i<7;i++)begin
				R77xs_q1[i] <= 'b0;
			end
			uPED_q1 <= 'b0;
		end
		else begin
			ydot1_q <= ydot1;
			R77xs_q1 <= R77xs_q;
			uPED_q1 <= uPED_q;
		end
	end
	//--------------------------------
	NS NS_1(
		.clk(clk),
		.rst(rst),
		.y(ydot1_q),
		.Riixs(R77xs_q1),
		.uPED(uPED_q1),
		
		.s(s),
		.PED(PED)
	);
endmodule