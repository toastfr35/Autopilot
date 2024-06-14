-------------------------------------------------------
-- Package AFDS.RUDDER
--
-- Apply rudder control
-------------------------------------------------------

with AFDS.iface.aircraft;

with average;

package body AFDS.rudder is

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
   -- Set the rudder position
   -------------------------------
   procedure set_target(v : t_rudder) is
   begin
      p_average.add (Float(v));
      AFDS.iface.aircraft.control.set_rudder(t_rudder(p_average.get));
   end set_target;


end AFDS.rudder;
