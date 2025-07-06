`include "RegisterFile.v"
`include "CounterUnit.v"
`include "ALU.v"
`include "Instruction_Fetch_Decoder.v"

module IITK_MIPS(
    input clk,
    input reset,
    output [31:0] a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11
);

// Internal wires
wire [31:0] pc;
wire [31:0] instruction;
wire [4:0] rs, rt, rd;
wire [5:0] opcode, funct;
wire [15:0] imm16;
wire [31:0] reg_data1, reg_data2;
wire [31:0] alu_result;
wire [31:0] write_data;
wire [4:0] write_reg;
wire reg_write_enable;
wire [31:0] imm_ext;

// Program Counter
CounterUnit counter (
    .clk(clk),
    .reset(reset),
    .pc_out(pc)
);

// Instruction Fetch + Decode
Instruction_Fetch_Decoder decoder (
    .pc(pc),
    .instruction(instruction),
    .opcode(opcode),
    .funct(funct),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .imm16(imm16)
);

// Register File
RegisterFile rf (
    .clk(clk),
    .rs(rs),
    .rt(rt),
    .rd(write_reg),
    .write_data(write_data),
    .reg_write(reg_write_enable),
    .data1(reg_data1),
    .data2(reg_data2)
);

// ALU
ALU alu (
    .input1(reg_data1),
    .input2(reg_data2),
    .alu_control(funct),
    .result(alu_result)
);

// Control Unit Logic (simplified here)
assign write_data = alu_result;
assign write_reg = rd;  // Write to rd for R-type
assign reg_write_enable = 1'b1;  // Always write for now
assign imm_ext = {{16{imm16[15]}}, imm16};  // Sign-extend

// Output mapping
assign a1 = pc;
assign a2 = instruction;
assign a3 = reg_data1;
assign a4 = reg_data2;
assign a5 = alu_result;
assign a6 = write_data;
assign a7 = imm_ext;
assign a8 = {27'b0, rs};
assign a9 = {27'b0, rt};
assign a10 = {27'b0, rd};
assign a11 = {26'b0, opcode};

endmodule
