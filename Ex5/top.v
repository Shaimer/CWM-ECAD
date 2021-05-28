//////////////////////////////////////////////////////////////////////////////////
// Exercise #5 - Air Conditioning
// Student Name: Shaimerden Kuanganov
// Date:  26.05.2021
//
//  Description: In this exercise, you need to an air conditioning control system
//  According to the state diagram provided in the exercise.
//
//  inputs:
//           clk, temperature [4:0]
//
//  outputs:
//           heating, cooling
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module monitor (
    //Todo: add ports 
	input clk, 
	input [4:0] temperature,

	output reg heating,
	output reg cooling

    );
                    
    //Todo: add registers and wires, if needed
	
	
	
    //Todo: add user logic

      always @(posedge clk)
	
	begin
		if(temperature>=22||(cooling==1 && temperature>20))
		begin
		heating <= 0;
		cooling <= 1;
		end
	
		else if(temperature<=18||(heating==1 && temperature<20))
		begin
		heating <= 1;
		cooling <= 0;
		end

		else 
		begin
		heating <= 0;
		cooling <= 0;
		end
		
			
	end


endmodule





