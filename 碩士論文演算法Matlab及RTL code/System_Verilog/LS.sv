`include "./parameter.sv"
module LS(
	input clk,
	input rst,
	input unsigned_logic Rii,
	
	output unsigned_logic Riixs[6:0]
);

	unsigned_logic nRii_d; 
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
	
	unsigned_logic Riixs_d1[6:0];
	always_comb begin
		Riixs_d1[0] = nRii;//1
		Riixs_d1[1] = {nRii[(`sign_bit-1)-1:0],1'b0};//2
		Riixs_d1[3] = {nRii[(`sign_bit-1)-2:0],2'b0};//4
		Riixs_d1[2] = Riixs_d1[0]+Riixs_d1[1];//3
		Riixs_d1[4] = Riixs_d1[0]+Riixs_d1[3];//5
		Riixs_d1[6] = Riixs_d1[2]+Riixs_d1[3];//7
		Riixs_d1[5] = {Riixs_d1[2][(`sign_bit-1)-1:0],1'b0};//6
	end
	
	//---------pipe--------------
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<7;i++)begin
				Riixs[i] <= 'b0;
			end
		end
		else begin
			Riixs <= Riixs_d1;
		end
	
	end
	//------------------------------
endmodule