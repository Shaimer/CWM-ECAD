//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
// Description: A testbench module to test Ex4 - Dynamic LED lights
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
	reg clk, rst, button;
    	wire [2:0] colour;
	reg [2:0] colour_prev;
    	reg err, condition;
	reg [3:0] counter_local=0;
    	
    	
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
    	rst=0;
	button=0;
	//counter_local=0;
	
	
	if (colour!=3'b000)
	begin
		$display ("***TEST FAILED!  Initialisation does not work! colour=%b ***", colour);
		err=1;
	end
		

	rst=1;
	#(CLK_PERIOD)
	if (colour!=3'b000)
	begin
		$display ("***TEST FAILED!  Reset does not work! colour=%b ***", colour);
		err=1;
	end

	rst=0;
	#(CLK_PERIOD)
	if (colour!=3'b001)
	begin
		$display ("***TEST FAILED!  Automatic set does not work! colour=%b ***", colour);
		err=1;
	end

	
		
	
	button=1;
	forever begin
	
	colour_prev=colour;
	#(CLK_PERIOD)	
	if (button)
	begin
		if ((colour_prev==3'b110 ||colour_prev==3'b111 ) && colour == 3'b001)
			condition=1;
		else if (colour == (colour_prev+1'b1))
			condition=1;
		else
			condition=0;
	
		if (!condition)
		begin
			$display ("***TEST FAILED!  Check your button!***");
			err=1;
		end
	end
	else 
	begin
	
		if (colour!=colour_prev)
		begin
			$display ("***TEST FAILED!  Check your button again!***");
			err=1;
		end
	end

	if (counter_local==4'b1111 )
		button=~button;
	counter_local=counter_local+1'b1;
	
	$display("rst=%b, button=%b, colour=%b, counter_local=%b err=%b", rst, button, colour, counter_local,err);
	end
end


monitor top(
.clk (clk),.rst(rst), .button(button), .colour (colour)
);	
//Todo: Finish test, check for success
initial begin
#(CLK_PERIOD*500)
if (err==0)

	$display ("***TEST PASSED! colour=%b ***", colour);
$display("rst=%b, button=%b, colour=%b", rst, button, colour);
$finish;

end
//Todo: Instantiate counter module
  
endmodule 
