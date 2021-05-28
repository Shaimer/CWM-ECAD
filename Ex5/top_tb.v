//////////////////////////////////////////////////////////////////////////////////
// Test bench for Exercise #5 - Air Conditioning
// Student Name: Shaimerden
// Date: 26.05.2021
//
// Description: A testbench module to test Ex5 - Air Conditioning
// You need to write the whole file
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module top_tb(
    );
    
//Todo: Parameters
	parameter CLK_PERIOD = 10;
//Todo: Regitsers and wires
	reg clk;
	reg [4:0] temperature;
    	wire  heating;
	wire  cooling;
    	reg err, condition;
	reg [4:0] increase=1;
	

    	
    	
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
	
	
	temperature=22;
	#(CLK_PERIOD)
	if ( heating!=0 || cooling!=1)
	begin
		$display ("***TEST FAILED!  Too hot! temperature=%b ***", temperature);
		err=1;
	end
	
	temperature=18;	
	#(CLK_PERIOD)
	
	if (heating!=1 || cooling!=0)
	begin
		$display ("***TEST FAILED!  Too cold! temperature=%b ***", temperature);
		err=1;
	end
		
	
	
	forever begin
	
	
		
	
	if (heating==1  && temperature>=20)
		condition=1;
	else if (cooling==1  && temperature<=20)
		condition=1;
	else if (cooling==0 && heating==0)
		condition=1;
	else
		condition=0;
	
	#(CLK_PERIOD)
	if (condition&& (heating!=0 && cooling!=0))
		begin
			$display ("***TEST FAILED!  Can't turn-off something!***");
			err=1;
		end
	
	

	if (temperature==31 || temperature ==0)

		increase=-increase;
	
	temperature=temperature+increase;
	
	
	$display("temperature=%d, heating=%b, cooling=%b, err=%b, increase=%d", temperature, heating, cooling, err,increase);
	end
end


	
//Todo: Finish test, check for success
initial begin
#(500)
if (err==0)

	$display ("***TEST PASSED! temperature=%d ***", temperature);
$display("heating=%b, cooling=%b", heating, cooling);
$finish;

end
//Todo: Instantiate counter module
monitor top(
.clk (clk),.temperature(temperature), .heating(heating), .cooling (cooling)
);
  
endmodule 
