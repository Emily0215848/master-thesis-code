//NodeSelector
`include "./parameter.sv"
module NSnoPED(
	input clk,
	input rst,
	input signed_logic y,
	input unsigned_logic Riixs[6:0],//7654321
	
	output logic [3:0] s
);

	unsigned_logic c2;
	logic c1,c3;
	assign c1 = (y[(`sign_bit-1):0]>Riixs[3])?1:0;
	always_comb begin
		case(c1)
			0:begin
				c2 = Riixs[1];
			end
			1:begin
				c2 = Riixs[5];
			end
		endcase
	end
	assign c3 = (y[(`sign_bit-1):0]>c2)?1:0;
	
	
	assign s = {y[`sign_bit],c1,c3,1'b1};
	
endmodule