-------------------------------------------------------
-- Package CTRL_THROTTLE
--
-- Apply throttles control
-------------------------------------------------------

package body ctrl_throttle is

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
   procedure set_target(v1, v2 : aircraft.t_throttle) is
   begin
      aircraft.control.set_throttles(v1, v2);
   end set_target;

end ctrl_throttle;
