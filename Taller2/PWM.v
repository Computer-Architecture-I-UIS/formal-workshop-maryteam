module PWM(
  input        clock,
  input        reset,
  input        io_inc,
  input  [7:0] io_T,
  input  [7:0] io_duty,
  output       io_out,
  output [7:0] io_cont
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  reg [7:0] x; // @[PWM.scala 14:19]
  wire [7:0] _T_1 = x + 8'h1; // @[PWM.scala 15:10]
  wire  _T_2 = x >= io_T; // @[PWM.scala 16:13]
  wire  _T_3 = x <= io_duty; // @[PWM.scala 20:26]
  assign io_out = io_inc & _T_3; // @[PWM.scala 20:10]
  assign io_cont = x; // @[PWM.scala 21:10]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  x = _RAND_0[7:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
  always @(posedge clock) begin
    if (reset) begin
      x <= 8'h0;
    end else if (_T_2) begin
      x <= 8'h0;
    end else begin
      x <= _T_1;
    end
  end
endmodule
