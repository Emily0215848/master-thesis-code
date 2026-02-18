`include "C:/Users/Lab601-1/Desktop/hardware/parameter.sv"

module sub_9bit(	
	input [`sign_bit:0] a, 
	input [`sign_bit:0] b,
	output logic [`sign_bit:0] S
	);
	always_comb 
	begin
		if(a[`sign_bit]^b[`sign_bit])		//c,d異號相加同號相減 =1 異號  =0同號 
		begin
			S[`sign_bit]=a[`sign_bit];
			S[(`sign_bit-1):0]=a[(`sign_bit-1):0]+b[(`sign_bit-1):0];
		end
		else 
		begin
			if(a[(`sign_bit-1):0]>=b[(`sign_bit-1):0])
			begin
				S[`sign_bit]=a[`sign_bit];
				S[(`sign_bit-1):0]=a[(`sign_bit-1):0]-b[(`sign_bit-1):0];
			end
			else
			begin
				S[`sign_bit]=~b[`sign_bit];
				S[(`sign_bit-1):0]=b[(`sign_bit-1):0]-a[(`sign_bit-1):0];
			end
		end
	end
endmodule