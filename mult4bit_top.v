module mult4bit_top #(parameter M = 4)(
  input            clk    ,
  input            reset_n,
  input  [M-1:0]   A_in   ,
  input  [M-1:0]   B_in   ,
  input            start  ,
  output [2*M-1:0] S       
  );

  wire             init  ;
  wire             plus  ;
  wire             shift ;
  wire             finish;
  wire [M-1:0]     B     ;


mult4bit_controller #(.N(M)) mult4bit_controller_0 (  
  .clk    (clk    ),
  .reset_n(reset_n),
  .start  (start  ),
  .B      (B      ),
  .init   (init   ),
  .plus   (plus   ),
  .shift  (shift  ),
  .finish (finish )
  );

mult4bit_datapath #(.N(M)) mult4bit_datapath_0 (   
  .clk    (clk    ),
  .reset_n(reset_n),
  .A_in   (A_in   ),
  .B_in   (B_in   ),
  .init   (init   ),
  .plus   (plus   ),
  .shift  (shift  ),
  .finish (finish ),
  .B      (B      ),
  .S      (S      )
  );

endmodule