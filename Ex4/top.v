//////////////////////////////////////////////////////////////////////////////////
// Exercise #4 - Dynamic LED lights
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to design a LED based lighting solution, 
//  following the diagram provided in the exercises documentation. The lights change 
//  as long as a button is pressed, and stay the same when it is released. 
//
//  inputs:
//           clk, rst, button
//
//  outputs:
//           colour [2:0]
//
//  You need to write the whole file.
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 100ps

module monitor (
    //Todo: add ports 
	input clk, 
	input rst, 
	input button, 

	output [2:0] colour

    );
                    
    //Todo: add registers and wires, if needed
	
	reg [2:0] colour;
	initial colour=3'b000;
	
    //Todo: add user logic

      always @(posedge clk)
	
	begin
	if(rst)
	colour <= 3'b000;
	else if(colour==3'b111||colour==3'b000)
	colour <= 3'b001;
	else if(!button)
	colour <= colour;
	else if(colour==3'b110)
	colour <= 3'b001;
	else
	colour <= colour+1'b1;
	end

endmodule





