module tb();
  reg        clk    ;
  reg        reset_n;
  reg  [4:0] A_in   ;
  reg  [4:0] B_in   ;
  reg        start  ;
  wire [9:0] S      ;

  mult4bit_top mult4bit_top_0 (
  .clk    (clk    ),
  .reset_n(reset_n),
  .A_in   (A_in   ),
  .B_in   (B_in   ),
  .start  (start  ),
  .S      (S      )
  );
  
  defparam mult4bit_top_0.M = 5;

  always #10 clk = ~clk;

  initial begin
    start = 0;
    clk = 0;
    reset_n = 0;
    @(posedge clk);
    reset_n = 1;
    A_in = 5'b01100;
    B_in = 5'b01011;
    start = 1;
    @(posedge clk);
    start = 0;
    repeat(6) @(posedge clk);
    @(posedge clk);
    reset_n = 1;
    A_in = 5'b11101;
    B_in = 5'b01101;
    start = 1;
    @(posedge clk);
    start = 0;
    repeat(6) @(posedge clk);
    $finish;
  end

endmodule