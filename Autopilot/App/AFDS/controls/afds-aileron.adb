-------------------------------------------------------
-- Package AFDS.AILERON
--
-- Apply aileron control
-------------------------------------------------------

with AFDS.iface;

package body AFDS.aileron is

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      -- no internal state
      null;
   end reset;


   -------------------------------
   -- Set the aileron position to ACC
   -------------------------------
   procedure set_target(v : t_aileron) is
      target_v : constant Float := Float (v);
      curr_v   : Float := Float(AFDS.iface.ACS.data.aileron);
      delta_v  : constant Float := target_v - curr_v;
   begin
      curr_v := curr_v + (delta_v / 5.0);
      AFDS.iface.ACC.data.command_aileron := t_aileron(curr_v);
   end set_target;


end AFDS.aileron;
