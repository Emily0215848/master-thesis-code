`include "./parameter.sv"
module LS1357(
	input clk,
	input rst,
	input unsigned_logic Rii,
	
	output unsigned_logic Riix1357[3:0]
);

	unsigned_logic nRii_d; 
	unsigned_logic Riix2;
	unsigned_logic Riix4;
	always_comb begin
		nRii_d = {3'b0,Rii[(`sign_bit-1):3]}+{5'b0,Rii[(`sign_bit-1):5]};
	end
	
	unsigned_logic nRii; 
	always_ff@(posedge clk)begin
		if(rst)begin
			nRii <= 'b0;
		end
		else begin
			nRii <= nRii_d;
		end
	
	end
	
	unsigned_logic Riix1357_d1[3:0];
	always_comb begin
		Riix1357_d1[0] = nRii;
		Riix2 = {nRii[(`sign_bit-1)-1:0],1'b0};
		Riix4 = {nRii[(`sign_bit-1)-2:0],2'b0};
		Riix1357_d1[1] = nRii+Riix2;
		Riix1357_d1[2] = nRii+Riix4;
		Riix1357_d1[3] = Riix1357_d1[1]+Riix4;
	end
	
	//---------pipe--------------
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<4;i++)begin
				Riix1357[i] <= 'b0;
			end
		end
		else begin
			Riix1357 <= Riix1357_d1;
		end
	
	end
	//------------------------------
endmodule