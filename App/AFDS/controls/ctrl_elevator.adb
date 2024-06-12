-------------------------------------------------------
-- Package CTRL_ELEVATOR
--
-- Apply elevator control
-------------------------------------------------------

with aircraft; use aircraft;

with math; use math;

package body ctrl_elevator is

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;

   -------------------------------
   --
   -------------------------------
   procedure set_target(v : aircraft.t_elevator) is
      target_v : constant Float := Float (v);
      curr_v   : Float := Float(aircraft.status.elevator);
      delta_v  : constant Float := target_v - curr_v;
      abs_delta_v : constant Float := fabs(delta_v);
   begin
      if abs_delta_v > 10.0 then
         curr_v := curr_v + (delta_v / 10.0);
      elsif  abs_delta_v > 5.0 then
         curr_v := curr_v + (delta_v / 5.0);
      else
         curr_v := target_v;
      end if;

      aircraft.control.set_elevator(t_elevator(curr_v));
   end set_target;

end ctrl_elevator;
