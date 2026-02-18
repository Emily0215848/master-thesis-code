module CHIP(
	input clk,
	input rst,
	input s_ssn,
	input s_sclk,
	input [8:0] h,
	
	output logic [8:0] mosi,
	output logic m_ssn,
	output logic m_sclk
);

logic ipad_clk;
logic ipad_rst;
logic ipad_s_ssn;
logic ipad_s_sclk;
logic [8:0] ipad_h;

logic [8:0] opad_mosi; 
logic opad_m_ssn;
logic opad_m_sclk;

PDIDGZ_33 u_clk		(.PAD(clk	),	.C(ipad_clk	)		);
PDIDGZ_33 u_rst     (.PAD(rst   ),	.C(ipad_rst   )		);
PDIDGZ_33 u_s_ssn   (.PAD(s_ssn ),	.C(ipad_s_ssn )		);
PDIDGZ_33 u_s_sclk  (.PAD(s_sclk),	.C(ipad_s_sclk)		);
PDIDGZ_33 u_h_0     (.PAD(h[0]   ),	.C(ipad_h[0]   )		);
PDIDGZ_33 u_h_1     (.PAD(h[1]   ),	.C(ipad_h[1]   )		);
PDIDGZ_33 u_h_2     (.PAD(h[2]   ),	.C(ipad_h[2]   )		);
PDIDGZ_33 u_h_3     (.PAD(h[3]   ),	.C(ipad_h[3]   )		);
PDIDGZ_33 u_h_4     (.PAD(h[4]   ),	.C(ipad_h[4]   )		);
PDIDGZ_33 u_h_5     (.PAD(h[5]   ),	.C(ipad_h[5]   )		);
PDIDGZ_33 u_h_6     (.PAD(h[6]   ),	.C(ipad_h[6]   )		);
PDIDGZ_33 u_h_7     (.PAD(h[7]   ),	.C(ipad_h[7]   )		);
PDIDGZ_33 u_h_8     (.PAD(h[8]   ),	.C(ipad_h[8]   )		);

PDO16CDG_33 u_mosi_0 (.I(opad_mosi[0]),		.PAD(mosi[0])		);
PDO16CDG_33 u_mosi_1 (.I(opad_mosi[1]),		.PAD(mosi[1])		);
PDO16CDG_33 u_mosi_2 (.I(opad_mosi[2]),		.PAD(mosi[2])		);
PDO16CDG_33 u_mosi_3 (.I(opad_mosi[3]),		.PAD(mosi[3])		);
PDO16CDG_33 u_mosi_4 (.I(opad_mosi[4]),		.PAD(mosi[4])		);
PDO16CDG_33 u_mosi_5 (.I(opad_mosi[5]),		.PAD(mosi[5])		);
PDO16CDG_33 u_mosi_6 (.I(opad_mosi[6]),		.PAD(mosi[6])		);
PDO16CDG_33 u_mosi_7 (.I(opad_mosi[7]),		.PAD(mosi[7])		);
PDO16CDG_33 u_mosi_8 (.I(opad_mosi[8]),		.PAD(mosi[8])		);
PDO16CDG_33 u_m_ssn  (.I(opad_m_ssn ),		.PAD(m_ssn)			);
PDO16CDG_33 u_m_sclk (.I(opad_m_sclk),		.PAD(m_sclk)		);

top test_top(					
    .clk                (ipad_clk                	),
    .rst	            (ipad_rst             		),
    .s_ssn           	(ipad_s_ssn             	),
    .h  				(ipad_h  					),
	.s_sclk  			(ipad_s_sclk  				),
	
	.mosi  				(opad_mosi  				),
	.m_ssn  			(opad_m_ssn  				),
	.m_sclk  			(opad_m_sclk  				)
);



endmodule