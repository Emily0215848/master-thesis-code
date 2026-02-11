// VM2xN_micro_rotation.sv
`include "./parameter.sv"
//VM2xN+1

module VM2xN_micro_rotation#(parameter N = 7)(
//A c 
//B d 
	input signed_logic A_in[N:0],    //第一列
	input signed_logic B_in[N:0],    //第二列
	
	input clk,
	input rst,

	output angle_logic angle_out,
	//最後角度是{p0,p1,p2,.....,p5},p0象限在外面做,所以p1最左邊

	output signed_logic A_out[N:0],
	output signed_logic B_out[(N-1):0]
	
	);
	
	
	//-------------  象限判斷在外面做(因為架構的關係，theta_ab是不用判斷象限)
	//所以統一，向限判斷就改在外面那層的CGR或RCGR來做
//-----------------------micro_1-----------2^0
	signed_logic A_1q[N:0], B_1q[N:0];
	signed_logic A_rm0to1[N:0], B_rm0to1[N:0], A_1d[N:0], B_1d[N:0];
	logic p_1;
	
	assign p_1=(A_in[0][`sign_bit]~^B_in[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p1=-signx*signy
	
	genvar i_1;
	generate 
	for (i_1=0; i_1<(N+1); i_1=i_1+1) begin:rm0to1
		assign A_rm0to1[i_1] = {(p_1^A_in[i_1][`sign_bit]),(A_in[i_1][(`sign_bit-1):0])};	//除2^0
		assign B_rm0to1[i_1] = {(p_1^B_in[i_1][`sign_bit]),(B_in[i_1][(`sign_bit-1):0])};	//除2^0
		sub_14bit   micro_rotate_0to1_Asub(A_in[i_1],B_rm0to1[i_1],A_1d[i_1]); 
		adder_14bit micro_rotate_0to1_Badd(B_in[i_1],A_rm0to1[i_1],B_1d[i_1]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_1;
	generate 
	for (j_1=0; j_1<(N+1); j_1=j_1+1) begin:DFF_1
		always_ff@(posedge clk)begin
			if(rst)begin
				A_1q[j_1] <= 'b0;
				B_1q[j_1] <= 'b0;
			end
			else begin
				A_1q[j_1] <= A_1d[j_1];
				B_1q[j_1] <= B_1d[j_1];
			end
		end
	end
	endgenerate
	
//-----------------------micro_2-----------2^1
	signed_logic A_2q[N:0], B_2q[N:0];
	signed_logic A_rm1to2[N:0], B_rm1to2[N:0], A_2d[N:0], B_2d[N:0];
	logic p_2;
	
	assign p_2=(A_1q[0][`sign_bit]~^B_1q[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p1=-signx*signy
	
	genvar i_2;
	generate 
	for (i_2=0; i_2<(N+1); i_2=i_2+1) begin:rm1to2
		assign A_rm1to2[i_2]={(p_2^A_1q[i_2][`sign_bit]),1'b0,(A_1q[i_2][(`sign_bit-1):1])};	//除2^1
		assign B_rm1to2[i_2]={(p_2^B_1q[i_2][`sign_bit]),1'b0,(B_1q[i_2][(`sign_bit-1):1])};	//除2^1
		sub_14bit   micro_rotate_1to2_Asub(A_1q[i_2],B_rm1to2[i_2],A_2d[i_2]); 
		adder_14bit micro_rotate_1to2_Badd(B_1q[i_2],A_rm1to2[i_2],B_2d[i_2]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_2;
	generate 
	for (j_2=0; j_2<(N+1); j_2=j_2+1) begin:DFF_2
		always_ff@(posedge clk)begin
			if(rst)begin
				A_2q[j_2] <= 'b0;
				B_2q[j_2] <= 'b0;
			end
			else begin
				A_2q[j_2] <= A_2d[j_2];
				B_2q[j_2] <= B_2d[j_2];
			end
		end
	end
	endgenerate
	
//-----------------------micro_3-----------2^2
	signed_logic A_3q[N:0], B_3q[N:0];
	signed_logic A_rm2to3[N:0], B_rm2to3[N:0], A_3d[N:0], B_3d[N:0];
	logic p_3;
	
	assign p_3=(A_2q[0][`sign_bit]~^B_2q[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	genvar i_3;
	generate 
	for (i_3=0; i_3<(N+1); i_3=i_3+1) begin:rm2to3
		assign A_rm2to3[i_3]={(p_3^A_2q[i_3][`sign_bit]),2'b0,(A_2q[i_3][(`sign_bit-1):2])};	//除2^2
		assign B_rm2to3[i_3]={(p_3^B_2q[i_3][`sign_bit]),2'b0,(B_2q[i_3][(`sign_bit-1):2])};	//除2^2
		sub_14bit   micro_rotate_2to3_Asub(A_2q[i_3],B_rm2to3[i_3],A_3d[i_3]); 
		adder_14bit micro_rotate_2to3_Badd(B_2q[i_3],A_rm2to3[i_3],B_3d[i_3]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_3;
	generate 
	for (j_3=0; j_3<(N+1); j_3=j_3+1) begin:DFF_3
		always_ff@(posedge clk)begin
			if(rst)begin
				A_3q[j_3] <= 'b0;
				B_3q[j_3] <= 'b0;
			end
			else begin
				A_3q[j_3] <= A_3d[j_3];
				B_3q[j_3] <= B_3d[j_3];
			end
		end
	end
	endgenerate
	
//-----------------------micro_4-----------2^3
	signed_logic A_4q[N:0], B_4q[N:0];
	signed_logic A_rm3to4[N:0], B_rm3to4[N:0], A_4d[N:0], B_4d[N:0];
	logic p_4;
	
	assign p_4=(A_3q[0][`sign_bit]~^B_3q[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	genvar i_4;
	generate 
	for (i_4=0; i_4<(N+1); i_4=i_4+1) begin:rm3to4
		assign A_rm3to4[i_4]={(p_4^A_3q[i_4][`sign_bit]),3'b0,(A_3q[i_4][(`sign_bit-1):3])};	//除2^3
		assign B_rm3to4[i_4]={(p_4^B_3q[i_4][`sign_bit]),3'b0,(B_3q[i_4][(`sign_bit-1):3])};	//除2^3
		sub_14bit   micro_rotate_3to4_Asub(A_3q[i_4],B_rm3to4[i_4],A_4d[i_4]); 
		adder_14bit micro_rotate_3to4_Badd(B_3q[i_4],A_rm3to4[i_4],B_4d[i_4]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_4;
	generate 
	for (j_4=0; j_4<(N+1); j_4=j_4+1) begin:DFF_4
		always_ff@(posedge clk)begin
			if(rst)begin
				A_4q[j_4] <= 'b0;
				B_4q[j_4] <= 'b0;
			end
			else begin
				A_4q[j_4] <= A_4d[j_4];
				B_4q[j_4] <= B_4d[j_4];
			end
		end
	end
	endgenerate
	
//-----------------------micro_5-----------2^4
	signed_logic A_5q[N:0], B_5q[N:0];
	signed_logic A_rm4to5[N:0], B_rm4to5[N:0], A_5d[N:0], B_5d[N:0];
	logic p_5;
	
	assign p_5=(A_4q[0][`sign_bit]~^B_4q[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	genvar i_5;
	generate 
	for (i_5=0; i_5<(N+1); i_5=i_5+1) begin:rm4to5
		assign A_rm4to5[i_5]={(p_5^A_4q[i_5][`sign_bit]),4'b0,(A_4q[i_5][(`sign_bit-1):4])};	//除2^4
		assign B_rm4to5[i_5]={(p_5^B_4q[i_5][`sign_bit]),4'b0,(B_4q[i_5][(`sign_bit-1):4])};	//除2^4
		sub_14bit   micro_rotate_4to5_Asub(A_4q[i_5],B_rm4to5[i_5],A_5d[i_5]); 
		adder_14bit micro_rotate_4to5_Badd(B_4q[i_5],A_rm4to5[i_5],B_5d[i_5]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_5;
	generate 
	for (j_5=0; j_5<(N+1); j_5=j_5+1) begin:DFF_5
		always_ff@(posedge clk)begin
			if(rst)begin
				A_5q[j_5] <= 'b0;
				B_5q[j_5] <= 'b0;
			end
			else begin
				A_5q[j_5] <= A_5d[j_5];
				B_5q[j_5] <= B_5d[j_5];
			end
		end
	end
	endgenerate
	
//-----------------------micro_6-----------2^5
	signed_logic A_6q[N:0], B_6q[N:0];
	signed_logic A_rm5to6[N:0], B_rm5to6[N:0], A_6d[N:0], B_6d[N:0];
	logic p_6;
	
	assign p_6=(A_5q[0][`sign_bit]~^B_5q[0][`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	genvar i_6;
	generate 
	for (i_6=0; i_6<(N+1); i_6=i_6+1) begin:rm5to6
		assign A_rm5to6[i_6]={(p_6^A_5q[i_6][`sign_bit]),5'b0,(A_5q[i_6][(`sign_bit-1):5])};	//除2^5
		assign B_rm5to6[i_6]={(p_6^B_5q[i_6][`sign_bit]),5'b0,(B_5q[i_6][(`sign_bit-1):5])};	//除2^5
		sub_14bit   micro_rotate_5to6_Asub(A_5q[i_6],B_rm5to6[i_6],A_6d[i_6]); 
		adder_14bit micro_rotate_5to6_Badd(B_5q[i_6],A_rm5to6[i_6],B_6d[i_6]); 
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_6;
	generate 
	for (j_6=0; j_6<(N+1); j_6=j_6+1) begin:DFF_6
		always_ff@(posedge clk)begin
			if(rst)begin
				A_6q[j_6] <= 'b0;
				B_6q[j_6] <= 'b0;
			end
			else begin
				A_6q[j_6] <= A_6d[j_6];
				B_6q[j_6] <= B_6d[j_6];
			end
		end
	end
	endgenerate
		
//-----------------------micro_7-----------2^6
	signed_logic A_7q[N:0], B_7q[N:0];
	signed_logic A_rm6to7[N:0], B_rm6to7[N:0], A_7d[N:0], B_7d[N:0];
	logic p_7;
	
	assign p_7=(A_6q[0][`sign_bit]~^B_6q[0][`sign_bit]);//(A_pre[15]~^B_pre[15])=p0=-signx*signy
	
	genvar i_7;
	generate 
	for (i_7=0; i_7<(N+1); i_7=i_7+1) begin:rm6to7
		assign A_rm6to7[i_7]={(p_7^A_6q[i_7][`sign_bit]),6'b0,(A_6q[i_7][(`sign_bit-1):6])};	//除2^6
		assign B_rm6to7[i_7]={(p_7^B_6q[i_7][`sign_bit]),6'b0,(B_6q[i_7][(`sign_bit-1):6])};	//除2^6
		sub_14bit   micro_rotate_6to7_Asub(A_6q[i_7],B_rm6to7[i_7],A_7d[i_7]); 
		adder_14bit micro_rotate_6to7_Badd(B_6q[i_7],A_rm6to7[i_7],B_7d[i_7]); 
	end
	endgenerate
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_7;
	generate 
	for (j_7=0; j_7<(N+1); j_7=j_7+1) begin:DFF_7
		always_ff@(posedge clk)begin
			if(rst)begin
				A_7q[j_7] <= 'b0;
				B_7q[j_7] <= 'b0;
			end
			else begin
				A_7q[j_7] <= A_7d[j_7];
				B_7q[j_7] <= B_7d[j_7];
			end
		end
	end
	endgenerate		
//乘kapa = ((2^-1+2^-3) - 2^-6  = 0.609375
	unsigned_logic kapaA13[N:0], kapaB13[N:0];
	unsigned_logic A_hat_p[N:0], B_hat_p[N:0];
	
	genvar k_1;
	generate 
	for (k_1=0; k_1<(N+1); k_1=k_1+1) begin:kapa1
		assign kapaA13[k_1] = {1'b0,A_7q[k_1][(`sign_bit-1):1]} + {3'b0, A_7q[k_1][(`sign_bit-1):3]};//因為是自己加自己，所以只要考慮大小
		
		assign kapaB13[k_1] = {1'b0,B_7q[k_1][(`sign_bit-1):1]} + {3'b0, B_7q[k_1][(`sign_bit-1):3]};//因為是自己加自己，所以只要考慮大小

	end
	endgenerate
	
	unsigned_logic kapaA13q[N:0], kapaB13q[N:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int k=0;k<(N+1);k++)begin
				kapaA13q[k] <= 'b0;
				kapaB13q[k] <= 'b0;
			end
		end
		else begin
			kapaA13q <= kapaA13;
			kapaB13q <= kapaB13;
		end
	end
	genvar k_2;
	generate 
	for (k_2=0; k_2<(N+1); k_2=k_2+1) begin:kapa2
		
		assign A_hat_p[k_2] = kapaA13q[k_2] - {6'b0,A_7q[k_2][(`sign_bit-1):6]};
		
		
		assign B_hat_p[k_2] = kapaB13q[k_2] - {6'b0,B_7q[k_2][(`sign_bit-1):6]};
	end
	endgenerate
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	genvar j_9;
	generate 
	for (j_9=0; j_9<(N+1); j_9=j_9+1) begin:DFF_9
		always_ff@(posedge clk)begin
			if(rst)begin
				A_out[j_9] <= 'b0;				
			end
			else begin
				A_out[j_9] <= {A_7q[j_9][`sign_bit],A_hat_p[j_9]};
			end
		end
	end
	endgenerate
	
	genvar j_8;
	generate 
	for (j_8=0; j_8<N; j_8=j_8+1) begin:DFF_8
		always_ff@(posedge clk)begin
			if(rst)begin
				B_out[j_8] <= 'b0;
			end
			else begin
				B_out[j_8] <= {B_7q[j_8+1][`sign_bit],B_hat_p[j_8+1]};
			end
		end
	end
	endgenerate
	
	always_ff@(posedge clk)begin
		if(rst)begin
			angle_out <= 'b0;
		end
		else begin
			angle_out <= {p_1,p_2,p_3,p_4,p_5,p_6,p_7};
			//最後角度是{p1,p2,.....,p5},角度編號遞增，實際代表的角度大小遞減
		end
	end	


	
endmodule

