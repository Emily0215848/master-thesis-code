`timescale 1ns/1ps
`include "C:/Users/Lab601-1/Desktop/hardware/parameter.sv"
//timeunit 1ps;//work.test_SCQR_top


module test_SQRD_top_spi();
`define RTL
//`define GATE

	//系統
	logic clk,rst;
	
	//DE_CV
	logic [35:0] GPIO;//晶片的腳位
	
	//SPI
	//logic get_data;	//接收top之output
	//logic cmd_miso;
	//logic mosi;
	//logic cmd_ssn;
	//logic sclk;
	parameter DATA = 3;
	parameter SPI_T = 100;	//控制ssn的傳輸速度，調慢sclk解決sclk太快導致sclk_pos會慢的問題
	//possessed
	
	
	//===========================
	logic s_sclk, m_sclk;
	logic s_ssn, m_ssn;
	signed_logic mosi;
	signed_logic h;
	
	integer fp_test,callback,input_time,fp_final_result,data_recieve_time;
	integer i;
	
	initial 
	begin
		`ifdef GATE
			$sdf_annotate("CHIP.sdf", CHIP,,,"maximum"); 
			$fsdbDumpfile("CHIP.fsdb");   
			$fsdbDumpvars(0,"+mda");
			$fsdbDumpvars();
		`endif
		`ifdef RTL
			$fsdbDumpfile("CHIP.fsdb");
			$fsdbDumpvars(0,"+mda");
			$fsdbDumpvars();
		`endif
	end
	
	
	
	
	


top test_top(					
    .clk                (clk                ),
    .rst	            (rst             	),
    .s_ssn           	(s_ssn             	),
    .h  				(h  				),
	.s_sclk  			(s_sclk  				),
	
	.mosi  				(mosi  				),
	.m_ssn  			(m_ssn  			),
	.m_sclk  			(m_sclk  				)
);

always #10 clk = ~clk;

//	
task write(
	input integer input_time
	);
	
	integer i, j;
	
	for (i = 0; i<input_time; i=i+1)
	begin
		//開始傳輸
		s_ssn = 1;
		#100;
		h = 9'b0;
		#200;
		s_ssn = 0;
		for (j = 0; j<4; j=j+1)
		begin
			callback = $fscanf(fp_test, "%5d\t"  ,h);
			#SPI_T s_sclk = 1;
			#SPI_T s_sclk = 0;
			callback = $fscanf(fp_test, "%5d\t"  ,h);
			#SPI_T s_sclk = 1;
			#SPI_T s_sclk = 0;
			callback = $fscanf(fp_test, "%5d\t"  ,h);
			#SPI_T s_sclk = 1;
			#SPI_T s_sclk = 0;
			callback = $fscanf(fp_test, "%5d\t"  ,h);
			callback = $fscanf(fp_test, "\n" );
			#SPI_T s_sclk = 1;
			#SPI_T s_sclk = 0;
		end
		#200;//200是跟著前面的200
		
		
		
	end
	
endtask
//
//------------開始testbench讀取測資---------
	initial begin
		h = 9'b0;
		fp_test = $fopen("C:/Users/Lab601-1/Desktop/hardware/aug_HH.txt","r");//r: 打開一個文件進行讀取。該文件必須存在
		clk = 0; rst = 1; 
		s_ssn = 1; 
		input_time = 3; 
		s_sclk=0;
		#1000	
		rst = 0; //#5會吃不到rst=1
		write(4);
        $fclose(fp_test);

        //@(posedge test_SCQR_top.frame_in_tac4_h22R);
        //@(posedge clk);
        //@(negedge clk);
		//
        //fp_test = $fopen("test_yy_SNR_15.txt","r");//r: 打開一個文件進行讀取。該文件必須存在
        //data_recieve_time = 50;
        //s_ssn = 0; 
		//#10;
		//for(input_time = 0 ; input_time < data_recieve_time ; input_time ++)
		//begin
        //callback = $fscanf(fp_test, "%5d\t"  ,y.r1);
		//callback = $fscanf(fp_test, "%5d\t"  ,y.r2);
        //callback = $fscanf(fp_test, "%5d\t"  ,y.r3);
        //callback = $fscanf(fp_test, "%5d\t"  ,y.r4);
        //callback = $fscanf(fp_test, "%5d\t"  ,y.i1);
		//callback = $fscanf(fp_test, "%5d\t"  ,y.i2);
        //callback = $fscanf(fp_test, "%5d\t"  ,y.i3);
        //callback = $fscanf(fp_test, "%5d\t"  ,y.i4);
		//callback = $fscanf(fp_test, "\n" );
        //#10;
		//end
		//$fclose(fp_test);
        //#60;
        ////fp_final_result  = $fopen("final_result_SNR_15.txt","w");
		////	$timeformat(-12,0,"ps",8);//timeformat四個參數:(時間標度(ex:ns,ps) , 小數點後數據精度, 時間值後的後綴字符,顯示數值的最小寬度)	
		////	for(i = 0 ; i < data_recieve_time ; i ++)
		////	begin
		////		$display("Num:%d time:%t\n",i,$realtime);
        ////        $fwrite(fp_final_result, "%5d\t"  ,final_antenna_set);
        ////        $fwrite(fp_final_result, "%5d\t"  ,final_ss_hat_1_R);
        ////        $fwrite(fp_final_result, "%5d\t"  ,final_ss_hat_1_I);	
        ////        $fwrite(fp_final_result, "%5d\t"  ,final_ss_hat_2_R);
        ////        $fwrite(fp_final_result, "%5d\t"  ,final_ss_hat_2_I);	
		////		$fwrite(fp_final_result, "\n" );
		////		#10;
		////	end
		//
		////	$fclose(fp_final_result);     
		////	$display("data collect finish time:%t\n",$realtime);
		//
        //fp_final_result  = $fopen("final_result_SNR_15_bits.txt","w");
	    //$timeformat(-12,0,"ps",8);//timeformat四個參數:(時間標度(ex:ns,ps) , 小數點後數據精度, 時間值後的後綴字符,顯示數值的最小寬度)	
	    //for(i = 0 ; i < data_recieve_time ; i ++)
	    //begin
	    //	$display("Num:%d time:%t\n",i,$realtime);
        //    $fwrite(fp_final_result, "%10b\t"  ,result_bit_stream);
	    //	#10;
	    //end
	    //$fclose(fp_final_result);     
	    //$display("data collect finish time:%t\n",$realtime);

        #1000 $stop;
	end
	
	


endmodule