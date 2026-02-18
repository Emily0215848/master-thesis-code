//clk_div4.sv

module clk_div4 (
    input        clk,
    input        rst,
	input		 load_sclk,
    output logic o_clk
);

	logic [1:0] cnt;
	
	always_ff @(posedge clk) 
	begin
		if (rst)
			cnt <= 2'd0;
		else if(load_sclk)
			cnt <= cnt + 1;
	end

assign o_clk = cnt[1];

endmodule