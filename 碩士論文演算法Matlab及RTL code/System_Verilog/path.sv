`include "./parameter.sv"
module path (
	input clk,
	input rst,
	input signed_logic y,
	input [3:0] us1,
	input unsigned_logic uPED,
	input unsigned_logic R78xs[3:0],
	input sign_R78,
	input unsigned_logic R77xs[6:0],
	
	output logic [3:0] s[1:0],
	output unsigned_logic PED[1:0]
);
	logic p1;
	signed_logic Rs;
	signed_logic ydot_d;
	always_comb begin
		p1 = us1[3]^sign_R78;
		case(us1[2:1])
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
	sub_14bit y_R78s(y,Rs,ydot_d);
	
	signed_logic ydot_q;
	unsigned_logic R77xs_q[6:0];
	unsigned_logic uPED_q;
	always_ff@(posedge clk)begin
		if(rst)begin
			ydot_q <= 'b0;
			R77xs_q[0] <= 'b0;
			R77xs_q[1] <= 'b0;
			R77xs_q[2] <= 'b0;
			R77xs_q[3] <= 'b0;
			R77xs_q[4] <= 'b0;
			R77xs_q[5] <= 'b0;
			R77xs_q[6] <= 'b0;
			uPED_q <= 'b0;
		end
		else begin
			ydot_q <= ydot_d;
			R77xs_q <= R77xs;
			uPED_q <= uPED;
		end
	end
	NS NS_1(
		.clk(clk),
		.rst(rst),
		.y(ydot_q),
		.Riixs(R77xs_q),
		.uPED(uPED_q),
		
		.s(s),
		.PED(PED)
	);
endmodule