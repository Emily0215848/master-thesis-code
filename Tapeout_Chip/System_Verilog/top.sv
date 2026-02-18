
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
		if(rst | rst_normh12)
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
		if(rst | rst_normh3)
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
	
	logic rst_normh_dff, load_min, load_min_index;
	logic min_index;
	signed_logic min_norm_h, normh_dff;

	
	 
	always_ff@(posedge clk) begin
		if(rst | rst_normh_dff  )
			normh_dff <= 'b0;
		else if(s_sclk_posedge)
			normh_dff [`sign_bit-1: 0 ] <= normh_dff [`sign_bit-1: 0 ] + h [`sign_bit-1: 0 ];
	end
	
	always_ff@(posedge clk)begin
		if(rst) begin
			min_norm_h <= 9'b0;
		end
		else if(load_min) begin				
			min_norm_h <= normh_dff;
					
		end		
	end	
	
	always_ff@(posedge clk)begin
		if(rst) begin
			min_index <= 1'b0;
		end
		else if(load_min_index) begin	
			case(min_norm_h>normh_dff)
				0:
					min_index <= 0;		
				1:
					min_index <= 1;		
			endcase
				
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
	//logic sclk_en_latch;
	//logic sclk_en, ssn_en , m_ssn_delay;
	//always_latch
	//	if(~clk)
	//		sclk_en_latch = sclk_en;
	//		m_ssn_en_latch = m_ssn_en;
	//	
	//assign m_sclk = clk & sclk_en_latch;
	//assign m_ssn = m_ssn_en;
	//------------------------------------------
	//
	//--------m_ssn, mosi-------------------
	
	
	//always_ff @(negedge clk)
	//begin
	//	if(rst)
	//	begin
	//		m_ssn_delay <= 1'b0;
	//		m_ssn 		<= 1'b0;
	//		mosi 		<= 9'b0;
	//	end
	//	else
	//	begin
	//		m_ssn_delay <= ssn_en ;
	//		m_ssn 		<= m_ssn_delay;
	//				
	//	end
	//end
	//
	//----------------mosi-------------
	//--------------shift_data_rx---------
	logic rst_sel_R, inc_sel_R, load_shift_data_rx;
	logic [3:0] sel_R;
	logic [8:0] shift_data_rx [11:0];
	logic [3:0] i;
	
	always_ff@(posedge clk)
	begin
		if(rst | rst_sel_R)
		begin
			sel_R <= 'b0;
		end
		else if (inc_sel_R)
		begin
			sel_R <= sel_R + 1;
		end
	end
	
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			for(i=0; i<12; i=i+1)
			begin
				shift_data_rx[i] <= 'b0;
			end
		end
		else if (load_shift_data_rx)
		begin
			case(sel_R)
				1: 
					shift_data_rx[0] <= A_out;
				2: 
					shift_data_rx[0] <= {7'b0,min_index3x3};
				3: 
					shift_data_rx[0] <= C_out;
				4: 
					shift_data_rx[0] <= E_out;
				5: 
					shift_data_rx[0] <= G_out;
				6: 
					shift_data_rx[0] <= A_out;
				7: 
					shift_data_rx[0] <= C_out;
				8: 
					shift_data_rx[0] <= E_out;
				9: 
					shift_data_rx[0] <= {8'b0,min_index2x2};
				10: 
					shift_data_rx[0] <= A_out;
				11: 
					shift_data_rx[0] <= C_out;	
				12: 
					shift_data_rx[0] <= {1'b0,D_out[`sign_bit-1:0]};		
				default:
					shift_data_rx[0] <= 'b0;
			endcase
			for(i=0; i<11; i=i+1)
			begin
				shift_data_rx[i+1] <= shift_data_rx[i];
			end
		end
	end
	//--------------shift_data_tx---------
	logic load_shift_data_tx, load_mosi;
	logic [8:0] shift_data_tx [11:0];
	logic [3:0] j;
	
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			mosi <= 'b0;
			for(j=0; j<12; j=j+1)
			begin
				shift_data_tx[j] <= 'b0;
			end
		end
		else if (load_shift_data_tx)
		begin
			for(j=0; j<12; j=j+1)
			begin
				shift_data_tx[j] <= shift_data_rx[j];
			end
		end
		else if (load_mosi)
		begin
			mosi <= shift_data_tx[11];
			for(j=0; j<11; j=j+1)
			begin	
				shift_data_tx[j+1] <= shift_data_tx[j];
			end
		end
	end
	//m_ssn, m_sclk_en-----------
	logic m_ssn_en, m_sclk_en;
	
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			m_sclk <= 'b0;
			m_ssn  <= 'b0;
		end
		else
		begin
			m_sclk <= m_sclk_en;
			m_ssn  <= m_ssn_en;
		end
	end
	
	logic inc_sclk_cnt;
	logic [1:0] sclk_cnt;
 	
	always_ff@(posedge clk)
	begin
		if(rst)
		begin
			sclk_cnt <= 'b0;
		end
		else if(inc_sclk_cnt)
		begin
			sclk_cnt <= sclk_cnt + 1;
		end
	end
	
	logic rst_send_data_cnt, inc_send_data_cnt;
	logic [3:0] send_data_cnt;
 	
	always_ff@(posedge clk)
	begin
		if(rst | rst_send_data_cnt)
		begin
			send_data_cnt <= 'b0;
		end
		else if(inc_send_data_cnt)
		begin
			send_data_cnt <= send_data_cnt + 1;
		end
	end
	///------------	FSM_1----------
	typedef enum {  
                        START,
						INITIAL,
						load_HH4,
						load_HH8,
						load_HH15
				
                        } Hload_controller;

    Hload_controller ps,ns;
	
	logic HVM_start;
	
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
	
	logic tx_req;
	
	///------------	FSM_3----------
	typedef enum {  
                        START_SPI_tx,
						INITIAL_tx,
						LOAD_SHIFT_DATA,
						SHIFT_MOSI_0,
						SHIFT_MOSI_123,
						SHIFT_MOSI_456,
						SHIFT_MOSI_7,
						m_ssn_delay,
						FINISH
						
                        } tx_controller;

    tx_controller ps_tx,ns_tx;
	
	
	always_ff@(posedge clk) begin
		if(rst)
			ps_tx <= START_SPI_tx;
		else 
			ps_tx <= ns_tx;
	end
	
	//--------FSM_1-----------
	always_comb begin
		ns = START;
		load_min_index = 0;
		rst_normh_dff = 0;
		load_min = 0;
		HVM_start = 0;
		
			case(ps)
				START:
					ns = INITIAL;
				INITIAL: 
				begin
					rst_normh_dff = 1;
					if(s_ssn_negedge)
					begin
						ns = load_HH4;
						//Full = 1;
						//inc_cnt15 = 1;
					end
					else
					begin
						ns = INITIAL;
						rst_normh_dff = 1;
					end
					
				end	
				load_HH4:
				begin
					if(cnt15<4)
					begin
						ns = load_HH4;
					end
					else
					begin	
						ns = load_HH8;
						rst_normh_dff = 1;
						load_min = 1;	
					end
				end	
				load_HH8:
				begin	
				
					if(cnt15<8)
					begin
						ns = load_HH8;
					end
					else
					begin
						load_min_index = 1;//cmp
						ns = load_HH15;
					end
				end
				load_HH15:
				begin	
				
					if(cnt15<15)
					begin	
						ns = load_HH15;
					end
					else
					begin
						if(s_sclk_posedge)
						begin
							ns = INITIAL;
							HVM_start = 1;
							rst_normh_dff = 1;
						end
						else
							ns = load_HH15;
					end
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
		
		rst_sel_R = 0;
		load_shift_data_rx = 0;
		inc_sel_R = 0;
		tx_req = 0;
			case(ps_VM)
				START_VM:
					ns_VM = INITIAL_VM;
				INITIAL_VM: 
				begin
					rst_normh12 = 1;
					rst_normh3 = 1;
					if(HVM_start)
					begin
						ns_VM = VM12_1;
						rst_sel_R = 1;
						
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
					
				end
				VM14_5:
				begin
					ns_VM = min_2;
					load_VM5 = 1;
					//ssn_en  = 0;
					
					inc_sel_R = 1;
				end
				min_2:
				begin
					ns_VM = VM23_1;
					load_normh12 = 1;
					load_normh3 = 1;
					
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM23_1://min_index3x3出來
				begin
					ns_VM = VM23_2;
					sel_col = 2'b1;
					sel_QRdecom_VM = 0;
					load_VM1 = 1;
					
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM23_2:
				begin
					ns_VM = VM23_3;
					load_VM2 = 1;
					//sel_R = 3;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM23_3:
				begin
					ns_VM = VM23_4;
					load_VM3 = 1;
					//sel_R = 4;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM23_4://
				begin
					ns_VM = VM23_5;
					load_VM4 = 1;
					//sel_R = 5;
					//sclk_en = 1;
					//ssn_en  = 0;

					load_shift_data_rx = 1;
				end
				VM23_5:
				begin
					ns_VM = VM24_1;
					load_VM5 = 1;
					//sel_R = 0;
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM24_1:
				begin
					ns_VM = VM24_2;
					rst_normh12 = 1;
					load_VMout = 1;
					sel_col = 2'b1;
					sel_QRdecom_VM = 1;
					load_VM1 = 1;
					//sel_R = 0;//
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM24_2:
				begin
					ns_VM = VM24_3;
					load_VM2 = 1;
					//sel_R = 0;//
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM24_3:
				begin
					ns_VM = VM24_4;
					load_VM3 = 1;
					//sel_R = 0;//
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM24_4:
				begin
					ns_VM = VM24_5;
					load_VM4 = 1;
					//sel_R = 0;//
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM24_5:
				begin
					ns_VM = min_3;
					load_VM5 = 1;
					//sel_R = 0;//
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				min_3:
				begin
					ns_VM = VM34_1;
					load_normh12 = 1;
					//sel_R = 0;
					//sclk_en = 1;
					//ssn_en  = 0;
				end
				VM34_1://min_index2x2出來
				begin
					ns_VM = VM34_2;
					sel_col = 2;
					sel_QRdecom_VM = 0;
					load_VM1 = 1;
					
					inc_sel_R = 1;
					
				end
				VM34_2:
				begin
					ns_VM = VM34_3;
					load_VM2 = 1;
					//sel_R = 2;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM34_3:
				begin
					ns_VM = VM34_4;
					load_VM3 = 1;
					//sel_R = 3;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM34_4:
				begin
					ns_VM = VM34_5;
					load_VM4 = 1;
					//sel_R = 4;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				VM34_5:
				begin
					ns_VM = R8;
					load_VM5 = 1;
					//sel_R = 6;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				R8:
				begin
					ns_VM = R9;
					//sel_R = 2;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				R9:
				begin
					ns_VM = R10;
					//sel_R = 3;
					//sclk_en = 1;
					//ssn_en  = 0;
					inc_sel_R = 1;
					load_shift_data_rx = 1;
				end
				R10:
				begin
					ns_VM = INITIAL_VM;
					//sel_R = 7;
					//sclk_en = 1;
					//ssn_en  = 0;
					load_shift_data_rx = 1;
					tx_req = 1;
				end
			endcase
		
	end		
	//---------FSM_SPI_tx------------
	always_comb begin
		ns_tx 			= START_SPI_tx;
		load_shift_data_tx = 0;
		load_mosi = 0;
		m_ssn_en		= 1;
		m_sclk_en 		= 0;
		inc_sclk_cnt 	= 0;
		rst_send_data_cnt 	= 0;
		inc_send_data_cnt 	= 0;
			case(ps_tx)
				START_SPI_tx:
					ns_tx = INITIAL_tx;
				INITIAL_tx: 
				begin
					if(tx_req)
					begin
						ns_tx = LOAD_SHIFT_DATA;
						m_ssn_en 		= 0;
						rst_send_data_cnt 	= 1;
					end
					else
						ns_tx = INITIAL_tx;
				end	
				
				LOAD_SHIFT_DATA:
				begin
					ns_tx = SHIFT_MOSI_0;
					load_shift_data_tx = 1;
					m_ssn_en 		= 0;
				end
				
				SHIFT_MOSI_0://開始sclk
				begin
					ns_tx = SHIFT_MOSI_123;
					m_ssn_en		= 0;
					m_sclk_en		= 0;
					load_mosi		= 1;
					inc_sclk_cnt 	= 1;
				end
				
				SHIFT_MOSI_123:
				begin
					inc_sclk_cnt 	= 1;
					if(sclk_cnt < 3)
					begin
						m_sclk_en	= 0;
						m_ssn_en 	= 0;
						ns_tx = SHIFT_MOSI_123;
					end
					else
					begin
						m_sclk_en	= 0;
						m_ssn_en 	= 0;
						ns_tx = SHIFT_MOSI_456;
					end
				end	
				
				SHIFT_MOSI_456:
				begin
					inc_sclk_cnt 	= 1;
					if(sclk_cnt < 2)
					begin
						m_sclk_en	= 1;
						m_ssn_en 	= 0;
						ns_tx = SHIFT_MOSI_456;
					end
					else
					begin
						m_sclk_en	= 1;
						m_ssn_en 	= 0;
						ns_tx = SHIFT_MOSI_7;
					end
				end	
				
				SHIFT_MOSI_7:
				begin
					inc_sclk_cnt 	= 1;
					m_sclk_en	= 1;
					m_ssn_en 	= 0;
					if(send_data_cnt < 11)
					begin
						inc_send_data_cnt 	= 1;
						ns_tx = SHIFT_MOSI_0;
					end
					else
						ns_tx = m_ssn_delay;
				end
				
				m_ssn_delay://12筆數據傳送完畢
				begin
					m_sclk_en	= 0;
					m_ssn_en 	= 0;
					ns_tx = FINISH;
				end
				
				FINISH://12筆數據傳送完畢
				begin
					m_sclk_en	= 0;
					m_ssn_en 	= 0;
					ns_tx = INITIAL_tx;
				end
			endcase
		
	end		
endmodule

