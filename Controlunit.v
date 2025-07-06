module CountorUnit(OUT1addr, OUT2addr, INaddr, func1, Select, imm_signal, comp_signal, instruction);
  input [31:0] instruction;
  output reg [5:0] func1;
  output reg imm_signal;
  output reg [4:0] Select;
  output reg [4:0] OUT1addr;
  output reg [4:0] OUT2addr;
  output reg [4:0] INaddr;
  output reg comp_signal;

  always @(instruction) begin
    func1 = instruction[5:0];
    Select = instruction[25:21];
    INaddr = instruction[20:16];
    OUT2addr = instruction[15:11];
    OUT1addr = instruction[10:6];
    imm_signal = 1'b0;
    comp_signal = 1'b0;
    case (instruction[31:24])
      8'b00001000: imm_signal = 1'b1;
      8'b00001001: comp_signal = 1'b1;
      default: ;
    endcase
  end
endmodule

