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
    	reg [7:0] counter_out;
    	reg [7:0] local_counter;
    	
    	
//Todo: Clock generation
initial
    begin
       clk = 0;
       forever
         #(CLK_PERIOD/2) clk=~clk;
     end
//Todo: User logic
	initial 
		begin
		local_counter=0;
    		rst=1;
		change=0;
		#10 rst=0;
		change=1;
		on_off=1;
		#10 rst=0;
		change=1;
		on_off=0;
		#10
		$display("rst=%h, change=%h, on_off=%h, counter_out=%h", rst, change, on_off, counter_out);
	end
	
//Todo: Finish test, check for success

//Todo: Instantiate counter module
  monitor top(.clk (clk),.rst(rst), .change (change), .on_off (on_off), .counter_out (counter_out));
endmodule 
