// See LICENSE.txt for license details.
package projects

import chisel3._

class PWM extends Module {
  val io = IO(new Bundle {
    val inc = Input(Bool())
    val T   = Input(UInt(8.W))
    val duty= Input(UInt(8.W))
    val out = Output(Bool())
    val cont= Output(UInt(8.W))
  })
  val x  = RegInit(0.U(8.W))
  x := x + 1.U
  when   (x >= io.T) { 
  x := 0.U 
  }
  //io.out := io.inc && (x > io.duty)
  io.out := io.inc && (x <= io.duty)
  io.cont:= x
//  io.tot := Counter.counter(io.T, io.inc)

}
object PWMMain extends App {
  chisel3.Driver.execute(args, () => new PWM)
  }
