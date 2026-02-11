// RM_microRotation.sv
`include "./parameter.sv"

module RM_microRotation(
	input signed_logic A_in, 
	input signed_logic B_in,	
	input p1_in,
	input p2_in,
	input p3_in,
	input p4_in,
	input p5_in,
    input p6_in,
	input p7_in,
	input clk,
	input rst,
	
	output signed_logic A_out,
	output signed_logic B_out);
	
	
	//-------------  象限判斷在外面做
	
	//-----------------------micro_1-----------2^0
	signed_logic A_1q,B_1q;
	signed_logic A_rm0to1,B_rm0to1,A_1d,B_1d;
	
	assign A_rm0to1={(p1_in^A_in[`sign_bit]),(A_in[(`sign_bit-1):0])};  //除2^0
	assign B_rm0to1={(p1_in^B_in[`sign_bit]),(B_in[(`sign_bit-1):0])};  //除2^0
	
	sub_14bit   micro_rotate_0to1_Csub(A_in,B_rm0to1,A_1d);	
	adder_14bit micro_rotate_0to1_Dadd(B_in,A_rm0to1,B_1d);	
	
	//暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_1q <= 'b0;
			B_1q <= 'b0;
			end
		else
			begin
			A_1q <= A_1d;
			B_1q <= B_1d;
			end
	end
	
	//-----------------------micro_2-----------2^1
	
	signed_logic A_2q,B_2q;
	signed_logic A_rm1to2,B_rm1to2,A_2d,B_2d;
	
	assign A_rm1to2={(p2_in^A_1q[`sign_bit]),1'b0,(A_1q[(`sign_bit-1):1])};
	assign B_rm1to2={(p2_in^B_1q[`sign_bit]),1'b0,(B_1q[(`sign_bit-1):1])};
	
	sub_14bit   micro_rotate_1to2_Asub(A_1q,B_rm1to2,A_2d);
	adder_14bit micro_rotate_1to2_Badd(B_1q,A_rm1to2,B_2d);
	
	//暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_2q <= 'b0;
			B_2q <= 'b0;
			end
		else
			begin
			A_2q <= A_2d;
			B_2q <= B_2d;
			end
	end
	
	//-----------------------micro_3-----------2^2
	
	signed_logic A_3q,B_3q;
	signed_logic A_rm2to3,B_rm2to3,A_3d,B_3d;
	
	assign A_rm2to3={(p3_in^A_2q[`sign_bit]),2'b0,(A_2q[(`sign_bit-1):2])};
	assign B_rm2to3={(p3_in^B_2q[`sign_bit]),2'b0,(B_2q[(`sign_bit-1):2])};
	
	sub_14bit   micro_rotate_2to3_Asub(A_2q,B_rm2to3,A_3d);
	adder_14bit micro_rotate_2to3_Badd(B_2q,A_rm2to3,B_3d);
	
	//暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_3q <= 'b0;
			B_3q <= 'b0;
			end
		else
			begin
			A_3q <= A_3d;
			B_3q <= B_3d;
			end
	end
	
	//-----------------------micro_4-----------2^3
	
	signed_logic A_4q,B_4q;
	signed_logic A_rm3to4,B_rm3to4,A_4d,B_4d;
	
	assign A_rm3to4={(p4_in^A_3q[`sign_bit]),3'b0,(A_3q[(`sign_bit-1):3])};
	assign B_rm3to4={(p4_in^B_3q[`sign_bit]),3'b0,(B_3q[(`sign_bit-1):3])};
	
	sub_14bit   micro_rotate_3to4_Asub(A_3q,B_rm3to4,A_4d);
	adder_14bit micro_rotate_3to4_Badd(B_3q,A_rm3to4,B_4d);
	
	//暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_4q <= 'b0;
			B_4q <= 'b0;
			end
		else
			begin
			A_4q <= A_4d;
			B_4q <= B_4d;
			end
	end
	
	//-----------------------micro_5-----------2^4
	
	signed_logic A_5q,B_5q;
	signed_logic A_rm4to5,B_rm4to5,A_5d,B_5d;
	
	assign A_rm4to5={(p5_in^A_4q[`sign_bit]),4'b0,(A_4q[(`sign_bit-1):4])};
	assign B_rm4to5={(p5_in^B_4q[`sign_bit]),4'b0,(B_4q[(`sign_bit-1):4])};
	
	sub_14bit   micro_rotate_4to5_Asub(A_4q,B_rm4to5,A_5d);
	adder_14bit micro_rotate_4to5_Badd(B_4q,A_rm4to5,B_5d);

    //暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_5q <= 'b0;
			B_5q <= 'b0;
			end
		else
			begin
			A_5q <= A_5d;
			B_5q <= B_5d;
			end
	end
	
	//-----------------------micro_6-----------2^5
	
	signed_logic A_6q,B_6q;
	signed_logic A_rm5to6,B_rm5to6,A_6d,B_6d;
	
	assign A_rm5to6={(p6_in^A_5q[`sign_bit]),5'b0,(A_5q[(`sign_bit-1):5])};
	assign B_rm5to6={(p6_in^B_5q[`sign_bit]),5'b0,(B_5q[(`sign_bit-1):5])};
	
	sub_14bit   micro_rotate_5to6_Asub(A_5q,B_rm5to6,A_6d);
	adder_14bit micro_rotate_5to6_Badd(B_5q,A_rm5to6,B_6d);

    //暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_6q <= 'b0;
			B_6q <= 'b0;
			end
		else
			begin
			A_6q <= A_6d;
			B_6q <= B_6d;
			end
	end
	
	//-----------------------micro_7-----------2^6
	signed_logic A_7q, B_7q;
	signed_logic A_rm6to7,B_rm6to7,A_7d,B_7d;
	
	assign A_rm6to7={(p7_in^A_6q[`sign_bit]),6'b0,(A_6q[(`sign_bit-1):6])};
	assign B_rm6to7={(p7_in^B_6q[`sign_bit]),6'b0,(B_6q[(`sign_bit-1):6])};
	
	sub_14bit   micro_rotate_6to7_Asub(A_6q,B_rm6to7,A_7d);
	adder_14bit micro_rotate_6to7_Badd(B_6q,A_rm6to7,B_7d);
	
	//暫存器
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_7q <= 'b0;
			B_7q <= 'b0;
			end
		else
			begin
			A_7q <= A_7d;
			B_7q <= B_7d;
			end
	end
	//乘kapa = ((2^-1+2^-3) - 2^-6  = 0.609375
	unsigned_logic kapaA13, kapaB13;
    unsigned_logic A_hat_p,B_hat_p;
	always_comb begin
		kapaA13 = {1'b0,A_7q[(`sign_bit-1):1]} + {3'b0, A_7q[(`sign_bit-1):3]};//因為是自己加自己，所以只要考慮大小
		
		
		kapaB13 = {1'b0,B_7q[(`sign_bit-1):1]} + {3'b0, B_7q[(`sign_bit-1):3]};//因為是自己加自己，所以只要考慮大小
		
	end
	unsigned_logic kapaA13q, kapaB13q;
	signed_logic A_7q1, B_7q1;
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			kapaA13q <= 'b0;
			kapaB13q <= 'b0;
			A_7q1 <= 'b0;
			B_7q1 <= 'b0;
			end
		else
			begin
			kapaA13q <= kapaA13;
			kapaB13q <= kapaB13;
			A_7q1 <= A_7q;
			B_7q1 <= B_7q;
			end
	end
	always_comb begin
		
		A_hat_p = kapaA13q - {6'b0,A_7q1[(`sign_bit-1):6]};
		
		
		B_hat_p = kapaB13q - {6'b0,B_7q1[(`sign_bit-1):6]};
	end
//out暫存器(在每一層的micro_rotation後都要有一個reg)
    always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_out <= 'b0;
			B_out <= 'b0;
			end
		else
			begin
			A_out <= {A_7q1[`sign_bit],A_hat_p};
			B_out <= {B_7q1[`sign_bit],B_hat_p};
			end
	end
	
	
endmodule

