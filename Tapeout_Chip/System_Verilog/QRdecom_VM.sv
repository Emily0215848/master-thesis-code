//QRdecom_VM.sv
`include "./parameter.sv"

module QRdecom_VM(
		col.in col1,
		col.in col2,
		col.in col3,
		col.in col4,
		
		input clk,
		input rst,
		input load_VM1, load_VM2, load_VM3, load_VM4, load_VM5,
		input [1:0] sel,
		
		
		output signed_logic A_out,
		output signed_logic B_out,
		output signed_logic C_out,
		output signed_logic D_out,
		output signed_logic E_out,
		output signed_logic F_out,
		output signed_logic G_out,
		output signed_logic H_out
		);
		
		signed_logic A_in, B_in, C_in, D_in, E_in, F_in, G_in, H_in;
		logic col_sign;
			
		always_comb
		begin
			A_in = 9'b0;
			B_in = 9'b0;
			C_in = 9'b0;
			D_in = 9'b0;
			E_in = 9'b0;
			F_in = 9'b0;
			G_in = 9'b0;
			H_in = 9'b0;
			case(sel)//考慮不用case
				0: //V12,V23,V34
				begin
					col_sign = (col1.c1[8] == 1'b1) && (col1.c1[7:0] != 8'b00000000);
					if(col_sign)
						begin
							A_in = {~col1.c1[8],col1.c1[7:0]};
						    B_in = col1.c2;
						    C_in = {~col2.c1[8],col2.c1[7:0]};
						    D_in = col2.c2;
						    E_in = {~col3.c1[8],col3.c1[7:0]};
						    F_in = col3.c2;
						    G_in = {~col4.c1[8],col4.c1[7:0]};
							H_in = col4.c2;
						end
					else
						begin
							A_in = {1'b0,col1.c1[7:0]};
							B_in = col1.c2;
							C_in = col2.c1;
							D_in = col2.c2;
							E_in = col3.c1;
							F_in = col3.c2;
							G_in = col4.c1;
							H_in = col4.c2;
						end	
				end
				1: //V13
				begin
					A_in = A_out;//col1.c1
					B_in = col1.c3;//col1.c3
					C_in = C_out;//col2.c1
					D_in = col2.c3;//col2.c3
					E_in = E_out; //col3.c1
					F_in = col3.c3;//col3.c3
					G_in = G_out; //col4.c1
					H_in = col4.c3;//col4.c3
				end
				2: //V14
				begin
					A_in = A_out;
					B_in = col1.c4;
					C_in = C_out;
					D_in = col2.c4;
					E_in = E_out;
					F_in = col3.c4;
					G_in = G_out;
					H_in = col4.c4;
				end
				
				3://VM24,其實=V13
				begin
					A_in = 0;
					B_in = 0;
					C_in = 0;
					D_in = 0;
					E_in = 0;
					F_in = 0;
					G_in = 0;
					H_in = 0;
				end
				
			endcase
		end
		
		
		
		VM2x4_micro_rotation VM_1(

							.A_in	  (A_in),  
							.B_in	  (B_in),  
							.C_in	  (C_in),  
							.D_in	  (D_in),  
							.E_in	  (E_in),  
							.F_in	  (F_in),  
							.G_in	  (G_in),  
							.H_in	  (H_in),  
							.clk 	  (clk 	  ),
							.rst	  (rst	  ),
							.load_VM1	(load_VM1),
							.load_VM2	(load_VM2),
							.load_VM3	(load_VM3),
							.load_VM4	(load_VM4),
							.load_VM5	(load_VM5),
					        
							.A_out    (A_out    ),
							.B_out    (B_out    ),
							.C_out    (C_out    ),
							.D_out    (D_out    ),
							.E_out    (E_out    ),
							.F_out    (F_out    ),
							.G_out    (G_out    ),
							.H_out    (H_out    )  
							);

endmodule