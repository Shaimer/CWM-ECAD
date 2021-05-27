//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #6 - RGB Colour Converter
// Student Name: Shaimerden
// Date: 27.05.2021
//
// Description: A testbench module to test Ex6 - RGB Colour Converter
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
	reg clk;
	reg [2:0] colour;
    	wire  [23:0] rgb;
	
    	reg err, enable;
	
	

    	
    	
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
	
	
	colour=3'b001;
	#(CLK_PERIOD)
	if ( rgb==24'h0000FF)
	begin
		$display ("***TEST FAILED!  Too hot! rgb=%h ***", rgb);
		err=1;
	end
	
	
		
	
	
	
end


	
//Todo: Finish test, check for success
initial begin
#(500)
if (err==0)

	$display ("***TEST PASSED! rgb=%h ***", rgb);
$display("colour=%b, rgb=%b", colour, rgb);
$finish;

end
//Todo: Instantiate module
monitor top(
.clk (clk),.colour(colour), .enable(enable), .rgb (rgb)
);
  
endmodule 
