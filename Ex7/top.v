//////////////////////////////////////////////////////////////////////////////////
// Exercise #7 - Lights Selector
// Student Name:
// Date: 
//
//  Description: In this exercise, you need to implement a selector between RGB 
// lights and a white light, coded in RGB. If sel is 0, white light is used. If
//  the sel=1, the coded RGB colour is the output.
//
//  inputs:
//           clk, sel, rst, button
//
//  outputs:
//           light [23:0]
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module selector(
    //Todo: define inputs here
    input clk,
    input rst,
    input sel,
    input button,
    output [23:0] light );
    
    reg [23:0] white=24'hFFFFFF;
	wire [2:0] colour;	
	wire [23:0] rgb;

	lights the_lights(.clk(clk), .rst(rst), .button(button), .colour(colour));

	converter the_converter(.clk(clk),.colour(colour), .enable(1), .rgb(rgb));

	multiplexer the_multiplexer(.rgb(rgb), .white(white), .sel(sel), .light(light));

   
      
endmodule
