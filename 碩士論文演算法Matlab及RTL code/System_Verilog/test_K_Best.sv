`timescale 1ns/1ps
`include "./parameter.sv"
//timeunit 1ps;//work.test_SCQR_top


module test_K_Best();
`define RTL
//`define GATE
	integer fp_test,callback,input_time,data_recieve_time;
	integer OK, fp_r, fp_w0, fp_std, cnt, cnt_1, x, j, i;
	integer x_sv, x_NN, x_NN_s;
	reg[100*8-1:0] file_name_w0, file_name_str_r;
	//reg[100*8-1:0] file_H_r, file_y_r;
	//integer fp_H_r, fp_y_r
	
	//系統
	logic clk,rst;
	signed_logic H [7:0][7:0];
	signed_logic y [7:0];
	
	logic QRHVM_finish_o, KB_finish_o;
	logic [23:0] result_bitstream;
	
	
	
	
	//initial 
	//begin
	//	`ifdef GATE
	//		$sdf_annotate("CHIP.sdf", CHIP,,,"maximum"); 
	//		$fsdbDumpfile("CHIP.fsdb");   
	//		$fsdbDumpvars(0,"+mda");
	//		$fsdbDumpvars();
	//	`endif
	//	`ifdef RTL
	//		$fsdbDumpfile("CHIP.fsdb");
	//		$fsdbDumpvars(0,"+mda");
	//		$fsdbDumpvars();
	//	`endif
	//end
	
	initial begin
		//檔案名稱暫存
		//輸入
		//file_H_r = "test_input/Ht_fix7.txt";
		//file_y_r = "test_input/y_fix7.txt";
		// SV輸出
		file_name_w0 = "x_sv.txt";
		// matlab或python輸出
		file_name_str_r = "x_fix20.txt";
		
		//開啟檔案位置	$fopen(檔案名稱, "r":read "w":write)
		//輸入
		//fp_H_r = $fopen(file_H_r, "r");
		//fp_y_r = $fopen(file_y_r, "r");
		// SV輸出
		fp_w0 = $fopen(file_name_w0, "w");
		// matlab或python輸出
		fp_std = $fopen(file_name_str_r, "r");
	end
	


top top(					
    .clk                (clk                ),
    .rst	            (rst             	),
    .H 					(H  				),
	.y 					(y  				),
	
	.QRHVM_finish_o 	(QRHVM_finish_o	),
	.KB_finish_o 		(KB_finish_o	),
	.result_bitstream 	(result_bitstream	)
);

always #2 clk = ~clk; //#4*1ns=4ns=>250MHz

//-------------取得硬體資料並寫成txt檔----------
	always_ff@(negedge clk)begin//取負緣以確保抓到正確資料
		if(KB_finish_o) begin
			if (result_bitstream == 24'bz)
				$fwrite(fp_w0, "%5d\n", -1); //-1代表high z
			else if(result_bitstream == 24'bx)
				$fwrite(fp_w0, "%5d\n", -2); //-2代表X unknown
			else begin
				$fwrite(fp_w0, "%5d\n", result_bitstream); 
			end
		end
	end
	//$fwrite(檔案, "輸出格式", 輸出資料所存reg);資料寫入檔案 $signed表示有號數
//--------------------------------------------

//------------開始testbench讀取測資---------
	initial begin
		//h = 9'b0;
		fp_test = $fopen("./aug_HH.txt","r");//r: 打開一個文件進行讀取。該文件必須存在
		clk = 0; rst = 1; 	
		input_time = 0; 	
		#100
		rst = 0; //#5會吃不到rst=1	
		begin
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[0][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[0][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[0][7]);
		callback = $fscanf(fp_test, "\n" );
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[1][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[1][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[1][7]);
		callback = $fscanf(fp_test, "\n" );
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[2][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[2][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[2][7]);
		callback = $fscanf(fp_test, "\n" );
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[3][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[3][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[3][7]);
		callback = $fscanf(fp_test, "\n" );
		callback = $fscanf(fp_test, "%5d\t"  ,H[4][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[4][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[4][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[4][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[4][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[4][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[4][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[4][7]);
		callback = $fscanf(fp_test, "\n" );
		callback = $fscanf(fp_test, "%5d\t"  ,H[5][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[5][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[5][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[5][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[5][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[5][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[5][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[5][7]);
		callback = $fscanf(fp_test, "\n" );
		callback = $fscanf(fp_test, "%5d\t"  ,H[6][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[6][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[6][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[6][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[6][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[6][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[6][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[6][7]);
		callback = $fscanf(fp_test, "\n" );
		callback = $fscanf(fp_test, "%5d\t"  ,H[7][0]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[7][1]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[7][2]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[7][3]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[7][4]);
		callback = $fscanf(fp_test, "%5d\t"  ,H[7][5]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[7][6]);
        callback = $fscanf(fp_test, "%5d\t"  ,H[7][7]);
		callback = $fscanf(fp_test, "\n" );
		end
        $fclose(fp_test);
		
		@(posedge QRHVM_finish_o);
        @(posedge clk);
        
		
        fp_test = $fopen("aug_yy.txt","r");//r: 打開一個文件進行讀取。該文件必須存在
        data_recieve_time = 1000; 
		for(input_time = 0 ; input_time < data_recieve_time ; input_time ++)
		begin
        callback = $fscanf(fp_test, "%5d\t"  ,y[0]);
		callback = $fscanf(fp_test, "%5d\t"  ,y[1]);
        callback = $fscanf(fp_test, "%5d\t"  ,y[2]);
        callback = $fscanf(fp_test, "%5d\t"  ,y[3]);
        callback = $fscanf(fp_test, "%5d\t"  ,y[4]);
		callback = $fscanf(fp_test, "%5d\t"  ,y[5]);
        callback = $fscanf(fp_test, "%5d\t"  ,y[6]);
        callback = $fscanf(fp_test, "%5d\t"  ,y[7]);
		callback = $fscanf(fp_test, "\n" );
		#4;
		end
		$fclose(fp_test);
		
        #5000
		//關閉檔案
		$fclose(fp_w0);
        
		//--------比對輸入和輸出資料-----------
		fp_r = $fopen(file_name_w0, "r"); //sv輸出
		fp_std = $fopen(file_name_str_r, "r"); //Matlab輸出
		
		x = 0;
		OK = 1;
		for(i=0; i<1000; i++)begin
			//讀取測試和預計結果
			cnt_1 = $fscanf(fp_r, "%d\n", x_sv);
			cnt = $fscanf(fp_std, "%d\n", x_NN);
			x = x+1; //計算輸入資料量
			
			//結果為z
			if(cnt_1 == -1)
			begin
				OK = 0;
				$display("ERROR! -1. \n");
			end
			else if(cnt_1 == -2)
			begin
				OK = 0;
				$display("ERROR! -2. \n");
			end
			//比對
			if (x_sv != x_NN)
			begin
				OK = 0;
				$display("line: %d ==> %d != %d \n", x, x_sv, x_NN);
			end
		end
		//顯示比對結果成功/失敗
		if(OK==1)
			$display("Good job!, Simulation OK. \n");
		else
			$display("Sorry, Simulation ERROR. \n");
			
       $fclose(fp_r);
	   $fclose(fp_std);
	   
	   $finish;
	end
	
	


endmodule