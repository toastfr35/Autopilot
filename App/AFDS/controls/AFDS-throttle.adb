-------------------------------------------------------
-- Package AFDS.THROTTLE
--
-- Apply throttles control
-------------------------------------------------------

with AFDS.iface.aircraft;

package body AFDS.throttle is


   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      null;
   end reset;


   -------------------------------
   -- Set the desired throttle input percentage
   -------------------------------
   procedure set_target(v1, v2 : t_throttle) is
   begin
      AFDS.iface.aircraft.control.command_throttle1 := v1;
      AFDS.iface.aircraft.control.command_throttle2 := v2;
   end set_target;


end AFDS.throttle;
