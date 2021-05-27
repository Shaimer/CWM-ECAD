//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #7 - Lights Selector
// Student Name: Shaimerden Kuanganov
// Date: 27.05.2021
//
// Description: A testbench module to test Ex7 - Lights Selector
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
	reg clk, rst, button;
    	wire [23:0] light;
	reg [2:0] colour;
	reg [2:0] colour_prev;
    	reg err, condition;
	reg [3:0] counter_local=0;
	reg [47:0] ab;
    	reg [47:0] ab_prev;
	reg [23:0] white=24'hFFFFFF;
    	reg sel;
    	
    	
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
	sel=0;
	button=0;
	//counter_local=0;
	
	
	if (light!=24'h000000)
	begin
		$display ("***TEST FAILED!  Initialisation does not work! light=%h ***", light);
		err=1;
	end
		

	rst=1;
	#(CLK_PERIOD)
	if (light!=24'h000000)
	begin
		$display ("***TEST FAILED!  Reset does not work! light=%h ***", light);
		err=1;
	end

	rst=0;
	#(CLK_PERIOD*5)
	if (colour!=24'h0000ff)
	begin
		$display ("***TEST FAILED!  Automatic set does not work! colour=%b ***", colour);
		err=1;
	end

	
		
	
	button=1;
	forever begin
	colour_prev=colour;
	#(CLK_PERIOD*5)	

	if (light==24'h0000FF)
	colour=3'b001;
	else if (light==24'h00FF00)
	colour=3'b010;
	else if (light==24'h00FFFF)
	colour=3'b011;
	else if (light==24'hFF0000)
	colour=3'b100;
	else if (light==24'hFF00FF)
	colour=3'b101;
	else if (light==24'hFFFF00)
	colour=3'b110;
	else if (light==24'hFFFFFF)
	colour=3'b111;
	else colour=3'b000;
	
	
	if (button)
	begin
		if ((colour_prev==3'b110 ||colour_prev==3'b111 ) && colour == 3'b001)
			condition=1;
		else if (colour == (colour_prev+1'b1)) // 
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
	
	$display("rst=%b, button=%b, colour=%b, light=%h, counter_local=%b err=%b", rst, button, colour, light, counter_local,err);
	end
end

initial begin
       
       sel=0;
       
       forever begin
         #(CLK_PERIOD*5)
	 
	 if ((sel&(light==white))| (!sel&(light!=white)))
         begin
           $display("***TEST FAILED! light==%h, white==%h, sel=%b ***",light,white,sel);
           err=1;
         end
	
 
          sel=~sel;
       end
     end
	
//Todo: Finish test, check for success
initial begin
#(700)
if (err==0)

	$display ("***TEST PASSED! colour=%b ***", colour);
$display("rst=%b, button=%b, colour=%b", rst, button, colour);
$finish;

end
//Todo: Instantiate counter module

selector top(
.clk (clk),.rst(rst), .button(button),.sel(sel), .light (light)
);
endmodule 
