-------------------------------------------------------
-- Package CTRL_RUDDER
--
-- Apply rudder control
-------------------------------------------------------

with aircraft; use aircraft;
with average;

package body ctrl_rudder is

   -- Average the last 32 commands to dampen the rudder effect
   package p_average is new average(32);

   -------------------------------
   -- Reset internal state
   -------------------------------
   procedure reset is
   begin
      p_average.reset;
   end reset;


   -------------------------------
   --
   -------------------------------
   procedure set_target(v : t_rudder) is
   begin
      p_average.add (Float(v));
      aircraft.control.set_rudder(t_rudder(p_average.get));
   end set_target;

end ctrl_rudder;
