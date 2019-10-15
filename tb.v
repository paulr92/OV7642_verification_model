`timescale 1ns / 1ps

module top_cam();



	reg clk;
	reg	rst;
	reg Y, href_ff;
	wire [7:0] data;
	wire wr_done;
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		// Wait 100 ns for global reset to finish
		#100;
      rst = 1;  
		#50;
		// Add stimulus here
		// #600_000;//600us
		#58_000_000;//58ms
		$finish;

	end
	
	always begin
	#5 clk = ~clk;
	end
	
	sim_camera cam(
	 .xclk(clk),
	 .n_rst(rst),
	 .pclk(pclk),
	 .vsync(vsync),
	 .href(href),
	 .data(data)
	);
	
	image_write im_wr(
	  .HCLK(clk),
	  .HRESETn(rst),
	  .hsync(href & Y),
	  .DATA_IN(data),
	  .Write_Done(wr_done)
	);
	
	always @(posedge clk or negedge rst) begin
		if (~rst)
			Y <= 1;
		if (href==0 & href_ff==1)begin
			Y <= 1;
		end
		else if (href==1)
			Y <= ~Y;
	end
	
	always @(negedge clk)
		href_ff <= href;
endmodule;