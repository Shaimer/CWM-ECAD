//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #3 - Active IoT Devices Monitor
// Student Name: Shaimerden
// Date: 24.05.2021
//
// Description: A testbench module to test Ex3 - Active IoT Devices Monitor
// Guidance: start with simple tests of the module (how should it react to each 
// control signal?). Don't try to test everything at once - validate one part of 
// the functionality at a time.
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
	reg clk, rst, change, on_off;
    	wire [7:0] counter_out;
    	reg err;
	reg [7:0] counter_local;
    	
    	
//Todo: Clock generation
initial
    begin
       clk = 1'b0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
//Todo: User logic
	initial 
		 begin
		err=0;
    		rst=1;
		change=0;
		on_off=1;
		counter_local=0;
	
	#(CLK_PERIOD)
		if (counter_out!=0)
		begin
		$display ("***TEST FAILED!  Reset does not work!counter_out=%b ***", counter_out);
		err=1;
		end


		rst=0;
	#(CLK_PERIOD)
		if (counter_out!=0)
		begin
		$display ("***TEST FAILED! Change does not work! counter_out=%b ***", counter_out);
		err=1;
		end

		change=1;
	#(CLK_PERIOD)
		if (counter_out==0)
		begin
		$display ("***TEST FAILED! On-off=1 does not work! counter_out=%b ***", counter_out);
		err=1;
		end
		
		on_off=0;
	#(CLK_PERIOD)
		if (counter_out!=0)
		begin
		$display ("***TEST FAILED!  On-off=0 does not work! counter_out=%b ***", counter_out);
		err=1;
		end
	on_off=1;
	forever begin
	
	#(CLK_PERIOD)
	if (on_off)
		counter_local=counter_local+1;
	else
		counter_local=counter_local-1;
	
	if (counter_out!=counter_local)
		begin
		$display ("***TEST FAILED!  Check your counting method! counter_out=%b counter_local=%b***", counter_out, counter_local);
		err=1;
		end
	if (counter_local==8'b11111111||counter_local==8'b00000000 )
		on_off=~on_off;
	
	
	$display("rst=%b, change=%b, on_off=%b, counter_out=%b", rst, change, on_off, counter_out);
	end
end


	
//Todo: Finish test, check for success
initial begin
#(CLK_PERIOD*512)
if (err==0)

	$display ("***TEST PASSED!  counter_out=%d ***", counter_out);
$display("rst=%b, change=%b, on_off=%b, counter_out=%b", rst, change, on_off, counter_out);
$finish;
end
//Todo: Instantiate counter module
  monitor top(
.clk (clk),.rst(rst), .change (change), .on_off (on_off), .counter_out (counter_out)
);
endmodule 
