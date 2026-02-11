//adder_14bit.sv
`include "./parameter.sv"

module adder_14bit(			
	input [`sign_bit:0] a, 
	input [`sign_bit:0] b,
	output logic [`sign_bit:0] S
	);
	always_comb 
	begin
		if(a[`sign_bit]^b[`sign_bit])		//A,B異號相減同號相加 =1 異號  =0同號 
		begin
			if(a[(`sign_bit-1):0]>=b[(`sign_bit-1):0])
			begin
				S[`sign_bit]=a[`sign_bit];
				S[(`sign_bit-1):0]=a[(`sign_bit-1):0]-b[(`sign_bit-1):0];
			end
			else
			begin
				S[`sign_bit]=b[`sign_bit];
				S[(`sign_bit-1):0]=b[(`sign_bit-1):0]-a[(`sign_bit-1):0];
			end
		end
		else 
		begin
			S[`sign_bit]=a[`sign_bit];
			S[(`sign_bit-1):0]=a[(`sign_bit-1):0]+b[(`sign_bit-1):0];
		end
	end	
endmodule