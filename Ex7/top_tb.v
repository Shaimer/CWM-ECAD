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
	reg [2:0] colour_prev=0;
    	reg err, condition;
	reg [3:0] counter_local=0;
	reg button_prev=0;
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
    	rst=1;
	sel=1;
	button=0;
	//counter_local=0;
	#(CLK_PERIOD*10)
	rst=0;
	
	if (light!=24'h000000)
	begin
		$display ("***TEST FAILED!  Initialisation does not work! light=%h ***", light);
		err=1;
	end
		

	rst=1;
	#(CLK_PERIOD*10)
	if (light!=24'h000000)
	begin
		$display ("***TEST FAILED!  Reset does not work! light=%h ***", light);
		err=1;
	end

	rst=0;
	#(CLK_PERIOD*10)
	if (light!=24'h0000ff)
	begin
		$display ("***TEST FAILED!  Automatic set does not work! light=%h ***", light);
		err=1;
	end

	
		
	
	button=1;
	colour=3'b001; //because light==24'b0000ff
	forever begin
	colour_prev=colour;
	button_prev=button;
	#(CLK_PERIOD)
	button=0; //so that nothing changes during the next clock periods
	#(CLK_PERIOD*9)	
	button=button_prev;

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
	
	$display("rst=%b, button=%b, colour=%b, light=%h, colour_prev=%b counter_local=%b err=%b", rst, button, colour, light, colour_prev, counter_local,err);
	end
end

initial begin
       
       sel=1;
       
       forever begin
         #(CLK_PERIOD*10)
	 
	 if ((sel&(light==white))| (!sel&(light!=white)))
         begin
           $display("***TEST FAILED! light==%h, white==%h, sel=%b ***",light,white,sel);
           err=1;
         end
	
 
          
       end
     end
	
//Todo: Finish test, check for success
initial begin
#(1000)
if (err==0)
	$display ("***TEST PASSED! colour=%h ***", light);
$display("rst=%b, button=%b, colour=%h", rst, button, light);
$finish;

end
//Todo: Instantiate counter module

selector top(
.clk (clk),.rst(rst), .sel(sel), .button(button), .light(light)
);
endmodule 
