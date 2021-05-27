//////////////////////////////////////////////////////////////////////////////////
// Exercise #6 - RGB Colour Converter
// Student Name: Shaimerden Kuanganov
// Date: 26.05.2021
//
//
//  Description: In this exercise, you need to design a memory with 8 entries, 
//  converting colours to their RGB code.
//
//  inputs:
//           clk, colour [2:0], enable
//
//  outputs:
//           rgb [23:0]
//
//////////////////////////////////////////////////////////////////////////////////

// The following must be inserted into your Verilog file for this
// core to be instantiated. Change the instance name and port connections
// (in parentheses) to your own signal names.
module monitor(
//Todo: add ports 
	input clk, 
	input [2:0] colour,
	input enable,
	output [23:0] rgb	

    );

/*always @(posedge clk)
	
	begin
		if(enable)
		rgb <= rgb_mem;
	end*/
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG
mybram  blockram(
  .clka(clk),    // input wire clka
  .ena(enable),      // input wire ena
  .wea(1'b0),      // input wire [0 : 0] wea
  .addra(colour),  // input wire [2 : 0] addra
  .dina(24'h0),    // input wire [23 : 0] dina
  .douta(rgb)  // output wire [23 : 0] douta
);
// INST_TAG_END ------ End INSTANTIATION Template ---------

// You must compile the wrapper file mybram.v when simulating
// the core, mybram. When compiling the wrapper file, be sure to
// reference the Verilog simulation library.

endmodule
