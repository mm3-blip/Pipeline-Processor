`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.05.2026 11:42:04
// Design Name: 
// Module Name: pipeline
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


module pipeline(
    input clk,
    input reset
);

// -----------------------------
// Instruction Format
// [7:6] Opcode
// 00 -> ADD
// 01 -> SUB
// 10 -> LOAD
// -----------------------------

// Instruction Memory
reg [7:0] instruction_memory [0:7];

// Register File
reg [7:0] register_file [0:3];

// Pipeline Registers
reg [7:0] IF_ID;
reg [7:0] ID_EX;
reg [7:0] EX_WB;

reg [1:0] pc;

// Initialize Instructions
initial begin
    instruction_memory[0] = 8'b00000011; // ADD
    instruction_memory[1] = 8'b01000010; // SUB
    instruction_memory[2] = 8'b10000001; // LOAD

    register_file[0] = 10;
    register_file[1] = 5;
end

// =============================
// Stage 1 : Instruction Fetch
// =============================
always @(posedge clk or posedge reset)
begin
    if(reset)
        pc <= 0;
    else begin
        IF_ID <= instruction_memory[pc];
        pc <= pc + 1;
    end
end

// =============================
// Stage 2 : Instruction Decode
// =============================
always @(posedge clk)
begin
    ID_EX <= IF_ID;
end

// =============================
// Stage 3 : Execute
// =============================
always @(posedge clk)
begin
    case(ID_EX[7:6])

        2'b00: EX_WB <= register_file[0] + register_file[1]; // ADD

        2'b01: EX_WB <= register_file[0] - register_file[1]; // SUB

        2'b10: EX_WB <= 8'd25; // LOAD constant

        default: EX_WB <= 0;

    endcase
end

// =============================
// Stage 4 : Write Back
// =============================
always @(posedge clk)
begin
    register_file[0] <= EX_WB;
end

endmodule
