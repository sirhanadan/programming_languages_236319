use "hw2_q3.sml";
use "hw3_q1_def.sml";
use "hw3_q1.sml";
use "hw3_q2_def.sml";
use "hw3_q2.sml";
use "hw4_q1_def.sml";

local 
    structure runCycleKernel = Kernel2D(struct
      type source = bool
      type target = bool
      fun kernel t1 t2 t3 = is_alive_bool t1 t2 t3
      fun default _ = false
    end);
  in
    fun runCycle frame = stateToFrame (runCycleKernel.runKernel (frameToState frame));
  end;


local 
  val frameRef = ref [];
in
  fun gameOfLife frame = (
    frameRef := frame;
    fn () => (printFrame(!frameRef);
      frameRef := runCycle (!frameRef)));
end;