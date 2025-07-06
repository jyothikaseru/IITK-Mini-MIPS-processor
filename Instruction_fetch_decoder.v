module Instruction_Fetch_Decoder(clk, reset, PC, R_type, I_type, J_type,
                                 rt, rs, rd, ins_op_code, ins_func,
                                 ins_rs, ins_rt, ins_rd, ins_shamt,
                                 address, imm);
  input clk, reset;
  output reg [31:0] PC;
  output reg [1:0] R_type, I_type, J_type;
  output reg [31:0] rt, rs, rd;
  output reg [5:0] ins_op_code, ins_func;
  output reg [4:0] ins_rs, ins_rt, ins_rd, ins_shamt;
  output reg [25:0] address;
  output reg [15:0] imm;

  reg [31:0] instruction;
  reg [31:0] R[31:0];
  integer i;

  always @(reset) begin
    for (i = 0; i < 32; i = i + 1)
      R[i] = 32'b0;

    PC = 0;
    R_type = 0;
    I_type = 0;
    J_type = 0;
  end

  always @(posedge clk) begin
    instruction = R[PC >> 2];
    ins_op_code = instruction[31:26];
    PC = PC + 4;

    if (ins_op_code == 0) begin
      R_type = 1;
      I_type = 0;
      J_type = 0;
      ins_rs = instruction[25:21];
      ins_rt = instruction[20:16];
      ins_rd = instruction[15:11];
      ins_shamt = instruction[10:6];
      ins_func = instruction[5:0];
      rs = R[ins_rs];
      rt = R[ins_rt];
      rd = R[ins_rd];
    end else begin
      R_type = 0;
      I_type = 1;
      J_type = 0;
      ins_rs = instruction[25:21];
      ins_rt = instruction[20:16];
      imm = instruction[15:0];
      rs = R[ins_rs];
      rt = R[ins_rt];
      address = instruction[25:0];
    end
  end
endmodule

