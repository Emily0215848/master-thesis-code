//K-Best

`ifndef MATRIX_SV
`define MATRIX_SV

`define bit_number 14

//`define symbol_pattern_1 `bit_number'd323 // 1 *2^10/SQRT(10)
//`define symbol_pattern_3 `bit_number'd971 // 3 *2^10/SQRT(10)

`define sign_bit `bit_number-1 //16-1

`define angleWithSign 7
`define angle 6



//`define TAC1 4'b0001
//`define TAC2 4'b0010
//`define TAC3 4'b0011
//`define TAC4 4'b0110

//`define p_symbol_pattern_1 `symbol_pattern_1
//`define p_symbol_pattern_3 `symbol_pattern_3
//`define n_symbol_pattern_1 (`symbol_pattern_1 + 16'h8000)
//`define n_symbol_pattern_3 (`symbol_pattern_3 + 16'h8000)

typedef logic [`sign_bit-1     : 0 ] unsigned_logic;//typedef:創建新的類型 , unsigned_logic(類型:logic 位寬:拔掉sign_bit的bit數)
typedef logic [`sign_bit       : 0 ] signed_logic; //共8位
typedef logic [`angle          : 0 ] angle_logic;
typedef logic [`angleWithSign  : 0 ] angleWithSign_logic;


//interface matrix ();
//
//  signed_logic h11;
//  signed_logic h21;
//  signed_logic h31;
//  signed_logic h41;
//  signed_logic h12;
//  signed_logic h22;
//  signed_logic h32;
//  signed_logic h42;
//  signed_logic h13;
//  signed_logic h23;
//  signed_logic h33;
//  signed_logic h43;
//  signed_logic h14;
//  signed_logic h24;
//  signed_logic h34;
//  signed_logic h44;
//  
//endinterface

interface col #(int N = 8) ();
  signed_logic c [N-1:0];                  // c[0]..c[N-1]

  modport in  (input  c);
  modport out (output c);
endinterface

interface row #(int N = 8) ();
  signed_logic c [N-1:0];                  // c[0]..c[N-1]

  modport in  (input  c);
  modport out (output c);
endinterface
//interface col ();
//
//  signed_logic c0;
//  signed_logic c1;
//  signed_logic c2;
//  signed_logic c3;
//  signed_logic c4;
//  signed_logic c5;
//  signed_logic c6;
//  signed_logic c7;
//  
//  
//
//  modport in(
//	input c0,
//	input c1,
//	input c2,
//	input c3,
//	input c4,
//	input c5,
//    input c6,
//	input c7
//  );
//  
//  
//  modport out(
//	output c0,
//	output c1,
//	output c2,
//	output c3,
//	output c4,
//	output c5,
//    output c6,
//	output c7
//	
//  );
//endinterface
interface col1_angle ();

  angleWithSign_logic h11h21_theta_AB;
  angleWithSign_logic h31h41_theta_AB;
  angleWithSign_logic h51h61_theta_AB;
  angleWithSign_logic h71h81_theta_AB;
  angle_logic 	      h11h31_theta_AB;
  angle_logic 	      h51h71_theta_AB;
  angle_logic 	      h11h51_theta_AB;

  modport RM(
      input h11h21_theta_AB,
      input h31h41_theta_AB,
      input h51h61_theta_AB,
      input h71h81_theta_AB,
      input h11h31_theta_AB,
      input h51h71_theta_AB,
      input h11h51_theta_AB
  );

  modport VM(
      output h11h21_theta_AB,
      output h31h41_theta_AB,
      output h51h61_theta_AB,
      output h71h81_theta_AB,
      output h11h31_theta_AB,
      output h51h71_theta_AB,
      output h11h51_theta_AB
  );

endinterface

interface col2_angle ();

  angleWithSign_logic h22h32_theta_AB;
  angleWithSign_logic h42h52_theta_AB;
  angleWithSign_logic h62h72_theta_AB;
  angle_logic 	      h22h42_theta_AB;
  angle_logic 	      h62h82_theta_AB;
  angle_logic 	      h22h62_theta_AB;

  modport RM(
      input h22h32_theta_AB,
      input h42h52_theta_AB,
      input h62h72_theta_AB,
      input h22h42_theta_AB,
      input h62h82_theta_AB,
      input h22h62_theta_AB
  );

  modport VM(
      output h22h32_theta_AB,
      output h42h52_theta_AB,
      output h62h72_theta_AB,
      output h22h42_theta_AB,
      output h62h82_theta_AB,
      output h22h62_theta_AB
  );

endinterface

interface col3_angle ();

  angleWithSign_logic h33h43_theta_AB;
  angleWithSign_logic h53h63_theta_AB;
  angleWithSign_logic h73h83_theta_AB;
  angle_logic 	      h33h53_theta_AB;
  angle_logic 	      h33h73_theta_AB;
  

  modport RM(
      input h33h43_theta_AB,
      input h53h63_theta_AB,
      input h73h83_theta_AB,
      input h33h53_theta_AB,
      input h33h73_theta_AB
  );

  modport VM(
      output h33h43_theta_AB,
      output h53h63_theta_AB,
      output h73h83_theta_AB,
      output h33h53_theta_AB,
      output h33h73_theta_AB
  );

endinterface

interface col4_angle ();

  angleWithSign_logic h44h54_theta_AB;
  angleWithSign_logic h64h74_theta_AB;
  angle_logic 	      h44h64_theta_AB;
  angle_logic 	      h44h84_theta_AB;
  

  modport RM(
      input h44h54_theta_AB,
      input h64h74_theta_AB,
      input h44h64_theta_AB,
      input h44h84_theta_AB
  );

  modport VM(
      output h44h54_theta_AB,
      output h64h74_theta_AB,
      output h44h64_theta_AB,
      output h44h84_theta_AB
  );

endinterface

interface col5_angle ();

  angleWithSign_logic h55h65_theta_AB;
  angleWithSign_logic h75h85_theta_AB;
  angle_logic 	      h55h75_theta_AB;
  
  

  modport RM(
      input h55h65_theta_AB,
      input h75h85_theta_AB,
      input h55h75_theta_AB
  );

  modport VM(
      output h55h65_theta_AB,
      output h75h85_theta_AB,
      output h55h75_theta_AB
  );

endinterface

interface col6_angle ();

  angleWithSign_logic h66h76_theta_AB;
  angle_logic 	      h66h86_theta_AB;
  
  

  modport RM(
      input h66h76_theta_AB,
      input h66h86_theta_AB
  );

  modport VM(
      output h66h76_theta_AB,
      output h66h86_theta_AB
  );
 endinterface
 
interface col7_angle ();

  angleWithSign_logic h77h87_theta_AB;
  logic	      	      h88_theta_AB;
  
  

  modport RM(
      input h77h87_theta_AB,
      input h88_theta_AB
  );

  modport VM(
      output h77h87_theta_AB,
      output h88_theta_AB
  );

endinterface

`endif


