module ALU(A, B, ALU_Sel, ALU_Out, CarryOut);
  input [31:0] A, B;
  input [4:0] ALU_Sel;
  output [31:0] ALU_Out;
  output CarryOut;

  reg [31:0] ALU_Result;
  wire [32:0] tmp;
  assign tmp = {1'b0, A} + {1'b0, B};
  assign CarryOut = tmp[32];
  assign ALU_Out = ALU_Result;

  always @(*) begin
    case (ALU_Sel)
      5'b00000: ALU_Result = A + B;
      5'b00001: ALU_Result = A - B;
      5'b00010: ALU_Result = A * B;
      5'b00011: ALU_Result = A / B;
      5'b00100: ALU_Result = A << 1;
      5'b00101: ALU_Result = A >> 1;
      5'b00110: ALU_Result = {A[6:0], A[7]};
      5'b00111: ALU_Result = {A[0], A[7:1]};
      5'b01000: ALU_Result = A & B;
      5'b01001: ALU_Result = A | B;
      5'b01010: ALU_Result = A ^ B;
      5'b01011: ALU_Result = ~(A | B);
      5'b01100: ALU_Result = ~(A & B);
      5'b01101: ALU_Result = ~(A ^ B);
      5'b01110: ALU_Result = (A > B) ? 32'd1 : 32'd0;
      5'b01111: ALU_Result = (A == B) ? 32'd1 : 32'd0;
      default:  ALU_Result = A + B;
    endcase
  end
endmodule

