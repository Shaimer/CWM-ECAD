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
	enable=0;
	
	colour=3'b000;
	#(CLK_PERIOD)
	if (rgb==24'h00ff00)
	begin
		$display ("***TEST FAILED!  rgb=%h ***", rgb);
		err=1;
	end
	forever begin
	
	enable=1;
	colour=colour+1'b1;
	#(CLK_PERIOD*2) //two periods needed
	if (rgb[23]!=colour[2] ||rgb[15]!=colour[1]||rgb[7]!=colour[0] )
		begin
			$display ("***TEST FAILED! Something is wrong! ***");
			err=1;
		end
	

	
	$display("colour=%b, enable=%b,  err=%b, rgb=%h", colour, enable, err,rgb);
	end
		
end


	
//Todo: Finish test, check for success
initial begin
#(700)
if (err==0)

	$display ("***TEST PASSED! rgb=%h  enable=%b***", rgb, enable);
$display("colour=%b, rgb=%h", colour, rgb);
$finish;

end
//Todo: Instantiate module
monitor top(
.clk (clk),.colour(colour), .enable(enable), .rgb (rgb)
);
  
endmodule 
