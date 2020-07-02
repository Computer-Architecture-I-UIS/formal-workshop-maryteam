
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
		//assume(io_inc);
		//assume(io_duty<=255);
		//assume(io_T<=255);
	end
	if (!reset) begin
		if ($past(io_inc))begin
			assert(!io_cont);
		end
		if ($past(io_inc,2))begin
			assert(io_cont);
		end
		if (io_cont<= io_duty)begin
			assert(io_out);
		end
		if (io_cont> io_duty)begin 
			assert(!io_out);
		end
		if (io_cont<=io_T)begin
			assert($past(io_cont)+1==io_cont);
		end
		//if (io_cont>=io_T)assert(!io_out);
		assert(io_cont<=io_T);
		//if (reset) assert(!io_out);
		assert(io_duty<=io_T);	
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
