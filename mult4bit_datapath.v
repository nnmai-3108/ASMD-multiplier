module mult4bit_datapath #(parameter N = 4) (
  input                clk    ,
  input                reset_n,
  input      [N-1:0]   A_in   ,
  input      [N-1:0]   B_in   ,
  input                init   ,
  input                plus   ,
  input                shift  ,
  input                finish ,
  output reg [N-1:0]   B      ,
  output reg [2*N-1:0] S      
  );
  reg [2*N-1:0] A;

  always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
      A <= 0;
      B <= 0;
      S <= 0;
    end
    else begin
      if(init) begin
        A <= {{N{1'b0}}, A_in};
        B <= B_in;
        S <= 0;
      end
      if(plus) begin
        S <= S + A;
        A <= A << 1;
        B <= B >> 1;
      end
      if(shift) begin
        A <= A << 1;
        B <= B >> 1;
      end
      if(finish) begin
        A <= 0;
        B <= 0;
      end
    end
  end
endmodule