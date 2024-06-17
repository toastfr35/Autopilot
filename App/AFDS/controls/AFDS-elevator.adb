-------------------------------------------------------
-- Package AFDS.ELEVATOR
--
-- Apply elevator control
-------------------------------------------------------

with AFDS.iface.aircraft;

with math; use math;

package body AFDS.elevator is


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;

   -------
   ------------------------
   -- Set the elevator position
   -------------------------------
   procedure set_target(v : t_elevator) is
      target_v : constant Float := Float (v);
      curr_v   : Float := Float(AFDS.iface.aircraft.status.elevator);
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
      AFDS.iface.aircraft.control.command_elevator := t_elevator(curr_v);
   end set_target;


end AFDS.elevator;
