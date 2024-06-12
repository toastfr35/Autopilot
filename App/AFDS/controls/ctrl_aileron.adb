-------------------------------------------------------
-- Package CTRL_AILERON
--
-- Apply aileron control
-------------------------------------------------------

with aircraft; use aircraft;

package body ctrl_aileron is


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
   procedure set_target(v : aircraft.t_aileron) is
      target_v : constant Float := Float (v);
      curr_v   : Float := Float(aircraft.status.aileron);
      delta_v  : constant Float := target_v - curr_v;
   begin
      curr_v := curr_v + (delta_v / 5.0);
      aircraft.control.set_aileron(t_aileron(curr_v));
   end set_target;

end ctrl_aileron;
