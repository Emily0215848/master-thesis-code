//unsigned_cmp.sv
`include "./parameter.sv"

module unsigned_cmp #(parameter W=2, N=0)(
	input unsigned_logic a,
	input unsigned_logic b,
	
	output unsigned_logic min,
	output logic [(W-1):0] index
);
	parameter M = N+1;
	always_comb
	begin
		case(a>b)
			0: begin
				min = a;
				index = N;
			end
			1: begin
				min = b;
				index = M;
			end
		endcase
	end
endmodule