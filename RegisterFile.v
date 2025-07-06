module RegisterFile(clk, rst, write_enable, address, datain, mode, dataout);
  parameter WIDTH = 32;
  input [4:0] address;
  input [WIDTH-1:0] datain;
  input write_enable, clk, rst, mode;
  output [WIDTH-1:0] dataout;

  reg [WIDTH-1:0] reg_file [WIDTH-1:0]; 
  reg [WIDTH-1:0] stage1_data, stage2_data;
  reg prev_mode, curr_mode;

  always @(posedge clk)
  begin
    prev_mode <= curr_mode;
    curr_mode <= mode;
    stage1_data <= stage2_data;

    if (rst) begin
      integer i;
      for (i = 0; i < WIDTH; i = i + 1)
        reg_file[i] = 32'b0;
    end else begin
      if (write_enable)
        reg_file[address] <= datain;
      stage2_data <= reg_file[address];
    end
  end

  assign dataout = (prev_mode ? stage1_data : stage2_data);
endmodule

