-------------------------------------------------------
-- Generic package PID
--
-------------------------------------------------------

package body pid is

   -- Internal state for the PID controller
   integral : Float := 0.0;
   previous_error : Float := 0.0;


   -- Reset the internal state
   procedure reset is
   begin
      integral := 0.0;
      previous_error := 0.0;
   end reset;


   -- PID controller function
   function get (Kp, Ki, Kd : Float; error : t_error) return t_output is
      ferror      : constant Float := Float(error);
      derivative  : constant Float := ferror - previous_error;
      output      : Float;
   begin
      -- Update integral term
      integral := integral + ferror;

      -- Calculate output
      output := (Kp * ferror) + (Ki * integral) + (Kd * derivative);

      -- Update state
      previous_error := ferror;

      -- Ensure the output is within the aileron range
      if output > Float (t_output'Last) then
         return t_output'Last;
      elsif output < Float (t_output'First) then
         return t_output'First;
      else
         return t_output(output);
      end if;
   end get;

end pid;
