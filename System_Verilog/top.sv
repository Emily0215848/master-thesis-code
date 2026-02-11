//top.sv
`include "./parameter.sv"
module top(//QRdecom
	input clk, 
	input rst,
	input signed_logic H [7:0][7:0],
	input signed_logic y [7:0],
	
	output logic QRHVM_finish_o, KB_finish_o,
	output logic [23:0] result_bitstream
);
	signed_logic R1[7:0];
	signed_logic R2[6:0];
	signed_logic R3[5:0];
	signed_logic R4[4:0];
	signed_logic R5[3:0];
	signed_logic R6[2:0];
	signed_logic R7[1:0];
	signed_logic R8;
	
	logic [1:0] min_index8x4w;
	logic [1:0] min_index8x4;
	//logic [2:0] sel_col;
	col #(.N(8)) col8_0(), col8_1(), col8_2(), col8_3(),
				 col8_4(), col8_5(), col8_6(), col8_7();
	
	//col col0();
	//col col1();
	//col col2();
	//col col3();
	//col col4();
	//col col5();
	//col col6();
	//col col7();
	
	
	//---------Sort8*4------------------
	CGAS8x4 CGAS8x4_1(.clk(clk), .rst(rst), .H(H), .min_index(min_index8x4w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index8x4 <= 'b0;
		else 
			min_index8x4 <= min_index8x4w;
	end
	//--------------------------------
	col_sel8x4 col_sel8x4_1(
		.min_index8x4(min_index8x4),
		.H(H),
		
		.col8_0(col8_0),
		.col8_1(col8_1),
		.col8_2(col8_2),
		.col8_3(col8_3),
		.col8_4(col8_4),
		.col8_5(col8_5),
		.col8_6(col8_6),
		.col8_7(col8_7)
	);  
	//----------CORDIC VM/RM---------
	signed_logic H_1[6:0][6:0];
	col1_angle h1A();
	signed_logic row1[7:0];
	
	QRdecom_VM8x8 QRdecom_VM8x8_1(
		.col8_0(col8_0),
		.col8_1(col8_1),
		.col8_2(col8_2),
		.col8_3(col8_3),
		.col8_4(col8_4),
		.col8_5(col8_5),
		.col8_6(col8_6),
		.col8_7(col8_7),
		.clk	(clk),
		.rst	(rst),

		.h1A(h1A),
		.B_2(H_1[0]),
		.B_4(H_1[2]),
		.B_6(H_1[4]),
		.B_8(H_1[6]),
		.B_3(H_1[1]),
		.B_7(H_1[5]),
		.B_5(H_1[3]),
		.norm_col1(row1)
	);
	assign R1[0] = row1[0];
	//---------Sort7*7------------------
	logic [2:0] min_index7x7w;
	logic [2:0] min_index7x7;
	CGAS7x7 CGAS7x7_1(.clk(clk), .rst(rst), .H(H_1), .min_index(min_index7x7w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index7x7 <= 'b0;
		else 
			min_index7x7 <= min_index7x7w;
	end
	//--------------------------------
	signed_logic row7_0[6:0];
	signed_logic row7_1[6:0];
	signed_logic row7_2[6:0];
	signed_logic row7_3[6:0];
	signed_logic row7_4[6:0];
	signed_logic row7_5[6:0];
	signed_logic row7_6[6:0];
	signed_logic row1_1d[6:0];
	
	col_sel7x7 col_sel7x7_1(
		.min_index7x7(min_index7x7),
		.H(H_1),
		.row1(row1[7:1]),
		
		.row7_0(row7_0),
		.row7_1(row7_1),
		.row7_2(row7_2),
		.row7_3(row7_3),
		.row7_4(row7_4),
		.row7_5(row7_5),
		.row7_6(row7_6),
		.row1_1d(row1_1d)
		
	);
	assign R1[1] = row1_1d[0];
	signed_logic row1_1q[5:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row1_1q[0] <= 'b0;
			row1_1q[1] <= 'b0;
			row1_1q[2] <= 'b0;
			row1_1q[3] <= 'b0;
			row1_1q[4] <= 'b0;
			row1_1q[5] <= 'b0;
		end
		else
			row1_1q <= row1_1d[6:1];
	end
	//----------CORDIC VM/RM---------
	signed_logic H_2[5:0][5:0];
	col2_angle h2A();
	signed_logic row2[6:0];
	QRdecom_VM7x7 QRdecom_VM7x7_1(
		.row7_0(row7_0),
		.row7_1(row7_1),
		.row7_2(row7_2),
		.row7_3(row7_3),
		.row7_4(row7_4),
		.row7_5(row7_5),
		.row7_6(row7_6),
		.clk	(clk),
		.rst	(rst),

		.h2A(h2A),
		.B_2(H_2[0]),
		.B_4(H_2[2]),
		.B_6(H_2[4]),
		.B_3(H_2[1]),
		.B_7(H_2[5]),
		.B_5(H_2[3]),
		.norm_col1(row2)
	);
	assign R2[0] = row2[0];
	//---------Sort6*6------------------
	logic [2:0] min_index6x6w;
	logic [2:0] min_index6x6;
	CGAS6x6 CGAS6x6_1(.clk(clk), .rst(rst), .H(H_2), .min_index(min_index6x6w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index6x6 <= 'b0;
		else 
			min_index6x6 <= min_index6x6w;
	end
	//--------------------------------
	signed_logic row6_0[5:0];
	signed_logic row6_1[5:0];
	signed_logic row6_2[5:0];
	signed_logic row6_3[5:0];
	signed_logic row6_4[5:0];
	signed_logic row6_5[5:0];
	signed_logic row1_2d[5:0];
	signed_logic row2_1d[5:0];
	
	col_sel6x6 col_sel6x6_1(
		.min_index6x6(min_index6x6),
		.H(H_2),
		.row2(row2[6:1]),
		.row1_1q(row1_1q),
		
		.row6_0(row6_0),
		.row6_1(row6_1),
		.row6_2(row6_2),
		.row6_3(row6_3),
		.row6_4(row6_4),
		.row6_5(row6_5),
		.row1_2d(row1_2d),
		.row2_1d(row2_1d)
	);
	assign R2[1] = row2_1d[0];
	signed_logic row2_1q[4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row2_1q[0] <= 'b0;
			row2_1q[1] <= 'b0;
			row2_1q[2] <= 'b0;
			row2_1q[3] <= 'b0;
			row2_1q[4] <= 'b0;
		end
		else
			row2_1q <= row2_1d[5:1];
	end
	assign R1[2] = row1_2d[0];
	signed_logic row1_2q[4:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row1_2q[0] <= 'b0;
			row1_2q[1] <= 'b0;
			row1_2q[2] <= 'b0;
			row1_2q[3] <= 'b0;
			row1_2q[4] <= 'b0;
		end
		else
			row1_2q <= row1_2d[5:1];
	end
	//----------CORDIC VM/RM---------
	signed_logic H_3[4:0][4:0];
	col3_angle h3A();
	signed_logic row3[5:0];
	QRdecom_VM6x6 QRdecom_VM6x6_1(
		.row6_0(row6_0),
		.row6_1(row6_1),
		.row6_2(row6_2),
		.row6_3(row6_3),
		.row6_4(row6_4),
		.row6_5(row6_5),
		.clk	(clk),
		.rst	(rst),

		.h3A(h3A),
		.B_2(H_3[0]),
		.B_4(H_3[2]),
		.B_6(H_3[4]),
		.B_3(H_3[1]),
		.B_5(H_3[3]),
		.norm_col1(row3)
	);
	assign R3[0] = row3[0];
	//---------Sort5*5------------------
	logic [2:0] min_index5x5w;//0~4
	logic [2:0] min_index5x5;
	CGAS5x5 CGAS5x5_1(.clk(clk), .rst(rst), .H(H_3), .min_index(min_index5x5w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index5x5 <= 'b0;
		else 
			min_index5x5 <= min_index5x5w;
	end
	//--------------------------------
	signed_logic row5_0[4:0];
	signed_logic row5_1[4:0];
	signed_logic row5_2[4:0];
	signed_logic row5_3[4:0];
	signed_logic row5_4[4:0];
	signed_logic row1_3d[4:0];
	signed_logic row2_2d[4:0];
	signed_logic row3_1d[4:0];
	
	col_sel5x5 col_sel5x5_1(
		.min_index5x5(min_index5x5),
		.H(H_3),
		.row3(row3[5:1]),
		.row1_2q(row1_2q),
		.row2_1q(row2_1q),
		
		.row5_0(row5_0),
		.row5_1(row5_1),
		.row5_2(row5_2),
		.row5_3(row5_3),
		.row5_4(row5_4),
		.row1_3d(row1_3d),
		.row2_2d(row2_2d),
		.row3_1d(row3_1d)
	);
	assign R3[1] = row3_1d[0];
	signed_logic row3_1q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row3_1q[0] <= 'b0;
			row3_1q[1] <= 'b0;
			row3_1q[2] <= 'b0;
			row3_1q[3] <= 'b0;
		end
		else
			row3_1q <= row3_1d[4:1];
	end
	assign R2[2] = row2_2d[0];
	signed_logic row2_2q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row2_2q[0] <= 'b0;
			row2_2q[1] <= 'b0;
			row2_2q[2] <= 'b0;
			row2_2q[3] <= 'b0;
		end
		else
			row2_2q <= row2_2d[4:1];
	end
	assign R1[3] = row1_3d[0];
	signed_logic row1_3q[3:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row1_3q[0] <= 'b0;
			row1_3q[1] <= 'b0;
			row1_3q[2] <= 'b0;
			row1_3q[3] <= 'b0;
		end
		else
			row1_3q <= row1_3d[4:1];
	end
	//----------CORDIC VM/RM---------
	signed_logic H_4[3:0][3:0];
	col4_angle h4A();
	signed_logic row4[4:0];
	QRdecom_VM5x5 QRdecom_VM5x5_1(
		.row5_0(row5_0),
		.row5_1(row5_1),
		.row5_2(row5_2),
		.row5_3(row5_3),
		.row5_4(row5_4),
		.clk	(clk),
		.rst	(rst),

		.h4A(h4A),
		.B_2(H_4[0]),
		.B_4(H_4[2]),
		.B_3(H_4[1]),
		.B_5(H_4[3]),
		.norm_col1(row4)
	);
	assign R4[0] = row4[0];
	//---------Sort4*4------------------
	logic [1:0] min_index4x4w;//0~3
	logic [1:0] min_index4x4;
	CGAS4x4 CGAS4x4_1(.clk(clk), .rst(rst), .H(H_4), .min_index(min_index4x4w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index4x4 <= 'b0;
		else 
			min_index4x4 <= min_index4x4w;
	end
	//--------------------------------
	signed_logic row4_0[3:0];
	signed_logic row4_1[3:0];
	signed_logic row4_2[3:0];
	signed_logic row4_3[3:0];
	signed_logic row1_4d[3:0];
	signed_logic row2_3d[3:0];
	signed_logic row3_2d[3:0];
	signed_logic row4_1d[3:0];
	
	col_sel4x4 col_sel4x4_1(
		.min_index4x4(min_index4x4),
		.H(H_4),
		.row4(row4[4:1]),
		.row1_3q(row1_3q),
		.row2_2q(row2_2q),
		.row3_1q(row3_1q),
		
		.row4_0(row4_0),
		.row4_1(row4_1),
		.row4_2(row4_2),
		.row4_3(row4_3),
		.row1_4d(row1_4d),
		.row2_3d(row2_3d),
		.row3_2d(row3_2d),
		.row4_1d(row4_1d)
	);
	assign R4[1] = row4_1d[0];
	signed_logic row4_1q[2:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row4_1q[0] <= 'b0;
			row4_1q[1] <= 'b0;
			row4_1q[2] <= 'b0;
		end
		else
			row4_1q <= row4_1d[3:1];
	end
	assign R3[2] = row3_2d[0];
	signed_logic row3_2q[2:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row3_2q[0] <= 'b0;
			row3_2q[1] <= 'b0;
			row3_2q[2] <= 'b0;
		end
		else
			row3_2q <= row3_2d[3:1];
	end
	assign R2[3] = row2_3d[0];
	signed_logic row2_3q[2:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row2_3q[0] <= 'b0;
			row2_3q[1] <= 'b0;
			row2_3q[2] <= 'b0;
		end
		else
			row2_3q <= row2_3d[3:1];
	end
	assign R1[4] = row1_4d[0];
	signed_logic row1_4q[2:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			row1_4q[0] <= 'b0;
			row1_4q[1] <= 'b0;
			row1_4q[2] <= 'b0;
		end
		else
			row1_4q <= row1_4d[3:1];
	end
	//----------CORDIC VM/RM---------
	signed_logic H_5[2:0][2:0];
	col5_angle h5A();
	signed_logic row5[3:0];
	QRdecom_VM4x4 QRdecom_VM4x4_1(
		.row4_0(row4_0),
		.row4_1(row4_1),
		.row4_2(row4_2),
		.row4_3(row4_3),
		.clk	(clk),
		.rst	(rst),

		.h5A(h5A),
		.B_2(H_5[0]),
		.B_4(H_5[2]),
		.B_3(H_5[1]),
		.norm_col1(row5)
	);
	assign R5[0] = row5[0];
	//---------Sort3*3------------------
	logic [1:0] min_index3x3w;//0~2
	logic [1:0] min_index3x3;
	CGAS3x3 CGAS3x3_1(.clk(clk), .rst(rst), .H(H_5), .min_index(min_index3x3w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index3x3 <= 'b0;
		else 
			min_index3x3 <= min_index3x3w;
	end
	//--------------------------------
	signed_logic row3_0[2:0];
	signed_logic row3_1[2:0];
	signed_logic row3_2[2:0];
	signed_logic row1_5d[2:0];
	signed_logic row2_4d[2:0];
	signed_logic row3_3d[2:0];
	signed_logic row4_2d[2:0];
	signed_logic row5_1d[2:0];
	
	col_sel3x3 col_sel3x3_1(
		.min_index3x3(min_index3x3),
		.H(H_5),
		.row5(row5[3:1]),
		.row1_4q(row1_4q),
		.row2_3q(row2_3q),
		.row3_2q(row3_2q),
		.row4_1q(row4_1q),
		
		.row3_0(row3_0),
		.row3_1(row3_1),
		.row3_2(row3_2),
		.row1_5d(row1_5d),
		.row2_4d(row2_4d),
		.row3_3d(row3_3d),
		.row4_2d(row4_2d),
		.row5_1d(row5_1d)
	);
	assign R5[1] = row5_1d[0];
	assign R4[2] = row4_2d[0];
	assign R3[3] = row3_3d[0];
	assign R2[4] = row2_4d[0];
	assign R1[5] = row1_5d[0];
	//----------CORDIC VM/RM---------
	signed_logic H_6[1:0][1:0];
	col6_angle h6A();
	signed_logic row6[2:0];
	QRdecom_VM3x3 QRdecom_VM3x3_1(
		.row3_0(row3_0),
		.row3_1(row3_1),
		.row3_2(row3_2),
		.clk	(clk),
		.rst	(rst),

		.h6A(h6A),
		.B_2(H_6[0]),
		.B_3(H_6[1]),
		.norm_col1(row6)
	);
	assign R6[0] = row6[0];
	//---------Sort2*2-----------------
	logic min_index2x2w;//0~1
	logic min_index2x2;
	CGAS2x2 CGAS2x2_1(.clk(clk), .rst(rst), .H(H_6), .min_index(min_index2x2w));
	
	always_ff@(posedge clk) begin
		if(rst)
			min_index2x2 <= 'b0;
		else 
			min_index2x2 <= min_index2x2w;
	end
	//--------------------------------
	signed_logic row2_0[1:0];
	signed_logic row2_1[1:0];
	signed_logic row1_6d[1:0];
	signed_logic row2_5d[1:0];
	signed_logic row3_4d[1:0];
	signed_logic row4_3d[1:0];
	signed_logic row5_2d[1:0];
	signed_logic row6_1d[1:0];
	
	col_sel2x2 col_sel2x2_1(
		.min_index2x2(min_index2x2),
		.H(H_6),
		.row6(row6[2:1]),
		.row1_5q(row1_5d[2:1]),
		.row2_4q(row2_4d[2:1]),
		.row3_3q(row3_3d[2:1]),
		.row4_2q(row4_2d[2:1]),
		.row5_1q(row5_1d[2:1]),
		
		.row2_0(row2_0),
		.row2_1(row2_1),
		.row1_6d(row1_6d),
		.row2_5d(row2_5d),
		.row3_4d(row3_4d),
		.row4_3d(row4_3d),
		.row5_2d(row5_2d),
		.row6_1d(row6_1d)
	);
	
	signed_logic row1_6q[1:0];
	signed_logic row2_5q[1:0];
	signed_logic row3_4q[1:0];
	signed_logic row4_3q[1:0];
	signed_logic row5_2q[1:0];
	signed_logic row6_1q[1:0];
	always_ff@(posedge clk)begin
		if(rst)begin
			for(int i=0;i<2;i++)begin
				row1_6q[i] <= 'b0;
				row2_5q[i] <= 'b0;
				row3_4q[i] <= 'b0;
				row4_3q[i] <= 'b0;
				row5_2q[i] <= 'b0;
				row6_1q[i] <= 'b0;
			end
		end
		else begin
			row1_6q <= row1_6d;
			row2_5q <= row2_5d;
			row3_4q <= row3_4d;
			row4_3q <= row4_3d;
			row5_2q <= row5_2d;
			row6_1q <= row6_1d;
		end
	end
	assign R6[2:1] = row6_1q;
	assign R5[3:2] = row5_2q;
	assign R4[4:3] = row4_3q;
	assign R3[5:4] = row3_4q;
	assign R2[6:5] = row2_5q;
	assign R1[7:6] = row1_6q;
	//----------CORDIC VM/RM---------f
	col7_angle h7A();
	QRdecom_VM2x2 QRdecom_VM2x2_1(
		.row2_0(row2_0),
		.row2_1(row2_1),
		.clk	(clk),
		.rst	(rst),

		.h7A(h7A),
		.B_2(R8),
		.norm_col1(R7)
	);
	//----------y_rm-------------------------
	signed_logic y_tilde [7:0];
	y_RM y_RM_1(
		.clk(clk),
		.rst(rst),
		.h1A(h1A),
		.h2A(h2A),
		.h3A(h3A),
		.h4A(h4A),
		.h5A(h5A),
		.h6A(h6A),
		.h7A(h7A),
		.y(y),
		
		.y_tilde(y_tilde)	
	);
	//----------K-Best--------------------
	logic [3:0] symbol[7:0];
	KB KB_1(
		.clk(clk),
		.rst(rst),
		.y_tilde(y_tilde),
		.R1(R1),
		.R2(R2),
		.R3(R3),
		.R4(R4),
		.R5(R5),
		.R6(R6),
	    .R7(R7),
	    .R8(R8),
		
		.s1_1(symbol)
	);
	//-------symbol_mapping------------------
	symbol_mapping symbol_mapping_1(
	.clk(clk),
	.rst(rst),
	.symbol(symbol),
	.min_index8x4(min_index8x4),
	.min_index7x7(min_index7x7),
	.min_index6x6(min_index6x6),
	.min_index5x5(min_index5x5),
	.min_index4x4(min_index4x4),
	.min_index3x3(min_index3x3),
	.min_index2x2(min_index2x2),
	
	.result_bitstream(result_bitstream)
	);
	//----------FSM_1------------------------
	logic rst_cnt1, load_cnt1;
	logic [7:0] cnt1;
	always_ff@(posedge clk)begin
		if(rst)
			cnt1 <= 'b0;
		else if(rst_cnt1)
			cnt1 <= 'b0;
		else if(load_cnt1)
			cnt1 <= cnt1+1;
	end
	
	typedef enum {  
                        START,
						INITIAL,
						H_vm,
						y_rm,
						K_Best
				
                        } Hload_controller;

    Hload_controller ps,ns;
	
	logic QRHVM_finish, KB_finish;
	always_ff@(posedge clk) begin
		if(rst) begin
			QRHVM_finish_o <= 'b0;
			KB_finish_o <= 'b0;
		end
		else begin
			QRHVM_finish_o <= QRHVM_finish;
			KB_finish_o <= KB_finish;
		end
	end
	
	always_ff@(posedge clk) begin
		if(rst)
			ps <= START;
		else 
			ps <= ns;
	end
	
	always_comb begin//CORDIC:119clk
		ns = START;
		rst_cnt1 = 0;
		load_cnt1 = 0;
		QRHVM_finish = 0;
		KB_finish = 0;
		case(ps)
			START:
				ns = INITIAL;
			INITIAL: 
			begin
				ns = H_vm;
				rst_cnt1 = 1;
			end
			H_vm:
			begin
				if(cnt1<157)begin
					load_cnt1  = 1;
					ns = H_vm;
				end
				else begin
					QRHVM_finish = 1;
					rst_cnt1 = 1;
					ns = y_rm;
				end
			end
			y_rm: 
			begin
				if(cnt1<154)begin
					load_cnt1  = 1;
					ns = y_rm;
				end
				else begin
					rst_cnt1 = 1;
					ns = K_Best;
				end
			end
			K_Best: 
			begin
				if(cnt1<56)begin
					load_cnt1  = 1;
				end
				else begin
					KB_finish = 1;
				end
				ns = K_Best;
			end
		endcase
	end
endmodule