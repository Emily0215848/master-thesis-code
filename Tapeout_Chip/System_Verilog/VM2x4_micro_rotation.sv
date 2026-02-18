// VM2x4_micro_rotation.sv
//切4刀
`include "C:/Users/Lab601-1/Desktop/hardware/parameter.sv"


module VM2x4_micro_rotation(
//A c e g
//B d f h
	input signed_logic A_in,    //A
	input signed_logic B_in,    //B
	input signed_logic C_in,    //C
	input signed_logic D_in,    //D
	input signed_logic E_in,    //E
	input signed_logic F_in,    //F
	input signed_logic G_in,    //G
	input signed_logic H_in,    //H
	
	input clk,
	input rst,
    input load_VM1, load_VM2, load_VM3, load_VM4, load_VM5,

	//output angle_logic angle_out,
	//最後角度是{p0,p1,p2,.....,p5},p0象限在外面做,所以p1最左邊

	output signed_logic A_out,
	output signed_logic B_out,
	output signed_logic C_out,
	output signed_logic D_out,
	output signed_logic E_out,
	output signed_logic F_out,
	output signed_logic G_out,
	output signed_logic H_out);
	
	
	//-------------  象限判斷在外面做(因為架構的關係，theta_ab是不用判斷象限)
	//所以統一，向限判斷就改在外面那層的CGR或RCGR來做
//-----------------------micro_1-----------2^0
	signed_logic A_1q,B_1q,C_1q,D_1q,E_1q,F_1q,G_1q,H_1q;
	signed_logic A_rm0to1,B_rm0to1,C_rm0to1,D_rm0to1,E_rm0to1,F_rm0to1,G_rm0to1,H_rm0to1
				,A_1d,B_1d,C_1d,D_1d,E_1d,F_1d,G_1d,H_1d;
	logic p_1;
	//logic p1_1q;
    //micro_rr(1,1)=micro_rr(1,1)-p0*(2^(-i))*micro_rr(2,1);
    //micro_rr(2,1)=micro_rr(2,1)+p0*(2^(-i))*micro_rr(1,1);
    //                                       
    //micro_rr(1,2)=micro_rr(1,2)-p0*(2^(-i))*micro_rr(2,2);
    //micro_rr(2,2)=micro_rr(2,2)+p0*(2^(-i))*micro_rr(1,2);
	
	assign p_1=(A_in[`sign_bit]~^B_in[`sign_bit]);//(x_pre[15]~^y_pre[15])=p1=-signx*signy
	
	assign A_rm0to1={(p_1^A_in[`sign_bit]),(A_in[(`sign_bit-1):0])};	//乘2^0
	assign B_rm0to1={(p_1^B_in[`sign_bit]),(B_in[(`sign_bit-1):0])};	//乘2^0
	sub_9bit   micro_rotate_0to1_Asub(A_in,B_rm0to1,A_1d); 	
	adder_9bit micro_rotate_0to1_Badd(B_in,A_rm0to1,B_1d); 	
	
	assign C_rm0to1={(p_1^C_in[`sign_bit]),(C_in[(`sign_bit-1):0])};   //乘2^0
	assign D_rm0to1={(p_1^D_in[`sign_bit]),(D_in[(`sign_bit-1):0])};   //乘2^0
	sub_9bit   micro_rotate_0to1_Csub(C_in,D_rm0to1,C_1d);	
	adder_9bit micro_rotate_0to1_Dadd(D_in,C_rm0to1,D_1d);	
	
	assign E_rm0to1={(p_1^E_in[`sign_bit]),(E_in[(`sign_bit-1):0])};   //乘2^0
	assign F_rm0to1={(p_1^F_in[`sign_bit]),(F_in[(`sign_bit-1):0])};   //乘2^0
	sub_9bit   micro_rotate_0to1_Esub(E_in,F_rm0to1,E_1d);	
	adder_9bit micro_rotate_0to1_Fadd(F_in,E_rm0to1,F_1d);	
	
	assign G_rm0to1={(p_1^G_in[`sign_bit]),(G_in[(`sign_bit-1):0])};   //乘2^0
	assign H_rm0to1={(p_1^H_in[`sign_bit]),(H_in[(`sign_bit-1):0])};   //乘2^0
	sub_9bit   micro_rotate_0to1_Gsub(G_in,H_rm0to1,G_1d);	
	adder_9bit micro_rotate_0to1_Hadd(H_in,G_rm0to1,H_1d);	
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
    always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_1q <= 9'b0;
			B_1q <= 9'b0;
			C_1q <= 9'b0;
			D_1q <= 9'b0;
			E_1q <= 9'b0;
			F_1q <= 9'b0;
			G_1q <= 9'b0;
			H_1q <= 9'b0;
			//p2_1q <= 1'b0;
			//p1_2q <= 1'b0;
			end
		else if (load_VM1)
			begin
			A_1q <= A_1d;
			B_1q <= B_1d;
			C_1q <= C_1d;
			D_1q <= D_1d;
			E_1q <= E_1d;
			F_1q <= F_1d;
			G_1q <= G_1d;
			H_1q <= H_1d;
			//p2_1q <= p_2;
			//p1_2q <= p1_1q;
			end
	end
	
//-----------------------micro_2-----------2^1
	signed_logic A_2q,B_2q,C_2q,D_2q,E_2q,F_2q,G_2q,H_2q;
	signed_logic A_rm1to2,B_rm1to2,C_rm1to2,D_rm1to2,E_rm1to2,F_rm1to2,G_rm1to2,H_rm1to2
				,A_2d,B_2d,C_2d,D_2d,E_2d,F_2d,G_2d,H_2d;
	logic p_2;
    //logic p2_1q,p1_2q;
	
	assign p_2=(A_1q[`sign_bit]~^B_1q[`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	assign A_rm1to2={(p_2^A_1q[`sign_bit]),1'b0,(A_1q[(`sign_bit-1):1])};	//乘2^1
	assign B_rm1to2={(p_2^B_1q[`sign_bit]),1'b0,(B_1q[(`sign_bit-1):1])};  //乘2^1
	sub_9bit   micro_rotate_1to2_Asub(A_1q,B_rm1to2,A_2d); 	
	adder_9bit micro_rotate_1to2_Badd(B_1q,A_rm1to2,B_2d);
	
	assign C_rm1to2={(p_2^C_1q[`sign_bit]),1'b0,(C_1q[(`sign_bit-1):1])};
	assign D_rm1to2={(p_2^D_1q[`sign_bit]),1'b0,(D_1q[(`sign_bit-1):1])};
	sub_9bit   micro_rotate_1to2_Csub(C_1q,D_rm1to2,C_2d);
	adder_9bit micro_rotate_1to2_Dadd(D_1q,C_rm1to2,D_2d);
	
	assign E_rm1to2={(p_2^E_1q[`sign_bit]),1'b0,(E_1q[(`sign_bit-1):1])};
	assign F_rm1to2={(p_2^F_1q[`sign_bit]),1'b0,(F_1q[(`sign_bit-1):1])};
	sub_9bit   micro_rotate_1to2_Esub(E_1q,F_rm1to2,E_2d);
	adder_9bit micro_rotate_1to2_Fadd(F_1q,E_rm1to2,F_2d);
	
	assign G_rm1to2={(p_2^G_1q[`sign_bit]),1'b0,(G_1q[(`sign_bit-1):1])};
	assign H_rm1to2={(p_2^H_1q[`sign_bit]),1'b0,(H_1q[(`sign_bit-1):1])};
	sub_9bit   micro_rotate_1to2_Gsub(G_1q,H_rm1to2,G_2d);
	adder_9bit micro_rotate_1to2_Hadd(H_1q,G_rm1to2,H_2d);
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_2q <= 9'b0;
			B_2q <= 9'b0;
			C_2q <= 9'b0;
			D_2q <= 9'b0;
			E_2q <= 9'b0;
			F_2q <= 9'b0;
			G_2q <= 9'b0;
			H_2q <= 9'b0;
			//p2_1q <= 1'b0;
			//p1_2q <= 1'b0;
			end
		else if (load_VM2)
			begin
			A_2q <= A_2d;
			B_2q <= B_2d;
			C_2q <= C_2d;
			D_2q <= D_2d;
			E_2q <= E_2d;
			F_2q <= F_2d;
			G_2q <= G_2d;
			H_2q <= H_2d;
			//p2_1q <= p_2;
			//p1_2q <= p1_1q;
			end
	end
	
//-----------------------micro_3-----------2^2
	signed_logic A_3q,B_3q,C_3q,D_3q,E_3q,F_3q,G_3q,H_3q;
	signed_logic A_rm2to3,B_rm2to3,C_rm2to3,D_rm2to3,E_rm2to3,F_rm2to3,G_rm2to3,H_rm2to3
				,A_3d,B_3d,C_3d,D_3d,E_3d,F_3d,G_3d,H_3d;
	logic p_3;
	//logic p3_1q,p2_2q,p1_3q;
	
	assign p_3=(A_2q[`sign_bit]~^B_2q[`sign_bit]);//(x_pre[15]~^y_pre[15])=p0=-signx*signy
	
	assign A_rm2to3={(p_3^A_2q[`sign_bit]),2'b0,(A_2q[(`sign_bit-1):2])};	 //乘2^2
	assign B_rm2to3={(p_3^B_2q[`sign_bit]),2'b0,(B_2q[(`sign_bit-1):2])};  //乘2^2
	sub_9bit   micro_rotate_2to3_Asub(A_2q,B_rm2to3,A_3d); 	
	adder_9bit micro_rotate_2to3_Badd(B_2q,A_rm2to3,B_3d);
	
	assign C_rm2to3={(p_3^C_2q[`sign_bit]),2'b0,(C_2q[(`sign_bit-1):2])};
	assign D_rm2to3={(p_3^D_2q[`sign_bit]),2'b0,(D_2q[(`sign_bit-1):2])};
	sub_9bit   micro_rotate_2to3_Csub(C_2q,D_rm2to3,C_3d);
	adder_9bit micro_rotate_2to3_Dadd(D_2q,C_rm2to3,D_3d);
	
	assign E_rm2to3={(p_3^E_2q[`sign_bit]),2'b0,(E_2q[(`sign_bit-1):2])};
	assign F_rm2to3={(p_3^F_2q[`sign_bit]),2'b0,(F_2q[(`sign_bit-1):2])};
	sub_9bit   micro_rotate_2to3_Esub(E_2q,F_rm2to3,E_3d);
	adder_9bit micro_rotate_2to3_Fadd(F_2q,E_rm2to3,F_3d);
	
	assign G_rm2to3={(p_3^G_2q[`sign_bit]),2'b0,(G_2q[(`sign_bit-1):2])};
	assign H_rm2to3={(p_3^H_2q[`sign_bit]),2'b0,(H_2q[(`sign_bit-1):2])};
	sub_9bit   micro_rotate_2to3_Gsub(G_2q,H_rm2to3,G_3d);
	adder_9bit micro_rotate_2to3_Hadd(H_2q,G_rm2to3,H_3d);
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_3q <= 9'b0;
			B_3q <= 9'b0;
			C_3q <= 9'b0;
			D_3q <= 9'b0;
			E_3q <= 9'b0;
			F_3q <= 9'b0;
			G_3q <= 9'b0;
			H_3q <= 9'b0;
			//p2_1q <= 1'b0;
			//p1_2q <= 1'b0;
			end
		else if (load_VM3)
			begin
			A_3q <= A_3d;
			B_3q <= B_3d;
			C_3q <= C_3d;
			D_3q <= D_3d;
			E_3q <= E_3d;
			F_3q <= F_3d;
			G_3q <= G_3d;
			H_3q <= H_3d;
			//p2_1q <= p_2;
			//p1_2q <= p1_1q;
			end
	end
    

    
    //kapa----------------------------------------------------------------------------------------
    //((2^-1+2^-3) - 2^-6  = 0.609375
	signed_logic A_4q,B_4q,C_4q,D_4q,E_4q,F_4q,G_4q,H_4q;
	signed_logic A_hat_p,B_hat_p,C_hat_p,D_hat_p,E_hat_p,F_hat_p,G_hat_p,H_hat_p;
	signed_logic kapaA13;
	signed_logic kapaA13q;
	adder_9bit kapaA_1add3({2'b0,A_3q[(`sign_bit-1):1]},{4'b0, A_3q[(`sign_bit-1):3]},kapaA13);
	
	

	signed_logic kapaB13;
	signed_logic kapaB13q;
	adder_9bit kapaB_1add3({2'b0,B_3q[(`sign_bit-1):1]},{4'b0, B_3q[(`sign_bit-1):3]},kapaB13);
	
	
	signed_logic kapaC13;
	signed_logic kapaC13q;
	adder_9bit kapaC_1add3({2'b0,C_3q[(`sign_bit-1):1]},{4'b0, C_3q[(`sign_bit-1):3]},kapaC13);
	

	signed_logic kapaD13;
	signed_logic kapaD13q;
	adder_9bit kapaD_1add3({2'b0,D_3q[(`sign_bit-1):1]},{4'b0, D_3q[(`sign_bit-1):3]},kapaD13);
	
	
	signed_logic kapaE13;
	signed_logic kapaE13q;
	adder_9bit kapaE_1add3({2'b0,E_3q[(`sign_bit-1):1]},{4'b0, E_3q[(`sign_bit-1):3]},kapaE13);
	
	
	signed_logic kapaF13;
	signed_logic kapaF13q;
	adder_9bit kapaF_1add3({2'b0,F_3q[(`sign_bit-1):1]},{4'b0, F_3q[(`sign_bit-1):3]},kapaF13);
	
	
	signed_logic kapaG13;
	signed_logic kapaG13q;
	adder_9bit kapaG_1add3({2'b0,G_3q[(`sign_bit-1):1]},{4'b0, G_3q[(`sign_bit-1):3]},kapaG13);
	
	
	signed_logic kapaH13;
	signed_logic kapaH13q;
	adder_9bit kapaH_1add3({2'b0,H_3q[(`sign_bit-1):1]},{4'b0, H_3q[(`sign_bit-1):3]},kapaH13);
	
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_4q <= 9'b0;
			B_4q <= 9'b0;
			C_4q <= 9'b0;
			D_4q <= 9'b0;
			E_4q <= 9'b0;
			F_4q <= 9'b0;
			G_4q <= 9'b0;
			H_4q <= 9'b0;

			kapaA13q <= 9'b0;
			kapaB13q <= 9'b0;
			kapaC13q <= 9'b0;
			kapaD13q <= 9'b0;
			kapaE13q <= 9'b0;
			kapaF13q <= 9'b0;
			kapaG13q <= 9'b0;
			kapaH13q <= 9'b0;
			end
		else if (load_VM4)
			begin
			A_4q <= A_3q;
			B_4q <= B_3q;
			C_4q <= C_3q;
			D_4q <= D_3q;
			E_4q <= E_3q;
			F_4q <= F_3q;
			G_4q <= G_3q;
			H_4q <= H_3q;
			
			kapaA13q <= kapaA13;
			kapaB13q <= kapaB13;
			kapaC13q <= kapaC13;
			kapaD13q <= kapaD13;
			kapaE13q <= kapaE13;
			kapaF13q <= kapaF13;
			kapaG13q <= kapaG13;
			kapaH13q <= kapaH13;
			
			end
	end	

	
	sub_9bit   kapaA_13sub6(kapaA13q,{7'b0,A_4q[(`sign_bit-1):6]},A_hat_p);
	sub_9bit   kapaB_13sub6(kapaB13q,{7'b0,B_4q[(`sign_bit-1):6]},B_hat_p);
	sub_9bit   kapaC_13sub6(kapaC13q,{7'b0,C_4q[(`sign_bit-1):6]},C_hat_p);
	sub_9bit   kapaD_13sub6(kapaD13q,{7'b0,D_4q[(`sign_bit-1):6]},D_hat_p);
	sub_9bit   kapaE_13sub6(kapaE13q,{7'b0,E_4q[(`sign_bit-1):6]},E_hat_p);
	sub_9bit   kapaF_13sub6(kapaF13q,{7'b0,F_4q[(`sign_bit-1):6]},F_hat_p);
	sub_9bit   kapaG_13sub6(kapaG13q,{7'b0,G_4q[(`sign_bit-1):6]},G_hat_p);
	sub_9bit   kapaH_13sub6(kapaH13q,{7'b0,H_4q[(`sign_bit-1):6]},H_hat_p);
//暫存器(在每一層的micro_rotation後都要有一個reg，有load才會加載)
	always_ff@(posedge clk)	begin
		if(rst)
			begin
			A_out <= 9'b0;
			B_out <= 9'b0;
			C_out <= 9'b0;
			D_out <= 9'b0;
			E_out <= 9'b0;
			F_out <= 9'b0;
			G_out <= 9'b0;
			H_out <= 9'b0;
			
			//angle_out <= 0;
			end
		else if (load_VM5)
			begin
			A_out <= {A_4q[`sign_bit],A_hat_p[7:0]};
			B_out <= {B_4q[`sign_bit],B_hat_p[7:0]};
			C_out <= {C_4q[`sign_bit],C_hat_p[7:0]};
			D_out <= {D_4q[`sign_bit],D_hat_p[7:0]};
			E_out <= {E_4q[`sign_bit],E_hat_p[7:0]};
			F_out <= {F_4q[`sign_bit],F_hat_p[7:0]};
			G_out <= {G_4q[`sign_bit],G_hat_p[7:0]};
			H_out <= {H_4q[`sign_bit],H_hat_p[7:0]};
			
			//angle_out <= {p1_2q,p2_1q,p_3,1'b0,1'b0,1'b0};
			//最後角度是{p1,p2,.....,p5},角度編號遞增，實際代表的角度大小遞減
			end
	end
	
	
	
endmodule

