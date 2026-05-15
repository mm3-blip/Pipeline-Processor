`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 11:46:08
// Design Name: 
// Module Name: pipeline_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module pipeline_tb;

reg clk;
reg reset;

// Instantiate DUT
pipeline uut(
    .clk(clk),
    .reset(reset)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    clk = 0;
    reset = 1;

    #10 reset = 0;

    #200 $finish;
end

endmodule