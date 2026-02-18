
//Top.sv
`include "C:/Users/Lab601-1/Desktop/hardware/parameter.sv"
module top(
	input clk,
	input rst,
	input s_ssn,
	input s_sclk,
	input signed_logic h,
	
	output signed_logic mosi,
	output logic m_ssn,
	output logic m_sclk
);
	
	logic s_signal, d_signal, s_sclk_posedge;
	logic s_signal_1, d_signal_1, s_ssn_negedge;
	
	//sclk正源觸發
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			s_signal <= 1'b1;
			d_signal <= 1'b1;
			s_sclk_posedge <= 1'b0;
		end
		else
		begin
			{d_signal, s_signal} <= {s_signal, s_sclk};
			s_sclk_posedge <= s_signal & ~d_signal;
		end
	end
	//
	//s_ssn負源觸發
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			s_signal_1 <= 1'b1;
			d_signal_1 <= 1'b1;
			s_ssn_negedge <= 1'b0;
		end
		else
		begin
			{d_signal_1, s_signal_1} <= {s_signal_1, s_ssn};
			s_ssn_negedge <= ~s_signal_1 & d_signal_1;
		end
	end
	//
	//-------DFF H-------------------------
	matrix HH();
	signed_logic A_out, B_out, C_out, D_out, E_out, F_out, G_out, H_out;
	logic [2:0] sel_HH;
	
	always_ff@(posedge clk)	begin
		if(rst) begin
			HH.h11 <= 9'b0;
			HH.h12 <= 9'b0;
			HH.h13 <= 9'b0;
			HH.h14 <= 9'b0; 
			HH.h21 <= 9'b0; 
			HH.h22 <= 9'b0;
			HH.h23 <= 9'b0; 
			HH.h24 <= 9'b0; 
			HH.h31 <= 9'b0;
			HH.h32 <= 9'b0;
			HH.h33 <= 9'b0;
			HH.h34 <= 9'b0;
			HH.h41 <= 9'b0;
			HH.h42 <= 9'b0;
			HH.h43 <= 9'b0;
			HH.h44 <= 9'b0;
		end
		else if(s_sclk_posedge) begin
			HH.h11 <= HH.h21;
			HH.h21 <= HH.h31;
			HH.h31 <= HH.h41;
			HH.h41 <= HH.h12; 
			HH.h12 <= HH.h22; 
			HH.h22 <= HH.h32;
			HH.h32 <= HH.h42; 
			HH.h42 <= HH.h13; 
			HH.h13 <= HH.h23;
			HH.h23 <= HH.h33;
			HH.h33 <= HH.h43;
			HH.h43 <= HH.h14;
			HH.h14 <= HH.h24;
			HH.h24 <= HH.h34;
			HH.h34 <= HH.h44;
			HH.h44 <= h;
		end
		
	end
	//-------DFF H-------------------------
	
//----------Sort3x3, 2x2--------------
	logic rst_normh12, load_normh12, rst_normh3, load_normh3, min_index2x2;
	logic [1:0] min_index3x3;
	signed_logic normh1, normh2, normh3, min1;
	
	always_ff@(posedge clk)
	begin
		if(rst_normh12)
		begin
			normh1 <= {1'b0, D_out[`sign_bit-1: 0 ]};
			normh2 <= {1'b0, F_out[`sign_bit-1: 0 ]};
		end
		else if(load_normh12)
		begin
			normh1[`sign_bit-1: 0 ] <= D_out[`sign_bit-1: 0 ] + normh1[`sign_bit-1: 0 ];
			normh2[`sign_bit-1: 0 ] <= F_out[`sign_bit-1: 0 ] + normh2[`sign_bit-1: 0 ];
		end		
	end
	
	always_ff@(posedge clk)
	begin
		if(rst_normh3)
		begin
			normh3 <= {1'b0, H_out[`sign_bit-1: 0 ]};
		end
		else if(load_normh3)
		begin
			normh3[`sign_bit-1: 0 ] <= H_out[`sign_bit-1: 0 ] + normh3[`sign_bit-1: 0 ];
		end		
	end
	
	always_comb
	begin
		case((normh1 > normh2))
			0:
			begin
				min1 = normh1;
				min_index2x2 = 0;
			end
			1:
			begin
				min1 = normh2;
				min_index2x2 = 1;
			end
		endcase
	end
	
	always_comb
	begin
		case((min1 > normh3))
			0:
			begin
				min_index3x3 = min_index2x2;
			end
			1:
			begin
				min_index3x3 = 2;
			end
		endcase
	end
	
//--------------Sort4x4----------------------
	logic [2:0] cnt3;
	logic rst_normh_dff, rst_min, load_min, load_min_index;
	logic min_index, index;
	signed_logic norm_h, min_norm_h, normh_dff;

	assign norm_h = normh_dff + {1'b0, h [`sign_bit-1: 0 ]};
	 
	always_ff@(posedge clk) begin
		if(rst | rst_normh_dff  )
			normh_dff <= 9'b0;
		else if(s_sclk_posedge)
			normh_dff [`sign_bit-1: 0 ] <= norm_h [`sign_bit-1: 0 ];
	end
	
	always_ff@(posedge clk)begin
		if(rst | rst_min) begin
			min_norm_h <= 9'b011111111;
			index <= 1'b1;
			
		end
		else if(load_min) begin				
			min_norm_h <= norm_h;
			index <= index + 1;			
		end		
	end	
	
	always_ff@(posedge clk)begin
		if(rst) begin
			min_index <= 1'b0;
		end
		else if(load_min_index) begin				
			min_index <= index;			
		end		
	end	
//---------------load_VMout-----------
	signed_logic D_out_VM12, F_out_VM12, H_out_VM12, D_out_VM13, F_out_VM13, H_out_VM13;
	logic load_VMout;
	
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			D_out_VM12 <= 9'b0;
			F_out_VM12 <= 9'b0;
			H_out_VM12 <= 9'b0;
			D_out_VM13 <= 9'b0;
			F_out_VM13 <= 9'b0;
			H_out_VM13 <= 9'b0;
		end
		else if(load_VMout)
		begin
			D_out_VM12 <= D_out_VM13;
			F_out_VM12 <= F_out_VM13;
			H_out_VM12 <= H_out_VM13;
			D_out_VM13 <= D_out;
			F_out_VM13 <= F_out;
			H_out_VM13 <= H_out;
		end
	end
//----------sel_col--------------	

	col col1();
	col col2();
	col col3();
	col col4();
	logic [1:0] sel_col;
	
	always_comb
	begin
	col1.c1 = 0;
	col1.c2 = 0;
	col1.c3 = 0;
	col1.c4 = 0;
	col2.c1 = 0;
	col2.c2 = 0;
	col2.c3 = 0;
	col2.c4 = 0;
	col3.c1 = 0;
	col3.c2 = 0;
	col3.c3 = 0;
	col3.c4 = 0;
	col4.c1 = 0;
	col4.c2 = 0;
	col4.c3 = 0;
	col4.c4 = 0;
		case(sel_col)
			0:begin//index4x4只可能是0或1
				case(min_index)
					0:
					begin
						col1.c1 = HH.h11;
						col1.c2 = HH.h21;
						col1.c3 = HH.h31;
						col1.c4 = HH.h41;
						col2.c1 = HH.h12;
						col2.c2 = HH.h22;
						col2.c3 = HH.h32;
						col2.c4 = HH.h42;
						col3.c1 = HH.h13;
						col3.c2 = HH.h23;
						col3.c3 = HH.h33;
						col3.c4 = HH.h43;
						col4.c1 = HH.h14;
						col4.c2 = HH.h24;
						col4.c3 = HH.h34;
						col4.c4 = HH.h44;
					end
					1:
					begin
						col1.c1 = HH.h12;
						col1.c2 = HH.h22;
						col1.c3 = HH.h32;
						col1.c4 = HH.h42;
						col2.c1 = HH.h11;
						col2.c2 = HH.h21;
						col2.c3 = HH.h31;
						col2.c4 = HH.h41;
						col3.c1 = HH.h13;
						col3.c2 = HH.h23;
						col3.c3 = HH.h33;
						col3.c4 = HH.h43;
						col4.c1 = HH.h14;
						col4.c2 = HH.h24;
						col4.c3 = HH.h34;
						col4.c4 = HH.h44;
					end
					
				endcase
			end
			1:begin
				case(min_index3x3)
					0:
					begin
						
						col1.c1 = D_out_VM12;
						col1.c2 = D_out;
						col1.c3 = D_out_VM13;
						
						col2.c1 = F_out_VM12;
						col2.c2 = F_out;
						col2.c3 = F_out_VM13;
						
						col3.c1 = H_out_VM12;
						col3.c2 = H_out;
						col3.c3 = H_out_VM13;
					end
					1:
					begin
						
						col1.c1 = F_out_VM12;
						col1.c2 = F_out;
						col1.c3 = F_out_VM13;
						
						col2.c1 = D_out_VM12;
						col2.c2 = D_out;
						col2.c3 = D_out_VM13;
						
						col3.c1 = H_out_VM12;
						col3.c2 = H_out;
						col3.c3 = H_out_VM13;
						
					end
					2:
					begin
						
						col1.c1 = H_out_VM12;
						col1.c2 = H_out;
						col1.c3 = H_out_VM13;
						
						col2.c1 = F_out_VM12;
						col2.c2 = F_out;
						col2.c3 = F_out_VM13;
					
						col3.c1 = D_out_VM12;
						col3.c2 = D_out;
						col3.c3 = D_out_VM13;
					end
						
				endcase
			end
			2:begin
				case(min_index2x2)
					0:
					begin
						col1.c1 = D_out;
						col1.c2 = D_out_VM13;
						
						col2.c1 = F_out;
						col2.c2 = F_out_VM13;
					end
					1:
					begin
						col1.c1 = F_out;
						col1.c2 = F_out_VM13;
						
						col2.c1 = D_out;
						col2.c2 = D_out_VM13;
					end
				endcase
			end
		endcase	
	end
//-----------CORDIC VM/RM---------
	logic load_VM1,load_VM2, load_VM3, load_VM4, load_VM5;
	logic [1:0] sel_QRdecom_VM;
	
	QRdecom_VM QRdecom_VM_1(
		.col1(col1),
		.col2(col2),
		.col3(col3),
		.col4(col4),
		
		.clk	(clk),
		.rst	(rst),
		.load_VM1	(load_VM1),
		.load_VM2	(load_VM2),
		.load_VM3	(load_VM3),
		.load_VM4	(load_VM4),
		.load_VM5	(load_VM5),
		.sel	(sel_QRdecom_VM),
		
		.A_out	(A_out),	
		.B_out	(B_out),
		.C_out	(C_out),
		.D_out	(D_out),
		.E_out	(E_out),
		.F_out	(F_out),
		.G_out	(G_out),
		.H_out  (H_out)
		);
	//------------sclk_output-------------------
	//----------------------------------------
	logic sclk_en_latch;
	logic sclk_en, ssn_en , m_ssn_delay;
	always_latch
		if(~clk)
			sclk_en_latch = sclk_en;
		
	assign m_sclk = clk & sclk_en_latch;
	//------------------------------------------
	//clk_div4 clk_div4_1(
	//	.clk(clk),
	//	.rst(rst),
	//	.load_sclk(sclk_en),
	//	.o_clk(m_sclk)
	//);
	//--------m_ssn, mosi-------------------
	logic [2:0] sel_R;
	
	
	always_ff @(posedge clk)
	begin
		if(rst)
			mosi 		<= 9'b0;
		else
		begin if (shift_mosi)
			case(sel_R)
				0:
					mosi <= 9'b0;
				1: 
					mosi <= {7'b0,min_index3x3};
				2: 
					mosi <= A_out;
				3: 
					mosi <= C_out;
				4: 
					mosi <= E_out;
				5: 
					mosi <= G_out;
				6: 
					mosi <= {8'b0,min_index2x2};
				7: 
					mosi <= {1'b0,D_out[`sign_bit-1:0]};

					
			endcase		
		end
	end
	
	always_ff @(posedge clk)
	begin
		if(rst)
			sel_R 		<= 4'b0;
		else
		begin if (inc_sel_R)
			sel_R 		<= sel_R + 1 ;
	
	
	//
	//----------------mosi-------------
	
	
	always_ff@(posedge clk) begin
		if(rst)
			ps <= START;
		else 
			ps <= ns;
	end
	
	
	//--------FSM_1-----------
	always_comb begin
		ns 			= 0;
		inc_sel_R 	= 0;
		ssn 		= 1;
		sclk 		= 0;
			case(ps)
				START:
					ns = INITIAL;
				INITIAL: 
				begin
					if(tx_reg)
					begin
						ns = SHIFT_MOSI_0;
						ssn 		= 0;
					end
					else
						ns = INITIAL;
				end	
				
				SHIFT_MOSI_0:
					begin
						ns = SHIFT_MOSI_1;
						ssn 		= 0;
					end
					else
						ns = INITIAL;
				
				SHIFT_MOSI_1:
				begin
					
					begin
						sclk	= 0;
						ns = SHIFT_MOSI_2;
					end
					else
				
				end	
				
				SHIFT_MOSI_2:
				begin
			
					begin
						sclk	= 1;
					
						
						ns = SHIFT_MOSI_3;
					end
					else
				
				end	
				
				
				SHIFT_MOSI_3:
				begin
			
					begin
						sclk	= 1;
					
						
						ns = SHIFT_MOSI_4;
					end
					else
				
				end	
				
				
				SHIFT_MOSI_4:
				begin
					if(inc_sel_R < 15)
					begin
						sclk	= 1;
					
						inc_sel_R 	= 1;
						ns = SHIFT_MOSI_4;
					end
					else
						ns - FISISH;
				end	
				
				
				
					
				
				
				cmp_norm:
				begin	
				
					if (s_sclk_posedge) 
					begin
						ns = load_HH;
						rst_normh_dff = 1;
						
						if(norm_h<min_norm_h)
						begin
							load_min = 1;
						end
						load_min_index = 1;
					end
					else 
						ns = cmp_norm;
						
					
					
					
				end
				
			endcase
		
	end		
	
	
	
	
	
	
	
	
	
	//always_comb
	//begin
	//mosi = 9'b0;
	//	case(sel_R)
	//		0:
	//			mosi = 9'b0;
	//		1: 
	//			mosi = A_out;
	//		2: 
	//			mosi = C_out;
	//		3: 
	//			mosi = E_out;
	//		4: 
	//			mosi = {7'b0,min_index3x3};
	//		5: 
	//			mosi = R4;
	//		6: 
	//			mosi = {8'b0,min_index2x2};
	//		7: 
	//			mosi = {1'b0,D_out[`sign_bit-1:0]};	
	//	endcase		
	//end
	///------------	FSM_1----------
	typedef enum {  
                        START,
						INITIAL,
						load_HH,
						cmp_norm
				
                        } Hload_controller;

    Hload_controller ps,ns;
	
	
	always_ff@(posedge clk) begin
		if(rst)
			ps <= START;
		else 
			ps <= ns;
	end
	
	//logic rst_cnt15, inc_cnt15;
	logic [3:0] cnt15;
	
	always_ff@(posedge clk) begin
		if(rst)
			cnt15 <= 4'b0;
		else if(s_sclk_posedge)
			cnt15 <= cnt15 + 1;
	end
	
	//logic rst_cnt3, inc_cnt;
	//
	//always_ff@(posedge clk) begin
	//	if(rst | rst_cnt3)
	//		cnt3 <= 3'b0;
	//	else if(s_sclk_posedge)
	//		cnt3 <= cnt3 + 1;
	//end
	
	
	//------------FSM_2------------
	typedef enum {  
                        START_VM,
						INITIAL_VM,
						VM12_1,
						VM12_2,
						VM12_3,
						VM12_4,
						VM12_5,
						VM13_1,
						VM13_2,
						VM13_3,
						VM13_4,
						VM13_5,
						VM14_1,
						VM14_2,
						VM14_3,
						VM14_4,
						VM14_5,
						min_2,
						VM23_1,
						VM23_2,
						VM23_3,
						VM23_4,
						VM23_5,
						VM24_1,
						VM24_2,
						VM24_3,
						VM24_4,
						VM24_5,
						min_3,
						VM34_1,
						VM34_2,
						VM34_3,
						VM34_4,
						VM34_5,
						R8,
						R9,
						R10
						
                        } HVM_controller;

    HVM_controller ps_VM,ns_VM;
	
	
	always_ff@(posedge clk) begin
		if(rst)
			ps_VM <= START_VM;
		else 
			ps_VM <= ns_VM;
	end
	
	logic HVM_start;
	
	
	
	//--------FSM_1-----------
	always_comb begin
		ns = START;
		load_min_index = 0;
		rst_normh_dff = 0;
		rst_min = 0;
		load_min = 0;
		HVM_start = 0;
		
			case(ps)
				START:
					ns = INITIAL;
				INITIAL: 
				begin
					if(s_ssn_negedge)
					begin
						ns = load_HH;
						//Full = 1;
						//inc_cnt15 = 1;
					end
					else
					begin
						ns = INITIAL;
						
					end
					
				end	
				load_HH:
				begin
					if(cnt15<15)
					begin
						
						//inc_cnt15 = 1;
						if(cnt15[1:0] == 3)
						begin
							ns = cmp_norm;
						end
						else
							ns = load_HH;
						
					end
					else
					begin
						if (s_sclk_posedge) 
						begin
							ns = INITIAL;
							rst_min = 1;
							rst_normh_dff = 1;
							HVM_start = 1;
						end
						else
							ns = load_HH;
					end
				end	
				cmp_norm:
				begin	
				
					if (s_sclk_posedge) 
					begin
						ns = load_HH;
						rst_normh_dff = 1;
						
						if(norm_h<min_norm_h)
						begin
							load_min = 1;
						end
						load_min_index = 1;
					end
					else 
						ns = cmp_norm;
						
					
					
					
				end
				
			endcase
		
	end		
	
	//--------FSM_2-----------
	always_comb begin
		ns_VM = START_VM;
		sel_col = 2'b0;
		sel_QRdecom_VM = 2'b0;
		load_VM1 = 1'b0;
		load_VM2 = 1'b0;
		load_VM3 = 1'b0;
		load_VM4 = 1'b0;
		load_VM5 = 1'b0;
	
		rst_normh12 = 0;
		rst_normh3 = 0;
		load_normh12 = 0;
		load_normh3 = 0;
		load_VMout = 0;
		sel_R = 3'b0;
		sclk_en = 0;
		ssn_en  = 1;
		
			case(ps_VM)
				START_VM:
					ns_VM = INITIAL_VM;
				INITIAL_VM: 
				begin
					//m_ssn = 1;
					rst_normh12 = 1;
					rst_normh3 = 1;
					if(HVM_start)
					begin
						ns_VM = VM12_1;
					end
					else
					begin
						ns_VM = INITIAL_VM;
					end
					
				end	
				VM12_1://開始做VM12_1
				begin
					ns_VM = VM12_2;
					sel_col = 2'b0;
					sel_QRdecom_VM = 0;
					load_VM1 = 1;
				end
				VM12_2:
				begin
					ns_VM = VM12_3;
					load_VM2 = 1;
				end
				VM12_3:
				begin
					ns_VM = VM12_4;
					load_VM3 = 1;
				end
				VM12_4:
				begin
					ns_VM = VM12_5;
					load_VM4 = 1;
				end	
				VM12_5:
				begin
					ns_VM = VM13_1;
					load_VM5 = 1;
				end	
				VM13_1:
				begin
					ns_VM = VM13_2;
					sel_col = 2'b0;
					sel_QRdecom_VM = 1;
					load_VM1 = 1;
					rst_normh12 = 1;
					rst_normh3 = 1;
					load_VMout = 1;
					
				end
				VM13_2:
				begin
					ns_VM = VM13_3;	
					load_VM2 = 1;
					
				end
				VM13_3:
				begin
					ns_VM = VM13_4;	
					load_VM3 = 1;
				end
				VM13_4:
				begin
					ns_VM = VM13_5;	
					load_VM4 = 1;
				end
				VM13_5:
				begin
					ns_VM = VM14_1;
					load_VM5 = 1;
				end
				VM14_1:
				begin
					ns_VM = VM14_2;
					sel_col = 2'b0;
					sel_QRdecom_VM = 2;
					load_VM1 = 1;
					load_normh12 = 1;
					load_normh3 = 1;
					load_VMout = 1;
					//ssn_en  = 0;
				end
				VM14_2:
				begin
					ns_VM = VM14_3;
					load_VM2 = 1;
					//ssn_en  = 0;;
					
				end
				VM14_3:
				begin
					ns_VM = VM14_4;
					load_VM3 = 1;
					
					
				end
				VM14_4:
				begin
					ns_VM = VM14_5;
					load_VM4 = 1;
					ssn_en  = 0;	
				end
				VM14_5:
				begin
					ns_VM = min_2;
					load_VM5 = 1;
					ssn_en  = 0;
				end
				min_2:
				begin
					ns_VM = VM23_1;
					load_normh12 = 1;
					load_normh3 = 1;
					
					sel_R = 2;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM23_1://min_index3x3出來
				begin
					ns_VM = VM23_2;
					sel_col = 2'b1;
					sel_QRdecom_VM = 0;
					load_VM1 = 1;
					sel_R = 1;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM23_2:
				begin
					ns_VM = VM23_3;
					load_VM2 = 1;
					sel_R = 3;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM23_3:
				begin
					ns_VM = VM23_4;
					load_VM3 = 1;
					sel_R = 4;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM23_4://
				begin
					ns_VM = VM23_5;
					load_VM4 = 1;
					sel_R = 5;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM23_5:
				begin
					ns_VM = VM24_1;
					load_VM5 = 1;
					sel_R = 0;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM24_1:
				begin
					ns_VM = VM24_2;
					rst_normh12 = 1;
					load_VMout = 1;
					sel_col = 2'b1;
					sel_QRdecom_VM = 1;
					load_VM1 = 1;
					sel_R = 0;//
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM24_2:
				begin
					ns_VM = VM24_3;
					load_VM2 = 1;
					sel_R = 0;//
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM24_3:
				begin
					ns_VM = VM24_4;
					load_VM3 = 1;
					sel_R = 0;//
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM24_4:
				begin
					ns_VM = VM24_5;
					load_VM4 = 1;
					sel_R = 0;//
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM24_5:
				begin
					ns_VM = min_3;
					load_VM5 = 1;
					sel_R = 0;//
					sclk_en = 1;
					ssn_en  = 0;
				end
				min_3:
				begin
					ns_VM = VM34_1;
					load_normh12 = 1;
					sel_R = 0;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM34_1://min_index2x2出來
				begin
					ns_VM = VM34_2;
					sel_col = 2;
					sel_QRdecom_VM = 0;
					load_VM1 = 1;
					sel_R = 0;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM34_2:
				begin
					ns_VM = VM34_3;
					load_VM2 = 1;
					sel_R = 2;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM34_3:
				begin
					ns_VM = VM34_4;
					load_VM3 = 1;
					sel_R = 3;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM34_4:
				begin
					ns_VM = VM34_5;
					load_VM4 = 1;
					sel_R = 4;
					sclk_en = 1;
					ssn_en  = 0;
				end
				VM34_5:
				begin
					ns_VM = R8;
					load_VM5 = 1;
					sel_R = 6;
					sclk_en = 1;
					ssn_en  = 0;
				end
				R8:
				begin
					ns_VM = R9;
					sel_R = 2;
					sclk_en = 1;
					ssn_en  = 0;
				end
				R9:
				begin
					ns_VM = R10;
					sel_R = 3;
					sclk_en = 1;
					ssn_en  = 0;
				end
				R10:
				begin
					ns_VM = INITIAL_VM;
					sel_R = 7;
					sclk_en = 1;
					ssn_en  = 0;
				end
			endcase
		
	end		
endmodule

