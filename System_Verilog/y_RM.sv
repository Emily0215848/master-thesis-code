`include "./parameter.sv"
module y_RM(
	input clk,
	input rst,
	input signed_logic y[7:0],
	col1_angle.RM h1A,
	col2_angle.RM h2A,
	col3_angle.RM h3A,
	col4_angle.RM h4A,
	col5_angle.RM h5A,
	col6_angle.RM h6A,
	col7_angle.RM h7A,
	
	output signed_logic y_tilde[7:0]
);
	parameter T = 9;//9刀
	signed_logic y_1[7:0];
	JRGR2x1_yRM rm12(
	.A			(y[0]), 
	.B			(y[1]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h11h21_theta_AB),
	
	.A_out		(y_1[0]),
	.B_out		(y_1[1])
	);
	
	JRGR2x1_yRM rm34(
	.A			(y[2]), 
	.B			(y[3]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h31h41_theta_AB),
	
	.A_out		(y_1[2]),
	.B_out		(y_1[3])
	);
	
	JRGR2x1_yRM rm56(
	.A			(y[4]), 
	.B			(y[5]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h51h61_theta_AB),
	
	.A_out		(y_1[4]),
	.B_out		(y_1[5])
	);
	
	JRGR2x1_yRM rm78(
	.A			(y[6]), 
	.B			(y[7]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h71h81_theta_AB),
	
	.A_out		(y_1[6]),
	.B_out		(y_1[7])
	);
	
	logic [55:0]y_1_pipe[(T*2-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T*2); i_1++)begin
				y_1_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_1_pipe[0] <= {y_1[1],y_1[3],y_1[5],y_1[7]};
			for(int j_1=0; j_1<(T*2-1); j_1++)begin
				y_1_pipe[j_1+1] <= y_1_pipe[j_1];
			end
		end
		
	end
	
	signed_logic y_12[3:0];
	RGR2x1_yRM rm13(
	.A			(y_1[0]), 
	.B			(y_1[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h11h31_theta_AB),
	
	.A_out		(y_12[0]),
	.B_out		(y_12[1])
	);
	
	RGR2x1_yRM rm57(
	.A			(y_1[4]), 
	.B			(y_1[6]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h51h71_theta_AB),
	
	.A_out		(y_12[2]),
	.B_out		(y_12[3])
	);
	
	logic [27:0]y_12_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<T; i_1++)begin
				y_12_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_12_pipe[0] <= {y_12[1],y_12[3]};
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_12_pipe[j_1+1] <= y_12_pipe[j_1];
			end
		end
	end
	
	signed_logic y_13[1:0];
	RGR2x1_yRM rm15(
	.A			(y_12[0]), 
	.B			(y_12[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h1A.h11h51_theta_AB),
	
	.A_out		(y_13[0]),
	.B_out		(y_13[1])
	);
	
	signed_logic y_2[7:0];
	assign y_2[0] = y_13[0];
	assign y_2[4] = y_13[1];
	assign y_2[2] = y_12_pipe[(T-1)][27:14];
	assign y_2[6] = y_12_pipe[(T-1)][13:0];
	assign y_2[1] = y_1_pipe[(2*T-1)][55:42];
	assign y_2[3] = y_1_pipe[(2*T-1)][41:28];
	assign y_2[5] = y_1_pipe[(2*T-1)][27:14];
	assign y_2[7] = y_1_pipe[(2*T-1)][13:0];
	
	signed_logic y_20_pipe [(T*14-1):0];//y[0]?
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<T*14; i_1++)begin
				y_20_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_20_pipe[0] <= y_2[0];
			for(int j_1=0; j_1<(T*14-1); j_1++)begin
				y_20_pipe[j_1+1] <= y_20_pipe[j_1];
			end
		end
	end
	
	//col2_angle
	signed_logic y_2_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_2_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_2_pipe[0] <= y_2[7];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_2_pipe[j_1+1] <= y_2_pipe[j_1];
			end
		end
	end
	
	signed_logic y_21[5:0];
	JRGR2x1_yRM rm12_1(
	.A			(y_2[1]), 
	.B			(y_2[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h22h32_theta_AB),
	
	.A_out		(y_21[0]),
	.B_out		(y_21[1])
	);
	
	JRGR2x1_yRM rm34_1(
	.A			(y_2[3]), 
	.B			(y_2[4]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h42h52_theta_AB),
	
	.A_out		(y_21[2]),
	.B_out		(y_21[3])
	);
	
	JRGR2x1_yRM rm56_1(
	.A			(y_2[5]), 
	.B			(y_2[6]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h62h72_theta_AB),
	
	.A_out		(y_21[4]),
	.B_out		(y_21[5])
	);
	
	logic [41:0]y_21_pipe[(2*T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(2*T); i_1++)begin
				y_21_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_21_pipe[0] <= {y_21[1],y_21[3],y_21[5]};
			for(int j_1=0; j_1<(2*T-1); j_1++)begin
				y_21_pipe[j_1+1] <= y_21_pipe[j_1];
			end
		end
	end
	
	signed_logic y_22[3:0];
	RGR2x1_yRM rm13_1(
	.A			(y_21[0]), 
	.B			(y_21[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h22h42_theta_AB),
	
	.A_out		(y_22[0]),
	.B_out		(y_22[1])
	);
	
	RGR2x1_yRM rm57_1(
	.A			(y_21[4]), 
	.B			(y_2_pipe[(T-1)]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h62h82_theta_AB),
	
	.A_out		(y_22[2]),
	.B_out		(y_22[3])
	);
	
	logic [27:0]y_22_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<T; i_1++)begin
				y_22_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_22_pipe[0] <= {y_22[1],y_22[3]};
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_22_pipe[j_1+1] <= y_22_pipe[j_1];
			end
		end
	end
	
	signed_logic y_23[1:0];
	RGR2x1_yRM rm15_1(
	.A			(y_22[0]), 
	.B			(y_22[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h2A.h22h62_theta_AB),
	
	.A_out		(y_23[0]),
	.B_out		(y_23[1])
	);
	
	signed_logic y_3[6:0];
	assign y_3[0] = y_23[0];
	assign y_3[4] = y_23[1];
	assign y_3[2] = y_22_pipe[(T-1)][27:14];
	assign y_3[6] = y_22_pipe[(T-1)][13:0];
	assign y_3[1] = y_21_pipe[(2*T-1)][41:28];
	assign y_3[3] = y_21_pipe[(2*T-1)][27:14];
	assign y_3[5] = y_21_pipe[(2*T-1)][13:0];
	
	signed_logic y_30_pipe [(11*T-1):0];//y[1]最後一次改//?
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(11*T); i_1++)begin
				y_30_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_30_pipe[0] <= y_3[0];
			for(int j_1=0; j_1<(11*T-1); j_1++)begin
				y_30_pipe[j_1+1] <= y_30_pipe[j_1];
			end
		end
	end
	
	//col3_angle
	signed_logic y_31[5:0];
	JRGR2x1_yRM rm12_2(
	.A			(y_3[1]), 
	.B			(y_3[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h3A.h33h43_theta_AB),
	
	.A_out		(y_31[0]),
	.B_out		(y_31[1])
	);
	
	JRGR2x1_yRM rm34_2(
	.A			(y_3[3]), 
	.B			(y_3[4]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h3A.h53h63_theta_AB),
	
	.A_out		(y_31[2]),
	.B_out		(y_31[3])
	);
	
	JRGR2x1_yRM rm56_2(
	.A			(y_3[5]), 
	.B			(y_3[6]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h3A.h73h83_theta_AB),
	
	.A_out		(y_31[4]),
	.B_out		(y_31[5])
	);
	
	signed_logic y_310_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_310_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_310_pipe[0] <= y_31[4];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_310_pipe[j_1+1] <= y_310_pipe[j_1];
			end
		end
	end
	
	logic [41:0]y_31_pipe[(2*T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(2*T); i_1++)begin
				y_31_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_31_pipe[0] <= {y_31[1],y_31[3],y_31[5]};
			for(int j_1=0; j_1<(2*T-1); j_1++)begin
				y_31_pipe[j_1+1] <= y_31_pipe[j_1];
			end
		end
	end
	
	signed_logic y_32[1:0];
	RGR2x1_yRM rm13_2(
	.A			(y_31[0]), 
	.B			(y_31[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h3A.h33h53_theta_AB),
	
	.A_out		(y_32[0]),
	.B_out		(y_32[1])
	);
	
	signed_logic y_32_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<T; i_1++)begin
				y_32_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_32_pipe[0] <= y_32[1];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_32_pipe[j_1+1] <= y_32_pipe[j_1];
			end
		end
	end
	
	signed_logic y_33[1:0];
	RGR2x1_yRM rm15_2(
	.A			(y_32[0]), 
	.B			(y_310_pipe[(T-1)]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h3A.h33h73_theta_AB),
	
	.A_out		(y_33[0]),
	.B_out		(y_33[1])
	);
	
	signed_logic y_4[5:0];
	assign y_4[0] = y_33[0];
	assign y_4[4] = y_33[1];
	assign y_4[2] = y_32_pipe[(T-1)];
	assign y_4[1] = y_31_pipe[(2*T-1)][41:28];
	assign y_4[3] = y_31_pipe[(2*T-1)][27:14];
	assign y_4[5] = y_31_pipe[(2*T-1)][13:0];
	
	signed_logic y_40_pipe [(8*T-1):0];//y[2]最後一次改
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(8*T); i_1++)begin
				y_40_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_40_pipe[0] <= y_4[0];
			for(int j_1=0; j_1<(8*T-1); j_1++)begin
				y_40_pipe[j_1+1] <= y_40_pipe[j_1];
			end
		end
	end
	
	//col4_angle
	signed_logic y_4_pipe[(2*T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(2*T); i_1++)begin
				y_4_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_4_pipe[0] <= y_4[5];
			for(int j_1=0; j_1<(2*T-1); j_1++)begin
				y_4_pipe[j_1+1] <= y_4_pipe[j_1];
			end
		end
	end
	
	signed_logic y_41[3:0];
	JRGR2x1_yRM rm12_3(
	.A			(y_4[1]), 
	.B			(y_4[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h4A.h44h54_theta_AB),
	
	.A_out		(y_41[0]),
	.B_out		(y_41[1])
	);
	
	JRGR2x1_yRM rm34_3(
	.A			(y_4[3]), 
	.B			(y_4[4]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h4A.h64h74_theta_AB),
	
	.A_out		(y_41[2]),
	.B_out		(y_41[3])
	);
	
	logic [27:0]y_41_pipe[(2*T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(2*T); i_1++)begin
				y_41_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_41_pipe[0] <= {y_41[1],y_41[3]};
			for(int j_1=0; j_1<(2*T-1); j_1++)begin
				y_41_pipe[j_1+1] <= y_41_pipe[j_1];
			end
		end
	end
	
	signed_logic y_42[1:0];
	RGR2x1_yRM rm13_3(
	.A			(y_41[0]), 
	.B			(y_41[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h4A.h44h64_theta_AB),
	
	.A_out		(y_42[0]),
	.B_out		(y_42[1])
	);
	
	signed_logic y_42_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_42_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_42_pipe[0] <= y_42[1];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_42_pipe[j_1+1] <= y_42_pipe[j_1];
			end
		end
	end
	
	signed_logic y_43[1:0];
	RGR2x1_yRM rm15_3(
	.A			(y_42[0]), 
	.B			(y_4_pipe[(2*T-1)]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h4A.h44h84_theta_AB),
	
	.A_out		(y_43[0]),
	.B_out		(y_43[1])
	);
	
	signed_logic y_5[4:0];
	assign y_5[0] = y_43[0];
	assign y_5[4] = y_43[1];
	assign y_5[2] = y_42_pipe[(T-1)];
	assign y_5[1] = y_41_pipe[(2*T-1)][27:14];
	assign y_5[3] = y_41_pipe[(2*T-1)][13:0];
	
	signed_logic y_50_pipe [(5*T-1):0];//y[3]最後一次改
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(5*T); i_1++)begin
				y_50_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_50_pipe[0] <= y_5[0];
			for(int j_1=0; j_1<(5*T-1); j_1++)begin
				y_50_pipe[j_1+1] <= y_50_pipe[j_1];
			end
		end
	end
	
	//col5_angle
	signed_logic y_51[3:0];
	JRGR2x1_yRM rm12_4(
	.A			(y_5[1]), 
	.B			(y_5[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h5A.h55h65_theta_AB),
	
	.A_out		(y_51[0]),
	.B_out		(y_51[1])
	);
	
	JRGR2x1_yRM rm34_4(
	.A			(y_5[3]), 
	.B			(y_5[4]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h5A.h75h85_theta_AB),
	
	.A_out		(y_51[2]),
	.B_out		(y_51[3])
	);
	
	logic [27:0]y_51_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_51_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_51_pipe[0] <= {y_51[1],y_51[3]};
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_51_pipe[j_1+1] <= y_51_pipe[j_1];
			end
		end
	end
	
	signed_logic y_52[1:0];
	RGR2x1_yRM rm13_4(
	.A			(y_51[0]), 
	.B			(y_51[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h5A.h55h75_theta_AB),
	
	.A_out		(y_52[0]),
	.B_out		(y_52[1])
	);
	
	signed_logic y_6[3:0];
	assign y_6[0] = y_52[0];
	assign y_6[2] = y_52[1];
	assign y_6[1] = y_51_pipe[(T-1)][27:14];
	assign y_6[3] = y_51_pipe[(T-1)][13:0];
	
	signed_logic y_60_pipe [(3*T-1):0];//y[4]最後一次改
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(3*T); i_1++)begin
				y_60_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_60_pipe[0] <= y_6[0];
			for(int j_1=0; j_1<(3*T-1); j_1++)begin
				y_60_pipe[j_1+1] <= y_60_pipe[j_1];
			end
		end
	end
	
	//col6_angle
	signed_logic y_6_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_6_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_6_pipe[0] <= y_6[3];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_6_pipe[j_1+1] <= y_6_pipe[j_1];
			end
		end
	end
	
	signed_logic y_61[1:0];
	JRGR2x1_yRM rm12_5(
	.A			(y_6[1]), 
	.B			(y_6[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h6A.h66h76_theta_AB),
	
	.A_out		(y_61[0]),
	.B_out		(y_61[1])
	);
	
	signed_logic y_61_pipe[(T-1):0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<(T); i_1++)begin
				y_61_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_61_pipe[0] <= y_61[1];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_61_pipe[j_1+1] <= y_61_pipe[j_1];
			end
		end
	end
	
	signed_logic y_62[1:0];
	RGR2x1_yRM rm13_5(
	.A			(y_61[0]), 
	.B			(y_6_pipe[(T-1)]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h6A.h66h86_theta_AB),
	
	.A_out		(y_62[0]),
	.B_out		(y_62[1])
	);
	
	signed_logic y_7[2:0];
	assign y_7[0] = y_62[0];
	assign y_7[2] = y_62[1];
	assign y_7[1] = y_61_pipe[(T-1)];
	
	signed_logic y_70_pipe [(T-1):0];//y[5]最後一次改
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i_1=0; i_1<T; i_1++)begin
				y_70_pipe[i_1] <= 'b0;
			end
		end
		else begin
			y_70_pipe[0] <= y_7[0];
			for(int j_1=0; j_1<(T-1); j_1++)begin
				y_70_pipe[j_1+1] <= y_70_pipe[j_1];
			end
		end
	end
	
	//col7_angle
	signed_logic y_71[1:0];
	JRGR2x1_yRM rm12_6(
	.A			(y_7[1]), 
	.B			(y_7[2]),
	.clk		(clk),
	.rst		(rst),
	.thetaAB_in	(h7A.h77h87_theta_AB),
	
	.A_out		(y_71[0]),
	.B_out		(y_71[1])
	);
	
	signed_logic y_8[1:0];
	assign y_8[0] = y_71[0];
	
	always_comb begin
		if (h7A.h88_theta_AB)
			y_8[1] = {~y_71[1][`sign_bit], y_71[1][(`sign_bit-1):0]};
		else
			y_8[1] = y_71[1];
	end
	
	//y_tilde
	assign y_tilde[0] = y_20_pipe[(T*14-1)];
	assign y_tilde[1] = y_30_pipe[(T*11-1)];
	assign y_tilde[2] = y_40_pipe[(T*8-1)];
	assign y_tilde[3] = y_50_pipe[(T*5-1)];
	assign y_tilde[4] = y_60_pipe[(T*3-1)];
	assign y_tilde[5] = y_70_pipe[(T-1)];
	assign y_tilde[6] = y_8[0];
	assign y_tilde[7] = y_8[1];
endmodule
