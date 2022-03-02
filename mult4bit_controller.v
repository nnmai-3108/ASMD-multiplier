module mult4bit_controller #(parameter N = 4)(
  input         clk    ,
  input         reset_n,
  input         start  ,
  input [N-1:0] B      ,
  output reg    init   ,
  output reg    plus   ,
  output reg    shift  ,
  output reg    finish 
  );

  localparam IDLE = 1'b0;
  localparam COMPUTE = 1'b1;

  reg current_state;
  reg next_state   ;

  always @(start, B) begin
    init   = 0;
    plus   = 0;
    shift  = 0;
    finish = 0;
    case(current_state)
      IDLE: begin
        if(start) begin
          init = 1;
          next_state = COMPUTE;
        end
        else begin
          next_state = IDLE;
        end
      end
      COMPUTE: begin
        if(B[0]) begin
          plus = 1;
          next_state = COMPUTE;
        end
        else begin
          if(!B) begin
            finish = 1;
            next_state = IDLE;
          end
          else begin
            shift = 1;
            next_state = COMPUTE;
          end
        end
      end
    endcase
  end

  always @(posedge clk, negedge reset_n) begin
    if(!reset_n) begin
      current_state <= IDLE;
    end
    else begin
      current_state <= next_state;
    end
  end
endmodule