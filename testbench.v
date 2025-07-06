`timescale 1ns / 1ps

module testbench();

  reg clock;
  reg reset;

  wire [31:0] a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11;

  IITK_MIPS dut (
    .clk(clock),
    .reset(reset),
    .a1(a1), .a2(a2), .a3(a3), .a4(a4), .a5(a5),
    .a6(a6), .a7(a7), .a8(a8), .a9(a9), .a10(a10),
    .a11(a11)
  );

  initial clock = 0;
  always #5 clock = ~clock;

  initial begin
    $dumpfile("full_tb.vcd");
    $dumpvars(0, testbench);
  end

  initial begin
    $monitor(
      $time, 
      " array = %d %d %d %d %d %d %d %d %d %d\n array_size = %d\n",
      a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11
    );
    reset = 1;
    #5 reset = 0;
    #20000 $finish;
  end

endmodule

