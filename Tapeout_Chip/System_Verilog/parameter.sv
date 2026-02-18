//SQRD
//QPSK 8bits
`ifndef MATRIX_SV
`define MATRIX_SV

`define bit_number 9

//`define symbol_pattern_1 `bit_number'd323 // 1 *2^10/SQRT(10)
//`define symbol_pattern_3 `bit_number'd971 // 3 *2^10/SQRT(10)

`define sign_bit `bit_number-1 //8





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


interface matrix ();

  signed_logic h11;
  signed_logic h21;
  signed_logic h31;
  signed_logic h41;
  signed_logic h12;
  signed_logic h22;
  signed_logic h32;
  signed_logic h42;
  signed_logic h13;
  signed_logic h23;
  signed_logic h33;
  signed_logic h43;
  signed_logic h14;
  signed_logic h24;
  signed_logic h34;
  signed_logic h44;
  
endinterface

interface col ();

  signed_logic c1;
  signed_logic c2;
  signed_logic c3;
  signed_logic c4;
  
  

  modport in(
	input c1,
	input c2,
	input c3,
	input c4
  );
  
  
  modport out(
	output c1,
	output c2,
	output c3,
	output c4
	
  );
      
  
endinterface


`endif


