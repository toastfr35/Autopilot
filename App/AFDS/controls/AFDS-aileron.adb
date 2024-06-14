-------------------------------------------------------
-- Package AFDS.AILERON
--
-- Apply aileron control
-------------------------------------------------------

with AFDS.iface.aircraft;

package body AFDS.aileron is


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;


   -------------------------------
   -- Set the aileron position
   -------------------------------
   procedure set_target(v : t_aileron) is
      target_v : constant Float := Float (v);
      curr_v   : Float := Float(AFDS.iface.aircraft.status.aileron);
      delta_v  : constant Float := target_v - curr_v;
   begin
      curr_v := curr_v + (delta_v / 5.0);
      AFDS.iface.aircraft.control.set_aileron(t_aileron(curr_v));
   end set_target;


end AFDS.aileron;
