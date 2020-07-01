
module wrapper(
  input        clock,
  input        reset,
  input        io_inc,
  input  [7:0] io_T,
  input  [7:0] io_duty,
  output       io_out,
  output [7:0] io_cont
);

reg init=1;

always @(posedge clock) begin
	if (init) begin
		assume(reset);
		assume(io_inc);
		assume(io_duty==4);
		assume(io_T==9);
	end
	if (!reset) begin
		if (io_cont<= io_duty) assert(io_out);
		if (io_cont> io_duty) assert(!io_out);
		if (io_cont>=io_T) assert(!io_out);
		if (reset) assert(!io_out);	
	end     
	if(!io_inc)assert(!io_out);
end 

PWM PMW(
.clock(clock),
.reset(reset),
.io_inc(io_inc),
.io_T(io_T),
.io_duty(io_duty),
.io_out(io_out),
.io_cont(io_cont)
);

endmodule
