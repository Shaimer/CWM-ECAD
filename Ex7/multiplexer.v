//////////////////////////////////////////////////////////////////////////////////
// Exercise #2 - Doorbell Chime
// Student Name: Shaimerden Kuanganov
// Date: 24.05.2021
//
//  Description: In this exercise, you need to design a multiplexer that chooses between two sounds, where the  
//  output is delayed by 5 ticks (not clocks!) and acts according to the following truth table:
//
//  sel | out
// -----------------
//   0  | a
//   1  | b
//
//  inputs:
//           a, b, sel
//
//  outputs:
//           out
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 100ps

module multiplexer(
    //Todo: define inputs here
    input [23:0] rgb,
    input [23:0] white,
    input sel,
    output [23:0] light);
    
    //Todo: define registers and wires here
	wire light;

    //Todo: define your logic here      
	assign light =  (sel==1)?rgb:white;         
      
endmodule
